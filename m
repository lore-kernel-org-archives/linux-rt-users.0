From: Dirk Behme <dirk.behme@googlemail.com>
Subject: 2.6.19 rc6 rt3 on embedded ARM system
Date: Sun, 19 Nov 2006 18:36:03 +0100
Message-ID: <45609603.3000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:49422 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756806AbWKSRbH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 12:31:07 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2021444nfa
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Nov 2006 09:31:05 -0800 (PST)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

playing with patch-2.6.19-rc6-rt3 on an embedded TI OMAP 
based ARM926 system I encountered two issues.

First, I got the system booting and even playing MP3 via NFS 
using madplay on ALSA works :)

But after madplay stops, I got an Oops:

kernel BUG at kernel/rtmutex.c:672!
Unable to handle kernel NULL pointer dereference at virtual
address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
PC is at __bug+0x44/0x58
LR is at rt_up+0x4c/0x6c
...

Any ideas what's wrong here? Note that I used recent OMAP 
git and not OMAP mainline so I manually had to convert some 
spinlock_t to raw_spinlock_t.

Second, I tried to compile cyclictest 0.11. Seems that for 
me it isn't so easy as described on [1] "Get the latest 
source tarball, untar into a directory of your choice and 
run make in the source directory.":

~/cyclictest> make
arm-linux-gcc -Wall -O2  -lpthread -lrt cyclictest.c -o 
cyclictest
cyclictest.c: In function 'timerthread':
cyclictest.c:153: error: 'SIGEV_THREAD_ID' undeclared (first 
use in this function)
cyclictest.c:153: error: (Each undeclared identifier is 
reported only once
cyclictest.c:153: error: for each function it appears in.)
cyclictest.c:155: error: 'union <anonymous>' has no member 
named '_tid'
cyclictest.c: At top level:
cyclictest.c:318: error: 'CLOCK_MONOTONIC' undeclared here 
(not in a function)

Looking into kernel headers, SIGEV_THREAD_ID and 
CLOCK_MONOTONIC are defined by kernels include files, but 
seems that they are not included here correctly. Defining 
them manually in cyclictest.c then results in

cyclictest.c:158: error: 'union <anonymous>' has no member 
named '_tid'

And here, I stopped because my _sigev_un in 
include/bits/siginfo.h really contains no _tid:

   struct
	  {
	    void (*_function) (sigval_t);	/* Function to start.  */
	    void *_attribute;			/* Really pthread_attr_t.  */
	  } _sigev_thread;
       } _sigev_un;

I use a gcc 4.1.0 toolchain built with crosstool with 
glibc-2.3.2:

~/cyclictest> arm-linux-gcc -v
Using built-in specs.
Target: arm-linux
Configured with: 
/crossgcc/arm/arm_gcc_4_1_0/crosstool-0.42/build/arm-linux/gcc-4.1.0-glibc-2.3.2/gcc-4.1.0/configure 
--target=arm-linux --host=i686-host_pc-linux-gnu 
--prefix=/usr/arm/arm-linux 
--with-headers=/usr/arm-linux/arm-linux/include 
--with-local-prefix=/usr/arm-linux/arm-linux --disable-nls 
--enable-threads=posix --enable-symvers=gnu 
--enable-__cxa_atexit --enable-languages=c,c++ 
--enable-shared --enable-c99 --enable-long-long
Thread model: posix
gcc version 4.1.0

Any ideas here as well?

[1] http://rt.wiki.kernel.org/index.php/Cyclictest
