From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/6] x86-Tell-irq-work-about-self-IPI-support-3.14
Date: Fri, 07 Aug 2015 10:01:12 -0400
Message-ID: <20150807140121.446269762@goodmis.org>
References: <20150807140109.299360883@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-x86-Tell-irq-work-about-self-IPI-support-3.14.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.44-rt62-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <fweisbec@gmail.com>

commit 3010279f0fc36f0388872203e63ca49912f648fd
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Sat Aug 16 18:47:15 2014 +0200

x86: Tell irq work about self IPI support

x86 supports irq work self-IPIs when local apic is available. This is
partly known on runtime so lets implement arch_irq_work_has_interrupt()
accordingly.

This should be safely called after setup_arch().

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/Kbuild     |  1 -
 arch/x86/include/asm/irq_work.h | 11 +++++++++++
 arch/x86/kernel/irq_work.c      |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/irq_work.h

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1eb77ac0613c..7f669853317a 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -5,4 +5,3 @@ genhdr-y += unistd_64.h
 genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
-generic-y += irq_work.h
diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_work.h
new file mode 100644
index 000000000000..78162f8e248b
--- /dev/null
+++ b/arch/x86/include/asm/irq_work.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_IRQ_WORK_H
+#define _ASM_IRQ_WORK_H
+
+#include <asm/processor.h>
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return cpu_has_apic;
+}
+
+#endif /* _ASM_IRQ_WORK_H */
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 1de84e3ab4e0..15d741ddfeeb 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -41,7 +41,7 @@ __visible void smp_trace_irq_work_interrupt(struct pt_regs *regs)
 void arch_irq_work_raise(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (!cpu_has_apic)
+	if (!arch_irq_work_has_interrupt())
 		return;
 
 	apic->send_IPI_self(IRQ_WORK_VECTOR);
-- 
2.1.4
