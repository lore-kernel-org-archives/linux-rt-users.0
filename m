From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] kernel/fork: use vfree_atomic() to free thread stack
Date: Fri, 18 Nov 2016 14:03:51 +0100
Message-ID: <1479474236-4139-6-git-send-email-hch@lst.de>
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

vfree() is going to use sleeping lock. Thread stack freed in atomic
context, therefore we must use vfree_atomic() here.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 997ac1d..cfee5ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -229,7 +229,7 @@ static inline void free_thread_stack(struct task_struct *tsk)
 		}
 		local_irq_restore(flags);
 
-		vfree(tsk->stack);
+		vfree_atomic(tsk->stack);
 		return;
 	}
 #endif
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
