From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.8-rt1
Date: Thu, 6 Oct 2016 10:52:29 +0200
Message-ID: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
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

I'm pleased to announce the v4.8-rt1 patch set. 

Changes since v4.6.7-rt14:

  - rebased to v4.8

Known issues
	- CPU hotplug got a little better but can deadlock.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.8-rt1

The RT patch against 4.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/older/patch-4.8-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/older/patches-4.8-rt1.tar.xz

Sebastian
