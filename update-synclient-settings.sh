#!/bin/bash
#
#   Synclient settings saver
#
# - Author: Seon Wook Park
# - Date: 31st Oct 2011
#
# Run after changing settings via `synclient`

APPNAME="apply-synclient-settings"
TMPFILE=".synclient.out"
TMPFOLDER="/tmp"
SYNFILE=$HOME"/.config/"$APPNAME".sh"

# Check if synclient is accessible
if [[ `command -v synclient` == '' ]]; then
	echo "Error: synclient is not installed"
	exit
fi

# Change directory to tmp
cd $TMPFOLDER

# Remove synclient updating file if it exists
if [ -e $SYNFILE ]; then
	rm $SYNFILE
fi

# Add bash header to new file
echo "#!/bin/bash" >> $SYNFILE

# Grab output from synclient
echo "Grabbing current settings from synclient..."
synclient -l > $TMPFILE

# Parse synclient output
echo "Parsing settings..."
while read line; do
	if [[ $line =~ ([[:alnum:]]+)[[:space:]]*=[[:space:]]*([0-9\.]+) ]]; then
		echo "synclient "${BASH_REMATCH[1]}"="${BASH_REMATCH[2]} >> $SYNFILE
		echo "	"${BASH_REMATCH[1]}"="${BASH_REMATCH[2]}
	fi
done < $TMPFILE
rm $TMPFILE

# Make output file executable
chmod +x $SYNFILE

echo; echo "Settings script created in "$SYNFILE


# Add .desktop for non-KDE DEs
DPFILE=$HOME"/.config/autostart/"$APPNAME".desktop"

if [ -e $DPFILE ]; then
	rm $DPFILE
fi

echo "[Desktop Entry]" >> $DPFILE
echo "Type=Application" >> $DPFILE
echo "Exec="$SYNFILE >> $DPFILE
echo "Hidden=false" >> $DPFILE
echo "NoDisplay=false" >> $DPFILE
echo "Name=Apply Synclient Settings" >> $DPFILE
echo "Comment=Apply your saved synclient settings" >> $DPFILE
echo "X-GNOME-Autostart-enabled=true" >> $DPFILE

echo "Added script to startup"
