FROM ubuntu:22.04
RUN apt update && apt install curl wget git sudo build-essential gcc make libapache2-mod-neko neko-dev libapr1 libmariadb3 mariadb-common mysql-common neko -y
COPY haxe.sh /tmp/haxe.sh

WORKDIR /tmp
RUN chmod +x haxe.sh
RUN sh haxe.sh -y

RUN haxelib install lime
RUN haxelib install openfl
RUN haxelib install flixel
RUN haxelib run lime setup flixel
RUN haxelib run lime setup -y

RUN haxelib install flixel
RUN haxelib install flixel-addons
RUN haxelib install flixel-ui
RUN haxelib install hscript
RUN haxelib install newgrounds
RUN haxelib git polymod https://github.com/larsiusprime/polymod.git
RUN haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
RUN haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
RUN haxelib install hxcpp-debug-server

RUN git clone https://github.com/FunkinCrew/Funkin.git funkin
COPY APIStuff.hx /tmp/funkin/source/APIStuff.hx
WORKDIR /tmp/funkin
RUN lime test linux