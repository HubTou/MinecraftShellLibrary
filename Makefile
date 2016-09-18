# @(#) MinecraftShellLibrary:Makefile v1.00 (2016-09-18) / Hubert Tournier

VERSION=1.00

DEFAULTDESTDIR=/home/minecraft
DEFAULTUSER=minecraft
DEFAULTGROUP=minecraft

tarball:
	@tar czf MinecraftShellLibrary-${VERSION}.tar.gz License Makefile ReadMe README.md .minecraft-library .server-settings.ini Commands CronTasks

verifyprerequisites:
	@[ "`whereis screen | sed "s/screen://"`" = "" ] && echo "WARNING: GNU Screen doesn't seem to be installed. You'll need it!"
	@[ "`whereis nbt2yaml | sed "s/nbt2yaml://"`" = "" ] && echo "WARNING: NBT2YAML doesn't seem to be installed. You'll need it!"

install: verifyprerequisites
	@echo -n "Destination directory [$(DEFAULTDESTDIR)]: " ; \
	read DESTDIR ; \
	[ "$$DESTDIR" = "" ] && DESTDIR=$(DEFAULTDESTDIR) ; \
	echo -n "Minecraft user [$(DEFAULTUSER)]: " ; \
	read USER ; \
	[ "$$USER" = "" ] && USER=$(DEFAULTUSER) ; \
	echo -n "Minecraft group [$(DEFAULTGROUP)]: " ; \
	read GROUP ; \
	[ "$$GROUP" = "" ] && GROUP=$(DEFAULTGROUP) ; \
	install -m 0755 -o $$USER -g $$GROUP .minecraft-library $$DESTDIR ; \
	install -m 0755 -o $$USER -g $$GROUP .server-settings.ini $$DESTDIR ; \
	[ ! -f $$DESTDIR/.server-settings ] && cp .server-settings.ini $$DESTDIR/.server-settings ; \
	cp -R Commands CronTasks $$DESTDIR ; \
	chown -R $$USER:$$GROUP $$DESTDIR/Commands $$DESTDIR/CronTasks $$DESTDIR/.server-settings ; \
	chmod 0755 $$DESTDIR/Commands $$DESTDIR/CronTasks $$DESTDIR/.server-settings ; \
	mv $$DESTDIR/Commands/* $$DESTDIR ; \
	rmdir $$DESTDIR/Commands

