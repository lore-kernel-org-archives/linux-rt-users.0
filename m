From: Venkat Subbiah <venkat.subbiah@cavium.com>
Subject: [PATCH] MIPS: Octeon: Mark octeon_wdt interrupt as IRQF_NO_THREAD
Date: Mon,  3 Oct 2011 16:30:28 -0700
Message-ID: <1317684628-17488-1-git-send-email-venkat.subbiah@cavium.com>
Cc: linux-rt-users@vger.kernel.org, david.daney@cavium.com
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13331 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab1JCXba (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Oct 2011 19:31:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is to exclude it from force threading to allow RT patch set to work.

The watchdog timers are per-CPU and the addresses of register that reset
the timer are calculated based on the current CPU.  Therefore we cannot
allow it to run on a thread on a different CPU.  Also we only do a
single register write, which is much faster than scheduling a handler
thread.

And while on this line remove IRQF_DISABLED as this flag is a NOP.


Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 945ee83..7c0d863 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -402,7 +402,7 @@ static void octeon_wdt_setup_interrupt(int cpu)
 	irq = OCTEON_IRQ_WDOG0 + core;
 
 	if (request_irq(irq, octeon_wdt_poke_irq,
-			IRQF_DISABLED, "octeon_wdt", octeon_wdt_poke_irq))
+			IRQF_NO_THREAD, "octeon_wdt", octeon_wdt_poke_irq))
 		panic("octeon_wdt: Couldn't obtain irq %d", irq);
 
 	cpumask_set_cpu(cpu, &irq_enabled_cpus);
-- 
1.7.0.4

