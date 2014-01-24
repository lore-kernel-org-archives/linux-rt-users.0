From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 15:09:33 -0500
Message-ID: <20140124150933.22d8c20a@gandalf.local.home>
References: <20140124145157.1f30d447@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>,
	Joakim Hernberg <jbh@alchemy.lu>,
	Joe Korty <joe.korty@ccur.com>,
	Muli Baron <muli.baron@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140124145157.1f30d447@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ Talking with Sebastian on IRC, it seems that doing the irq_work_run()
  from the interrupt in -rt is a bad thing. Here we simply raise the
  softirq if there's irq work to do. This too boots on my i7 ]

After trying hard to figure out why my i7 box was locking up with the
new active_timers code, that does not run the timer softirq if there
are no active timers, I took an extra look at the softirq handler and
noticed that it doesn't just run timer softirqs, it also runs irq work.

This was the bug that was locking up the system. It wasn't missing a
timer, it was missing irq work. By always doing the irq work callbacks,
the system boots fine.

No need to check for defined(CONFIG_IRQ_WORK). When that's not set the
"irq_work_needs_cpu()" is a static inline that returns false.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/timer.c b/kernel/timer.c
index 46467be..c01a0d2 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1464,8 +1464,13 @@ void run_local_timers(void)
 		raise_softirq(TIMER_SOFTIRQ);
 		return;
 	}
-	if (!base->active_timers)
-		goto out;
+	if (!base->active_timers) {
+#ifdef CONFIG_PREEMPT_RT_FULL
+		/* On RT, irq work runs from softirq */
+		if (!irq_work_needs_cpu())
+#endif
+			goto out;
+	}
 
 	/* Check whether the next pending timer has expired */
 	if (time_before_eq(base->next_timer, jiffies))
