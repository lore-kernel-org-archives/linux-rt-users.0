From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 0/3] Stable rt updates - part II
Date: Mon, 16 Jul 2012 08:07:43 -0000
Message-ID: <20120715090141.942753287@linutronix.de>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

please pick the following three patches which address the CPU hotplug
nightmare on RT.

I still hate them, but we want to have that addressed in the stable
series.

Aside of that there are the outstanding issues with btrfs and io unplug.

The missing spin_lock_init() fix should reach you via mainline stable
updates. Mike and Chris are looking into that interesting locking
features.

The io unplug thing stays mysterious, but as I just wrote in that
thread, my patch to address it is fundamentally wrong. :(

I'm off for a week of vacation, so do not expect any further updates
from my side. If Mike and Chris come up with an agreed solution for
the locking issue, please pick it up yourself.

Thanks,

	tglx
