This repository serves as quick-start to obtain the sheesy binaries.
They will be downloaded on demand for your platform.

### How to...

#### ...setup a single-partition vault

A partition has recipients which are able to read and write its contents.
When you need no further restrictions, this is the setup for you.

```bash
./sy vault init --gpg-keys-dir vault/keys --secrets-dir vault
```

#### ...setup a multi-partition vault

With multiple partitions you can effectively prevent certain secrets to be read
by everyone. For example, there can be a partition most people have access to,
and another one with secrets only for a select few.

```bash
./sy vault init --first-partition --name prod --gpg-keys-dir vault/keys --secrets-dir vault/prod
./sy vault partition add preprod 
```
