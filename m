From: GeunSik Lim <leemgs1@gmail.com>
Subject: Test Scenario for Realtime latency benchmark in the worstcase
	environment.
Date: Fri, 19 Jun 2009 08:42:36 +0900
Message-ID: <1245368556.2153.10.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:58408 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbZFROnX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jun 2009 10:43:23 -0400
Received: by pxi27 with SMTP id 27so1141864pxi.33
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jun 2009 07:43:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi all,

This is Realtime Latency Test Scenario during 24hours.
In this experiment, 
I adjusted CPU Affinity Policy to reduce Latency overheads in the Multicore.

Prepare cyclictest(rt-tests), taskset, chrt, ltp-full-20090531.tar.gz , 
hackbench , ping, dd, tar, netperf commands.

I want to listen some advices and opinions about below test scenario 
to measure a latency guarantee in the worstcase environments 
using simple script and commands. If I mistake, Please Correct me. 

- H/W Informatoin : Core2 Quad 9300 , DDR2 2G , Sata 400G, Realtek 1G Lan.
- 192.168.155.20(Private IP) is target board.



Thanks,

- - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - -
ssh root@192.168.155.20
cd /opt/testsuite.20080909/cyclictest/rt-tests-0.42

# This is task to keep Latency(Max limitation: 200uSec) at the worst case.
# If you need histogram information just, Please Use -h option.
time ./cyclictest -t1 -p 99 -i 1000 -n -l 1000000000000 -d 86400 -m -a 1      

# Now, Below test code is background stress for the worst case in RT system.
time ./cyclictest -t50 -p 80 -i 10000 -n -l 100000000000 -d 86400  -a 3

taskset -c 2,3 ./stress.20080904.sh
---------------------------
#!/bin/sh
# Most hardcore test (Ingo Molnar - http://lkml.org/lkml/2005/6/22/347)
# For Heavy CPU Ratio.
while true; do /bin/dd if=/dev/zero of=bigfile bs=1024000 count=1024; done &
while true; do /usr/bin/killall hackbench; sleep 5; done &
while true; do /sbin/hackbench 20; done &
cd ltp-full-20090531; while true; do ./runalltests.sh -x 40; done  & 
----------------------------
# Tip) Utilize iotop & top command to monitor CPU & IO Ratio.
# for 100% Usage of CPU Load using ping 
taskset -c 0 /bin/ping -l 100000 -q -s 10 -f localhost &
taskset -c 1 /bin/ping -l 100000 -q -s 10 -f localhost &
taskset -c 2 /bin/ping -l 100000 -q -s 10 -f localhost &
taskset -c 3 /bin/ping -l 100000 -q -s 10 -f localhost & 

# for 100% Usage of I/O Load using linux-2.6.30 tar source like tiobench s/w.
# Don't forget disk total usage ratio (ex: df ).
cd /opt
while true; do taskset -c 0 tar cvzf test1.tgz  ./linux-2.6.30 ; done  &
while true; do taskset -c 1 tar cvzf test2.tgz  ./linux-2.6.30 ; done  &
while true; do taskset -c 2 tar cvzf test3.tgz  ./linux-2.6.30 ; done  &
while true; do taskset -c 3 tar cvzf test4.tgz  ./linux-2.6.30 ; done  &

# Estimate file space usage ( for I/O Load)
while true; do taskset -c 3 /bin/du / ; done  &

# Network Stress ( Network Performance & Stress )
/usr/bin/netserver
/usr/bin/netperf -H 192.168.155.20 -t TCP_STREAM -A 16K,16K -l 3600
# Streamming Stress using firefox webbrowser.
firefox http://www.intomail.net/stream.php

# USB Disk I/O Stress (External HDD's I/O )
cd /media/usb/
taskset -c 2 tar cvzf test5.tgz  /media/usb/linux-2.6.30 &



-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

