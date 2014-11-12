#!/bin/bash

# Write the config file
echo "[$(date)] Writing config..."
cat<<EOF>/tmp/gvoicesender/runconfig.py
GV_EMAIL = '${GV_EMAIL}'
GV_PASSWD = '${GV_PASSWD}'
EOF

# Start the application
cd /tmp/gvoicesender
while [ true ]; do
  echo "[$(date)] Starting app"
  ./app.py
  echo "[$(date)] App died"
done

