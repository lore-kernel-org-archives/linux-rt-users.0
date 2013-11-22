From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT-3.10.6_p3 fails to boot: home.mount mounting timed out
Date: Fri, 22 Nov 2013 16:13:44 +0100
Message-ID: <20131122151343.GE8698@linutronix.de>
References: <526B46AA.1090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Light <sgsdxzy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45243 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab3KVPNo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 10:13:44 -0500
Content-Disposition: inline
In-Reply-To: <526B46AA.1090407@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Light | 2013-10-26 12:35:54 [+0800]:

> I am trying to build a RT kernel, however it cannot boot because it
>cannot mount /home, which is a subvolume of btrfs.  This is the entry
>of it in /etc/fstab:
>
>/dev/sda3    /home    btrfs
>subvol=gentoohome,defaults,compress=lzo,autodefrag 0 2

And this is okay it seems :)

>I copyed my .config from a working mainline 3.10 kernel(which is able
>to boot) and used "make oldconfig". The resulting config file is
>almost the same with mainline one: I only changed IO scheduler from
>BFQ(from gentoo patchset) to deadline, without even enabling
>CONFIG_PREEMPT_RT. However the RT kernel just cannot boot.

That is interresting. Does vanila v3.10.4 / v3.10.6 work? In your
bootlog I see
| Oct 26 11:33:19 Light kernel: 1;39mKernel command line: root=/dev/sda3 rootflags=subvol=gentoo init=/usr/lib/systemd/systemd ro
| Oct 26 11:33:19 Light kernel:  sda: sda1 sda2 sda3 sda4
| Oct 26 11:33:19 Light kernel: VFS: Mounted root (btrfs filesystem) readonly on device 0:12.

which means the disk there and btrfs was able to mount the root
subvolume. However your home subvolume timed out. If there is nothing
different with the way you create the kernel (initramfs and such) then I
have no clue. 
Maybe you could remove /home from fstab and mount it from commandline
because this might show you the error here.

Sebastian
