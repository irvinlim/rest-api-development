#!/bin/bash

set -e

export PORT=80

cd /var/www/app
echo "Initializing web app server..."
echo

# Install dependencies.
npm install

# Start the app server in the background.
echo "Starting web app server..."
npm run dev &

# Wait until server is running.
until $(curl --output /dev/null --silent --head --fail http://localhost:$PORT); do
    sleep 1
done

echo 
echo "Web app server running at http://localhost:$PORT"
echo "=================="
echo
