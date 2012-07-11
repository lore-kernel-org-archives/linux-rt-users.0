From: "Arnaud B." <discipleze1@gmail.com>
Subject: Possible kernel regression between 3.0.31-rt51 and 3.4.x on PPC64 ?
Date: Wed, 11 Jul 2012 18:02:32 +0200
Message-ID: <CAJVbuyqRZqtBat9hGWqK=EN1U4LA3uuQbwBmeazV83AuAP+Crg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41179 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467Ab2GKQCd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jul 2012 12:02:33 -0400
Received: by wgbds11 with SMTP id ds11so4712612wgb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Jul 2012 09:02:32 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I got a *big* issue with my current setup, and perhaps someone could
have a nice idea (or at least it will be helpful to have a bug report
from me :) )

I'm working on freescale P5020 with a 64bits kernel (ppc64) with
preempt-rt (kernel version 3.4.4 rt13)
And I got an issue, and couldn't find a solution yet.
I also try on another ppc64 board (my old MacPro G5 ) and I got the same issue !

Last thing to note:
  . it works ok with a 32bits kernel on P5020.
  . What is strange is that if I take 3.0 kernel (3.0.31-rt51) it's ok
(yes, even with a 64bit kernel)

So, here are the issue:
Kernel crash randomly. Often in udev. If it pass udev, it could run ok
for a while, but will fail eventually in the middle of LTP.

If in the kernel I put DEBUG_RT_MUTEXES, it will fail just after
registering perf monitor.
I tried was to put raw spin lock in plist, as it seems it fails
somewhere when dealing with that. No success :(

At this point the rtmutex plist is trashed. Data are bad when it crash
as pointer is not pointing to RAM anymore ;)
I tried add  call to plist_check_head at some place, and eventually I
got always a data access in init_lists (rtmutex.c). So at this point
plist is already corrupted.


So here is the call stack. Remember, it's alway the same :)

cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0e7830]
pc: c0000000000a2ba4: .__try_to_take_rt_mutex+0x74/0x1b0
lr: c0000000007d9f10: .rt_spin_lock_slowlock+0xa4/0x414
sp: c0000000fb0e7ab0
msr: 80029000
current = 0xc0000000fb0e20c0
paca = 0xc00000000fff9000 softe: 0 irq_happened: 0x01
pid = 3, comm = ksoftirqd/0
*kernel BUG at
/home/arnaud/ALU/KERNEL_34/HOME/build/linux/kernel/rtmutex_common.h:75!*
0:mon>  t
[c0000000fb0e7b60] c0000000007d9f10 .rt_spin_lock_slowlock+0xa4/0x414
[c0000000fb0e7cb0] c0000000007da6c0 .rt_spin_lock+0x20/0x30
[c0000000fb0e7d30] c00000000004532c .__thread_do_softirq+0xc4/0x1b4
[c0000000fb0e7dc0] c0000000000454dc .run_ksoftirqd+0xc0/0x208
[c0000000fb0e7e70] c00000000006becc .kthread+0xb8/0xc4

If you need an more information, I got all this boards in front of me :)

TIA,
/Arnaud.
