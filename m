From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.7-rt1
Date: Mon, 16 Feb 2015 12:18:22 +0100
Message-ID: <20150216111822.GA21649@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37392 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbbBPLSZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 06:18:25 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v3.18.7-rt1 patch set. It was running over
the weekend on my x86 box and was still alive this morning. However it
is still the first release for the v3.18 -RT series.
I haven't follow the mailing list or commented / applied any patches
from the list for -RT while being busy getting this release done (except
one patch I needed to have anyway). This is about to change. I will try to
go through my RT-inbox before doing the next release.

Changes since v3.14.25-rt22

- rebased to v3.18

- Added "Work Simple" from Daniel Wagner. I needed it for cgroup's RCU
  handling.
  
- "timers: do not raise softirq unconditionally" has been reverted. It
  has been added to optimize the FULL NOHZ case on CPUs which could avoid
  a softirq / timer wake up. Its been reverted because it breaks the
  switch to highres.

- added a few patches to get MQ-BLK and cgroups working.

Known issues:

      - bcache is disabled.

      - lazy preempt on x86_64 leads to a crash with some load.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        measuring the performance of the individual implementation.

The RT patch against 3.18.7 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.7-rt1.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.7-rt1.tar.xz

Sebastian
