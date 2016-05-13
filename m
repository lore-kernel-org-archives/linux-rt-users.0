From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6-rc7-rt1
Date: Fri, 13 May 2016 13:23:18 +0200
Message-ID: <20160513112318.GA10154@linutronix.de>
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

I'm pleased to announce the v4.6-rc7-rt1 patch set. I tested it on my
AMD A10, 64bit. Had a few runs on ARM, nothing exploded so far.

Changes since v4.4.9-rt17:
  - rebase to v4.6-rc7
  - RWLOCKS and SPINLOCKS used to be cacheline aligned on RT. Now there
    are no more which is the same behaviour as in upstream.

Known issues (inherited from v4.4-RT):
	- CPU hotplug got a little better but can deadlock.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6-rc7-rt1

The RT patch against 4.6-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6-rc7-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6-rc7-rt1.tar.xz

Sebastian
