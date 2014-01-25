TimerThings
===========

Script used to collect historical time by part of a shell script

Usage
=====
On your sheel script to start tracking one task, just call:

  timer.sh start $TASK_NAME

And to stop

  timer.sh stop $TASK_NAME


As example a script called ~/bin/backup_home.sh

  #!/bin/bash
  /usr/local/bin/timer.sh start rsync_bkp1
  rsync -auv --stats /home/ /mnt/sdc2/bkp_home/
  /usr/local/bin/timer.sh end rsync_bkp1

This will create the log file on:

  /export/logs/rsync_history/home__username__bin__backup_home.sh_YYYYMM.log
  
Containing a timestamp of the start and how long it took to run the rsync.



TODO
====
 - Make final log directory easier to configure
 - Better naming convention



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/pmoranga/timerthings/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
