Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6129C76596
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B85D2468F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814154;
	bh=rXX4baJBpVmsrJ1apwr5q2LcKvq7w9ypzd3klZbEYG4=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=MPX2VyMWxI9dtMR6rxnDqKv5BzeuC7wcmD3dIUsrSdDZwZn8uMv4T94kbmIVYHOHc
	 MSoxPAKj15F0dROjlFDlMEJ/tGMWDmuG4qTxDnQ+cZgFaHea9fiv3/8lilbfakP8km
	 cjdbmjU+btITucjwbQfTfirpg+E7NB3oMfPk1T9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbgB0Oft (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbgB0Od5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:33:57 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269F624697;
        Thu, 27 Feb 2020 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814036;
        bh=rXX4baJBpVmsrJ1apwr5q2LcKvq7w9ypzd3klZbEYG4=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VrPHTq5P1qoilg+HMyyH0zcQXSYfoYZ9ddHf/82/nI2n89Ux8RHTPipPS0YvC/AMW
         Ah8MmoemZDf0hzFJ/IWwNQ1OQGF9XW7LPJoX/Hy92nSbaXp9aNI28ZnS2TIRCSLVTn
         tVmmxr03qDzYs6nMbkx58oNMQ2LaUkBCNlBBdpww=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 01/23] Fix wrong-variable use in irq_set_affinity_notifier
Date:   Thu, 27 Feb 2020 08:33:12 -0600
Message-Id: <3e96d7fce5c890b243bd194810f1675bbcadf253.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Joe Korty <joe.korty@concurrent-rt.com>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Fixes upstream commit 3e4242082f0384311f15ab9c93e2620268c6257f,
  which erroneously switched old_notify->work to notify->work when
  fixing a merge conflict ]

4.14-rt: Fix wrong-variable use in irq_set_affinity_notifier.

The bug was introduced in the 4.14-rt patch

   0461-genirq-Handle-missing-work_struct-in-irq_set_affinit.patch

The symptom is a NULL pointer panic in the i40e driver on
system shutdown.

    Rebooting.
    BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
    IP: __kthread_cancel_work_sync+0x12/0xa0
    CPU: 15 PID: 6274 Comm: reboot Not tainted 4.14.155-rt70-RedHawk-8.0.2-prt-trace #1
    task: ffff9ef0d1a58000 task.stack: ffffbe540c038000
    RIP: 0010:__kthread_cancel_work_sync+0x12/0xa0
    RSP: 0018:ffffbe540c03bbd8 EFLAGS: 00010296
    RAX: 0000084000000020 RBX: 0000000000000000 RCX: 0000000000000034
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
    RBP: ffffbe540c03bc00 R08: ffff9ee8ccdc3800 R09: ffff9ef0d8c0c000
    R10: ffff9ef0d8c0c028 R11: 0000000000000040 R12: ffff9ee8ccdc3800
    R13: 0000000000000000 R14: ffff9ee8ccdc3960 R15: 0000000000000074
    FS:  00007ffff7fcf380(0000) GS:ffff9ef0ffdc0000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000020 CR3: 000000104b428003 CR4: 00000000005606e0
    DR0: 00000000006040e0 DR1: 00000000006040e8 DR2: 00000000006040f0
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
    PKRU: 55555554

    Call Trace:
     kthread_cancel_work_sync+0xb/0x10
     irq_set_affinity_notifier+0x8e/0xc0
     i40e_vsi_free_irq+0xbc/0x230 [i40e]
     i40e_vsi_close+0x24/0xa0 [i40e]
     i40e_close+0x10/0x20 [i40e]
     i40e_quiesce_vsi.part.40+0x30/0x40 [i40e]
     i40e_pf_quiesce_all_vsi.isra.41+0x34/0x50 [i40e]
     i40e_prep_for_reset+0x67/0x110 [i40e]
     i40e_shutdown+0x39/0x220 [i40e]
     pci_device_shutdown+0x2b/0x50
     device_shutdown+0x147/0x1f0
     kernel_restart_prepare+0x71/0x74
     kernel_restart+0xd/0x4e
     SyS_reboot.cold.1+0x9/0x34
     do_syscall_64+0x7c/0x150

4.19-rt and above do not have this problem due to a refactoring.

Signed-off-by: Joe Korty <Joe.Korty@concurrent-rt.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 071691963f7b..12702d48aaa3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -353,7 +353,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 
 	if (old_notify) {
 #ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
+		kthread_cancel_work_sync(&old_notify->work);
 #else
 		cancel_work_sync(&old_notify->work);
 #endif
-- 
2.14.1

