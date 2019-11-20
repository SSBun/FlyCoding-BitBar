#!/usr/local/bin/bash

# <bitbar.title>FlyCoding For BitBar</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>SSBun</bitbar.author>
# <bitbar.author.github>https://github.com/SSBun</bitbar.author.github>
# <bitbar.image>https://avatars3.githubusercontent.com/u/13583118?s=460&v=4</bitbar.image>
# <bitbar.desc>Small tools for iOS developers</bitbar.desc>




##### About Finder #####

# Display all hidden files.
# - param1: Either 1 or 0, 1 display, 0 hide.
showAllFiles() {
	show=YES
	if [ $1 -eq 1 ]; then
		show=YES
	else
		show=NO
	fi
	defaults write com.apple.finder AppleShowAllFiles $show; killall Finder /System/Library/CoreServices/Finder.app
	return 0
}

# Remove Xcode derived data folder.
cleanXcodeDerivedFolder() {
	xcodeDerivedFolderPath="`echo ~`/Library/Developer/Xcode/DerivedData"	
	rm -r $xcodeDerivedFolderPath
	osascript -e 'display notification "Clean Xcode derived data completion." with title "FlyCoding-BitBar"'
}

##### Execute script ######
if test $# -ge 1; then	
	method=$1
	shift
	$method $*
#	if [[ $1 == showAllFiles ]]; then
#		shift
#		showAllFiles $*
#	fi	
	# Default return succes code.
	return 0
fi


# The path of current shell file.
path="`pwd`/$0"
path=${path//' '/'\ '}

echo FlyCoding-BitBar
echo ---
echo Finder
echo -- Display all files ?
echo "---- ✅ YES | bash="$path" param1=showAllFiles param2=1 terminal=false"
echo "---- ❌ NO | bash="$path" param1=showAllFiles param2=0 terminal=false"
echo "-- Clean Xcode derived folder | bash="$path" param1=cleanXcodeDerivedFolder terminal=false"


	