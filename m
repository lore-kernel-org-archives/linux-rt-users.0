From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/9][RFC] rt: Fix hotplugging and other nasties
Date: Thu, 01 Mar 2012 13:55:27 -0500
Message-ID: <20120301185527.064629423@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On both 3.0-rt and 3.2-rt I ran a stress test on CPU hotplug and they
both failed miserably. These bugs also show themselves on suspend.

After spending 5 long days debugging this, and finding lots of bugs
I have a patch series that makes the CPU hot plugging rather stable.

The first few patches fix other broken RT features that were discovered
while debugging hotplug.

Patch 7 is a rework of how RT handles taking down a CPU. There were
several corner cases that the original approach failed on, and this
rework seems to cover them now.

Patch 8 and 9 revert the rework that was done on workqueue for RT.
Yes, letting workqueues play games with THREAD_BOUND is bad, but
the fixes introduced several more races that were very hard to fix.
Every fix seemed to produce a new race, and it was a bad game of
cat and mouse running around a goose hunt whacking moles!

Since the rework of the CPU down code no longer had issues with
workqueue messing with THREAD_BOUND, reverting the patches that did
the rework of workqueues fixed the bugs that I was hitting.

Lets fix CPU hotplug today, and leave the redesign of workqueues
for another day.

Comments,

-- Steve
