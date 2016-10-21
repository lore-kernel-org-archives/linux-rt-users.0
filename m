From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4.8-rt] x86-32: fix stalled boot issues due to missing thread info in %ebp
Date: Fri, 21 Oct 2016 14:10:51 -0400
Message-ID: <20161021181051.25437-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45306 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932749AbcJUSL2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Oct 2016 14:11:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In 4.7 development window, we got commit 1e17880371f8 ("x86/entry/32:
Remove GET_THREAD_INFO() from entry code") which said:

 The entry code used to cache the thread_info pointer in the EBP register,
 but all the code that used it has been moved to C.  Remove the unused
 code to get the pointer.

The problem arises when this commit interacts with the -rt patch
"x86: Support for lazy preemption" -- as it added another instance
where we were expecting thread info in %ebp.  But after the upstream
commit we end up looking for preempt_lazy in whatever random junk
was left there, which doesn't work so well.

Load up %ebp just before we try to use it ; this is also basically
what x86-64 does in the -rt preempt lazy patch mentioned above,
but it instead uses %rcx.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index aa149231b1ff..1d8ee026c9c5 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -282,6 +282,7 @@ need_resched:
 	cmpl $_PREEMPT_ENABLED,PER_CPU_VAR(__preempt_count)
 	jne restore_all
 
+	GET_THREAD_INFO(%ebp)
 	cmpl $0,TI_preempt_lazy_count(%ebp)	# non-zero preempt_lazy_count ?
 	jnz restore_all
 
-- 
2.10.0

