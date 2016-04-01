#!/bin/bash

set -e

PLUGIN_TXT=${PLUGIN_TXT:-/usr/share/elasticsearch/config/plugins.txt}
PLUGINS_PATH="/usr/share/elasticsearch/plugins"
PLUGIN_BIN="/usr/share/elasticsearch/bin/plugin"
ELASTIC_CONFIG="/usr/share/elasticsearch/config/elasticsearch.yml"


while [ ! -f $ELASTIC_CONFIG ]; do
    sleep 1
done

if [ -f "$PLUGIN_TXT" ]; then
    for plugin in $(<"${PLUGIN_TXT}"); do
        if [ -d "$PLUGINS_PATH/$plugin" ]; then
          echo "Plugin '$plugin' is already installed, skipping..."
        else
          echo "Plugin '$plugin' is missing..."
          $PLUGIN_BIN install $plugin
        fi
    done
fi

exec /docker-entrypoint.sh elasticsearch
