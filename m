From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.4.1-rt5
Date: Thu, 4 Feb 2016 21:40:07 +0100
Message-ID: <20160204204007.GE3381@linutronix.de>
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

I'm pleased to announce the v4.4.1-rt5 patch set.
Changes since v4.4.1-rt4:

- various compile fixes found by kbuild test robot.

- Mike Galbraith spotted that migrate_disables() sets ->nr_cpus_allowed
  to one by accident.

- Christoph Mathys reported that the "preemptirqsoff_hist" tracer
  reboots the system once enabled. The problem has been resolved.

- Thomas Gleixner sent a patch to set a default affinity for mask for
  interrupts via kernel command line.

- Yang Shi reported that some perf events were reported as "not counted"
  instead the actual numbers. The problem has been resolved.

Known issues:
  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.4.1-rt4 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.1-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.1-rt5

The RT patch against 4.4.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.1-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.1-rt5.tar.xz

Sebastian
