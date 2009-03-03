Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59207 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbZCCAS7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 19:18:59 -0500
From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH ARM] Use kernel/Kconfig.preempt for ARM
Date: Tue,  3 Mar 2009 01:18:57 +0100
Message-Id: <1236039537-8167-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20090303001525.GA16807@pengutronix.de>
References: <20090303001525.GA16807@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.orglinux-rt-users@vger.kernel.org
Cc: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

I suggested a similar patch on the linux-arm-kernel ML.  (That patch is
a bit more conservative because it changes kernel/Kconfig.preempt not to
modify the available options.)

Anyhow, to get the definition of PREEMPT_RT this patch is fine for the
-rt series.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm/Kconfig |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dbfdf87..ceb2e01 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -838,18 +838,7 @@ config LOCAL_TIMERS
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
 
-config PREEMPT
-	bool "Preemptible Kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
-
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
+source kernel/Kconfig.preempt
 
 config HZ
 	int
-- 
tg: (ff0b86d..) t/rt/source_kernel_Kconfig.preempt (depends on: rt-base)
