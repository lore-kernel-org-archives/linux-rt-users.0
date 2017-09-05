From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt13
Date: Tue, 5 Sep 2017 16:52:44 +0200
Message-ID: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdIEOwq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 10:52:46 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.11.12-rt13 patch set. 

Changes since v4.11.12-rt12:

  - Merging Anna-Maria's "hrtimer: Provide softirq context hrtimers"
    series. Merging this series enables the removal of almost all
    hrtimer related patches in the queue. What is left is the "force
    switch" of all timers to the softirq context (except a few special
    ones) and a wait-queue to wait until a timer is completed.
    The overall diffstat compared to -rt12 is
      21 files changed, 573 insertions(+), 651 deletions(-)
    amazing. We have RT wise the same functionality with 78 lines less
    of code.

Known issues
	- There was a report regarding a deadlock within the rtmutex code.

The delta patch against v4.11.12-rt12 is huge can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt12-rt13.patch.xz
     https://git.kernel.org/rt/linux-rt-devel/d/v4.11.12-rt13/v4.11.12-rt12

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt13

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt13.tar.xz

Sebastian
