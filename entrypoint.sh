#!/bin/sh

# Ensure we are starting with the correct configurations
if [ -f "/config/config.yaml" ]; then
    echo "Using configuration from /config/config.yaml"
else
    echo "Error: Configuration file not found!" && exit 1
fi

# Start FRPC with the provided configuration
frpc -c /config/config.yaml
