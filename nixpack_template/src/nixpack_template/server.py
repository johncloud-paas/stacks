import os
import csv

import torch
import joblib
from transformers import (
    BertTokenizerFast,
    BertForSequenceClassification,
    Trainer,
    TrainingArguments,
)
from sklearn.preprocessing import MultiLabelBinarizer
from datasets import Dataset
import numpy as np
import wandb


# 📝 Jeu de données
data = []
with open("ListeTitresCategories.csv", mode="r", encoding="utf-8") as csvfile:
    rdr = csv.reader(csvfile, delimiter=";")
    for row in rdr:
        data.append(dict(text=row[0], labels=[row[1]]))

# 🔄 Préparation des labels
mlb = MultiLabelBinarizer()
labels = mlb.fit_transform([item["labels"] for item in data])

# 🔧 Tokenisation
tokenizer = BertTokenizerFast.from_pretrained("bert-base-uncased")
encodings = tokenizer([item["text"] for item in data], truncation=True, padding=True)

# 📦 Dataset definition
dataset = Dataset.from_dict(
    {
        "input_ids": encodings["input_ids"],
        "attention_mask": encodings["attention_mask"],
        "labels": labels.astype(np.float32).tolist(),
    }
)

# 🧠 Modèle BERT pour classification multi-label
model = BertForSequenceClassification.from_pretrained(
    "bert-base-uncased", num_labels=len(mlb.classes_)
)
model.config.problem_type = "multi_label_classification"

# 🧪 Initialisation WandB avec clé API passée en argument
wandb.login(key=os.environ.get("WAND_AI_API_KEY"))  # Remplace par ta clé WandB

# ⚙️ Entraînement
training_args = TrainingArguments(
    output_dir="./results",
    num_train_epochs=10,
    per_device_train_batch_size=2,
    logging_dir="./logs",
    logging_steps=10,
    use_cpu=True,  # ✅ Force l'utilisation du CPU
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=dataset,
)

trainer.train()

# 🔍 Prédiction
preds = trainer.predict(dataset)
pred_labels = (torch.sigmoid(torch.tensor(preds.predictions)) > 0.5).int().numpy()
decoded_labels = mlb.inverse_transform(pred_labels)

# 📤 Affichage des résultats
for i, item in enumerate(data):
    print(f"Texte : {item['text']}")
    print(f"Labels prédits : {decoded_labels[i]}")
    print("---")

model.save_pretrained("./output")
tokenizer.save_pretrained("./output")
joblib.dump(mlb, "./output/mlb.pkl")
