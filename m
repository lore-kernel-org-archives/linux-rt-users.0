From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/3] alarmtimer: Prevent live lock in alarm_cancel()
Date: Fri,  4 May 2018 15:55:14 +0200
Message-ID: <20180504135516.32601-2-wagi@monom.org>
References: <20180504135516.32601-1-wagi@monom.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, stable-rt@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504135516.32601-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If alarm_try_to_cancel() requires a retry, then depending on the
priority setting the retry loop might prevent timer callback completion
on RT. Prevent that by waiting for completion on RT, no change for a
non RT kernel.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6fcc367ad531..9d5eac2c9275 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -392,7 +392,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
-- 
2.14.3
