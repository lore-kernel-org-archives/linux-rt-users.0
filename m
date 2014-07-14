From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] sched: Do not clear PF_NO_SETAFFINITY flag in select_fallback_rq()
Date: Mon, 14 Jul 2014 16:04:21 -0400
Message-ID: <20140714200435.542430985@goodmis.org>
References: <20140714200420.805309842@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-sched-Do-not-clear-PF_NO_SETAFFINITY-flag-in-select_.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.47-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

I talked with Peter Zijlstra about this, and he told me that the clearing
of the PF_NO_SETAFFINITY flag was to deal with the optimization of
migrate_disable/enable() that ignores tasks that have that flag set. But
that optimization was removed when I did a rework of the cpu hotplug code.

I found that ignoring tasks that had that flag set would cause those tasks
to not sync with the hotplug code and cause the kernel to crash. Thus it
needed to not treat them special and those tasks had to go though the same
work as tasks without that flag set.

Now that those tasks are not treated special, there's no reason to clear the
flag.

May still need to be tested as the migrate_me() code does not ignore those
flags.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20140701111444.0cfebaa1@gandalf.local.home
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a060a092e92b..b8acecc0600f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1289,12 +1289,6 @@ out:
 		}
 	}
 
-	/*
-	 * Clear PF_NO_SETAFFINITY, otherwise we wreckage
-	 * migrate_disable/enable. See optimization for
-	 * PF_NO_SETAFFINITY tasks there.
-	 */
-	p->flags &= ~PF_NO_SETAFFINITY;
 	return dest_cpu;
 }
 
-- 
2.0.0
