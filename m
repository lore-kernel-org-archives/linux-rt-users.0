From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] hotplug, hrtimer: Migrate expired/deferred timers during
 cpu offline
Date: Fri, 11 Aug 2017 09:55:16 +0200
Message-ID: <1502438116.16425.18.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de> <1501945043.5473.31.camel@gmx.de>
         <20170807073350.nwytftryfp34mrwi@linutronix.de>
         <1502094121.5568.22.camel@gmx.de> <1502186459.8042.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502186459.8042.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The below fixes the list debug explosion up.

If we do not migrate expired/deferred timers during cpu offline, ->cb_entry
will be corrupted by online initialization of base->expired, leading to a
loud list debug complaint should someone call __remove_hrtimer() thereafter.

Signed-off-by: Mike Galvraith <efault@gmx.de>
---
 kernel/time/hrtimer.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1802,6 +1802,19 @@ static void migrate_hrtimer_list(struct
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+
+	/*
+	 * Finally, migrate any expired timers deferred by RT.
+	 */
+	while (!list_empty(&old_base->expired)) {
+		struct list_head *entry = old_base->expired.next;
+
+		timer = container_of(entry, struct hrtimer, cb_entry);
+		/* XXX: hm, perhaps defer again instead of enqueueing. */
+		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, 0);
+		timer->base = new_base;
+		enqueue_hrtimer(timer, new_base);
+	}
 }
 
 int hrtimers_dead_cpu(unsigned int scpu)
