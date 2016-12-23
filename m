From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9-rt1
Date: Fri, 23 Dec 2016 17:32:13 +0100
Message-ID: <20161223163213.szj43nv7rnelkbty@linutronix.de>
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

I'm pleased to announce the v4.9-rt1 patch set. 

Please don't download and boot this before Christmas Eve.

Changes since v4.8.15-rt10

  - rebase to v4.9

Known issues
	- CPU hotplug got a little better but can deadlock.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9-rt1

The RT patch against v4.9 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9-rt1.tar.xz

Sebastian
