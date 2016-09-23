From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/10] x86/preempt-lazy: fixup should_resched()
Date: Thu, 22 Sep 2016 22:49:35 -0400
Message-ID: <20160923024939.190434953@goodmis.org>
References: <20160923024927.685936218@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-x86-preempt-lazy-fixup-should_resched.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.79-rt85-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

should_resched() returns true if NEED_RESCHED is set and the
preempt_count is 0 _or_ if NEED_RESCHED_LAZY is set ignoring the preempt
counter. Ignoring the preemp counter is wrong. This patch adds this into
account.
While at it, __preempt_count_dec_and_test() ignores preempt_lazy_count
while checking TIF_NEED_RESCHED_LAZY so we this check, too.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/preempt.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 9afdfb9ce021..aba26ff51f39 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -107,6 +107,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return false;
@@ -119,8 +121,19 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 #ifdef CONFIG_PREEMPT_LAZY
-	return unlikely(__this_cpu_read_4(__preempt_count) == preempt_offset || \
-			test_thread_flag(TIF_NEED_RESCHED_LAZY));
+	u32 tmp;
+
+	tmp = __this_cpu_read_4(__preempt_count);
+	if (tmp == preempt_offset)
+		return true;
+
+	/* preempt count == 0 ? */
+	tmp &= ~PREEMPT_NEED_RESCHED;
+	if (tmp)
+		return false;
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
+	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return unlikely(__this_cpu_read_4(__preempt_count) == preempt_offset);
 #endif
-- 
2.8.1
