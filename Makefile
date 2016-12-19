# @(#) MinecraftShellLibrary:Makefile (2016-09-30) / Hubert Tournier

VERSION=1.11

DEFAULTDESTDIR=/home/minecraft
DEFAULTUSER=minecraft
DEFAULTGROUP=minecraft

# Commands without display
OLD_WOD_CMD=achievement ban ban-ip mcclear debug defaultgamemode deop difficulty effect enchant gamemode gamerule give help kick mckill me op pardon playsound save-all save-on save-off say setblock setidletimeout setworldspawn spawnpoint spreadplayers summon tell tellraw testfor testforblock mctime toggledownfall tp weather xp
108_WOD_CMD=blockdata clone entitydata execute fill particle replaceitem stats testforblocks title trigger worldborder
109_WOD_CMD=stopsound
110_WOD_CMD=teleport
BKT_WOD_CMD=pex pex_reload mute kit
SELECTED_WOD_CMD=${OLD_WOD_CMD} ${BKT_WOD_CMD}

# Commands with display
OLD_WID_CMD=banlist list scoreboard seed whitelist
108_WID_CMD=
109_WID_CMD=
110_WID_CMD=
BKT_WID_CMD=mem mv_who
SELECTED_WID_CMD=${OLD_WID_CMD} ${BKT_WID_CMD}

default: usage

usage:
	@echo "make tarball   : Prepare a .tar.gz file for distributing the library"
	@echo "make install   : Install the library in a user provided Minecraft server directory"
	@echo "make uninstall : Uninstall the library from a user provided Minecraft server directory"

tarball:
	@tar czf MinecraftShellLibrary-${VERSION}.tar.gz License Makefile ReadMe README.md .minecraft-library .server-settings.ini Commands CronTasks Scripts config

verifyprerequisites:
	@if [ "`whereis screen`" = "screen:" ] ; then echo "WARNING: GNU Screen doesn't seem to be installed. You'll need it!" ; fi
	@if [ "`whereis nbt2yaml`" = "nbt2yaml:" ] ; then echo "WARNING: NBT2YAML doesn't seem to be installed. You'll need it!" ; fi

