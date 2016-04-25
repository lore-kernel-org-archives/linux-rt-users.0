From: "helix250@libero.it" <helix250@libero.it>
Subject: Kernel RT questions
Date: Mon, 25 Apr 2016 13:44:37 +0200 (CEST)
Message-ID: <1590963381.9624751461584677902.JavaMail.httpd@webmail-42.iol.local>
Reply-To: "helix250@libero.it" <helix250@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-33.italiaonline.it ([212.48.25.161]:34906 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753932AbcDYLxC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2016 07:53:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
I do not know if this is the right mailing list to ask this question, 
if this is not, please apologize and tell me where I could ask for this 
information.

I am trying to do my first tests with PREEMPT_RT on my BeagleBoneBlack board.
I am testing it with cyclictest and in the meanwhile I am copying a big file 
from /home/roor to /tmp to stress the system. 

I have two options at the moment, a standard kernel and a PREEMPT one.
I've got the kernels from https://github.com/beagleboard/linux.git using two 
different branch/tag as described below.

The result of my tests seems to indicate a not RT kernel and any RT 
performance.
My questions are:
- How can I detect during runtime that my kernel was properly configured for 
RT performances?
- Should I see any message in dmesg or at boot related to "Ingo Molnar"?
- Are the performances detected above with cyclictest the correct way to 
measure RT performances?


* Standard version
---------------------

root@beaglebone:~# uname -a
Linux beaglebone 4.1.6-yocto-standard #2 PREEMPT Thu Dec 3 16:13:24 CET 2015 
armv7l GNU/Linux

root@beaglebone:~# cat /proc/config.gz | gunzip | grep PREEMPT
CONFIG_PREEMPT_RCU=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_DEBUG_PREEMPT=y
# CONFIG_PREEMPT_TRACER is not set

root@beaglebone:~# ./cyclictest -t1 -p 80 -n -i 10000 -l 10000
T: 0 (  384) P:80 I:10000 C:   1141 Min:     14 Act:   16 Avg:  239 Max:   
42402


* RT version
--------------------
(git checkout tags/4.4.7-ti-rt-r19 -b 4.4.7-ti-rt-r19)

root@beaglebone:~# uname -a
Linux beaglebone 4.4.7 #2 SMP PREEMPT RT Thu Apr 21 14:48:58 CEST 2016 armv7l 
GNU/Linux

root@beaglebone:~# cat /proc/config.gz | gunzip | grep PREEMPT
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT__LL is not set
# CONFIG_PREEMPT_RTB is not set
CONFIG_PREEMPT_RT_FULL=y
CONFIG_PREEMPT_COUNT=y
CONFIG_DEBUG_PREEMPT=y
# CONFIG_PREEMPT_TRACER is not set

root@beaglebone:~# ./cyclictest -t1 -p 80 -n -i 10000 -l 10000
T: 0 (  302) P:80 I:10000 C:   6297 Min:     13 Act:   19 Avg:  159 Max:   
40226


Thank you in advance for your help.
--
Mauri
