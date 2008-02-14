From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2.6.24-rt1] SMC91x: Use special_lock when CONFIG_PREEMPT_[HARD|SOFT]IRQS
Date: Wed, 13 Feb 2008 17:35:46 -0800
Message-ID: <1202952946-10511-1-git-send-email-khilman@mvista.com>
Cc: linux-kernel@vger.kernel.org, Kevin Hilman <khilman@mvista.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60968 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750927AbYBNBrK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2008 20:47:10 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The smc_special_locks should also be used when either softIRQs or hard
IRQs are preempted which may lead to the same problems as under SMP.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/net/smc91x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index f198c49..be62616 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -530,7 +530,8 @@ static inline void  smc_rcv(struct net_device *dev)
 	}
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) ||						\
+    defined(CONFIG_PREEMPT_SOFTIRQS) || defined(CONFIG_PREEMPT_HARDIRQS)
 /*
  * On SMP we have the following problem:
  *
-- 
1.5.4
