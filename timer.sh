#!/bin/bash
#  This script keep track of time spent while running other tasks, creating historical logs
#  Script receives two parameter
#  1. start/end   - start/finish action
#  2. $string     - name of process being counted
#
TEMP=/tmp/history
# Where to put logs
LOGDIR=/export/logs/rsync_history

[ $# -ne 2 ] && echo "usage: `basename $0` [start|end] name" && exit 1

[ -d $TEMP ] || mkdir -p $TEMP
[ -d $LOGDIR ] || mkdir -p $LOGDIR
NOW=`date +"%s"`

#assemble string variable
STR=`echo $2 | tr "/ " __`

TIMEFILE=$TEMP/${STR}

case $1 in
  start)
     [ -e $TIMEFILE ] && echo `date` - $STR - timefile exists, last run of end not executed
     echo $NOW > $TIMEFILE
     echo `date +"%Y/%m/%d %H:%M:%S"` starting $STR
  ;;
  end|stop)
     [ ! -e $TIMEFILE ] && echo `date` - $STR - timefile not exists, not called before start script && exit 1
     START=`cat $TIMEFILE`
     END=$NOW
     ELAPSED=$((END-START))
     echo `date +"%Y/%m/%d %H:%M:%S"` $NOW $STR "Elapsed(s):" $ELAPSED "Elapsed(min):" $((ELAPSED/60)) | tee -a $LOGDIR/${STR}_`date +"%Y%m"`.log
     rm $TIMEFILE
  ;;
  *)
     echo usage: `basename $0` [start|end] name
     exit 1
  ;;
esac
