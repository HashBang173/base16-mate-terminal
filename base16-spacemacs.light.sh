#!/usr/bin/env bash
# Base16 Spacemacs - Mate Terminal color scheme install script
# Nasser Alshammari (https://github.com/nashamri/spacemacs-theme)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Spacemacs Light"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-spacemacs-light"
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
dset palette "'#f8f8f8:#f2241f:#67b11d:#b1951d:#4f97d7:#a31db1:#2d9574:#a3a3a3:#585858:#f2241f:#67b11d:#b1951d:#4f97d7:#a31db1:#2d9574:#1f2022'"
dset background-color "'#f8f8f8'"
dset foreground-color "'#444155'"
dset bold-color "'#444155'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
