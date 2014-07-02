From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/4] Fix latency histogram after "hrtimer: Set expiry time before
 switch_hrtimer_base()"
Date: Wed, 02 Jul 2014 13:14:17 -0400
Message-ID: <20140702171433.763323337@goodmis.org>
References: <20140702171414.482562827@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-Fix-latency-histogram-after-hrtimer-Set-expiry-time-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.22-rt35-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

In an rt-kernel with CONFIG_MISSED_TIMER_OFFSETS_HIST enabled,
__hrtimer_start_range_ns() now crashes, as new_base is not assigned
before it is used.

Tested-by: Carsten Emde <C.Emde@osadl.org>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/hrtimer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index bc0e47dc0a05..c967b718ab37 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1105,6 +1105,11 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 #endif
 	}
 
+	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
+
+	/* Switch the timer base, if necessary: */
+	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 	{
 		ktime_t now = new_base->get_time();
@@ -1116,11 +1121,6 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 #endif
 
-	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
-
-	/* Switch the timer base, if necessary: */
-	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
-
 	timer_stats_hrtimer_set_start_info(timer);
 
 	leftmost = enqueue_hrtimer(timer, new_base);
-- 
2.0.0
