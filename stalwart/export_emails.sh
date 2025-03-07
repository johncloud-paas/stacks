#! /bin/sh

# python3 -m venv .venv
# .venv/bin/python -m pip -r requirements.txt -U pip
.venv/bin/python migration.py /path/to/maildir/mailbox user.mbox

# stalwart-cli -u https://mail.domain.tld import messages -f mbox foo@domain.tld bar.mbox
sudo docker exec stalwart-mailserver-1 stalwart-cli -u https://mail.domain.tld import messages -f mbox foo@domain.tld user.mbox
