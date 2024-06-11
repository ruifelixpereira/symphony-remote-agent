#!/bin/bash

#./symphony-agent -c ./symphony-agent.json -l Debug
./symphony-api -c ./symphony-agent.json -l Debug

#nohup ./symphony-agent -c ./symphony-agent.json -l Debug > $HOME/local/symphony-agent-output.log 2>&1 &
