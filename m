From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 9/9] driver/gpio: gpio-omap: fix incompatible pointer type
Date: Fri, 15 Jan 2016 20:21:13 +0100
Message-ID: <1452885673-30891-10-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34446 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbcAOT1J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:09 -0500
Received: by mail-lf0-f52.google.com with SMTP id 17so86669179lfz.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:09 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
warning without this fix:
../drivers/gpio/gpio-omap.c: In function 'omap_gpio_runtime_resume':
../drivers/gpio/gpio-omap.c:1398:4: warning: passing argument 1 of
    'rt_spin_unlock' from incompatible pointer type [enabled by default]
In file included from ../include/linux/spinlock.h:290:0,
                 from ../include/linux/seqlock.h:35,
                 from ../include/linux/time.h:5,
                 from ../include/linux/stat.h:18,
                 from ../include/linux/module.h:10,
                 from ../drivers/gpio/gpio-omap.c:16:
../include/linux/spinlock_rt.h:24:56: note: expected
    'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 004888b..f3028e7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1395,7 +1395,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		if (c != bank->context_loss_count) {
 			omap_gpio_restore_context(bank);
 		} else {
-			spin_unlock_irqrestore(&bank->lock, flags);
+			raw_spin_unlock_irqrestore(&bank->lock, flags);
 			return 0;
 		}
 	}
-- 
2.1.4

