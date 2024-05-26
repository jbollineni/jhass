#!/usr/bin/with-contenv bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config_file=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."

# Start creation of configuration

echo "[stream]" > "${config_file}"
for stream in $(bashio::config 'stream.streams'); do
    echo "stream = ${stream}" >> "${config_file}"
done
echo "buffer = $(bashio::config 'stream.buffer')" >> "${config_file}"
echo "codec = $(bashio::config 'stream.codec')" >> "${config_file}"
echo "send_to_muted = $(bashio::config 'stream.send_to_muted')" >> "${config_file}"
echo "sampleformat = $(bashio::config 'stream.sampleformat')" >> "${config_file}"

echo "[http]" >> "${config_file}"
echo "enabled = $(bashio::config 'http.enabled')" >> "${config_file}"
echo "doc_root = $(bashio::config 'http.docroot')" >> "${config_file}"

echo "[tcp]" >> "${config_file}"
echo "enabled = $(bashio::config 'tcp.enabled')" >> "${config_file}"

echo "[logging]" >> "${config_file}"
echo "debug = $(bashio::config 'logging.enabled')" >> "${config_file}"

echo "[server]" >> "${config_file}"
echo "threads = $(bashio::config 'server.threads')" >> "${config_file}"

echo "[server]" >> "${config_file}"
echo "datadir = $(bashio::config 'server.datadir')" >> "${config_file}"

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /etc/snapserver.conf
