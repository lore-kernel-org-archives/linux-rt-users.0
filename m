Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A7C7657E
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E2624697
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814112;
	bh=eEY166ta87q0I5Yb9poafq3N1XnniQY60N3Cp98vY/c=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=c4IwqaqQpuJM0qBRXG0tYLMyzP37UQlQXfgi5Qmb7P6D2ylzDGpNAudhMkPja6wK/
	 T0G2oOndxMRb+6HMkwBayQw2+0cgGU7w+Sh81P18KQiS7Ep9rCAjkFhz4edsHZI2U3
	 WIOA0+FcWYO268iaUtlu30uk90xwlVK8bFUKj5O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgB0OfK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbgB0OeK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:10 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0FA3246B8;
        Thu, 27 Feb 2020 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814049;
        bh=eEY166ta87q0I5Yb9poafq3N1XnniQY60N3Cp98vY/c=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Bc+tbI1J5rTPCQEfGflEqZB773VyzsVLDf1Su+OBbz8/YS6P9m9L090GSNKeUdbE6
         WKrrsMusLA1oATsadBmiNRMmcr/a0aIxJ+LMIIt7fWM2CFq7VUEUExiPL+X9bmlg1z
         A0NZbSBwWzFFDHboSFzQbEundJ9DZc1k+mSCXXeA=
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
Subject: [PATCH RT 14/23] Revert "ARM: Initialize split page table locks for vector page"
Date:   Thu, 27 Feb 2020 08:33:25 -0600
Message-Id: <b1c7e28f28755f6bc202daf3b276f2874ac4c776.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 247074c44d8c3e619dfde6404a52295d8d671d38 ]

I'm dropping this patch, with its original description:

|ARM: Initialize split page table locks for vector page
|
|Without this patch, ARM can not use SPLIT_PTLOCK_CPUS if
|PREEMPT_RT_FULL=y because vectors_user_mapping() creates a
|VM_ALWAYSDUMP mapping of the vector page (address 0xffff0000), but no
|ptl->lock has been allocated for the page.  An attempt to coredump
|that page will result in a kernel NULL pointer dereference when
|follow_page() attempts to lock the page.
|
|The call tree to the NULL pointer dereference is:
|
|   do_notify_resume()
|      get_signal_to_deliver()
|         do_coredump()
|            elf_core_dump()
|               get_dump_page()
|                  __get_user_pages()
|                     follow_page()
|                        pte_offset_map_lock() <----- a #define
|                           ...
|                              rt_spin_lock()
|
|The underlying problem is exposed by mm-shrink-the-page-frame-to-rt-size.patch.

The patch named mm-shrink-the-page-frame-to-rt-size.patch was dropped
from the RT queue once the SPLIT_PTLOCK_CPUS feature (in a slightly
different shape) went upstream (somewhere between v3.12 and v3.14).

I can see that the patch still allocates a lock which wasn't there
before. However I can't trigger a kernel oops like described in the
patch by triggering a coredump.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 arch/arm/kernel/process.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index cf4e1452d4b4..d96714e1858c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -325,30 +325,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_MMU
-/*
- * CONFIG_SPLIT_PTLOCK_CPUS results in a page->ptl lock.  If the lock is not
- * initialized by pgtable_page_ctor() then a coredump of the vector page will
- * fail.
- */
-static int __init vectors_user_mapping_init_page(void)
-{
-	struct page *page;
-	unsigned long addr = 0xffff0000;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset_k(addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	page = pmd_page(*(pmd));
-
-	pgtable_page_ctor(page);
-
-	return 0;
-}
-late_initcall(vectors_user_mapping_init_page);
-
 #ifdef CONFIG_KUSER_HELPERS
 /*
  * The vectors page is always readable from user space for the
-- 
2.14.1

