#!/bin/bash

TARGET=motor_hall
OUTPUT_FILE=/tmp/${TARGET}_benchmark.txt
INSTALL_PATH=/mnt/d/projects/unhuman/obot-controller
BIN_PARAM=${INSTALL_PATH}/obot_g474/build/${TARGET}/${TARGET}_param_only.bin
BIN_PROGRAM=${INSTALL_PATH}/obot_g474/build/${TARGET}/${TARGET}_noparam.bin
ELF_TARGET=${INSTALL_PATH}/obot_g474/build/${TARGET}.elf
MOTOR_PATHS=1-5

cd $INSTALL_PATH
GIT_STATUS=`git describe --dirty --always --tags --long`

echo "$TARGET $GIT_STATUS $(date)" >> $OUTPUT_FILE
motor_util -p $MOTOR_PATHS --run-stats 1000 --no-list | awk -F", " \
  'NR==1 { for (i = 1; i < 5; i++) { headers[i]=$(i+5) } } \
  NR>1 { for (i in headers) { print "  " headers[i] \ 
  "\t" $(i+1) "\t" $(i+5) " cycles"} }' >> $OUTPUT_FILE
echo "  program_size $(wc -c < $BIN_PROGRAM) bytes" >> $OUTPUT_FILE
echo "  param_size   $(wc -c < $BIN_PARAM) bytes" >> $OUTPUT_FILE
echo "  text_size   $(size $ELF_TARGET | tail -n1 | cut -f1) bytes" >> $OUTPUT_FILE
echo "  data_size  $(size $ELF_TARGET | tail -n1 | cut -f2) bytes" >> $OUTPUT_FILE
echo "  bss_size   $(size $ELF_TARGET | tail -n1 | cut -f3) bytes" >> $OUTPUT_FILE
echo "  stack_used   $(motor_util -p $MOTOR_PATHS --no-list --set-api stack_used | cut -f2 -d' ') bytes" >> $OUTPUT_FILE
echo "  heap_used    $(motor_util -p $MOTOR_PATHS --no-list --set-api heap_used | cut -f2 -d' ') bytes" >> $OUTPUT_FILE
echo "--- $OUTPUT_FILE ---"
tail -n 24 $OUTPUT_FILE
