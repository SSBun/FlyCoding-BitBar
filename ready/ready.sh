#!/bin/bash

# Instlal brew
brew --version
if test $? -eq 0; then
	echo -e "✅\e[1;32m The brew is already installed. \e[0m"
else
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"	
	if test $? -eq 0; then
		echo -e "✅\e[1;32m Install brew successful. \e[0m"
	else
		echo -e "❌\e[1;31m Install brew failure. \e[0m"
	fi
fi

# Install bash 4.0
brew install bash

# Install Python 3.0
brew install python

# Install requests
pip3 install requests