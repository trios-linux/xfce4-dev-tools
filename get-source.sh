#!/bin/bash
#
# Fetches and extracts specified XFCE 4.12 source package, allowing
# us to keep only /debian for it in git.
#
# 2015 Filip Danilovic <filip@openmailbox.org>


# Set the package name:
PKG=xfce4-dev-tools-4.12.0.tar.bz2


# Set the directory in which to download/extract
# This is meant for workspace/build dir on Jenkins!
DIR=jenkins-build


# If directory is set and exists, change to it.

if [ -z $DIR ] && [ -d $DIR ];
then
	cd $DIR
fi


# If no argument is given, default to just downloading the package.

if [ ! -f $PKG ]; 
then
	wget http://archive.xfce.org/xfce/4.12/src/$PKG
else
	echo "$PKG exists, skipping download"
fi


# If argument is "-x", download and extract package.

if [ "$1" = "-x" ];
then
	if [ ! -f $PKG ]; 
	then
		wget http://archive.xfce.org/xfce/4.12/src/$PKG
	else
		echo "$PKG exists, skipping download"
	fi
	tar xvjf $PKG --strip 1
fi


# If arguments are "-x" & "-r", download, extract and remove package.
# Might be needed to prevent dpkg from complaining during package building.

if [ "$1" = "-x" ] && [ "$2" = "-r" ];
then
	if [ ! -f $PKG ]; 
	then
		wget http://archive.xfce.org/xfce/4.12/src/$PKG
	else
		echo "$PKG found, skipping download"
	fi
	tar xvjf $PKG --strip 1 && rm -v $PKG
fi


# If arguments are "-x" & "-m", download, extract and move package.

if [ "$1" = "-x" ] && [ "$2" = "-m" ];
then
	if [ ! -f $PKG ]; 
	then
		wget http://archive.xfce.org/xfce/4.12/src/$PKG
	else
		echo "$PKG found, skipping download"
	fi
	tar xvjf $PKG --strip 1 && mv -f -v $PKG ../
fi