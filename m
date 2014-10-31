From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/2] lockdep: Fix backport of "Correctly annotate hardirq context in
 irq_exit()"
Date: Thu, 30 Oct 2014 21:09:46 -0400
Message-ID: <20141031011009.702592774@goodmis.org>
References: <20141031010945.211059309@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-lockdep-Fix-backport-of-Correctly-annotate-hardirq-c.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.63-rt93-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The backport of f1a83e652bed "lockdep: Correctly annotate hardirq context
in irq_exit()" to v3.2.53-rt76 wasn't correct because v3.2-rt had two
calls to invoke_softirq(). One when __ARCH_IRQ_EXIT_IRQS_DISABLED is defined
and another when it is not defined. v3.14 which introduced this change
only had one version.

When I backported this change, I didn't see the two places and only one
was added. Unfortunately, it was the one that x86 does not use, and this
caused a lockdep splat on one of my tests. It only affected the -rt patch
when PREEMPT_RT_FULL was not set, so I did not spend much time looking to
see what broke.

Well, I finally spent a little time and found the cause, and this was
a simple fix. Now my all my tests pass on the v3.2-rt kernel, even the
one where I test CONFIG_PREEMPT_RT_FULL not set.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7d882ccfa22b..56d30853345d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -637,9 +637,10 @@ static inline void invoke_softirq(void)
 static inline void invoke_softirq(void)
 {
 #ifndef CONFIG_PREEMPT_RT_FULL
-	if (!force_irqthreads)
+	if (!force_irqthreads) {
+		lockdep_softirq_from_hardirq();
 		do_softirq();
-	else {
+	} else {
 		__local_bh_disable((unsigned long)__builtin_return_address(0),
 				SOFTIRQ_OFFSET);
 		wakeup_softirqd();
-- 
2.1.1
