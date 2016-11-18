From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/10] x86/ldt: use vfree_atomic() to free ldt entries
Date: Fri, 18 Nov 2016 14:03:52 +0100
Message-ID: <1479474236-4139-7-git-send-email-hch@lst.de>
References: <1479474236-4139-1-git-send-email-hch@lst.de>
Cc: aryabinin@virtuozzo.com,
	joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1479474236-4139-1-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

vfree() is going to use sleeping lock. free_ldt_struct()
may be called with disabled preemption, therefore we must
use vfree_atomic() here.

E.g. call trace:
	vfree()
	free_ldt_struct()
	destroy_context_ldt()
	__mmdrop()
	finish_task_switch()
	schedule_tail()
	ret_from_fork()

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/x86/kernel/ldt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 6707039..4d12cdf 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -93,7 +93,7 @@ static void free_ldt_struct(struct ldt_struct *ldt)
 
 	paravirt_free_ldt(ldt->entries, ldt->size);
 	if (ldt->size * LDT_ENTRY_SIZE > PAGE_SIZE)
-		vfree(ldt->entries);
+		vfree_atomic(ldt->entries);
 	else
 		free_page((unsigned long)ldt->entries);
 	kfree(ldt);
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
