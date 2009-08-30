From: Meha Mehta <mehtameha@gmail.com>
Subject: Process with SCHED_FIFO policy takes more time than SCHED_OTHER
	policy
Date: Sun, 30 Aug 2009 17:30:29 -0400
Message-ID: <af81d2bf0908301430m772bc6dcjf446bfc0960618e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:24304 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZH3VgJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Aug 2009 17:36:09 -0400
Received: by an-out-0708.google.com with SMTP id d40so4424163and.1
        for <linux-rt-users@vger.kernel.org>; Sun, 30 Aug 2009 14:36:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I have a code (see below) that is just a tight loop which execute for
10s (on 1.6GHz 4 core processor). When a process with this code run
with SCHED_FIFO policy it uses more time/jiffies than the same process
with SCHED_OTHER policy. My question is, Is it bug or expected
behavior (book-keeping overhead?). I am running 2.6.29.6-rt23 (rt
patch enabled, RT group scheduling disabled). I have also tried doing

#echo -1 > /proc/sys/kernel/sched_rt_runtime_us

but that does not help.

Following is the code and output with and without SCHED_FIFO policy.

#include <unistd.h>
#include <sched.h>
#include <stdlib.h>
#include <stdio.h>
#define N 5

main() {
  struct sched_param a;
  unsigned long mypid;
  char *str;
  FILE *input;
  int pid,ppid,pgid,sid,tty_nr,tty_pgrp;
  unsigned int flags;
  unsigned long min_flt,cmin_flt, maj_flt,cmaj_flt,cutime,cstime;
  unsigned long utime_io1=0, utime_io2=0;
  unsigned long stime_io1=0,stime_io2=0;
  char tcomm[50],state;
  int i,j,k ;
  unsigned int total_utime=0, total_stime=0;
  unsigned long  total_time=0;
  struct timeval curr_time1, curr_time2;

  a.sched_priority = 10 ;


  if(sched_setscheduler(0, SCHED_FIFO, &a) != 0)
     perror(NULL);
  str = malloc(sizeof(char)*16);
  mypid = getpid();

  sprintf(str,"%s%lu%s","/proc/",mypid,"/stat");

  for(k = 0; k < N; k++) {
      input = fopen(str, "r");

      if(!input ) {
         printf("\n error opening file");
         exit(1);
      }

      fscanf(input,"%d %s %c %d %d %d %d %d %u %lu %lu %lu %lu %lu
%lu",&pid,&tcomm,&state, &ppid, &pgid, &sid, &tty_nr, &tty_pgrp,
&flags, &min_flt, &cmin_flt, &maj_flt, &cmaj_flt, &utime_io1,
&stime_io1);
      fseek(input,0L,SEEK_SET);

      gettimeofday(&curr_time1,NULL);
      for(  j = 0; j < 37890; j++)
           for (i = 0; i <  100000; i ++);

      gettimeofday(&curr_time2,NULL);
      fscanf(input,"%d %s %c %d %d %d %d %d %u %lu %lu %lu %lu %lu
%lu",&pid,&tcomm,&state, &ppid, &pgid, &sid, &tty_nr, &tty_pgrp,
&flags, &min_flt, &cmin_flt, &maj_flt, &cmaj_flt, &utime_io2,
&stime_io2);

      total_utime += (utime_io2-utime_io1);
      total_stime += (stime_io2-stime_io1);
      total_time  +=  (curr_time2.tv_sec - curr_time1.tv_sec) *
1000000 + (curr_time2.tv_usec - curr_time1.tv_usec);
      fclose(input);
  }
  printf("\nuser jiffies = %lu \t system jiffies = %lu \t total time =
%lu(us) " , (total_utime/N), (total_stime/N), (total_time/N));
}


Output with SCHED_OTHER policy is

user jiffies = 1001      system jiffies = 0      total time = 10022721(us)

and Output with SCHED_FIFO policy is

user jiffies = 1667      system jiffies = 0      total time = 16671483(us)

As you can see user jiffies spent by SCHED_FIFO process is more than
SCHED_OTHER policy.

Is anybody seeing similar kind of behavior?

Thanks in advance.

Thanks,
Meha
