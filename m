From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: All 3.10.x rt patched kernels are unusable on my machine
Date: Fri, 25 Oct 2013 19:45:37 +0200
Message-ID: <20131025174537.GA21841@linutronix.de>
References: <1381746965.3978.27.camel@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42204 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3JYRpj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 13:45:39 -0400
Content-Disposition: inline
In-Reply-To: <1381746965.3978.27.camel@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ralf Mardorf | 2013-10-14 12:36:05 [+0200]:

>Hi,
Hi Ralf,

>non of the 3.10.x rt patched kernels does work on my machine.
>
>$ ls /usr/src/pkg-linux-rt/linux-rt-3*
>/usr/src/pkg-linux-rt/linux-rt-3.10.10_rt7-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.10.14_rt9-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.10.15_rt11-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.10.6_rt3-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.10.9_rt5-01-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.11_rt8-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt10-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt11-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt12-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt13-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt14-1-x86_64.pkg.tar.xz
>/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt9-1-x86_64.pkg.tar.xz

so 3.8 works then?

>It's not only on my main install, Arch Linux 64-bit architecture, I
>verified the issue by building a 3.10.x rt patched kernel for Ubuntu
>64-bit architecture too.

Interresting. The Debian people got it work
  http://packages.debian.org/wheezy-backports/linux-image-3.10-0.bpo.2-rt-amd64

so I guess the problem is with you hardware.

>$ ls /mnt/q/boot/vmlinuz*
>/mnt/q/boot/vmlinuz-3.10.9-rt5  /mnt/q/boot/vmlinuz-3.5.0-18-lowlatency  /mnt/q/boot/vmlinuz-3.6.5-rt14
>
>There were no issues without the rt patch for 3.10 kernels and no issues
>with kernel versions < 3.10.x with and without rt patch.

that means you take the .config from the non-RT test, enable PREEMPT RT
and after the recompile you don't get into X?

>
>Usually login doesn't work from lightdm, sometimes it does work, but
>after a short while terminals hang and the prompt gets lost, switching
>to tty by Ctrl + Alt + F-keys then doesn't work.

This could be driver issue. But it is hard to guess :)

>Last time I could login, I got
>
>$ cat .xsession-errors.rt11
>find: `/home/rocketmouse/.Xauthority.??????': No such file or directory
>weather-Message: getting
>http://api.yr.no/weatherapi/locationforecastlts/1.1/?lat=51.466702;lon=6.850000;msl=38
>PolicyKit daemon disconnected from the bus.
>We are no longer a registered authentication agent.
>xfce4-appfinder: Fatal IO error 11 (Resource temporarily unavailable) on
>X server :0.0.

I can't even say if this is good or bad. Maybe your X just crashed or
not started at all.

>Any info needed about my hardware, from journalctl the kernel's config
>or something else?

You try to connect an uart cable to year serial port and capture the
kernel's output. Maybe it shows what is wrong. Information about the
platform is probably usefull, too. Do you use only kernel modules from
kernel.org or do you have any out of tree patches / driver like graphics
driver, etc?

>Regards,
>Ralf

Sebastian
