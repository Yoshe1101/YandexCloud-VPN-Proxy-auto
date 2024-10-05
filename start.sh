#!/bin/bash

#telegram create code env install dependencies & start bot
python3 -m venv ./telegram/env
source ./telegram/env/bin/activate
pip3 install -r ./telegram/requirements.txt


python3 ./telegram/scripts/config.py
python3 ./telegram/bot.py