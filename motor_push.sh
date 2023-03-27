#!/bin/bash                                                           
INSTALL_PATH=/mnt/d/projects/unhuman/obot-controller/obot_g474

cd $INSTALL_PATH
build/$MOTOR_TARGET/load_${MOTOR_TARGET}.sh
