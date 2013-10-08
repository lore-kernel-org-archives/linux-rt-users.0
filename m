From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] ppc: use pagefault_disabled helper to fix compile fail for !RT_FULL
Date: Tue, 8 Oct 2013 10:42:19 -0400
Message-ID: <1381243339-31155-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49344 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3JHOmj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 10:42:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To fix:

arch/powerpc/mm/fault.c: In function 'do_page_fault':
arch/powerpc/mm/fault.c:267:42: error: 'struct task_struct' has no member named 'pagefault_disabled'
make[2]: *** [arch/powerpc/mm/fault.o] Error 1

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Should be squished into peter_zijlstra-frob-pagefault_disable.patch]

 arch/powerpc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a47400d..87f730e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -264,7 +264,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-	if (in_atomic() || mm == NULL || current->pagefault_disabled) {
+	if (in_atomic() || mm == NULL || pagefault_disabled()) {
 		if (!user_mode(regs)) {
 			rc = SIGSEGV;
 			goto bail;
-- 
1.8.1.2

