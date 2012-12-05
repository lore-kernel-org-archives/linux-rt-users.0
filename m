From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RT 1/2][RFC] ARM version of arch_trigger_all_cpu_backtrace()
Date: Tue, 4 Dec 2012 20:52:00 -0800
Message-ID: <50BED2F0.1080809@am.sony.com>
References: <50BED1DA.7070907@am.sony.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "paulmck@linux.vnet.ibm.com"
 <paulmck@linux.vnet.ibm.com>, "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50BED1DA.7070907@am.sony.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org


The RCU stall warning functions print_cpu_stall() and print_other_cpu_stall()
call trigger_all_cpu_backtrace() to print a backtrace on each cpu.  This
function is only implemented for x86.  Add a version for ARM.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/arm/include/asm/hardirq.h |    2 	1 +	1 -	0 !
 arch/arm/include/asm/irq.h     |    5 	5 +	0 -	0 !
 arch/arm/kernel/smp.c          |   70 	70 +	0 -	0 !
 3 files changed, 76 insertions(+), 1 deletion(-)

Index: b/arch/arm/include/asm/irq.h
===================================================================
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -30,6 +30,11 @@ extern void asm_do_IRQ(unsigned int, str
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
+#ifdef CONFIG_SMP
+void arch_trigger_all_cpu_backtrace(void);
+#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+#endif
+
 #endif
 
 #endif
Index: b/arch/arm/kernel/smp.c
===================================================================
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -56,6 +56,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+	IPI_BACKTRACE,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -359,6 +360,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_BACKTRACE, "Trigger all cpu backtrace"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -493,6 +495,70 @@ static void ipi_cpu_stop(unsigned int cp
 		cpu_relax();
 }
 
+#ifdef arch_trigger_all_cpu_backtrace
+/*
+ * Based on arch/x86/kernel/apic/hw_nmi.c:
+ *   arch_trigger_all_cpu_backtrace_handler()
+ *   arch_trigger_all_cpu_backtrace()
+ */
+
+static struct cpumask backtrace_mask;
+
+static unsigned long backtrace_flag;
+static arch_spinlock_t smp_backtrace_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+
+/*
+ * ipi_backtrace - handle IPI from smp_send_backtrace()
+ */
+static void ipi_backtrace(unsigned int cpu, struct pt_regs *regs)
+{
+	/*
+	 * serialize cpus
+	 */
+	arch_spin_lock(&smp_backtrace_lock);
+
+	pr_crit("\nCPU %u\n", cpu);
+
+	if (regs)
+		__show_regs(regs);
+
+	dump_stack();
+
+	cpumask_clear_cpu(cpu, &backtrace_mask);
+
+	arch_spin_unlock(&smp_backtrace_lock);
+}
+
+void arch_trigger_all_cpu_backtrace(void)
+{
+	int i;
+
+	if (test_and_set_bit(0, &backtrace_flag))
+		/*
+		 * If there is already a trigger_all_cpu_backtrace() in progress
+		 * (backtrace_flag == 1), don't output double cpu dump infos.
+		 */
+		return;
+
+	ipi_backtrace(smp_processor_id(), NULL);
+
+	cpumask_copy(&backtrace_mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &backtrace_mask);
+
+	if (!cpumask_empty(&backtrace_mask))
+		smp_cross_call(&backtrace_mask, IPI_BACKTRACE);
+
+	/* Wait for up to 10 seconds for all CPUs to do the backtrace */
+	for (i = 0; i < 10 * 1000; i++) {
+		if (cpumask_empty(&backtrace_mask))
+			break;
+		mdelay(1);
+	}
+
+	clear_bit(0, &backtrace_flag);
+}
+#endif
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -538,6 +604,10 @@ void handle_IPI(int ipinr, struct pt_reg
 		irq_exit();
 		break;
 
+	case IPI_BACKTRACE:
+		ipi_backtrace(cpu, regs);
+		break;
+
 	default:
 		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
 		       cpu, ipinr);
Index: b/arch/arm/include/asm/hardirq.h
===================================================================
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	6
 
 typedef struct {
 	unsigned int __softirq_pending;
