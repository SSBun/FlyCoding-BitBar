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

# Get Beijing weather.
getBeijingWeather() {	
	user=`echo ~`
	path="$user/Desktop/BitBar/utils/weather.py"
	result=`python3 $path`
	if test ${#result} -ge 1; then
		str=""
		index=0
		oldIFS=$IFS
		IFS=,
		
		for item in $result;
		do
			if test $index -eq 0; then
				str+="\e[1;32m $item \e[0m"
			elif test $index -eq 1; then
				str+="\e[1;32m $item \e[0m"
			elif test $index -eq 2; then
				str+="\e[1;34m $item \e[0m"
			elif test $index -eq 3; then
				str+="\e[1;31m $item \e[0m"
			fi
			let index+=1
		done
				
		IFS=$oldIFS		
		echo -e $str
		return 0
	fi
	echo $result
}

##### Execute script ######
if test $# -ge 1; then
	method=$1
	shift
	$method $*
	
	# Default return succes code.
	return 0
fi


# The path of current shell file.
path="`pwd`/$0"
path=${path//' '/'\ '}


#echo Bit bar
echo "🚀 `getBeijingWeather` 🚀 | font='Arial Rounded MT Bold"
echo ---
echo Finder
echo -- Display all files ?
echo "---- ✅ YES | bash="$path" param1=showAllFiles param2=1 terminal=false"
echo "---- ❌ NO | bash="$path" param1=showAllFiles param2=0 terminal=false"
echo "-- Clean Xcode derived folder | bash="$path" param1=cleanXcodeDerivedFolder terminal=false"
