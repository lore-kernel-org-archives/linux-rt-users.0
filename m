From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 2/7] timer: Invoke timer_start_debug() where it makes sense
Date: Wed,  4 Apr 2018 09:16:47 +0200
Message-ID: <20180404071652.24196-3-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable@vger.kernel.org,
        rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The timer start debug function is called before the proper timer base is
set. As a consequence the trace data contains the stale CPU and flags
values.

Call the debug function after setting the new base and flags.

Fixes: 500462a9de65 ("timers: Switch to a non-cascading wheel")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: rt@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a8246d79cb5a..6b322aea1c46 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -838,8 +838,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	debug_activate(timer, expires);
-
 	new_base = get_target_base(base, pinned);
 
 	if (base != new_base) {
@@ -854,6 +852,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 			base = switch_timer_base(timer, base, new_base);
 	}
 
+	debug_activate(timer, expires);
+
 	timer->expires = expires;
 	internal_add_timer(base, timer);
 
-- 
2.14.3
