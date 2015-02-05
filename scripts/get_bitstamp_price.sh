#!/bin/bash

curl --silent https://www.bitstamp.net/api/ticker/ | awk '{ print $4 }' | cut -d "\"" -f 2 | cut -d "." -f 1
