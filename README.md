:warning: Due to [Microsoft inept policy concerning Minecraft accounts](https://help.minecraft.net/hc/en-us/articles/19615552270221) I no longer have access to the game and thus won't maintain this software anymore

About Minecraft Shell Library
=============================
An API for Minecraft / Forge / Bukkit server management and scripting.


Installation
============
You'll need to know the location of your Minecraft server root directory (the place where you have your server.properties file), and the operating system user and group it runs under.

After that just type "make install" and answer those questions.

For an initial installation, you'll have to tweak the settings to your taste in the .server-settings installed file.
Else verify if there are new configuration items to import in your existing server configuration.

Also add the Commands and Scripts subdirectories to the PATH of your Minecraft system account.


Usage
=====
Include the following line near the start of your shell scripts:

. .minecraft-library

Then you can use all the functions in the library.

Check Scripts/mcchat for a little example.

The functions list is located at the start of the .minecraft-library file.
For parameters, check each function header.

The library is fully documented at the following Web address:
http://lotr-minecraft-mod-exiles.wikia.com/wiki/Minecraft_Shell_Library


Caveats
=======
Developed and tested only on FreeBSD 10.1.


Versions and changelog
======================
1.11	2016-12-19

			Corrected blocking syntax typo in the stop script
			Added an XRay mod to the mod's ban list

1.10	2016-09-30

			Added a StripColors() function for filtering out color codes from logfiles
			Added a DisplayChat() function for filtering the chat from a logfile
			Added a GetClientSideModsForPlayer() function for getting the list of client side mods used by a player
			Added a GetForbiddenModsForPlayer() function for getting the list of forbidden client side mods used by a player
			Corrected errors in ToggleNbtValue(), GetOnlinePlayers()
			
			Made generic wrappers for commands, with or without results to display
			Separated the /mem and /mv who commands from the mem command
			Corrected display glitches from the mem command
			Moved all commands out of the server root directory, back in the Commands subdir
			Added all the standard Minecraft commands
			
			Added a Script sub-directory to store Scripts
			Moved start* and stop commands to the Scripts subdirectory
			Made the start command obey the .dontrestart directive and check if the server is already loaded
			Added a mcchat script to display the chat
			Added a mclast script to display players' log in and out from logfiles
			
			Added a CronDetectCheaters Cron script to check if players are using forbidden client side mods and, if yes, apply justice to them
			Added MSL_ForbiddenMods.txt and MSL_ForbiddenMods-full.txt config files in tge config subdir with the list of forbidden mods
			
			Added usage and uninstall targets to the Makefile

1.00	2016-09-18	Initial public release


Further development plans
=========================
I'm considering to add custom shell commands, which could be implemented either through a non existent /-prefixed command to be caught in the server log, through a "/mail send" Bukkit Essentials command sent to an admin account, or better through a gateway mod or plugin which would also pass additional info (player position, item held, block being aimed at, etc.).

Everybody is also welcome to complete the forbidden client side mods list.


License
=======
This open source software is distributed under a BSD license (see the "License" file for details).


Author
======
Hubert Tournier
December, 19 2016
