From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.3-rt3 - xmit queue timeout, oops, rcu stalls
Date: Sun, 16 Aug 2015 13:23:25 +0200
Message-ID: <20150816112325.GA7004@linutronix.de>
References: <20150725103230.GA9470@linutronix.de>
 <55C39E5E.3060500@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50072 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbHPLX3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Aug 2015 07:23:29 -0400
Content-Disposition: inline
In-Reply-To: <55C39E5E.3060500@ccrma.stanford.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Fernando Lopez-Lezcano | 2015-08-06 10:50:22 [-0700]:

>I've had a few hangs with nothing left behind to debug... but today I
>find this:
>
>----
>Aug  5 10:46:18 localhost kernel: [ 2343.673560] WARNING: CPU: 3 PID:
>43 at net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
>Aug  5 10:46:18 localhost kernel: [ 2343.673561] NETDEV WATCHDOG:
>eth1 (e1000e): transmit queue 0 timed out
>----

Your network controller did not manage to send TX packets.

>and then:
>
>----
>Aug  5 10:46:18 localhost kernel: [ 2343.673679] e1000e 0000:04:00.0
>eth1: Reset adapter unexpectedly

this is the consequene of the former problem.

>Aug  5 10:46:30 localhost kernel: [ 2355.706987] ata5.00: exception
>Emask 0x40 SAct 0x0 SErr 0x80800 action 0x6 frozen
>Aug  5 10:46:30 localhost kernel: [ 2355.706990] ata5: SError: {
>HostInt 10B8B }
>Aug  5 10:46:30 localhost kernel: [ 2355.707003] ata5.00: cmd
>a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
>Aug  5 10:46:30 localhost kernel: [ 2355.707003]          Get event
>status notification 4a 01 00 00 10 00 00 00 08 00res
>40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x44 (timeout)
>Aug  5 10:46:30 localhost kernel: [ 2355.707005] ata5.00: status: { DRDY }
>Aug  5 10:46:30 localhost kernel: [ 2355.707007] ata5: hard resetting link

And now ata5 (hard disk?) suddenly got another problem and the link gets
reset.

>----
>Aug  5 10:46:18 localhost kernel: WARNING: CPU: 3 PID: 43 at
>net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
>Aug  5 10:46:18 localhost kernel: NETDEV WATCHDOG: eth1 (e1000e):
>transmit queue 0 timed out
ethernet is still not working.

>Aug  5 11:58:36 localhost kernel: [ 6678.122596] Network
>Receive[2409]: segfault at 28 ip 0000003c4c293ca9 sp 00007fb6f64dbb58
>error 6 in libc-2.18.so[3c4c200000+1b4000]
>Aug  5 11:58:36 localhost kernel: Network Receive[2409]: segfault at
>28 ip 0000003c4c293ca9 sp 00007fb6f64dbb58 error 6 in
>libc-2.18.so[3c4c200000+1b4000]

and now we have a segfault in libc. You box is kind of falling apart.

>And eventually (later) get a ton of these:
>
>----
>Aug  5 11:59:36 localhost kernel: [ 6738.107181] INFO: rcu_preempt
>detected stalls on CPUs/tasks: {} (detected by 3, t=60002 jiffies,
>g=37092, c=37091, q=0)
>Aug  5 11:59:36 localhost kernel: [ 6738.107183] All QSes seen, last
>rcu_preempt kthread activity 1 (4301410925-4301410924),
>jiffies_till_next_fqs=3, root ->qsmask 0x0

one CPU hangs and does not make any progress.

>
>So something is left in a not good state...

Can you reproduce this and if so with and without -RT? There is nothing
in the what would indicate a -RT bug.

>-- Fernando

Sebastian
