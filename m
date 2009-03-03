Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59196 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724AbZCCASe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 19:18:34 -0500
From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH ARM] use __preempt_enable_no_resched in cpu_idle()
Date: Tue,  3 Mar 2009 01:18:31 +0100
Message-Id: <1236039511-8088-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20090303001525.GA16807@pengutronix.de>
References: <20090303001525.GA16807@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.orglinux-rt-users@vger.kernel.org
Cc: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

instead of preempt_enable_no_resched.  The only difference is that the
latter wails if preempt_count drops to zero.  This however is OK here as
schedule is called afterwards.  The same was done for x86 in the -rt git
repo in commit 932e227146fbb26ea4688c126d0fd3953787f6a4 and this change
exists there as 5bbbd7e8ebff4570ae7453002f5b7f5f7114da8d, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d3ea6fa..8fbf03b 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -167,7 +167,7 @@ void cpu_idle(void)
 			idle();
 		leds_event(led_idle_end);
 		tick_nohz_restart_sched_tick();
-		preempt_enable_no_resched();
+		__preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
 	}
-- 
tg: (ff0b86d..) t/rt/__preempt_enable_no_resched-in-cpu_idle (depends on: rt-base)
