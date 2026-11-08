#!/usr/bin/env bash
set -e

KDIR="$HOME/.config/kitty"
CONF="$KDIR/kitty.conf"
INC="$KDIR/blade-transparency.conf"
LINE="include blade-transparency.conf"

# Retirer la transparence : bash transparency.sh --off
if [ "$1" = "--off" ]; then
  rm -f "$INC"
  [ -f "$CONF" ] && sed -i '/^include blade-transparency.conf$/d' "$CONF"
  pkill -USR1 kitty 2>/dev/null || true
  echo "✓ Transparence désactivée."
  exit 0
fi

# Opacité : 1 = opaque, 0.5 = très transparent (défaut : 0.85)
OPACITY="${1:-0.60}"

mkdir -p "$KDIR"
[ -f "$CONF" ] && cp "$CONF" "$CONF.bak.$(date +%s)"

cat > "$INC" <<EOF
background_opacity $OPACITY
dynamic_background_opacity yes
EOF

# l'include est placé à la fin pour avoir priorité sur le reste
grep -qxF "$LINE" "$CONF" 2>/dev/null || echo "$LINE" >> "$CONF"

pkill -USR1 kitty 2>/dev/null || true
echo "✓ Transparence réglée à $OPACITY."
