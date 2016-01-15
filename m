From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 6/9] drivers/clocksource: timer-atmel-st: undeclared var 'irq'
Date: Fri, 15 Jan 2016 20:21:10 +0100
Message-ID: <1452885673-30891-7-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35597 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcAOT1F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:05 -0500
Received: by mail-lf0-f52.google.com with SMTP id c192so288989413lfe.2
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:05 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Used the at91_dt_defconfig and this caused a compilation error without
this fix:
../drivers/clocksource/timer-atmel-st.c: In function
'atmel_st_timer_init':
../drivers/clocksource/timer-atmel-st.c:232:2: error: 'irq' undeclared
(first use in this function)
make[3]: *** [drivers/clocksource/timer-atmel-st.o] Error 1

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/timer-atmel-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ea4d8e5..b26735f 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -217,7 +217,7 @@ static void __init atmel_st_timer_init(struct device_node *node)
 {
 	struct clk *sclk;
 	unsigned int sclk_rate, val;
-	int ret;
+	int irq, ret;
 
 	regmap_st = syscon_node_to_regmap(node);
 	if (IS_ERR(regmap_st))
-- 
2.1.4

