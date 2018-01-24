#!/usr/bin/env bash
# linux only plij && 64 bit only plij

curl "https://excellmedia.dl.sourceforge.net/project/spimsimulator/qtspim_9.1.20_linux64.deb" > qtspim_9.1.20_linux64.deb
sudo dpkg -i qtspim_9.1.20_linux64.deb
echo "installed qtspim"
echo "-------------"
echo "run it with:"
echo "$ qtspim"