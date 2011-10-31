Use by running any of the following

	./update-synclient-settings.sh
	bash update-synclient-settings.sh

This script creates a bash script which re-applies your current synclient settings on startup.  
The startup script is created in *$HOME/.config/apply-synclient-settings.sh*.  
The startup entry is created in *$HOME/.config/autostart/apply-synclient-settings.desktop*.

--

Edit your synclient settings by using *synclient setting=value*.  
To view all settings and values, run

	synclient -l


To set the value of MinSpeed to 0.1 for example, do

	synclient MinSpeed=0.1


After completing all changes, run this script to save the settings.

