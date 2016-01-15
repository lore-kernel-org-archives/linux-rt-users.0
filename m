From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4/9] drivers/clocksource: timer-atmel-st: undeclared var 'ret'
Date: Fri, 15 Jan 2016 20:21:08 +0100
Message-ID: <1452885673-30891-5-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35579 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcAOT1D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:03 -0500
Received: by mail-lf0-f54.google.com with SMTP id c192so288988795lfe.2
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:02 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Used the at91_dt_defconfig and this caused a  compilation error without
this fix:
../drivers/clocksource/timer-atmel-st.c: In function
'clkevt32k_set_periodic':
../drivers/clocksource/timer-atmel-st.c:157:2: error: 'ret' undeclared
(first use in this function)

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/timer-atmel-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ea37afc..b6f4aa6 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -150,7 +150,7 @@ static int clkevt32k_set_oneshot(struct clock_event_device *dev)
 
 static int clkevt32k_set_periodic(struct clock_event_device *dev)
 {
-	int irq;
+	int irq, ret;
 
 	clkdev32k_disable_and_flush_irq();
 
-- 
2.1.4

