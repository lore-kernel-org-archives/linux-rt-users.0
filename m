From: jordan <triplesquarednine@gmail.com>
Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
Date: Fri, 1 Apr 2011 13:18:34 -0400
Message-ID: <AANLkTi=dfYvC0zkDMrygKSda2ou5w6ccnthk1i6fBL=x@mail.gmail.com>
References: <76D8B96C9CCF479A864872F2092B0C8F@e1705>
	<SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>
	<AANLkTim9aK3vPEiVKQVm3tFZufuYUwSe+=qL8xf=gDb8@mail.gmail.com>
	<SNT110-W41B95D47DC3E24ACAED19BA8BB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55870 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459Ab1DARSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2011 13:18:36 -0400
Received: by eyx24 with SMTP id 24so1120219eyx.19
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Apr 2011 10:18:35 -0700 (PDT)
In-Reply-To: <SNT110-W41B95D47DC3E24ACAED19BA8BB0@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Victor,

Sorry for the delayed response, i've been a little busy.

> Could you briefly summarize why use zen-kernel instead of vanilla? As
> far as I understand, the zen-kernel brings features that may not (yet)
> be available on vanilla kernel, (such as those scheduler BFS and BFQ?)

I use zen-kernel over vanilla, for the simple fact that it works, and
i don't have to apply multiple patches to a vanilla source. BFS will
likely never be upstream (which is old news), and BFQ i am not sure
about.

> Could please say wich optimization is needed for the best performances? I'd like to give it a try actually. Or is there a place where I can find all these recommendations; I'm talking about the special features that you can find specifically in a zen-kernel, and that can help further for lower latency for music performance.

BFS is the obvious patch set that helps with low-latency and cpu
scheduling. I do use BFQ io scheduler as well, and i have been
experimenting with the latest BFQ Cgroups stuff too. An example of
that can be found in the archlinux AUR ~ kernel26-ck.

I prefer to use non-vanilla, because often i am using more than a few
patches, on my kernel. Zen-kernel, -ck, etc already had other
tuning/fixes done to them.  then i can do the fine-tuning.

Other tunings you can do..? well, there are lots. When compiling a
kernel, use CFLAG optimizations.
Off hand, easy one's that are safe - CFLAGS='-march=native
-mtune=native' (those 2 will compile the code for your CPU). but there
are many that you can use. read through GCC documentation, Gentoo,
sourcemage and archlinux resources on compiling a kernel. (in fact
gentoo, and Arch have the best documentation on any Linux subject -
including guides on maximizing performance).

you could also only compile modules that you need (saves on compiling time too).

after getting a new kernel to run that is decent. You can muddle
through kernel subsystems;

disk scheduler tunables:

/sys/block/sda/queue
/sys/block/sda/queue/iosched

Cpu scheduler tunables:

/proc/sys/kernel

VM subsystem

/proc/sys/vm

I would have to go into way too much detail here, to explain these
and which things can be tuned.
But i think you will find that google is your friend in this case.
The idea is that you can adjust certain tunables to adjust the system
to better suit your needs. sometimes, reducing latency, or possibly
tuning scheduler performance, etc.

You then can store your changes in /etc/rc.local and /etc/sysctl.conf
- to be run on boot.

There are plenty of tools for benchmarking, latency-tests, etc.
...again, google.

There are also other daemons and tools that could be used...
Ulatencyd, verynice, schedtools, Cgroups(although, i wouldn't
recommend Cgroups just yet),etc. While not are meant for RT-related
Jack applications (actually some will hinder jackd performance).. Some
can be used to control/limit other processes that may be interferring,
introducing latency or causing xruns.  In most cases, you will require
testing/benchmarking, and also just as importantly - "real world
tests" (as in using your system).

tuning all hardware is also very important. using patched drivers, if
required. tuning your disk with tools like sdparm, hdparm. editing
your fstab, etc. I also tend to disable any hardware not being used.
(no kernel support/disable in bios)... I would run a stripped down
desktop too. Although, i do run gnome, i've optimized it.  Tuning your
IRQ manually, over using irqbalance, or rtirq...

> On the other hand, I've checked the www.zen-kernel.org website; the most recent kernel patch seem to be for 2.6.36 kernel; where did you find a 2.6.37 zen kernel?

master branch of Zen-stable (using Git). I have it locally, and update
the tree, when I am about to compile the kernel. I don't download
snapshots, or Zen-kernel patches, git only.

sorry that i don't have more specific info, but your asked a very
broad question.

cheerz

jordan
