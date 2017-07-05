From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.8-rt5
Date: Wed, 5 Jul 2017 12:27:58 +0200
Message-ID: <20170705102757.t65qoxirvhiv7fht@linutronix.de>
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

I'm pleased to announce the v4.11.8-rt5 patch set. 

Changes since v4.11.8-rt4:

  - Merged Tom Zanussi's "tracing: Inter-event (e.g. latency) support"
    series. As a result I dropped the old "latency histogram" patches
    we had in tree which provided more or less the thing (which means
    the following config symbols are gone: INTERRUPT_OFF_HIST,
    PREEMPT_OFF_HIST, WAKEUP_LATENCY_HIST, MISSED_TIMER_OFFSETS_HIST).

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.11.8-rt4 will be sent as a reply to this mail
and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.8-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.8-rt5

The RT patch against v4.11.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.8-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.8-rt5.tar.xz

Sebastian
