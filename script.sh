#!/bin/bash

# Script input: the two pdf files generated by Electrum's revealer.cc plugin.

if [ ! -r "$1" -o ! -r "$2" ];then
	echo -e "ERROR: Invalid or missing input.\nUsage:\n\t$0 revealer.pdf secret.pdf\n\nPDF files as generated by Electrum's revealer.cc plugin (see https://revealer.cc/how-to-use/)";
	exit 1;
fi

REVEALER_FILE=$1 ;
SECRET_FILE=$2;

REVEALER_NAME=$(basename -- "$REVEALER_FILE");
REVEALER_NAME="${REVEALER_NAME%.*}";

SECRET_NAME=$(basename -- "$SECRET_FILE");
SECRET_NAME="${SECRET_NAME%.*}";

if [ ! "`echo ${REVEALER_FILE} | grep -i pdf`" -o ! "`echo ${SECRET_FILE} | grep -i pdf`" ];then
	echo "ERROR: input files should be PDF documents generated by Electrum wallet's revealer.cc plugin";
	exit 1;
fi

echo "* Revealer: '$REVEALER_NAME' / Secret: '$SECRET_NAME'";

REVEALER_TEMP=`mktemp`_${REVEALER_NAME};
SECRET_TEMP=`mktemp`_${SECRET_NAME};
REVEALER_TRANSPARENT=`mktemp`_${REVEALER_NAME}_transparent.png;
REVEALED_SECRET="${SECRET_NAME}_revealed_secret.png";

echo "* Converting PDFs to PNGs";
/usr/bin/pdftoppm -singlefile ${REVEALER_FILE} ${REVEALER_TEMP} -png;
/usr/bin/pdftoppm -singlefile ${SECRET_FILE} ${SECRET_TEMP} -png;

echo "* Converting revealer image to transparent";
/usr/bin/convert ${REVEALER_TEMP}.png -fuzz 30% -transparent white ${REVEALER_TRANSPARENT};

echo "* Superimposing transparent revealer image on secret image for final result";
/usr/bin/convert ${SECRET_TEMP}.png ${REVEALER_TRANSPARENT} -composite ${REVEALED_SECRET};

echo "* Done! Image with revealed secret: '${REVEALED_SECRET}'";
# clean up
rm ${REVEALER_TEMP}.png ${SECRET_TEMP}.png ${REVEALER_TRANSPARENT};
