#!/bin/sh -e

if [ -n "$@" ]; then
  exec "$@"
fi

ARGS="ngrok"

# Set the protocol.
if [ "$NGROK_PROTOCOL" = "TCP" ]; then
  ARGS="$ARGS tcp"
else
  ARGS="$ARGS http"
  NGROK_PORT="${NGROK_PORT:-80}"
fi

# Set a custom region
if [ -n "$NGROK_REGION" ]; then
  ARGS="$ARGS -region=$NGROK_REGION "
fi

if [ -n "$NGROK_HEADER" ]; then
  ARGS="$ARGS -host-header=$NGROK_HEADER "
fi

if [ -n "$NGROK_USERNAME" ] && [ -n "$NGROK_PASSWORD" ] && [ -n "$NGROK_AUTH" ]; then
  ARGS="$ARGS -auth=\"$NGROK_USERNAME:$NGROK_PASSWORD\" "
elif [ -n "$NGROK_USERNAME" ] || [ -n "$NGROK_PASSWORD" ]; then
  if [ -z "$NGROK_AUTH" ]; then
    echo "You must specify a username, password, and Ngrok authentication token to use the custom HTTP authentication."
    echo "Sign up for an authentication token at https://ngrok.com"
    exit 1
  fi
fi

ARGS="$ARGS -log stdout"

# Set the port.
if [ -z "$NGROK_PORT" ]; then
  echo "You must specify a NGROK_PORT to expose."
  exit 1
fi
ARGS="$ARGS `echo $NGROK_PORT | sed 's|^tcp://||'`"

set -x
exec $ARGS
