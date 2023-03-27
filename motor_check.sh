#!/bin/bash

PHASE_LOCK_CURRENT=0.4
SPIN_CURRENT=0.1

motor_util --no-list set --mode open
sleep 1
motor_util --no-list set --mode phase_lock --current $PHASE_LOCK_CURRENT
sleep 1
motor_util --no-list set --mode open
sleep 1
motor_util --no-list set --mode current --current $SPIN_CURRENT
sleep 2
motor_util --no-list set --mode current --current -$SPIN_CURRENT
sleep 2
motor_util --no-list set --mode open
motor_util --run-stats
