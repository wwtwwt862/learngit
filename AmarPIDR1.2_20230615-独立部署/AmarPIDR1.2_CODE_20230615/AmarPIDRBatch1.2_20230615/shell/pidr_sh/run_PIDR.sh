#!/bin/sh
sh startup.sh datacopy
sh startup.sh preparerate
sh startup.sh preparecreass
sh startup.sh validate
sh startup.sh rating
sh startup.sh transfer
sh startup.sh report