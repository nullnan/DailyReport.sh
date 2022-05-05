function _md5() {
  echo -n $1 | md5sum | gawk '{print $1}'
}

function _base64() {
  echo -n $1 | base64
}

function get_config() {
  jq -r ".$1" config.json
}

function clean() {
  rm TOKEN CONTENT LAST_TIME
}