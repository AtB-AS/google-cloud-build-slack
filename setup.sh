#!/bin/bash

# Create config file with SLACK_WEBHOOK_URL and GC_SLACK_STATUS.
if [ -z "$GC_SLACK_STATUS" ]; then
  export GC_SLACK_STATUS="SUCCESS FAILURE TIMEOUT INTERNAL_ERROR"
fi
arr=(`echo ${GC_SLACK_STATUS}`);
json_array() {
  echo -n '['
  while [ $# -gt 0 ]; do
    x=${1//\\/\\\\}
    echo -n \"${x//\"/\\\"}\"
    [ $# -gt 1 ] && echo -n ', '
    shift
  done
  echo ']'
}
cat <<EOF > config.json
{
  "SLACK_WEBHOOK_URL" : "$SLACK_WEBHOOK_URL",
  "GC_SLACK_STATUS": $(json_array "${arr[@]}")
}
EOF
