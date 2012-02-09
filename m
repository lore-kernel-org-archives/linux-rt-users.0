From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/8] timer-fd: Prevent live lock
Date: Wed, 08 Feb 2012 20:59:31 -0500
Message-ID: <20120209020159.978564482@goodmis.org>
References: <20120209015926.851312665@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sankara Muthukrishnan <sankara.m@gmail.com>,
	stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-timer-fd-Prevent-live-lock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If hrtimer_try_to_cancel() requires a retry, then depending on the
priority setting te retry loop might prevent timer callback completion
on RT. Prevent that by waiting for completion on RT, no change for a
non RT kernel.

Reported-by: Sankara Muthukrishnan <sankara.m@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/timerfd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index dffeb37..57f0e4e 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -313,7 +313,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 		if (hrtimer_try_to_cancel(&ctx->tmr) >= 0)
 			break;
 		spin_unlock_irq(&ctx->wqh.lock);
-		cpu_relax();
+		hrtimer_wait_for_timer(&ctx->tmr);
 	}
 
 	/*
-- 
1.7.8.3
