function fpd {
  local dir
  dir=$(find "$@" -type d | fzf)
  if [ -d "$dir" ]; then
    pushd "$dir"
  fi
}
