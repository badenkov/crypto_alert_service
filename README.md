# Crypto Alert Service

[![CI](https://github.com/badenkov/crypto_alert_service/actions/workflows/ci.yml/badge.svg)](https://github.com/badenkov/crypto_alert_service/actions/workflows/ci.yml)

This is a test task (homework).
Build a personal crypto-alert service

Features:

- the user creates alerts (what symbol | crosses what threshold price | up or down) and manages them
- the user sets up and manages notification channels (write to a log / send an email / send a message to Telegram / send a browser notification / send an OS-notification / send to a message broker / …)
- the user receives notifications when the price crosses the threshold

## 🚀 How to run locally

### 0. Prerequisite

For managing the development environment this project uses:

- **[devenv.sh](https://devenv.sh)** — development environment manager  
  Installation guide: https://devenv.sh/getting-started/
- **[direnv](https://direnv.net/)** — automatically loads environment variables when entering a directory  
  Installation guide: https://direnv.net/docs/installation.html

Make sure both tools are installed before continuing.

### 1. Clone the repository

```bash
git clone https://github.com/username/crypto-alert-service.git
cd crypto-alert-service
cp ./envrc.example ./.envrc
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Create and seed the local SQLite database

```bash
bin/rails db:setup
```

### 4. Start the server

```bash
bin/rails server
```

## 🛠 Stack

- Ruby on Rails
- SQLite
