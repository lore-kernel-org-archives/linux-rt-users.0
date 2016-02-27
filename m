From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] rt,workqueue: Fix blocking call when !TASK_RUNNING splat
 in rescuer_thread()
Date: Sat, 27 Feb 2016 10:04:30 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271003220.3638@nanos>
References: <1456556755.3759.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35445 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JFu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 04:05:50 -0500
In-Reply-To: <1456556755.3759.4.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016, Mike Galbraith wrote:

> [    0.221225] ------------[ cut here ]------------
> [    0.221241] WARNING: CPU: 1 PID: 69 at kernel/sched/core.c:7733 __might_sleep+0x7f/0x90()
> [    0.221253] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff8106edc4>] rescuer_thread+0x64/0x340
> [    0.221263] Modules linked in:
> [    0.221272] CPU: 1 PID: 69 Comm: khelper Not tainted 4.0.0-rt4-lockdep #71
> [    0.221273] Hardware name: IBM System x3550 M3 -[7944K3G]-/69Y5698     , BIOS -[D6E150AUS-1.10]- 12/15/2010
> [    0.221280]  ffffffff81a2269f ffff8801789a7cc8 ffffffff81605182 0000000000000002
> [    0.221282]  ffff8801789a7d18 ffff8801789a7d08 ffffffff81053cda ffff8801789a7d48
> [    0.221284]  ffffffff81a23b44 0000000000000394 0000000000000000 0000000000000000
> [    0.221284] Call Trace:
> [    0.221288]  [<ffffffff81605182>] dump_stack+0x4f/0x9d
> [    0.221291]  [<ffffffff81053cda>] warn_slowpath_common+0x8a/0xe0
> [    0.221293]  [<ffffffff81053d76>] warn_slowpath_fmt+0x46/0x50
> [    0.221295]  [<ffffffff8106edc4>] ? rescuer_thread+0x64/0x340 
> [    0.221296]  [<ffffffff8106edc4>] ? rescuer_thread+0x64/0x340
> [    0.221298]  [<ffffffff810794ef>] __might_sleep+0x7f/0x90
> [    0.221299]  [<ffffffff8106ed60>] ? worker_thread+0x4d0/0x4d0
> [    0.221301]  [<ffffffff8160b4d4>] rt_spin_lock+0x24/0x70
> [    0.221304]  [<ffffffff8107fddd>] ? migrate_disable+0x7d/0xe0
> [    0.221305]  [<ffffffff8106ee09>] rescuer_thread+0xa9/0x340
> [    0.221307]  [<ffffffff8106ed60>] ? worker_thread+0x4d0/0x4d0
> [    0.221308]  [<ffffffff8106ed60>] ? worker_thread+0x4d0/0x4d0
> [    0.221311]  [<ffffffff81073721>] kthread+0xe1/0x100
> [    0.221312]  [<ffffffff8160b1e0>] ? _raw_spin_unlock_irq+0x30/0x70 
> [    0.221315]  [<ffffffff81073640>] ? __kthread_parkme+0xa0/0xa0
> [    0.221317]  [<ffffffff8160be88>] ret_from_fork+0x58/0x90
> [    0.221319]  [<ffffffff81073640>] ? __kthread_parkme+0xa0/0xa0
> [    0.221320] ---[ end trace 0000000000000001 ]---


Hmm. That looks wrong. Spinlocks are state preserving on RT. So I need to
figure out why that thingy triggers here.
 
Thanks,

	tglx
