#! /bin/sh

# python3 -m venv .venv
# .venv/bin/python -m pip -r requirements.txt -U pip
.venv/bin/python migration.py ~/johncloud_data/mailu/mail/yann@johncloud.fr yann.mbox
