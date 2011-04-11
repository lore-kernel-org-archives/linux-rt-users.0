From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 2.6.33.9-rt31
Date: Mon, 11 Apr 2011 17:35:45 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44188 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1DKPfs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Apr 2011 11:35:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the next update to our new preempt-rt
series which is mostly a forward to 2.6.33.9. Thanks Greg !

RT specific patches since 2.6.33.7.2-rt30

8a97f01: arm: mxc: Add sched_clock to mxc-platform
a5a2b75: arm: mxc: Add add dummy_get_cycles()
c1d6834: trace: Add timestamp to maxlatproc data
cfe9ed2: trace: Add current task to maxlatproc data
70fdd17: trace: Add timeroffset to maxlatproc data
db2aacd: trace: timer offsets histogram consider smp same prio
3115eb2: x86, hotplug: Revert 74a6e0fd8 (x86, hotplug: Use mwait to ...)
250bf15: ARM: sched_clock: make minsec argument to clocks_calc_mult_shift() zero
c04f3a8: ARM: sched_clock: allow init_sched_clock() to be called early
4d79f92: ARM: sched_clock: provide common infrastructure for sched_clock()
7443ac2: asm-generic/percpu: fixup RT mismerge
7e1c4f9: rtmutex: Ensure only the top waiter or higher priority task can take the lock
47b3309: rtmutex: Fix comment about why new_owner can be NULL in wake_futex_pi()
2ce1161: rtmutex: Revert Optimize rt lock wakeup
9704792: rtmutex: Try to take lock early in rt_spin_lock_slowlock()
5995a44: rtmutex: Only save lock depth once in spin_slowlock

Download locations:
   
    http://www.kernel.org/pub/linux/kernel/projects/rt/

Git release branch:
    git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git rt/2.6.33
  
Gitweb:
    http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=shortlog;h=rt/2.6.33
  
Information on the RT patch can be found at:

    http://rt.wiki.kernel.org/index.php/Main_Page

to build the 2.6.33.9-rt31 tree, the following patches should be
applied:

    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.9.tar.bz2
    http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.9-rt31.bz2

Enjoy !

      tglx
