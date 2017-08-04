From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt9
Date: Fri, 4 Aug 2017 19:38:23 +0200
Message-ID: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.11.12-rt9 patch set. 

Changes since v4.11.12-rt8:

  - CPU hotplug could be rock solid now. Yes. The rewrite of the hotplug
    related parts for RT including rwlock's implementation over the last
    few weeks looks good. 'good' means that Steven's CPU-hotplug test script
    run a x86 box with two nodes without hanging for over a week.

  - In v4.4.1-rt6 we enabled migration across scheduling while waiting
    for a lock [0]. As part of the hotplug rework, this optimisation is
    gone and the old behaviour is back.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/rt-locking-Reenable-migration-accross-schedule.patch?h=linux-4.4.y-rt-patches

  - Reader biased RWLOCK implementation for Preempt-RT. This is an
    alternative RWLOCK implementation for Preempt-RT and via Kconfig off
    by default. Please enable it and help testing to see if something
    stalls (as it not writer friendly). Nothing RT related should be
    affected but please test your workload it to make sure.

Known issues
	- none so far.

The web diff against v4.11.12-rt8
     https://git.kernel.org/rt/linux-rt-devel/d/v4.11.12-rt9/v4.11.12-rt8

The delta patch against v4.11.12-rt8 found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt9

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt9.tar.xz

Sebastian
