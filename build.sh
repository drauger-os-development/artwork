#!/bin/bash
VERSION=$(cat DEBIAN/control | grep 'Version: ' | sed 's/Version: //g')
PAK=$(cat DEBIAN/control | grep 'Package: ' | sed 's/Package: //g')
ARCH="$1"
if [ "$ARCH" == "" ] || [ "$ARCH" == "amd64" ] || [ "$ARCH" == "AMD64" ] || [ "$ARCH" == "AMD" ] || [ "$ARCH" == "amd" ] || [ "$ARCH" == "x86_64" ] || [ "$ARCH" == "x86" ] || [ "$ARCH" == "x64" ]; then
	ARCH="amd64"
elif [ "$ARCH" == "ARM" ] || [ "$ARCH" == "arm" ] || [ "$ARCH" == "ARM64" ] || [ "$ARCH" == "arm64" ]; then
	ARCH="arm64"
fi
FOLDER="$PAK\_$VERSION\_$ARCH"
FOLDER=$(echo "$FOLDER" | sed 's/\\//g')
mkdir ../"$FOLDER"
##############################################################
#							     #
#							     #
#  COMPILE ANYTHING NECSSARY HERE			     #
#							     #
#							     #
##############################################################
echo "Building for $ARCH"
##############################################################
#							     #
#							     #
#  REMEMBER TO DELETE SOURCE FILES FROM TMP		     #
#  FOLDER BEFORE BUILD					     #
#							     #
#							     #
##############################################################
if [ -d bin ]; then
	cp -R bin ../"$FOLDER"/bin
fi
if [ -d etc ]; then
	cp -R etc ../"$FOLDER"/etc
fi
if [ -d usr ]; then
	cp -R usr ../"$FOLDER"/usr
fi
if [ -d lib ]; then
	cp -R lib ../"$FOLDER"/lib
fi
if [ -d lib32 ]; then
	cp -R lib32 ../"$FOLDER"/lib32
fi
if [ -d lib64 ]; then
	cp -R lib64 ../"$FOLDER"/lib64
fi
if [ -d libx32 ]; then
	cp -R libx32 ../"$FOLDER"/libx32
fi
if [ -d sbin ]; then
	cp -R sbin ../"$FOLDER"/sbin
fi
if [ -d var ]; then
	cp -R var ../"$FOLDER"/var
fi
if [ -d opt ]; then
	cp -R opt ../"$FOLDER"/opt
fi
cp -R DEBIAN ../"$FOLDER"/DEBIAN
BASE="$PWD"
cd ..
# Remove and edit files
# Make sure we have all needed folders

# done
dpkg-deb --build "$FOLDER"
rm -rf "$FOLDER"
cd "$BASE"
if [ ! -d build ]; then
	mkdir -v build
fi
mv ../"$FOLDER".deb build/"$FOLDER".deb