install: verifyprerequisites
	@echo -n "Destination directory [$(DEFAULTDESTDIR)]: " ; \
	read DESTDIR ; \
	[ "$$DESTDIR" = "" ] && DESTDIR=$(DEFAULTDESTDIR) ; \
	if [ ! -d "$$DESTDIR" ] ; \
	then echo "ERROR: There is no Minecraft server in $$DESTDIR" ; \
	exit 0 ; \
	fi ; \
	echo -n "Minecraft user [$(DEFAULTUSER)]: " ; \
	read USER ; \
	[ "$$USER" = "" ] && USER=$(DEFAULTUSER) ; \
	echo -n "Minecraft group [$(DEFAULTGROUP)]: " ; \
	read GROUP ; \
	[ "$$GROUP" = "" ] && GROUP=$(DEFAULTGROUP) ; \
	install -m 0755 -o $$USER -g $$GROUP .minecraft-library $$DESTDIR ; \
	install -m 0755 -o $$USER -g $$GROUP .server-settings.ini $$DESTDIR ; \
	[ ! -f $$DESTDIR/.server-settings ] && cp .server-settings.ini $$DESTDIR/.server-settings ; \
	mkdir -p $$DESTDIR/Commands/setuid ; \
	for I in $(SELECTED_WOD_CMD) ; \
	do \
		ln Commands/Wrapper $$DESTDIR/Commands/$$I ; \
		ln Commands/setuid/GenericCommandWithoutResults $$DESTDIR/Commands/setuid/$$I ; \
	done ; \
	for I in $(SELECTED_WID_CMD) ; \
	do \
		ln Commands/Wrapper $$DESTDIR/Commands/$$I ; \
		ln Commands/setuid/GenericCommandWithResults $$DESTDIR/Commands/setuid/$$I ; \
	done ; \
	ln Commands/Wrapper $$DESTDIR/Commands/mc ; \
	ln Commands/setuid/PassThrough $$DESTDIR/Commands/setuid/mc ; \
	mkdir -p $$DESTDIR/CronTasks ; \
	install -m 0755 -o $$USER -g $$GROUP CronTasks/CronMonitor $$DESTDIR/CronTasks ; \
	install -m 0755 -o $$USER -g $$GROUP CronTasks/CronDetectCheaters $$DESTDIR/CronTasks ; \
	mkdir -p $$DESTDIR/Scripts/setuid ; \
	install -m 0755 -o $$USER -g $$GROUP Scripts/mcchat $$DESTDIR/Scripts ; \
	install -m 0755 -o $$USER -g $$GROUP Scripts/mclast $$DESTDIR/Scripts ; \
	ln Scripts/Wrapper $$DESTDIR/Scripts/start.sh ; \
	ln Scripts/Wrapper $$DESTDIR/Scripts/stop ; \
	install -m 0755 -o $$USER -g $$GROUP Scripts/setuid/start.sh $$DESTDIR/Scripts/setuid ; \
	install -m 0755 -o $$USER -g $$GROUP Scripts/setuid/startbukkit.sh $$DESTDIR/Scripts/setuid ; \
	install -m 0755 -o $$USER -g $$GROUP Scripts/setuid/stop $$DESTDIR/Scripts/setuid ; \
	install -m 0644 -o $$USER -g $$GROUP config/MSL_ForbiddenMods.txt-ini $$DESTDIR/config ; \
	[ ! -f $$DESTDIR/config/MSL_ForbiddenMods.txt ] && cp config/MSL_ForbiddenMods.txt-ini $$DESTDIR/config/MSL_ForbiddenMods.txt ; \
	install -m 0644 -o $$USER -g $$GROUP config/MSL_ForbiddenMods-full.txt-ini $$DESTDIR/config ; \
	[ ! -f $$DESTDIR/config/MSL_ForbiddenMods-full.txt ] && cp config/MSL_ForbiddenMods-full.txt-ini $$DESTDIR/config/MSL_ForbiddenMods-full.txt ; \
	chown -R $$USER:$$GROUP $$DESTDIR/Commands $$DESTDIR/CronTasks $$DESTDIR/Scripts $$DESTDIR/.server-settings ; \
	chmod 0755 $$DESTDIR/Commands $$DESTDIR/CronTasks $$DESTDIR/Scripts $$DESTDIR/.server-settings

uninstall:
	@echo -n "Destination directory [$(DEFAULTDESTDIR)]: " ; \
	read DESTDIR ; \
	[ "$$DESTDIR" = "" ] && DESTDIR=$(DEFAULTDESTDIR) ; \
	if [ ! -d "$$DESTDIR" ] ; \
	then echo "ERROR: There is no Minecraft server in $$DESTDIR" ; \
	exit 0 ; \
	fi ; \
	rm -f $$DESTDIR/.minecraft-library $$DESTDIR/.server-settings.ini ; \
	rm -f $$DESTDIR/CronTasks/CronMonitor $$DESTDIR/CronTasks/CronDetectCheaters ; \
	rm -f $$DESTDIR/Scripts/mcchat $$DESTDIR/Scripts/mclast $$DESTDIR/Scripts/start.sh $$DESTDIR/Scripts/stop ; \
	rm -f $$DESTDIR/Scripts/setuid/start.sh $$DESTDIR/Scripts/setuid/startbukkit.sh $$DESTDIR/Scripts/setuid/stop ; \
	rm -f $$DESTDIR/config/MSL_ForbiddenMods.txt-ini $$DESTDIR/config/MSL_ForbiddenMods-full.txt-ini ; \
	rm -f $$DESTDIR/Commands/mc $$DESTDIR/Commands/setuid/mc ; \
	for I in $(SELECTED_WOD_CMD) ; \
	do \
		rm -f $$DESTDIR/Commands/$$I ; \
		rm -f $$DESTDIR/Commands/setuid/$$I ; \
	done ; \
	for I in $(SELECTED_WID_CMD) ; \
	do \
		rm -f $$DESTDIR/Commands/$$I ; \
		rm -f $$DESTDIR/Commands/setuid/$$I ; \
	done
