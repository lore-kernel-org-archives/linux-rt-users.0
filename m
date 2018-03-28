From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 2/3] posix-timers: user proper timer while waiting for alarmtimer
Date: Wed, 28 Mar 2018 12:07:45 +0200
Message-ID: <20180328100746.18668-2-bigeasy@linutronix.de>
References: <20180328100746.18668-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable-rt@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328100746.18668-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On RT the timer can be preempted while running and therefore we wait
with timer_wait_for_callback() for the timer to complete (instead of
busy looping).
The POSIX timer has an hrtimer underneath and this hrtimer is used to
wait for its completion. The alartimer has also an hrtimer but at a
different location.

Instead of checking for ->timer_set which is the same for the alarmtimer
and the "posix-timers" I instead check for ->arm which is only used by
the "posix-timers". To match the alarmtimer I check for the alarm_clock
struct.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0b568087bd64..8a16cb8f684a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -802,8 +802,10 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 static void timer_wait_for_callback(const struct k_clock *kc, struct k_iti=
mer *timr)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_set =3D=3D common_timer_set)
+	if (kc->arm =3D=3D common_hrtimer_arm)
 		hrtimer_wait_for_timer(&timr->it.real.timer);
+	else if (kc =3D=3D alarm_clock)
+		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
 	else
 		/* FIXME: Whacky hack for posix-cpu-timers */
 		schedule_timeout(1);
--=20
2.16.3
