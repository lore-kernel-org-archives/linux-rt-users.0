From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Mon, 14 Apr 2014 00:04:29 +0400
Message-ID: <534AEDCD.20208@pavlinux.ru>
References: <20140411185739.GA6644@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:41779 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbaDMUEc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Apr 2014 16:04:32 -0400
In-Reply-To: <20140411185739.GA6644@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

11.04.2014 22:57, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:

> x86-64 crashed after I started hackbench. I figured out that the cras=
h
> does not happen with lazy-preempt disabled. Therefore the last but on=
e
> patch in the queue disables lazy preempt on x86-64. With this change =
the
> test box survived ~2h without a crash. I look at this later but it lo=
oks
> good now.


AMD64 (Dual AMD Opteron 285), 8Gb RAM, MB: TYAN Thunder KW8E 2895

WORK ONLY IN UniProcessor mode (maxcpus=3D0)

Normal boot: Debian 7 x64, Xorg, Google Chrome, Firefox/Thunderbird,
Unigine Heaven Benchmark: 39 FPS, Nvidia driver 334.21, watch youtube.

  ./hackbench -T 4 -l 10000
Time: 162.643

=2E/cyclictest -p 99 -D 60
policy: fifo: loadavg: 0.27 19.88 19.17 1/311 4481
T: 0 ( 4336) P:99 I:1000 C:  59995 Min: 19 Act: 23 Avg: 24 Max: 61

  ./signaltest -p99 -m -l 10000
0.25 13.60 16.96 3/312 4831

T: 0 ( 4812) P:99 C:  10000 Min: 9 Act: 9 Avg:10 Max: 35

---

In SMP mode boot only with kernel option init=3D/bin/bash
After remount /dev/sda2 to RW mode, and run mc (midnight commander)
system freezeeeee! But SysRQ key works!


/proc/cmdline:
root=3D/dev/sda2 quiet vga=3D0 pci=3Drouteirq nmi_watchdog=3D0 iommu=3D=
noagp
mce=3Ddont_log_ce tsc=3Dreliable clocksource=3Dhpet workqueue.power_eff=
icient=3D0
agp=3Doff reset_devices iommu=3Dmemaper=3D4 amd_iommu=3Dfullflush pci=3D=
skip_isa_align
sata_nv.adma=3D1 hpet=3Dforce zswap.enabled=3D1 maxcpus=3D0

=2Econfig:  http://pastebin.com/2GmGc3Ra
dmesg:  http://pastebin.com/gxZXHK2x


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
