From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 3/3] posix-timers: move the rcu head out of the union
Date: Wed, 28 Mar 2018 12:07:46 +0200
Message-ID: <20180328100746.18668-3-bigeasy@linutronix.de>
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
busy looping). The RCU-readlock is held to ensure that this posix timer
is not removed while we wait on it.
If the timer is removed then it invokes call_rcu() with a pointer that
is shared with the hrtimer because it is part of the same union.
In order to avoid any possible side effects I am moving the rcu pointer
out of the union.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/posix-timers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 672c4f32311e..4754eb4298b1 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -101,8 +101,8 @@ struct k_itimer {
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
-		struct rcu_head		rcu;
 	} it;
+	struct rcu_head		rcu;
 };
=20
 void run_posix_cpu_timers(struct task_struct *task);
--=20
2.16.3
