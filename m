From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 0/7] Various fixes for the stable RT series - part I
Date: Wed, 11 Jul 2012 22:05:17 -0000
Message-ID: <20120711214552.036760674@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <cbe@osadl.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The following patch series is a collection of bug fixes, which should
go into the 3.x based stable RT trees.

I have them locally applied to my 3.5 devel queue, but I'm still
distracted by other events (leap seconds and the like) to get a 3.5
devel queue released.

Steven, please pick up the lot.

I have a part II series pending which is addressing the widely
observed CPU hotplug issue. I'm going to send that out soon, despite
the fact that I fundamentaly hate it. Though the hotplug rework which
I have in the queue has turned out to be more work than expected and
there is no real way to backport all of the necessary changes into any
of the existing 3.x based RT trees. So I bite the bullet and go with
the workarounds to get rid of the last obstacles in the 3.x based RT
series.

Thanks,

	tglx
