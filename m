Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:52750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVn0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:26 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 05/15] alarmtimer: Prevent live lock in alarm_cancel()
Date: Tue, 14 Aug 2018 13:53:58 -0500
Message-Id: <f5183b98e3f877f8b380ff6f561a8122c6594ed7.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream rt-devel commit 51e376c469bf05f32cb1ceb9e39d31bb92f1f6c8 ]

If alarm_try_to_cancel() requires a retry, then depending on the
priority setting the retry loop might prevent timer callback completion
on RT. Prevent that by waiting for completion on RT, no change for a
non RT kernel.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 119847b93ba6..5a5e05fc92a3 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -395,7 +395,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
-- 
2.14.1
