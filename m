From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/9] drivers/clocksource: timer-atmel-pit: fix forward declaration
Date: Fri, 15 Jan 2016 20:21:06 +0100
Message-ID: <1452885673-30891-3-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35115 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcAOT1A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:00 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so319296643lbc.2
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:26:59 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Forward declare function at91sam926x_pit_interrupt before use.

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
error without this fix:
../drivers/clocksource/timer-atmel-pit.c: In function
'pit_clkevt_set_periodic':
../drivers/clocksource/timer-atmel-pit.c:111:31: error:
'at91sam926x_pit_interrupt' undeclared (first use in this function)
  ret = request_irq(data->irq, at91sam926x_pit_interrupt,

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/timer-atmel-pit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 2e313e6..f87e660 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -100,6 +100,7 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
 	return 0;
 }
 
+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id);
 /*
  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
  */
-- 
2.1.4

