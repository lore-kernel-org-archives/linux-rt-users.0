From: Alex Goebel <alex.goebel@gmail.com>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Mon, 17 Aug 2015 03:33:43 +0000 (UTC)
Message-ID: <loom.20150817T051749-439@post.gmane.org>
References: <20150803142700.1de720e4@sluggy> <20150804080829.GB9956@opentech.at> <alpine.DEB.2.11.1508041403550.3983@nanos> <20150816115859.GD7004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60930 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbbHQDfH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Aug 2015 23:35:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1ZRBCR-0004xN-KT
	for linux-rt-users@vger.kernel.org; Mon, 17 Aug 2015 05:35:04 +0200
Received: from S0106602ad0951f35.vc.shawcable.net ([24.84.40.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2015 05:35:03 +0200
Received: from alex.goebel by S0106602ad0951f35.vc.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2015 05:35:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Sebastian Andrzej Siewior <bigeasy <at> linutronix.de> writes:
> This might be a .config thing, device driver or user land behaviour.
> Usually ksoftirqd should remain (almost) idle because most of BH work
> remains in task-context and not in ksoftirqd. tasklets for instance
> should run in ksoftirqd. So a function trace or event tracing to figure
> out what is scheduling the softirq might give a pointer.

I have a problem that might be related, or at least I suffer from the same
symptoms:
Trying to run various Debian 4.1 (and 4.0 as well, IIRC) -rt kernels on a
Core i7-720QM Thinkpad, it boots up, I can log in, everything seems normal,
but then after a few minutes, not doing anything special, things get
sluggish and within seconds everything grinds to a complete halt. In the
last screen update I had, there was no double-digit percentage of ksoftirqd
though.

Below is what I get in the logs. Note that it doesn't actually shut down, it
just freezes and a hard reset is needed. The same kernels as non-RT work fine.

Not sure if this is really related, but perhaps it helps.
Cheers,
Alex

Aug 10 17:04:52 linux kernel: [  189.542192] INFO: rcu_preempt detected
stalls on CPUs/tasks: { 3} (detected by 0, t=5252 jiffies, g=3874, c=3873,
q=8201)
Aug 10 17:04:52 linux kernel: [  189.542194] Task dump for CPU 3:
Aug 10 17:04:52 linux kernel: [  189.542200] swapper/3       R  running task
       0     0      1 0x00200000
Aug 10 17:04:52 linux kernel: [  189.542206]  ffffffff8136e2fa
ffffffff8101f9e5 ffff8803333eee00 0000000008004000
Aug 10 17:04:52 linux kernel: [  189.542209]  0000000000000004
0000000000000004 ffffffff8145baf4 0000000000000000
Aug 10 17:04:52 linux kernel: [  189.542212]  0000000000000000
ffff88033338f020 ffff8803333eee00 ffffffff8190b640
Aug 10 17:04:52 linux kernel: [  189.542213] Call Trace:
Aug 10 17:04:52 linux kernel: [  189.542224]  [<ffffffff8136e2fa>] ?
intel_idle+0x12a/0x140
Aug 10 17:04:52 linux kernel: [  189.542230]  [<ffffffff8101f9e5>] ?
read_tsc+0x5/0x10
Aug 10 17:04:52 linux kernel: [  189.542238]  [<ffffffff8145baf4>] ?
cpuidle_enter_state+0x74/0x270
Aug 10 17:04:52 linux kernel: [  189.542244]  [<ffffffff810b9298>] ?
cpu_startup_entry+0x3a8/0x4e0
Aug 10 17:04:52 linux kernel: [  189.542249]  [<ffffffff8104e0d9>] ?
start_secondary+0x169/0x190
Aug 10 17:04:52 linux kernel: [  189.542254] rcu_preempt kthread starved for
5251 jiffies!
Aug 10 17:05:01 linux CRON[4531]: (root) CMD (command -v debian-sa1 >
/dev/null && debian-sa1 1 1)
Aug 10 17:05:33 linux kernel: [  210.562994] INFO: rcu_preempt detected
stalls on CPUs/tasks: { 3} (detected by 1, t=5252 jiffies, g=3875, c=3874,
q=14365)
Aug 10 17:05:33 linux kernel: [  210.562997] Task dump for CPU 3:
Aug 10 17:05:33 linux kernel: [  210.563003] swapper/3       R  running task
       0     0      1 0x00200000
Aug 10 17:05:33 linux kernel: [  210.563081]  ffffffff8136e2fa
ffffffff8101f9e5 ffff8803333eee00 0000000008004000
Aug 10 17:05:33 linux kernel: [  210.563085]  0000000000000004
0000000000000004 ffffffff8145baf4 0000000000000000
Aug 10 17:05:33 linux kernel: [  210.563090]  0000000000000000
ffff88033338f020 ffff8803333eee00 ffffffff8190b640
Aug 10 17:05:33 linux kernel: [  210.563091] Call Trace:
Aug 10 17:05:33 linux kernel: [  210.563103]  [<ffffffff8136e2fa>] ?
intel_idle+0x12a/0x140
Aug 10 17:05:33 linux kernel: [  210.563111]  [<ffffffff8101f9e5>] ?
read_tsc+0x5/0x10
Aug 10 17:05:33 linux kernel: [  210.563121]  [<ffffffff8145baf4>] ?
cpuidle_enter_state+0x74/0x270
Aug 10 17:05:33 linux kernel: [  210.563133]  [<ffffffff810b9298>] ?
cpu_startup_entry+0x3a8/0x4e0
Aug 10 17:05:33 linux kernel: [  210.563139]  [<ffffffff8104e0d9>] ?
start_secondary+0x169/0x190
Aug 10 17:05:33 linux kernel: [  210.563143] rcu_preempt kthread starved for
5252 jiffies!
Aug 10 17:05:34 linux shutdown[4689]: shutting down for system halt
Aug 10 17:05:34 linux init: Switching to runlevel: 0
Aug 10 17:05:34 linux shutdown[4822]: shutting down for system halt


