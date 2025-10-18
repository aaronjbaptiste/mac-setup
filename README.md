# Mac Setup Script

My setup.

## Pre

1. System Settings -> General -> Software Update

## How to run

1. **Clone this repo** (or download the setup.sh script):

```bash
cd ~
git clone https://github.com/aaronjbaptiste/mac-setup.git
cd mac-setup
chmod +x setup.sh
./setup.sh
```

2. Restart Mac

## Post (optional)

1. Log in to iCloud
2. Generate SSH Key + Add public key to github
3. Configure git author

```
git config --global user.email "<email>"
git config --global user.name "<user_name>"
```
