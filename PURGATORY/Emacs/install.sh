#!/bin/bash

####################################################
### AGNoStep gnustep-recommended
### (c) 2026 Patrick Cardona
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install Emacs with NS menus
################################

################################
### VARS
SPIN='/-\|'
FIND="YES"
SCRIPTS=../../../SCRIPTS
CONFIG_ARGS="--with-ns"
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

if [ ! -d ${SCRIPTS} ];then
    echo -e "Bad path: main SCRIPTS folder was not found.\n"
    exit 1
fi

################################
### You must be superuser to install
sudo -v

### Dependencies
#################################
. ./DEPS.ini
if [ "$RENAISSANCE" == "YES" ];then
    check_renaissance
fi

if [ -n "${DEBS}" ];then
    install_deps ${DEBS}
fi

sleep 2;clear

### Build and Install the GNUstep app
clear

echo -e "\nDebug status: $DEBUG"
sleep 1

STR="Purge old release";
subtitulo

pushd . >/dev/null
remove_ifx_app ${APPNAME}
popd >/dev/null
stop

sleep 2
clear
STR="Building and installing ${APP}"
subtitulo

pushd . >/dev/null
cd build/${REPO} || exit 1

warning "Emacs is a very big piece of software: be patient while it is building."

printf "Configuring...\n"
make clean
./autogen.sh
./configure ${CONFIG_ARGS}
ok "Done"
sleep 2

printf "Building...\n"
make &>>$LOG &
PID=$!
spinner
ok "\rDone"

if [ ! -d nextstep/Emacs.app ];then
	alert "The Bundle Emacs.app was not found."
	exit 1
fi

printf "Packaging the Bundle\n"
cp -r lisp nextstep/Emacs.app/Resources/
mkdir -p nextstep/Emacs.app/libexec
for FIC in exec/loader*.s
do cp ${FIC} nextstep/Emacs.app/libexec/
done

printf "Installing...\n"
cd nextstep || exit 1
sudo -E cp -a Emacs.app ${INSTALL_DIR}/
check $APPNAME
sleep $SLEEP

popd >/dev/null
stop

info "All was done for ${APPNAME}."
sleep 2
stop
