alias repow!="killall -9 pow"

function repow {
  pushd "$(git rev-parse --show-toplevel)" > /dev/null
  if [[ ! -d 'tmp' ]]; then
    mkdir tmp
  fi
  touch tmp/restart.txt
  popd > /dev/null
}