From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.7-rt13
Date: Thu, 15 Sep 2016 18:52:26 +0200
Message-ID: <20160915165225.73lr22kpn5coibxa@linutronix.de>
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

I'm pleased to announce the v4.6.7-rt13 patch set. 

Changes since v4.6.7-rt12:

  - The dcache regression fix up introduced another problem. As pointed
    out by Thomas Gleixner we can't avoid cpu_chill() for !RT tasks
    because the owner might be preempted and we would spin until our
    time slice is used up. Therefore the sched class is ignored and we
    "chill" if the lock is taken and cond_resched() did not work.

  - Newer gcc make some noise if __builtin_return_address(x) with x > 1
    is used. Warning can be ignored by a config option (Steven Rostedt)

  - might_resched() on x86 with lazy preempt might ignores the preemption
    counter. Now no more.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.7-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.7-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.7-rt13

The RT patch against 4.6.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.7-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.7-rt13.tar.xz

Sebastian
