docker compose down
mkdir -p data
rm -rf data/game/csgo/{cssharp,matchzy}.zip data/game/csgo/metamod.tar.gz
STEAMAPPVALIDATE=1 docker compose up -d cs2
