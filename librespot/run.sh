#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

LIBRESPOT_NAME="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_USER="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_PASSWORD="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_INITVOL="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_DEVICE="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_BITRATE="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_DEVICETYPE="$(bashio::config 'LIBRESPOT_NAME')"
LIBRESPOT_BACKEND="$(bashio::config 'LIBRESPOT_NAME')"

mkdir -p /share/snapcast/
mkfifo /share/snapcast/fifo

echo "Start Librespot..."
librespot -n "$LIBRESPOT_NAME" -u "$LIBRESPOT_USER" -p "$LIBRESPOT_PASSWORD" --device "$LIBRESPOT_DEVICE" --backend "$LIBRESPOT_BACKEND" -b "$LIBRESPOT_BITRATE" --initial-volume "$LIBRESPOT_INITVOL" --device-type "$LIBRESPOT_DEVICETYPE"
