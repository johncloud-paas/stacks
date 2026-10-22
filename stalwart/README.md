To save emails in sqlite format (e.g. backup.sqlite):

```bash
vandelay import jmap --url https://mail.domain.tld --auth-basic admin --auth-password 'yourpassword' --account-name foo@domain.tld --max-retries 5 backup.sqlite
```

To restore emails from sqlite format 

```bash
vandelay export --url https://mail.domain.tld --auth-basic foo@domain.tld --account-name foo@domain.tld  backup.sqlite
```
