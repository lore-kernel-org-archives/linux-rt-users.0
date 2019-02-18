From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 2/2] x86: lazy-preempt: properly check against preempt-mask
Date: Mon, 18 Feb 2019 17:31:37 +0100
Message-ID: <20190218163137.cmor4ek3odus5m6j@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

should_resched() should check against preempt_offset after unmasking the
need-resched-bit. Otherwise should_resched() won't work for
preempt_offset != 0 and lazy-preempt set.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 22992c8377952..f667087792747 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 	/* preempt count == 0 ? */
 	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp)
+	if (tmp != preempt_offset)
 		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
-- 
2.20.1
