From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/9] drivers/clocksource: timer-atmel-pit: fix irq name
Date: Fri, 15 Jan 2016 20:21:05 +0100
Message-ID: <1452885673-30891-2-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34373 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcAOT06 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:26:58 -0500
Received: by mail-lf0-f48.google.com with SMTP id 17so86666481lfz.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:26:57 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Use the same irq (data->irq) that we used while registering the timer
handle, and not atmel_pit_irq.

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
error without this fix:
../drivers/clocksource/timer-atmel-pit.c: In function
'pit_clkevt_shutdown':
../drivers/clocksource/timer-atmel-pit.c:99:11: error: 'atmel_pit_irq'
undeclared (first use in this function)
  free_irq(atmel_pit_irq, data);

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/timer-atmel-pit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 80d74c4..2e313e6 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -96,7 +96,7 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
 
 	/* disable irq, leaving the clocksource active */
 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
-	free_irq(atmel_pit_irq, data);
+	free_irq(data->irq, data);
 	return 0;
 }
 
-- 
2.1.4

