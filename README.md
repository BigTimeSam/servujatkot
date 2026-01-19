# Laniservut

## Prerequisites
- x86 Unix environment (Linux, WSL or Mac)
- Docker Compose

## Usage

### Mumble and Pro Pilkki 2
```
# In repository root
docker compose up -d
```

### CS2
Make sure your user has `uid=1000` and `gid=1000`, as the container user has `uid=1000` and needs write access to the bind mount. This can be checked with the `id` command.
If your user ID is something else, run the following commands:

```
cd cs2
mkdir data
chown -R 1000:1000 cs2/data
```

Start server with the helper script, plugins and configuration are automatic:

```
cd cs2
./up.sh

# Stop server if needed
./down.sh
```

### Setting up matches
All commands in `monospace` go to all chat.

1. Connect to the server
1. Pick the correct map: `.map de_anubis`
1. Adjust CSTV delay: `.rcon tv_delay 0`
1. Name the teams:
    * CT: `.team1 Team1Name`
    * T: `.team2 Team2Name`
1. Confirm settings: `.settings`
    * Knife round: `.rk`
    * Swap teams if needed with `.rcon mp_swapteams`
1. Wait for everyone to connect and for them to do`.ready`
1. Game starts instantly when 10 players are ready

> [!IMPORTANT]
> When the server is up and the match is about to start, make sure to adjust the CSTV delay.
> The delay is somewhat big by default, and it should be set to 0 for optimal and spoiler-free casting experience.
> Send `.rcon tv_delay 0` to the chat when the match is about to start.


### CS2 MatchZy commands
Everyone is an admin. Commands below can be used to set up maps and matches.

Remember to set team names with `.team1 Team1Name` and `.team2 Team2Name`.
Demos are recorded with team names, it is easier to figure out the matchups when gathering demos for analysis.

https://shobhit-pathak.github.io/MatchZy/commands/

### CS2 RCON
RCON is available in CS2 chat:

```
.rcon mp_friendlyfire 1
```

## Mumble
Login with username `SuperUser` with the password from `.env`.

Server configuration can then be done from the Mumble client.
Channels are added by first right clicking server root and then Add.

By default, SuperUser cannot talk. If a user needs admin rights and wants to be able to talk, someone needs to connect as SuperUser and add that user to the `admin` group:

1. Right click server root -> Edit
2. Go to Groups tab
3. Choose `admin` group
4. Pick user or write username into field next to Add button under Members
5. Click Add

## Pro Pilkki 2

https://propilkki.net/wp/verkkopelien-komennot/

### Starting the map
1. Connect to the server
2. Obtain admin privileges by entering `/admin <adminpassword>` in chat
3. Set map by picking the correct line from `propilkki2/autohost.ini` and pasting to chat
4. Type `/wait 300` to start the map in 300 seconds. (A high value is preferred for a break between maps)
5. After the map has finished, the wait time specified above will pass and the next map will start. Set the next map with instructions from step 3 before that happens.

### Configuration
Configuration is applied at Docker image build time.

Edit `propilkki/pp2host.conf` and `propilkki/autohost.ini` and force rebuild:

```
docker compose up -d --build propilkki2
```

By default only `$ORGA`, `$ADMIN` and `$PILKKI_PW` variables are passed to the build process.

## Troubleshooting

### CS2: Server not starting
Check that `cs2/data` has content, it should have a directory structure of `game/csgo` that contains the game files.
If not, run `chown -R 1000:1000 cs2/data` and restart the server.

### CS2: MatchZy commands not working
This has happened when trying to run the initial setup once with the wrong user. The addons directory gets created with the wrong user as owner and might not be fixed with the `chown` above.
The fix is similar, but the command to run is now `chown -R 1000:1000 cs2/data/game/csgo/addons`.

### CS2: Client is out of date
Redownload server files:

```
cd cs2

# Server is started automtically after repair
./repair.sh
```

### CS2: Client delta ticks out of order

This happens when spectating via CSTV, but the reason for it is unknown.
You are able to reconnect and carry on, make sure to have the connection command handy.

### CS2: Logs

```
cd cs2
docker compose logs -f
```