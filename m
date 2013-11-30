From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 1/4] migrate_disable pushd down in spin_trylock
Date: Sat, 30 Nov 2013 04:06:28 +0100
Message-ID: <20131130030628.GB8101@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54089 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3K3DG2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 22:06:28 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 7b60d163555d701b88f463d12ba62c6ceb61fb66 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 29 Nov 2013 00:21:59 -0500
Subject: [PATCH 4/4] migrate_disable pushd down in rt_write_trylock_irqsave

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rt.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rt.c b/kernel/rt.c
index 75372f0..ce44afc 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -196,10 +196,9 @@ int __lockfunc rt_write_trylock_irqsave(rwlock_t *rwlock, unsigned long *flags)
 	int ret;
 
 	*flags = 0;
-	migrate_disable();
 	ret = rt_write_trylock(rwlock);
-	if (!ret)
-		migrate_enable();
+	if (ret)
+		migrate_disable();
 	return ret;
 }
 EXPORT_SYMBOL(rt_write_trylock_irqsave);
-- 
1.7.2.5

