From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] Revert "posix-timers: Prevent broadcast signals"
Date: Wed, 11 Jul 2018 15:52:17 +0200
Message-ID: <20180711135217.s6at5tj4yiup2fxw@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This reverts commit "posix-timers: Prevent broadcast signals".
Broadcast signals are not prevented by preventing sig_kernel_only() and
sig_kernel_coredump() (as explained by Eric W. Biederman).
This change was probably required in the early days but I can't find a
reason why it should be still required.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e1c5b9b64140..0d14e044b46f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -434,7 +434,6 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn = current->group_leader;
-	int sig = event->sigev_signo;
 
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
@@ -444,8 +443,7 @@ static struct pid *good_sigevent(sigevent_t * event)
 		/* FALLTHRU */
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
-		if (sig <= 0 || sig > SIGRTMAX ||
-		    sig_kernel_only(sig) || sig_kernel_coredump(sig))
+		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
 			return NULL;
 		/* FALLTHRU */
 	case SIGEV_NONE:
-- 
2.18.0
