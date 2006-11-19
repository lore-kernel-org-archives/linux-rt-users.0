From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.19 rc6 rt3 on embedded ARM system
Date: Sun, 19 Nov 2006 19:15:39 +0100
Message-ID: <20061119181539.GQ18636@pengutronix.de>
References: <45609603.3000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:42423 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932722AbWKSSPm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 13:15:42 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <45609603.3000106@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Nov 19, 2006 at 06:36:03PM +0100, Dirk Behme wrote:
> playing with patch-2.6.19-rc6-rt3 on an embedded TI OMAP 
> based ARM926 system I encountered two issues.
> 
> First, I got the system booting and even playing MP3 via NFS 
> using madplay on ALSA works :)
> 
> But after madplay stops, I got an Oops:
> 
> kernel BUG at kernel/rtmutex.c:672!
> Unable to handle kernel NULL pointer dereference at virtual
> address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 817 [#1]
> PC is at __bug+0x44/0x58
> LR is at rt_up+0x4c/0x6c
> ...
> 
> Any ideas what's wrong here? 

You snipped the stack trace here, which could offer some information
about the call path. Could you post it?

> Second, I tried to compile cyclictest 0.11. Seems that for 
> me it isn't so easy as described on [1] "Get the latest 
> source tarball, untar into a directory of your choice and 
> run make in the source directory.":
> 
> ~/cyclictest> make
> arm-linux-gcc -Wall -O2  -lpthread -lrt cyclictest.c -o 

Sidenote: these days it doesn't really make sense any more to have
something like an arm-linux-gcc, as you can decide between different
cores (v4, v4t, v5, ...), different floating/fixed point models (hard
fpa, hard vfp, soft vfp, maverick crunch, iwmmxt, ...) etc. 

> cyclictest
> cyclictest.c: In function 'timerthread':
> cyclictest.c:153: error: 'SIGEV_THREAD_ID' undeclared (first 
> use in this function)

Hmm, it looks like SIGEV_THREAD_ID is not defined in the POSIX standard.
Maybe tglx can comment on where this comes from. 

Nevertheless, for me it is defined in bits/siginfo.h, both on debian
unstable (x86) and in our self built gccs; checked with

	arm-v4t-linux-gnueabi/gcc-4.2-20061031-glibc-2.5
	arm-v4t-linux-gnueabi/gcc-4.1.1-glibc-2.5

The include file comes in correctly by including signals.h and is a
glibc header file.

> cyclictest.c:318: error: 'CLOCK_MONOTONIC' undeclared here 
> (not in a function)

The POSIX manpage for timer_create() says that you have to define
signal.h and time.h, the latter one pulls in bits/time.h, which contains
CLOCK_MONOTONIC. This is also a glibc header file.

Maybe your glibc is too old?

> Looking into kernel headers, SIGEV_THREAD_ID and 
> CLOCK_MONOTONIC are defined by kernels include files, but 
> seems that they are not included here correctly. Defining 
> them manually in cyclictest.c then results in
> 
> cyclictest.c:158: error: 'union <anonymous>' has no member 
> named '_tid'
> 
> And here, I stopped because my _sigev_un in 
> include/bits/siginfo.h really contains no _tid:
> 
>   struct
> 	  {
> 	    void (*_function) (sigval_t);	/* Function to start.  */
> 	    void *_attribute;			/* Really pthread_attr_t.  */
> 	  } _sigev_thread;
>       } _sigev_un;

It contains _tid in later glibcs.

> I use a gcc 4.1.0 toolchain built with crosstool with glibc-2.3.2:

I assume glibc-2.3.2 is too old.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

