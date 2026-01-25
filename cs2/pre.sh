#!/bin/bash

pushd /home/steam/cs2-dedicated/game/csgo

if [ ! -f ./metamod.tar.gz ]; then
  curl -L $METAMOD_RELEASE_URL -o metamod.tar.gz
fi
tar -xf metamod.tar.gz

if [ ! -f ./cssharp.zip ]; then
  curl -L $CSSHARP_RELEASE_URL -o cssharp.zip
fi
unzip -oq cssharp.zip

if [ ! -f ./matchzy.zip ]; then
  curl -L $MATCHZY_RELEASE_URL -o matchzy.zip
fi
unzip -oq matchzy.zip

if ! grep -q "csgo/addons/metamod" ./gameinfo.gi; then
  sed -i 's/^\(\t\t\tGame\tcsgo\)\([^_]\)/\1\/addons\/metamod\r\n\t\t\tGame\tcsgo\2/' ./gameinfo.gi
fi

sed -i 's/matchzy_minimum_ready_required.*/matchzy_minimum_ready_required 0/' ./cfg/MatchZy/config.cfg
sed -i 's/matchzy_everyone_is_admin.*/matchzy_everyone_is_admin true/' ./cfg/MatchZy/config.cfg

cp /home/steam/gamemodes_server.txt ./gamemodes_server.txt

popd

