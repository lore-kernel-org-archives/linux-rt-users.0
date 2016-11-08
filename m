From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/3] kernel/fork: use vfree_atomic() to free thread stack
Date: Tue, 8 Nov 2016 18:05:44 +0300
Message-ID: <1478617545-8443-2-git-send-email-aryabinin@virtuozzo.com>
References: <20161107150947.GA11279@lst.de>
 <1478617545-8443-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrey
 Ryabinin <aryabinin@virtuozzo.com>, Andy Lutomirski <luto@kernel.org>, Joel
 Fernandes <joelaf@google.com>, Jisheng Zhang <jszhang@marvell.com>, Chris
 Wilson <chris@chris-wilson.co.uk>, John Dias <joaodias@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>, <x86@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1478617545-8443-1-git-send-email-aryabinin@virtuozzo.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

vfree() is going to use sleeping lock. Thread stack freed in atomic
context, therefore we must use vfree_atomic() here.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: John Dias <joaodias@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index fd85c68..417e94f 100644
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
2.7.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
