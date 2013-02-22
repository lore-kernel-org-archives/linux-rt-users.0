From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH rt-3.6] irq: fix printk messages for spurious IRQ on RT.
Date: Thu, 21 Feb 2013 20:14:06 -0500
Message-ID: <1361495646-29621-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:62384 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab3BVBOQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2013 20:14:16 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r1M1EGSs019139
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Feb 2013 17:14:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These messages refer to a Kconfig option that does no longer
exist.  Match them to their surrounding #ifdef options.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ For the patch queue, this change should be squished into the
  existing genirq-disable-irqpoll-on-rt.patch file.  It does
  not need to be maintained as a separate commit. ]

 kernel/irq/spurious.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index d1c80fa..e8dbd15 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -343,7 +343,7 @@ static int __init irqfixup_setup(char *str)
 {
 #ifdef CONFIG_PREEMPT_RT_BASE
 	printk(KERN_WARNING "irqfixup boot option not supported "
-		"w/ CONFIG_PREEMPT_RT\n");
+		"w/ CONFIG_PREEMPT_RT_BASE\n");
 	return 1;
 #endif
 	irqfixup = 1;
@@ -360,7 +360,7 @@ static int __init irqpoll_setup(char *str)
 {
 #ifdef CONFIG_PREEMPT_RT_BASE
 	printk(KERN_WARNING "irqpoll boot option not supported "
-		"w/ CONFIG_PREEMPT_RT\n");
+		"w/ CONFIG_PREEMPT_RT_BASE\n");
 	return 1;
 #endif
 	irqfixup = 2;
-- 
1.8.1.2

