From: David Peverley <pev@sketchymonkey.com>
Subject: Spinlocks during sysfs_write...
Date: Wed, 2 Mar 2011 18:10:48 +0000
Message-ID: <AANLkTiknq2sg_s+VrWELZGdxhST+VDpHfY5vN_L32YR+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48581 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1CBSKs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2011 13:10:48 -0500
Received: by iyb26 with SMTP id 26so166977iyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Mar 2011 10:10:48 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,


I've a conundrum here that I'm trying to figure out if anyone has any
ideas! In a driver we've written on top of linux-2.6.31-rt21 when I
enabled CONFIG_DEBUG_SPINLOCK_SLEEP we get the following :
[  103.398688] BUG: sleeping function called from invalid context at
/vobs/fbsr_kernel2/kernel/rtmutex.c:684
[  103.398738] in_atomic(): 0, irqs_disabled(): 128, pid: 334, name: rcS
[  103.398771] 1 lock held by rcS/334:
[  103.398793]  #0:  (&buffer->mutex){+.+.+.}, at: [<c010a588>]
sysfs_write_file+0x2c/0x190
[  103.398898] irq event stamp: 70360
[  103.398920] hardirqs last  enabled at (70360): [<c03207fc>]
_atomic_spin_unlock_irqrestore+0x68/0x70
[  103.398992] hardirqs last disabled at (70359): [<c0320b48>]
_atomic_spin_lock_irqsave+0x24/0x90
[  103.399049] softirqs last  enabled at (0): [<c003f4f8>]
copy_process+0x4c8/0x1038
[  103.399107] softirqs last disabled at (0): [<(null)>] (null)
[  103.399151] [<c002fcc4>] (unwind_backtrace+0x0/0xfc) from
[<c031d868>] (dump_stack+0x18/0x1c)
[  103.399249] [<c031d868>] (dump_stack+0x18/0x1c) from [<c003b400>]
(__might_sleep+0xf8/0x114)
[  103.399331] [<c003b400>] (__might_sleep+0xf8/0x114) from
[<c031fe08>] (rt_spin_lock+0x8c/0x94)
[  103.399415] [<c031fe08>] (rt_spin_lock+0x8c/0x94) from [<c002f8c8>]
(unwind_frame+0x64/0x460)
[  103.399502] [<c002f8c8>] (unwind_frame+0x64/0x460) from
[<c002d5a0>] (walk_stackframe+0x34/0x40)
[  103.399589] [<c002d5a0>] (walk_stackframe+0x34/0x40) from
[<c002d620>] (save_stack_trace_tsk+0x74/0xc0)
[  103.399675] [<c002d620>] (save_stack_trace_tsk+0x74/0xc0) from
[<c002d690>] (save_stack_trace+0x24/0x28)
[  103.399761] [<c002d690>] (save_stack_trace+0x24/0x28) from
[<c0069104>] (save_trace+0x44/0xac)
[  103.399850] [<c0069104>] (save_trace+0x44/0xac) from [<c00691ac>]
(add_lock_to_list+0x40/0xbc)
[  103.399931] [<c00691ac>] (add_lock_to_list+0x40/0xbc) from
[<c006c848>] (__lock_acquire+0x150c/0x1984)
[  103.400017] [<c006c848>] (__lock_acquire+0x150c/0x1984) from
[<c006cdc0>] (lock_acquire+0x100/0x124)
[  103.400101] [<c006cdc0>] (lock_acquire+0x100/0x124) from
[<c031fdf4>] (rt_spin_lock+0x78/0x94)
[  103.400185] [<c031fdf4>] (rt_spin_lock+0x78/0x94) from [<c004c0f8>]
(lock_timer_base+0x30/0x50)
[  103.400276] [<c004c0f8>] (lock_timer_base+0x30/0x50) from
[<c004cabc>] (mod_timer+0x4c/0x138)
[  103.400358] [<c004cabc>] (mod_timer+0x4c/0x138) from [<c004cbc8>]
(add_timer+0x20/0x38)
[  103.400438] [<c004cbc8>] (add_timer+0x20/0x38) from [<bf0312a4>]
(period_store+0x144/0x1b8 [femto_wdl])
[  103.400560] [<bf0312a4>] (period_store+0x144/0x1b8 [femto_wdl])
from [<c01cffac>] (dev_attr_store+0x24/0x28)
[  103.400665] [<c01cffac>] (dev_attr_store+0x24/0x28) from
[<c010a668>] (sysfs_write_file+0x10c/0x190)
[  103.400754] [<c010a668>] (sysfs_write_file+0x10c/0x190) from
[<c00c0ba4>] (vfs_write+0xbc/0x144)
[  103.400844] [<c00c0ba4>] (vfs_write+0xbc/0x144) from [<c00c0d08>]
(sys_write+0x44/0x74)
[  103.400924] [<c00c0d08>] (sys_write+0x44/0x74) from [<c0029a00>]
(ret_fast_syscall+0x0/0x34)
[  103.401090] [FEMTO-WDL]: Started with 60000 msec monitor interval
[  108.820233] alg: No test for authenc(hmac(sha1),cbc(aes))
(authenc(hmac(sha1-arm),cbc(aes-arm)))

Now, I understand this makes sense as in our code we set up :
  static DEVICE_ATTR(period, 0600, period_show, period_store);

and the function period_store() uses mod_timer() which in turn uses a
normal spin_lock() call so the warning rings true.

So I looked around at a few other drivers and for example, looking at :
  drivers/leds/ledtrig-timer.c

it does something similar i.e. the sysfs write call directly calls
mod_timer so in principle the same issue applies. Hence my question is
whether we should be worried about this or not? We have a few other
drivers that have similar issues but it's not clear if it's
significant or not?

Cheers!

~Pev
