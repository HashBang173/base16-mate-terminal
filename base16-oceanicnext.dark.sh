#!/usr/bin/env bash
# Base16 OceanicNext - Mate Terminal color scheme install script
# https://github.com/voronianski/oceanic-next-color-scheme

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 OceanicNext Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-oceanicnext-dark"
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
dset palette "'#1B2B34:#EC5f67:#99C794:#FAC863:#6699CC:#C594C5:#5FB3B3:#C0C5CE:#65737E:#EC5f67:#99C794:#FAC863:#6699CC:#C594C5:#5FB3B3:#D8DEE9'"
dset background-color "'#1B2B34'"
dset foreground-color "'#C0C5CE'"
dset bold-color "'#C0C5CE'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
