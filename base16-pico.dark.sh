#!/usr/bin/env bash
# Base16 Pico - Mate Terminal color scheme install script
# PICO-8 (http://www.lexaloffle.com/pico-8.php)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Pico Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-pico-dark"
[[ -z "$DCONFTOOL" ]] && DCONFTOOL=dconf
[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/mate/terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

dset() {
  local key="$1"; shift
  local val="$1"; shift

  "$DCONFTOOL" write "$PROFILE_KEY/$key" "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONFTOOL" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONFTOOL" write "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append /org/mate/terminal/global/profile-list "$PROFILE_SLUG"

dset visible-name "'$PROFILE_NAME'"
dset palette "'#000000:#ff004d:#00e756:#fff024:#83769c:#ff77a8:#29adff:#5f574f:#008751:#ff004d:#00e756:#fff024:#83769c:#ff77a8:#29adff:#fff1e8'"
dset background-color "'#000000'"
dset foreground-color "'#5f574f'"
dset bold-color "'#5f574f'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
