From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.4-rc6-rt1
Date: Wed, 23 Dec 2015 23:57:55 +0100
Message-ID: <20151223225755.GA21121@linutronix.de>
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

Please don't continue reading before christmas eve (or morning,
depending on your schedule). If you don't celebrate christmas,
well go ahead.

Dear RT folks!

I'm pleased to announce the v4.4-rc6-rt1 patch set. I tested it on my
AMD A10, 64bit. Nothing exploded so far, filesystem is still there.
I haven't tested it on anything else. Before someone asks: this does not
mean it does *not* work on ARM I simply did not try it.

If you are brave then download it, install it and have fun. If something
breaks, please report it. If your machine starts blinking like a
christmas tree while using the patch then *please* send a photo.

Changes since v4.1.15-rt17:
  - rebase to v4.4-rc6

Known issues (inherited from v4.1-RT):
      - bcache stays disabled
    
      - CPU hotplug is not better than before
    
      - The netlink_release() OOPS, reported by Clark, is still on the
        list, but unsolved due to lack of information
    
      - Christoph Mathys reported a stall in cgroup locking code while using
        Linux containers.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4-rc6-rt1

The RT patch against 4.4-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4-rc6-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4-rc6-rt1.tar.xz

Sebastian
