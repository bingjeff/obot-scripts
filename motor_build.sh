#!/bin/bash

INSTALL_PATH=/mnt/d/projects/unhuman/obot-controller/obot_g474

cd $INSTALL_PATH
make -j CONFIG=$MOTOR_TARGET
