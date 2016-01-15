From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/9] drivers/clocksource: timer-atmel-pit: fix unused var 'ret'
Date: Fri, 15 Jan 2016 20:21:07 +0100
Message-ID: <1452885673-30891-4-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34392 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcAOT1B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:01 -0500
Received: by mail-lf0-f41.google.com with SMTP id 17so86667229lfz.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:01 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
warning without this fix:
../drivers/clocksource/timer-atmel-pit.c: In function
'at91sam926x_pit_common_init':
../drivers/clocksource/timer-atmel-pit.c:193:6: warning: unused variable
'ret' [-Wunused-variable]

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/timer-atmel-pit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index f87e660..a7abdb6 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -190,7 +190,6 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
 {
 	unsigned long	pit_rate;
 	unsigned	bits;
-	int		ret;
 
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
-- 
2.1.4

