From: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: [PATCH] powerpc/64bit,PREEMPT_RT: Check preempt_count before preempting
Date: Mon, 15 Apr 2013 11:18:16 +0530
Message-ID: <1366004896-3006-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:35837 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752697Ab3DOFs3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 01:48:29 -0400
Received: from mail205-tx2 (localhost [127.0.0.1])	by
 mail205-tx2-R.bigfish.com (Postfix) with ESMTP id 9E2C56006BD	for
 <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2013 05:48:28 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.249])	by
 mail205-tx2.bigfish.com (Postfix) with ESMTP id 43617180044	for
 <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2013 05:48:27 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In ret_from_except_lite() with CONFIG_PREEMPT enabled,
add the missing check to compare value of preempt_count
with zero before continuing with preemption process of
the current task.
If preempt_count is non-zero, restore reg and return,
else continue the preemption process.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 arch/powerpc/kernel/entry_64.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 1b1c8ae..ec120e6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -643,6 +643,8 @@ resume_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Check if we need to preempt */
 	lwz	r8,TI_PREEMPT(r9)
+	cmpwi	0,r8,0		/* if non-zero, just restore regs and return */
+	bne	restore
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne+	check_count
 
-- 
1.7.4.1


