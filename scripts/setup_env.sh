#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

gen_secret() {
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -hex 32
  else
    python3 -c "import secrets; print(secrets.token_hex(32))"
  fi
}

if [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if grep -q '^SECRET_KEY=change-me-to-a-long-random-secret$' .env; then
  secret="$(gen_secret)"
  sed -i.bak "s/^SECRET_KEY=.*/SECRET_KEY=${secret}/" .env
  rm -f .env.bak
  echo "Generated a random SECRET_KEY"
else
  echo "SECRET_KEY already set, leaving it unchanged"
fi
