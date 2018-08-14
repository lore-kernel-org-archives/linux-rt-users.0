Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:39 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 13/15] s390/mm: Fix missed tsk->pagefault_disabled conversion to pagefault_disable()
Date: Tue, 14 Aug 2018 13:54:06 -0500
Message-Id: <f97ca04fb6bb69f9af55231470cd4f3ce4cf921e.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Tom Zanussi <tom.zanussi@linux.intel.com>

stable-rt commit 7be67fb433a0 ("mm: pagefault_disabled()") does this for s390:

  -       if (unlikely(!user_space_fault(regs) || in_atomic() || !mm ||
  +       if (unlikely(!user_space_fault(regs) || !mm ||
                       tsk->pagefault_disabled))

  whereas elsewhere it does the right thing for other arches e.g.:

  -       if (in_atomic() || !mm || current->pagefault_disabled)
  +       if (!mm || pagefault_disabled())

i.e. because of the linebreak it misses the tsk->pagefault_disabled
and leaves it unconverted.

So fix that up and use pagefault_disabled() as intended.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/s390/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 43ec237a17e2..466154e1dfc0 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -436,7 +436,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	 */
 	fault = VM_FAULT_BADCONTEXT;
 	if (unlikely(!user_space_fault(regs) || !mm ||
-		     tsk->pagefault_disabled))
+		     pagefault_disabled()))
 		goto out;
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
-- 
2.14.1
