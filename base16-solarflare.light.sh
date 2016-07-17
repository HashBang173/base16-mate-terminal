#!/usr/bin/env bash
# Base16 Solar Flare - Mate Terminal color scheme install script
# Chuck Harmston (https://chuck.harmston.ch)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Solar Flare Light"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-solarflare-light"
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
dset palette "'#F5F7FA:#EF5253:#7CC844:#E4B51C:#33B5E1:#A363D5:#52CBB0:#A6AFB8:#667581:#EF5253:#7CC844:#E4B51C:#33B5E1:#A363D5:#52CBB0:#18262F'"
dset background-color "'#F5F7FA'"
dset foreground-color "'#586875'"
dset bold-color "'#586875'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
