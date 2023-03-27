#!/bin/bash

# Helper to find the PID for this script.
function get_pid() {
    PGID=$( ps -q $$ -o pgid= )
    SID=$( ps -q $$ -o sid= )
    if [[ $PGID == $SID ]]; then
        echo 0
    else
        echo $PGID
    fi
}

# Enables ejecting early if one of the make-steps fails.
function die_if_fatal() {
    if [ $STATUS -ne 0 ]; then
        PID=$( get_pid )
        if [ $PID -ne 0 ]; then
            echo "!!! TERMINATING pid=$PID !!!"
            kill $PID
        else
            return
        fi
    fi
}

function build() {
    echo "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    echo "[START] $PROJECT - $1"
    make -j CONFIG=$1 $2
    STATUS=$?
    echo "[FINISH] $PROJECT - $1 ($STATUS)"
    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    die_if_fatal
}

INSTALL_PATH=/mnt/d/projects/unhuman/obot-controller/

PROJECT=boost_g474
cd $INSTALL_PATH/$PROJECT
build pz ""

PROJECT=fabulab_f446
cd $INSTALL_PATH/$PROJECT
build motor ""

PROJECT=obot_g474
cd $INSTALL_PATH/$PROJECT
build motor_enc ""
build motor_wheel ""
build osa14 ""
build motor_40_osa14 ""
build motor_aksim "C_DEFS=-DR3"
build h2 ""

echo "~~~ Great success! Everything built. ~~~"
