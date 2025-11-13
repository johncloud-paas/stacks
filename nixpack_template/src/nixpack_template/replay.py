import time

from transformers import BertForSequenceClassification, BertTokenizerFast
import joblib
import torch


# 🔁 Load model, tokenizer, and label binarizer
t0 = time.time()
model = BertForSequenceClassification.from_pretrained("modele")
tokenizer = BertTokenizerFast.from_pretrained("modele")
mlb = joblib.load("modele/mlb.pkl")
model.eval()
t1 = time.time()
dt = t1 - t0
print(f"Model loaded in {dt:.1f} s")

# 📝 Input text
text = "Le président a annoncé une nouvelle politique économique."

# 🔧 Tokenize
inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)

# 🧠 Inference
with torch.no_grad():
    outputs = model(**inputs)
    logits = outputs.logits
    probs = torch.sigmoid(logits)

# 🎯 Thresholding
pred_labels = (probs > 0.5).int().numpy()

# 🔍 Decode labels
decoded = mlb.inverse_transform(pred_labels)

# 📤 Result
print(f"Texte : {text}")
print(f"Labels prédits : {decoded[0][0]}")

dt = time.time() - t1
print(f"Inference made in {dt:.1f} s")
