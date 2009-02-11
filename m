From: Katsuya Matsubara <matsu@igel.co.jp>
Subject: [PATCH RT 3/4] sh: decouple the pagefault-disabled logic
Date: Thu, 12 Feb 2009 00:01:42 +0900
Message-ID: <1234364503-857-4-git-send-email-matsu@igel.co.jp>
References: <1234364503-857-1-git-send-email-matsu@igel.co.jp>
 <1234364503-857-2-git-send-email-matsu@igel.co.jp>
 <1234364503-857-3-git-send-email-matsu@igel.co.jp>
Cc: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mundt <lethal@linux-sh.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Katsuya Matsubara <matsu@igel.co.jp>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.igel.co.jp ([219.106.231.130]:41198 "EHLO
	mailhost.igel.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbZBKPXY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 10:23:24 -0500
In-Reply-To: <1234364503-857-3-git-send-email-matsu@igel.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The preempt-rt patch adds a pagefault-disabled logic. We must not take
page faults if pagefault_disabled > 0. The same treatment can be found
in other arch code.

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 arch/sh/mm/fault_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/fault_32.c b/arch/sh/mm/fault_32.c
index 898d477..2746b08 100644
--- a/arch/sh/mm/fault_32.c
+++ b/arch/sh/mm/fault_32.c
@@ -100,7 +100,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (in_atomic() || !mm || current->pagefault_disabled)
 		goto no_context;
 
 	down_read(&mm->mmap_sem);
-- 
1.6.1

