#!/bin/sh

set -eu

# shellcheck disable=1090
. "${0%/*}/.version"

assure_exists() {
  exe=${1:?}
  [ -f "$exe" ] && return 0

  dir="${exe%/*}"
  mkdir -p "$dir"
  # shellcheck disable=2064
  trap "rm -Rf '$dir'" INT

  (
    cd "$dir"
    {
      url="https://github.com/share-secrets-safely/cli/releases/download/$VERSION/sy-cli-$(uname -s)-x86_64.tar.gz"
      echo 1>&2 "Downloading $url..."
      if which wget > /dev/null 2>&1; then
        if readlink "$(which wget)" | grep -q busybox; then
          wget -q -O - "$url"
        else
          wget --show-progress -q -O - "$url"
        fi
      elif which curl > /dev/null 2>&1; then
        curl -L --progress "$url"
      else
        echo 1>&2 "Cannot find a program suitable to download '$url'"
        echo 1>&2 "Tried 'curl' and 'wget'"
        exit 2
      fi
    } | tar xzf -
  )
}
