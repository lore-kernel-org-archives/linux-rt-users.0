Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ACC3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B524650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320373;
	bh=ErSXUHeYK0f2Fj/VgiRkVyhrdKK30DcgL1yKKZH0grA=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=X2BN6jY/p+n9PvRGUSMbuDsWaxJ3aaNi+IjNPgH9hsa7YzZKpMwj1M+1y09s2u46S
	 QwPsm3sq5NpKgsVmNjbStPg6647QxKQL+ntF54pI/46CdaZKRwqKh1vHxqyUUkhgOr
	 S3Jo6xTAp2I09llEh6gPzcOjle9jd+5CATrMUBhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgBUVZc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgBUVZb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:31 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C0B208C4;
        Fri, 21 Feb 2020 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320330;
        bh=ErSXUHeYK0f2Fj/VgiRkVyhrdKK30DcgL1yKKZH0grA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jWb5E3zrjxUMUJpScEqkK0cHtoxfHjrTJLWSUJ950BEdHeadjVu6kBihgxz7ut5aD
         JRLOBf115VMb7sxNA7y1P4uOijijrl41NIgGaXjmSqfr32ArqZNtwg2nWrqc67XL39
         ZaVpU1RjykH65crDq30L3LL/py6YQlP8lTc28ge4=
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
Subject: [PATCH RT 16/25] Revert "ARM: Initialize split page table locks for vector page"
Date:   Fri, 21 Feb 2020 15:24:44 -0600
Message-Id: <0862e594250ce236c9e324e7fc3ff1eee44925b2.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
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

