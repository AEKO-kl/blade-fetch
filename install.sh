#!/usr/bin/env bash
set -e

REPO="https://github.com/AEKO-kl/blade-fetch.git"
TMP="$(mktemp -d)"
CONF="$HOME/.config/fastfetch"

git clone --depth 1 "$REPO" "$TMP"

if [ -d "$CONF" ]; then
  mv "$CONF" "$CONF.bak.$(date +%s)"
  echo "→ Ancienne config sauvegardée dans $CONF.bak.*"
fi

mkdir -p "$CONF"
cp "$TMP"/fastfetch/* "$CONF/"
sed -i "s|__HOME__|$HOME|g" "$CONF/config.jsonc"

rm -rf "$TMP"
echo "✓ Installé. Lance : fastfetch"
