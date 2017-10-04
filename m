From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] time/hrtimer: Use softirq based wakeups for non-RT threads
Date: Wed,  4 Oct 2017 18:08:20 +0200
Message-ID: <20171004160820.27754-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org,
        Gratian Crisan <gratian.crisan@ni.com>,
        Piotr Gregor <piotrgregor@rsyncme.org>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Normal wake ups (like clock_nanosleep()) which are performed by normal
users can easily lead to 2ms latency spikes if (enough) hrtimer wakeups
are synchronized.
This patch moves all hrtimers wakeups to the softirq queue unless the
caller has a RT priority.

Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3aa823fcab70..8ea2825a50af 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1622,14 +1622,31 @@ static enum hrtimer_restart hrtimer_wakeup(struct h=
rtimer *timer)
 	return HRTIMER_NORESTART;
 }
=20
+#ifdef CONFIG_PREEMPT_RT_FULL
+static bool task_is_elevated(struct task_struct *tsk)
+{
+	int policy =3D tsk->policy;
+
+	if (policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR)
+		return true;
+	if (policy =3D=3D SCHED_DEADLINE)
+		return true;
+	return false;
+}
+#endif
+
 static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				   clockid_t clock_id,
 				   enum hrtimer_mode mode,
 				   struct task_struct *task)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (!(clock_id & HRTIMER_BASE_SOFT_MASK))
-		clock_id |=3D HRTIMER_BASE_HARD_MASK;
+	if (!(clock_id & (HRTIMER_BASE_HARD_MASK | HRTIMER_BASE_SOFT_MASK))) {
+		if (task_is_elevated(current) || system_state !=3D SYSTEM_RUNNING)
+			clock_id |=3D HRTIMER_BASE_HARD_MASK;
+		else
+			clock_id |=3D HRTIMER_BASE_SOFT_MASK;
+	}
 #endif
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function =3D hrtimer_wakeup;
--=20
2.14.2
