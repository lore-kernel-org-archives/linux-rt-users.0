From: Lukasz Majewski <majess1982@gmail.com>
Subject: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Sun, 22 Feb 2009 21:49:13 +0100
Message-ID: <49A1BA49.7060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36709 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZBVUtR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Feb 2009 15:49:17 -0500
Received: by bwz5 with SMTP id 5so4192434bwz.13
        for <linux-rt-users@vger.kernel.org>; Sun, 22 Feb 2009 12:49:14 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello

I hope that this post won't be regarded as "dummy" one.

I'm struggling with 2.6.26.8-rt14 linux kernel for ARM architecture.

I'm using toolchain with uClibc 0.9.30, binutils 2.18 and gcc 4.2.4. I'm 
also using -msoft-float flag when I'm compiling my rt application. I'm 
performing heavy mathematical computations (mostly multiplication of 
double matrices).


The application is build around a simple static cyclic schedule with 
period of 20ms. During this time I'm performing my calculations for 
around 13 ms and sleep (with nanosleep)  for 7ms. I'm using gettimeofday 
instead of clock_gettime. I've set it's rtprio as 71 (only posixtimer 
has 99 rtprio). I'm also using NFS to mount root file system from my 
host x86 ubuntu PC.

My application consist of several .c and .h files, which build several 
object files (.o). I'm also using some global variables defined at 
common_def.h header file. I'm linking this application statically 
(LDFLAG=-static), so executable binary has 113kB .My embedded system has 
48MB of RAM to be used by Linux.

When I start my application it runs for some time and ends as expected. 
It seems that everything is OK. Static schedule is not violated. 
Unfortunately, after running this application for couple of times (6 to 
10) I can see that static schedule is violated(delayed in execution) for 
about 2-4 seconds. Application is running for 1-2 seconds as expected 
and then crashes(I mean exits with static schedule delay of 2-4 
seconds). It looks like page fault, but in my main() I've add mlockall() 
as writen in the examples from rt.wiki. Moreover I've prevent stack as 
written  in "square_wave example". Before my application exits I'm 
calling munlockall(). When I log via ssh to my embedded system and start 
top,I cannot see that I've got some memory leaks or zombi processes 
during run of my RT application.

May it be possible that by some chance some global variable is not 
locked in the memory? What is the "scope" of mlockall? Is it only valid 
in one .o module or it lock all pages as they were loaded?

What is the order of loading binary executable to the memory? May it 
happen that in some case there is one page which was not locked and it 
causes page fault?

In my application I'm using some /dev/ files (like ttyS0). I'm opening 
it during startup of my program (with non block flag) and call 
read/write during my RT loop. I've checked that with of without call to 
this read/write functions bug described above shows up.

I have also try to replace NFS rootfs with the same rootfs from SD card. 
There was no difference and the bug was in both cases.

I'd appreciate any hints/comments what can cause this bug. I was trying 
to use strace and gdb to fix this problem, but this tools are to slow 
and they cause violation of my cyclic static schedule.


Thank's in advance,
Lukasz


