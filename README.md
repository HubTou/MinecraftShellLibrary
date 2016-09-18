About Minecraft Shell Library
=============================
An API for Minecraft / Bukkit server management and scripting.
Check http://lotr-minecraft-mod-exiles.wikia.com/wiki/Minecraft_Shell_Library for functions list.


Installation
============
You'll need to know the location of your Minecraft server root directory (the place where you have your server.properties file), and the operating system user and group it runs under.

After that just type "make install" and answer those questions.

For an initial installation, you'll have to tweak the settings to your taste in the .server-settings installed file.
Else verify if there are new configuration items to import in your existing server configuration.


Usage
=====
Include the following line near the start of your shell scripts:

. .minecraft-library

Then you can use all the functions in the library.

Check CronTasks/CronMonitor for a little example.

The functions list is located at the start of the .minecraft-library file.
For parameters, check each function header.


Further development plans
=========================
The library works fine for me as it is.
Nonetheless, I think I'll add a function to check if a player is running a forbidden client side mod, which could then be called from a cron script to kick/ban offending players.
I'm also considering to add the remaining Minecraft console commands.


Caveats
=======
Developed and tested only on FreeBSD 10.1.


Versions and changelog
======================
1.00    2016-09-18      Initial public release


License
=======
This open source software is distributed under a BSD license (see the "License" file for details).


Author
======
Hubert Tournier
September, 18 2016
