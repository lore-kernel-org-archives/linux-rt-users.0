Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D9C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Mar 2021 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0133E61970
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Mar 2021 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSWeJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSWeA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Mar 2021 18:34:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF843C061760;
        Fri, 19 Mar 2021 15:33:59 -0700 (PDT)
Date:   Fri, 19 Mar 2021 23:33:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616193238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Jp1c3wlrXQ7hrVxZ4KjcM1NHiVwHh3RiWx3Av2mQQzQ=;
        b=2YeAnIb6QieM4YxRhFvQ5UJXZf59bYzx79Q3FgCuDmMC8LCiEDQHRkl27UWo2s+KnirKA9
        HN5pOOyPfmswAxfHGtg447OPNNCtxE6cJNuyUveiKPNdsrxUwfAVAje8XJThYvdD7e+WJ6
        EbaDZhBYchLMJRKOGxBNstM7kDmvH7iF6eYV50SZ0F1iOX6I0hSCjM0NozhXgI9bisZzP/
        6hsKkDQcpKESFmHbHI3MMC0O3dL1u7bIvawBi8h40xqLvrzjJfVuCbNn6QJT+uASkNTx2b
        gcWfz6gx140CLtxu/hR1yPDmp0t8j++NOrTcNScp6fDWvvG/+7ANJend4px/xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616193238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Jp1c3wlrXQ7hrVxZ4KjcM1NHiVwHh3RiWx3Av2mQQzQ=;
        b=SCA5NQ1VCxCz4aWcUe6a+yIdc0yLzSVoRFNhpF786arV5BONxLXmxsLedGA4LInHQxSjNX
        E8wqBqfAlca0jTAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.12-rc3-rt3
Message-ID: <20210319223357.uknv2t5uvxvzb46x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.12-rc3-rt3 patch set. 

Changes since v5.12-rc3-rt2:

  - Update the softirq/tasklet patches to the latest version which has
    been merged into the tip tree. Only the comments have changed.

  - In certain conditions the SLAB_TYPESAFE_BY_RCU marked SLAB pages may
    have been returned to the page-allocator without waiting for
    required grace period. The problem has been introduced during the
    rework in v5.11.2-rt9.

  - Update John's printk patches.
    With this update I can strike 
     - kdb/kgdb can easily deadlock.

    off the known issues list.

Known issues
     - netconsole triggers WARN.

The delta patch against v5.12-rc3-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.12/incr/patch-5.12-rc3-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.12-rc3-rt3

The RT patch against v5.12-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.12/older/patch-5.12-rc3-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.12/older/patches-5.12-rc3-rt3.tar.xz

Sebastian

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 7a13bc20f0a0c..e0ced3afc667f 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -57,6 +57,7 @@ struct smp_ops_t {
 
 extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
+extern void smp_send_debugger_break_cpu(unsigned int cpu);
 extern void smp_send_debugger_break(void);
 extern void start_secondary_resume(void);
 extern void smp_generic_give_timebase(void);
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 409080208a6c4..1f716688c9775 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -20,6 +20,7 @@
 #include <linux/signal.h>
 #include <linux/ptrace.h>
 #include <linux/kdebug.h>
+#include <linux/console.h>
 #include <asm/current.h>
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -120,11 +121,19 @@ int kgdb_skipexception(int exception, struct pt_regs *regs)
 
 static int kgdb_debugger_ipi(struct pt_regs *regs)
 {
-	kgdb_nmicallback(raw_smp_processor_id(), regs);
+	int cpu = raw_smp_processor_id();
+
+	if (!console_atomic_kgdb_cpu_delay(cpu))
+		kgdb_nmicallback(cpu, regs);
 	return 0;
 }
 
 #ifdef CONFIG_SMP
+void kgdb_roundup_cpu(unsigned int cpu)
+{
+	smp_send_debugger_break_cpu(cpu);
+}
+
 void kgdb_roundup_cpus(void)
 {
 	smp_send_debugger_break();
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 1ef55f4b389a2..3c8d9bbb51cfa 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -73,8 +73,7 @@ static const char *nvram_os_partitions[] = {
 };
 
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason,
-			  struct kmsg_dumper_iter *iter);
+			  enum kmsg_dump_reason reason);
 
 static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram
@@ -644,11 +643,11 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
  * partition.  If that's too much, go back and capture uncompressed text.
  */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason,
-			  struct kmsg_dumper_iter *iter)
+			  enum kmsg_dump_reason reason)
 {
 	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
 	static unsigned int oops_count = 0;
+	static struct kmsg_dump_iter iter;
 	static bool panicking = false;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long flags;
@@ -683,13 +682,14 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		return;
 
 	if (big_oops_buf) {
-		kmsg_dump_get_buffer(iter, false,
+		kmsg_dump_rewind(&iter);
+		kmsg_dump_get_buffer(&iter, false,
 				     big_oops_buf, big_oops_buf_sz, &text_len);
 		rc = zip_oops(text_len);
 	}
 	if (rc != 0) {
-		kmsg_dump_rewind(iter);
-		kmsg_dump_get_buffer(iter, false,
+		kmsg_dump_rewind(&iter);
+		kmsg_dump_get_buffer(&iter, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
 		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5a4d59a1070d5..b396c6eafce38 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -582,6 +582,11 @@ static void debugger_ipi_callback(struct pt_regs *regs)
 	debugger_ipi(regs);
 }
 
+void smp_send_debugger_break_cpu(unsigned int cpu)
+{
+	smp_send_nmi_ipi(cpu, debugger_ipi_callback, 1000000);
+}
+
 void smp_send_debugger_break(void)
 {
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, debugger_ipi_callback, 1000000);
diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index ec862846bc82c..6c3bc4b4da983 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -20,8 +20,7 @@
  * message, it just ensures that OPAL completely flushes the console buffer.
  */
 static void kmsg_dump_opal_console_flush(struct kmsg_dumper *dumper,
-					 enum kmsg_dump_reason reason,
-					 struct kmsg_dumper_iter *iter)
+				     enum kmsg_dump_reason reason)
 {
 	/*
 	 * Outside of a panic context the pollers will continue to run,
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index be2413890bdac..bf7d69625a2e5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3001,7 +3001,7 @@ print_address(unsigned long addr)
 static void
 dump_log_buf(void)
 {
-	struct kmsg_dumper_iter iter = { .active = 1 };
+	struct kmsg_dump_iter iter;
 	unsigned char buf[128];
 	size_t len;
 
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index deab9b56b51fd..0224fcb36e22c 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -8,9 +8,9 @@
 #include <os.h>
 
 static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
-				enum kmsg_dump_reason reason,
-				struct kmsg_dumper_iter *iter)
+				enum kmsg_dump_reason reason)
 {
+	static struct kmsg_dump_iter iter;
 	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
@@ -36,8 +36,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (!spin_trylock_irqsave(&lock, flags))
 		return;
 
+	kmsg_dump_rewind(&iter);
+
 	printf("kmsg_dump:\n");
-	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
+	while (kmsg_dump_get_line(&iter, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index ff7878df96b46..ac9d63b0b8645 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -32,6 +32,7 @@
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 #include <linux/nmi.h>
+#include <linux/console.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
@@ -502,9 +503,12 @@ static int kgdb_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		if (atomic_read(&kgdb_active) != -1) {
 			/* KGDB CPU roundup */
 			cpu = raw_smp_processor_id();
-			kgdb_nmicallback(cpu, regs);
-			set_bit(cpu, was_in_debug_nmi);
-			touch_nmi_watchdog();
+
+			if (!console_atomic_kgdb_cpu_delay(cpu)) {
+				kgdb_nmicallback(cpu, regs);
+				set_bit(cpu, was_in_debug_nmi);
+				touch_nmi_watchdog();
+			}
 
 			return NMI_HANDLED;
 		}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e0afa5031cc49..10a36833ad69c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1392,9 +1392,9 @@ static void vmbus_isr(void)
  * buffer and call into Hyper-V to transfer the data.
  */
 static void hv_kmsg_dump(struct kmsg_dumper *dumper,
-			 enum kmsg_dump_reason reason,
-			 struct kmsg_dumper_iter *iter)
+			 enum kmsg_dump_reason reason)
 {
+	struct kmsg_dump_iter iter;
 	size_t bytes_written;
 	phys_addr_t panic_pa;
 
@@ -1408,7 +1408,8 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+	kmsg_dump_rewind(&iter);
+	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 6bc2c728adb73..862c4a8892346 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -52,6 +52,7 @@ static struct mtdoops_context {
 	int nextcount;
 	unsigned long *oops_page_used;
 
+	unsigned long oops_buf_busy;
 	void *oops_buf;
 } oops_cxt;
 
@@ -180,6 +181,9 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	u32 *hdr;
 	int ret;
 
+	if (test_and_set_bit(0, &cxt->oops_buf_busy))
+		return;
+
 	/* Add mtdoops header to the buffer */
 	hdr = cxt->oops_buf;
 	hdr[0] = cxt->nextcount;
@@ -190,7 +194,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 				      record_size, &retlen, cxt->oops_buf);
 		if (ret == -EOPNOTSUPP) {
 			printk(KERN_ERR "mtdoops: Cannot write from panic without panic_write\n");
-			return;
+			goto out;
 		}
 	} else
 		ret = mtd_write(mtd, cxt->nextpage * record_size,
@@ -203,6 +207,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	memset(cxt->oops_buf, 0xff, record_size);
 
 	mtdoops_inc_counter(cxt);
+out:
+	clear_bit(0, &cxt->oops_buf_busy);
 }
 
 static void mtdoops_workfunc_write(struct work_struct *work)
@@ -267,18 +273,23 @@ static void find_next_position(struct mtdoops_context *cxt)
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-			    enum kmsg_dump_reason reason,
-			    struct kmsg_dumper_iter *iter)
+			    enum kmsg_dump_reason reason)
 {
 	struct mtdoops_context *cxt = container_of(dumper,
 			struct mtdoops_context, dump);
+	struct kmsg_dump_iter iter;
 
 	/* Only dump oopses if dump_oops is set */
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
-	kmsg_dump_get_buffer(iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
+	kmsg_dump_rewind(&iter);
+
+	if (test_and_set_bit(0, &cxt->oops_buf_busy))
+		return;
+	kmsg_dump_get_buffer(&iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
 			     record_size - MTDOOPS_HEADER_SIZE, NULL);
+	clear_bit(0, &cxt->oops_buf_busy);
 
 	if (reason != KMSG_DUMP_OOPS) {
 		/* Panics must be written immediately */
@@ -395,6 +406,7 @@ static int __init mtdoops_init(void)
 		return -ENOMEM;
 	}
 	memset(cxt->oops_buf, 0xff, record_size);
+	cxt->oops_buf_busy = 0;
 
 	INIT_WORK(&cxt->work_erase, mtdoops_workfunc_erase);
 	INIT_WORK(&cxt->work_write, mtdoops_workfunc_write);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b90fedcc17166..b9614db48b1de 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -383,9 +383,9 @@ void pstore_record_init(struct pstore_record *record,
  * end of the buffer.
  */
 static void pstore_dump(struct kmsg_dumper *dumper,
-			enum kmsg_dump_reason reason,
-			struct kmsg_dumper_iter *iter)
+			enum kmsg_dump_reason reason)
 {
+	struct kmsg_dump_iter iter;
 	unsigned long	total = 0;
 	const char	*why;
 	unsigned int	part = 1;
@@ -406,6 +406,8 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		}
 	}
 
+	kmsg_dump_rewind(&iter);
+
 	oopscount++;
 	while (total < kmsg_bytes) {
 		char *dst;
@@ -436,7 +438,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		dst_size -= header_size;
 
 		/* Write dump contents. */
-		if (!kmsg_dump_get_buffer(iter, true, dst + header_size,
+		if (!kmsg_dump_get_buffer(&iter, true, dst + header_size,
 					  dst_size, &dump_size))
 			break;
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 69bfff3682946..851daf13de0a5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -17,6 +17,18 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 #include <linux/printk.h>
+#include <linux/seqlock.h>
+
+#ifdef CONFIG_PRINTK_NMI
+#define PRINTK_CTX_NUM 2
+#else
+#define PRINTK_CTX_NUM 1
+#endif
+
+struct latched_seq {
+	seqcount_latch_t	latch;
+	u64			val[2];
+};
 
 struct vc_data;
 struct console_font_op;
@@ -155,7 +167,9 @@ struct console {
 #ifdef CONFIG_PRINTK
 	char	sync_buf[CONSOLE_LOG_MAX];
 #endif
-	atomic64_t printk_seq;
+	struct latched_seq printk_seq;
+	struct latched_seq printk_sync_seq[PRINTK_CTX_NUM];
+
 	struct task_struct *thread;
 	void	*data;
 	struct	 console *next;
@@ -239,5 +253,6 @@ void dummycon_unregister_output_notifier(struct notifier_block *nb);
 
 extern void console_atomic_lock(unsigned int *flags);
 extern void console_atomic_unlock(unsigned int flags);
+extern bool console_atomic_kgdb_cpu_delay(unsigned int cpu);
 
 #endif /* _LINUX_CONSOLE_H */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3b56b73deca24..34259d64de0de 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -662,8 +662,12 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 
 void tasklet_unlock(struct tasklet_struct *t);
 void tasklet_unlock_wait(struct tasklet_struct *t);
-void tasklet_unlock_spin_wait(struct tasklet_struct *t);
 
+/*
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+void tasklet_unlock_spin_wait(struct tasklet_struct *t);
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 392a3670944c6..67197bbdcba84 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -212,6 +212,8 @@ extern void kgdb_call_nmi_hook(void *ignored);
  */
 extern void kgdb_roundup_cpus(void);
 
+extern void kgdb_roundup_cpu(unsigned int cpu);
+
 /**
  *	kgdb_arch_set_pc - Generic call back to the program counter
  *	@regs: Current &struct pt_regs.
@@ -365,5 +367,6 @@ extern void kgdb_free_init_mem(void);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 static inline void kgdb_free_init_mem(void) { }
+static inline void kgdb_roundup_cpu(unsigned int cpu) {}
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 86673930c8ea2..906521c2329ca 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -30,13 +30,11 @@ enum kmsg_dump_reason {
 };
 
 /**
- * struct kmsg_dumper_iter - iterator for kernel crash message dumper
- * @active:	Flag that specifies if this is currently dumping
- * @cur_seq:	Points to the oldest message to dump (private)
- * @next_seq:	Points after the newest message to dump (private)
+ * struct kmsg_dump_iter - iterator for retrieving kernel messages
+ * @cur_seq:	Points to the oldest message to dump
+ * @next_seq:	Points after the newest message to dump
  */
-struct kmsg_dumper_iter {
-	bool	active;
+struct kmsg_dump_iter {
 	u64	cur_seq;
 	u64	next_seq;
 };
@@ -51,8 +49,7 @@ struct kmsg_dumper_iter {
  */
 struct kmsg_dumper {
 	struct list_head list;
-	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason,
-		     struct kmsg_dumper_iter *iter);
+	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
 	enum kmsg_dump_reason max_reason;
 	bool registered;
 };
@@ -60,13 +57,13 @@ struct kmsg_dumper {
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
-bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
+bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind(struct kmsg_dumper_iter *iter);
+void kmsg_dump_rewind(struct kmsg_dump_iter *iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
@@ -78,19 +75,19 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+static inline bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
+static inline bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 					char *buf, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
+static inline void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 {
 }
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 7e4352467d831..0cdd25b49fcc5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -50,7 +50,7 @@ static inline const char *printk_skip_headers(const char *buffer)
  * The maximum size of a record formatted for console printing
  * (i.e. with the prefix prepended to every line).
  */
-#define CONSOLE_LOG_MAX		4096
+#define CONSOLE_LOG_MAX		1024
 
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4708aec492df9..8a073198c4e80 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -241,35 +241,42 @@ NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
 	CSD_INIT(kgdb_call_nmi_hook, NULL);
 
-void __weak kgdb_roundup_cpus(void)
+void __weak kgdb_roundup_cpu(unsigned int cpu)
 {
 	call_single_data_t *csd;
+	int ret;
+
+	csd = &per_cpu(kgdb_roundup_csd, cpu);
+
+	/*
+	 * If it didn't round up last time, don't try again
+	 * since smp_call_function_single_async() will block.
+	 *
+	 * If rounding_up is false then we know that the
+	 * previous call must have at least started and that
+	 * means smp_call_function_single_async() won't block.
+	 */
+	if (kgdb_info[cpu].rounding_up)
+		return;
+	kgdb_info[cpu].rounding_up = true;
+
+	ret = smp_call_function_single_async(cpu, csd);
+	if (ret)
+		kgdb_info[cpu].rounding_up = false;
+}
+NOKPROBE_SYMBOL(kgdb_roundup_cpu);
+
+void __weak kgdb_roundup_cpus(void)
+{
 	int this_cpu = raw_smp_processor_id();
 	int cpu;
-	int ret;
 
 	for_each_online_cpu(cpu) {
 		/* No need to roundup ourselves */
 		if (cpu == this_cpu)
 			continue;
 
-		csd = &per_cpu(kgdb_roundup_csd, cpu);
-
-		/*
-		 * If it didn't round up last time, don't try again
-		 * since smp_call_function_single_async() will block.
-		 *
-		 * If rounding_up is false then we know that the
-		 * previous call must have at least started and that
-		 * means smp_call_function_single_async() won't block.
-		 */
-		if (kgdb_info[cpu].rounding_up)
-			continue;
-		kgdb_info[cpu].rounding_up = true;
-
-		ret = smp_call_function_single_async(cpu, csd);
-		if (ret)
-			kgdb_info[cpu].rounding_up = false;
+		kgdb_roundup_cpu(cpu);
 	}
 }
 NOKPROBE_SYMBOL(kgdb_roundup_cpus);
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b7187..539a2f0dc89d9 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -559,23 +559,17 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
+	/* mirror output on atomic consoles */
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
-		/*
-		 * Set oops_in_progress to encourage the console drivers to
-		 * disregard their internal spin locks: in the current calling
-		 * context the risk of deadlock is a bigger problem than risks
-		 * due to re-entering the console driver. We operate directly on
-		 * oops_in_progress rather than using bust_spinlocks() because
-		 * the calls bust_spinlocks() makes on exit are not appropriate
-		 * for this calling context.
-		 */
-		++oops_in_progress;
-		c->write(c, msg, msg_len);
-		--oops_in_progress;
+
+		if (!c->write_atomic)
+			continue;
+		c->write_atomic(c, msg, msg_len);
+
 		touch_nmi_watchdog();
 	}
 }
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index dbf1d126ac5e1..67d9f2403b52f 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2101,7 +2101,7 @@ static int kdb_dmesg(int argc, const char **argv)
 	int adjust = 0;
 	int n = 0;
 	int skip = 0;
-	struct kmsg_dumper_iter iter = { .active = 1 };
+	struct kmsg_dump_iter iter;
 	size_t len;
 	char buf[201];
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a5fc854977bb1..c2ef8089bfd2f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,8 +44,9 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
-#include <linux/kthread.h>
 #include <linux/kdb.h>
+#include <linux/kgdb.h>
+#include <linux/kthread.h>
 #include <linux/clocksource.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -350,11 +351,6 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-struct latched_seq {
-	seqcount_latch_t	latch;
-	u64			val[2];
-};
-
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
@@ -373,7 +369,7 @@ static struct latched_seq clear_seq = {
 #endif
 
 /* the maximum size allowed to be reserved for a record */
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -415,7 +411,7 @@ static bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
-/* Must be called under syslog_lock. */
+/* Must be called under associated write-protection lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
@@ -1720,7 +1716,7 @@ static bool kernel_sync_mode(void)
 	return (oops_in_progress || sync_mode);
 }
 
-static bool console_can_sync(struct console *con)
+static bool console_may_sync(struct console *con)
 {
 	if (!(con->flags & CON_ENABLED))
 		return false;
@@ -1737,16 +1733,28 @@ static bool call_sync_console_driver(struct console *con, const char *text, size
 {
 	if (!(con->flags & CON_ENABLED))
 		return false;
-	if (con->write_atomic && kernel_sync_mode())
-		con->write_atomic(con, text, text_len);
-	else if (con->write_atomic && (con->flags & CON_HANDOVER) && !con->thread)
-		con->write_atomic(con, text, text_len);
-	else if (con->write && (con->flags & CON_BOOT) && !con->thread)
-		con->write(con, text, text_len);
-	else
-		return false;
 
-	return true;
+	if (con->write_atomic && kernel_sync_mode()) {
+		con->write_atomic(con, text, text_len);
+		return true;
+	}
+
+	if (con->write_atomic && (con->flags & CON_HANDOVER) && !con->thread) {
+		if (console_trylock()) {
+			con->write_atomic(con, text, text_len);
+			console_unlock();
+			return true;
+		}
+
+	} else if (con->write && (con->flags & CON_BOOT) && !con->thread) {
+		if (console_trylock()) {
+			con->write(con, text, text_len);
+			console_unlock();
+			return true;
+		}
+	}
+
+	return false;
 }
 
 static bool have_atomic_console(void)
@@ -1791,65 +1799,93 @@ static bool print_sync(struct console *con, u64 *seq)
 	return true;
 }
 
-static void print_sync_until(struct console *con, u64 seq)
+static u64 read_console_seq(struct console *con)
+{
+	u64 seq2;
+	u64 seq;
+
+	seq = latched_seq_read_nolock(&con->printk_seq);
+	seq2 = latched_seq_read_nolock(&con->printk_sync_seq[0]);
+	if (seq2 > seq)
+		seq = seq2;
+#if PRINTK_CTX_NUM > 1
+	seq2 = latched_seq_read_nolock(&con->printk_sync_seq[1]);
+	if (seq2 > seq)
+		seq = seq2;
+#endif
+	return seq;
+}
+
+static void print_sync_until(struct console *con, u64 seq, bool is_locked)
 {
 	unsigned int flags;
 	u64 printk_seq;
 
 	console_atomic_lock(&flags);
 	for (;;) {
-		printk_seq = atomic64_read(&con->printk_seq);
+		printk_seq = read_console_seq(con);
 		if (printk_seq >= seq)
 			break;
 		if (!print_sync(con, &printk_seq))
 			break;
-		atomic64_set(&con->printk_seq, printk_seq + 1);
+
+		if (is_locked) {
+			latched_seq_write(&con->printk_seq, printk_seq + 1);
+		} else {
+			int ctx = 0;
+
+#ifdef CONFIG_PRINTK_NMI
+			if (in_nmi())
+				ctx = 1;
+#endif
+			latched_seq_write(&con->printk_sync_seq[ctx], printk_seq + 1);
+		}
 	}
 	console_atomic_unlock(flags);
 }
 
-#ifdef CONFIG_PRINTK_NMI
-#define NUM_RECURSION_CTX 2
-#else
-#define NUM_RECURSION_CTX 1
-#endif
+/*
+ * Recursion is tracked separately on each CPU. If NMIs are supported, an
+ * additional NMI context per CPU is also separately tracked. Until per-CPU
+ * is available, a separate "early tracking" is performed.
+ */
+static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
+static char printk_count_early[PRINTK_CTX_NUM];
 
-struct printk_recursion {
-	char	count[NUM_RECURSION_CTX];
-};
-
-static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
-static char printk_recursion_count[NUM_RECURSION_CTX];
+/*
+ * Recursion is limited to keep the output sane. printk() should not require
+ * more than 1 level of recursion (allowing, for example, printk() to trigger
+ * a WARN), but a higher value is used in case some printk-internal errors
+ * exist, such as the ringbuffer validation checks failing.
+ */
+#define PRINTK_MAX_RECURSION 3
 
+/* Return a pointer to the dedicated counter for the CPU+context of the caller. */
 static char *printk_recursion_counter(void)
 {
-	struct printk_recursion *rec;
-	char *count;
-
-	if (!printk_percpu_data_ready()) {
-		count = &printk_recursion_count[0];
-	} else {
-		rec = this_cpu_ptr(&percpu_printk_recursion);
-
-		count = &rec->count[0];
-	}
+	int ctx = 0;
 
 #ifdef CONFIG_PRINTK_NMI
 	if (in_nmi())
-		count++;
+		ctx = 1;
 #endif
-
-	return count;
+	if (!printk_percpu_data_ready())
+		return &printk_count_early[ctx];
+	return &((*this_cpu_ptr(&printk_count))[ctx]);
 }
 
+/*
+ * Enter recursion tracking. Interrupts are disabled to simplify tracking.
+ * The caller must check the return value to see if the recursion is allowed.
+ * On failure, interrupts are not disabled.
+ */
 static bool printk_enter_irqsave(unsigned long *flags)
 {
 	char *count;
 
 	local_irq_save(*flags);
 	count = printk_recursion_counter();
-	/* Only 1 level of recursion allowed. */
-	if (*count > 1) {
+	if (*count > PRINTK_MAX_RECURSION) {
 		local_irq_restore(*flags);
 		return false;
 	}
@@ -1858,6 +1894,7 @@ static bool printk_enter_irqsave(unsigned long *flags)
 	return true;
 }
 
+/* Exit recursion tracking, restoring interrupts. */
 static void printk_exit_irqrestore(unsigned long flags)
 {
 	char *count;
@@ -2064,8 +2101,8 @@ static int vprintk_store(int facility, int level,
 		struct console *con;
 
 		for_each_console(con) {
-			if (console_can_sync(con))
-				print_sync_until(con, seq + 1);
+			if (console_may_sync(con))
+				print_sync_until(con, seq + 1, false);
 		}
 	}
 
@@ -2162,7 +2199,6 @@ static int printk_kthread_func(void *data)
 	int ret = -ENOMEM;
 	char *text = NULL;
 	char *write_text;
-	u64 printk_seq;
 	size_t len;
 	int error;
 	u64 seq;
@@ -2182,7 +2218,7 @@ static int printk_kthread_func(void *data)
 	else
 		write_text = text;
 
-	seq = atomic64_read(&con->printk_seq);
+	seq = read_console_seq(con);
 
 	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
 
@@ -2223,9 +2259,16 @@ static int printk_kthread_func(void *data)
 				printk_time);
 		}
 
-		printk_seq = atomic64_read(&con->printk_seq);
-
 		console_lock();
+
+		/*
+		 * Even though the printk kthread is always preemptible, it is
+		 * still not allowed to call cond_resched() from within
+		 * console drivers. The task may become non-preemptible in the
+		 * console driver call chain. For example, vt_console_print()
+		 * takes a spinlock and then can call into fbcon_redraw(),
+		 * which can conditionally invoke cond_resched().
+		 */
 		console_may_schedule = 0;
 
 		if (kernel_sync_mode() && con->write_atomic) {
@@ -2247,7 +2290,7 @@ static int printk_kthread_func(void *data)
 		if (len)
 			printk_delay(r.info->level);
 
-		atomic64_cmpxchg_relaxed(&con->printk_seq, printk_seq, seq);
+		latched_seq_write(&con->printk_seq, seq);
 
 		console_unlock();
 	}
@@ -2292,8 +2335,8 @@ static void console_try_thread(struct console *con)
 	 * The printing threads have not been started yet. If this console
 	 * can print synchronously, print all unprinted messages.
 	 */
-	if (console_can_sync(con))
-		print_sync_until(con, prb_next_seq(prb));
+	if (console_may_sync(con))
+		print_sync_until(con, prb_next_seq(prb), true);
 }
 
 #else /* CONFIG_PRINTK */
@@ -2625,12 +2668,10 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (!console_trylock())
 		return;
 
-	console_may_schedule = 0;
-
 	if (mode == CONSOLE_REPLAY_ALL) {
 		seq = prb_first_valid_seq(prb);
 		for_each_console(c)
-			atomic64_set(&c->printk_seq, seq);
+			latched_seq_write(&c->printk_seq, seq);
 	}
 
 	console_unlock();
@@ -2768,6 +2809,7 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 void register_console(struct console *newcon)
 {
 	struct console *bcon = NULL;
+	u64 seq = 0;
 	int err;
 
 	for_each_console(bcon) {
@@ -2858,10 +2900,17 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
-	if (newcon->flags & CON_PRINTBUFFER)
-		atomic64_set(&newcon->printk_seq, 0);
-	else
-		atomic64_set(&newcon->printk_seq, prb_next_seq(prb));
+	if (!(newcon->flags & CON_PRINTBUFFER))
+		seq = prb_next_seq(prb);
+
+	seqcount_latch_init(&newcon->printk_seq.latch);
+	latched_seq_write(&newcon->printk_seq, seq);
+	seqcount_latch_init(&newcon->printk_sync_seq[0].latch);
+	latched_seq_write(&newcon->printk_sync_seq[0], seq);
+#if PRINTK_CTX_NUM > 1
+	seqcount_latch_init(&newcon->printk_sync_seq[1].latch);
+	latched_seq_write(&newcon->printk_sync_seq[1], seq);
+#endif
 
 	console_try_thread(newcon);
 	console_unlock();
@@ -3215,7 +3264,6 @@ EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
  */
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
-	struct kmsg_dumper_iter iter;
 	struct kmsg_dumper *dumper;
 
 	if (!oops_in_progress) {
@@ -3251,19 +3299,15 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		if (reason > max_reason)
 			continue;
 
-		/* initialize iterator with data about the stored records */
-		iter.active = true;
-		kmsg_dump_rewind(&iter);
-
 		/* invoke dumper which will iterate over records */
-		dumper->dump(dumper, reason, &iter);
+		dumper->dump(dumper, reason);
 	}
 	rcu_read_unlock();
 }
 
 /**
  * kmsg_dump_get_line - retrieve one kmsg log line
- * @iter: kmsg dumper iterator
+ * @iter: kmsg dump iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3278,19 +3322,20 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  * A return value of FALSE indicates that there are no more records to
  * read.
  */
-bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len)
 {
+	u64 min_seq = latched_seq_read_nolock(&clear_seq);
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
 	size_t l = 0;
 	bool ret = false;
 
-	prb_rec_init_rd(&r, &info, line, size);
+	if (iter->cur_seq < min_seq)
+		iter->cur_seq = min_seq;
 
-	if (!iter->active)
-		goto out;
+	prb_rec_init_rd(&r, &info, line, size);
 
 	/* Read text or count text lines? */
 	if (line) {
@@ -3318,11 +3363,11 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
 /**
  * kmsg_dump_get_buffer - copy kmsg log lines
- * @iter: kmsg dumper iterator
+ * @iter: kmsg dump iterator
  * @syslog: include the "<4>" prefixes
  * @buf: buffer to copy the line to
  * @size: maximum size of the buffer
- * @len: length of line placed into buffer
+ * @len_out: length of line placed into buffer
  *
  * Start at the end of the kmsg buffer and fill the provided buffer
  * with as many of the *youngest* kmsg records that fit into it.
@@ -3335,9 +3380,10 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * A return value of FALSE indicates that there are no more records to
  * read.
  */
-bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
+bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
+	u64 min_seq = latched_seq_read_nolock(&clear_seq);
 	struct printk_info info;
 	struct printk_record r;
 	u64 seq;
@@ -3346,9 +3392,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	if (!iter->active || !buf || !size)
+	if (!buf || !size)
 		goto out;
 
+	if (iter->cur_seq < min_seq)
+		iter->cur_seq = min_seq;
+
 	if (prb_read_valid_info(prb, iter->cur_seq, &info, NULL)) {
 		if (info.seq != iter->cur_seq) {
 			/* messages are gone, move to first available one */
@@ -3399,13 +3448,13 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
 /**
  * kmsg_dump_rewind - reset the iterator
- * @iter: kmsg dumper iterator
+ * @iter: kmsg dump iterator
  *
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
  */
-void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
+void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 {
 	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
 	iter->next_seq = prb_next_seq(prb);
@@ -3426,6 +3475,8 @@ static struct prb_cpulock name = {					\
 	.irqflags = &_##name##_percpu_irqflags,				\
 }
 
+static unsigned int kgdb_cpu = -1;
+
 static bool __prb_trylock(struct prb_cpulock *cpu_lock,
 			  unsigned int *cpu_store)
 {
@@ -3486,10 +3537,15 @@ static void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
  */
 static void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
 {
+	bool trigger_kgdb = false;
 	unsigned long *flags;
 	unsigned int cpu;
 
 	cpu = atomic_read(&cpu_lock->owner);
+	if (cpu == kgdb_cpu && cpu_store == -1) {
+		trigger_kgdb = true;
+		kgdb_cpu = -1;
+	}
 	atomic_set_release(&cpu_lock->owner, cpu_store);
 
 	if (cpu_store == -1) {
@@ -3498,6 +3554,11 @@ static void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
 	}
 
 	put_cpu();
+
+	if (trigger_kgdb) {
+		pr_warn("re-triggering kgdb roundup for CPU#%d\n", cpu);
+		kgdb_roundup_cpu(cpu);
+	}
 }
 
 DECLARE_STATIC_PRINTKRB_CPULOCK(printk_cpulock);
@@ -3514,6 +3575,16 @@ void console_atomic_unlock(unsigned int flags)
 }
 EXPORT_SYMBOL(console_atomic_unlock);
 
+bool console_atomic_kgdb_cpu_delay(unsigned int cpu)
+{
+	if (cpu != atomic_read(&printk_cpulock.owner))
+		return false;
+
+	kgdb_cpu = cpu;
+	return true;
+}
+EXPORT_SYMBOL(console_atomic_kgdb_cpu_delay);
+
 static void pr_msleep(bool may_sleep, int ms)
 {
 	if (may_sleep) {
@@ -3559,7 +3630,7 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		for_each_console(con) {
 			if (!(con->flags & CON_ENABLED))
 				continue;
-			printk_seq = atomic64_read(&con->printk_seq);
+			printk_seq = read_console_seq(con);
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
@@ -3567,7 +3638,7 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		if (diff != last_diff && reset_on_progress)
 			remaining = timeout_ms;
 
-		if (!diff || remaining == 0)
+		if (diff == 0 || remaining == 0)
 			break;
 
 		if (remaining < 0) {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4e90775770436..e3d9ea8a05f0a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -832,8 +832,8 @@ EXPORT_SYMBOL(tasklet_init);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
- * Do not use in new code. Waiting for tasklets from atomic contexts is
- * error prone and should be avoided.
+ * Do not use in new code. There is no real reason to invoke this from
+ * atomic contexts.
  */
 void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 {
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/slub.c b/mm/slub.c
index 26cf2872a7ff2..87b1e5cf9348e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1893,7 +1893,10 @@ static void discard_slab_delayed(struct kmem_cache *s, struct page *page,
 				 struct list_head *delayed_free)
 {
 	dec_slabs_node(s, page_to_nid(page), page->objects);
-	list_add(&page->lru, delayed_free);
+	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
+		call_rcu(&page->rcu_head, rcu_free_slab);
+	else
+		list_add(&page->lru, delayed_free);
 }
 
 static void discard_slab(struct kmem_cache *s, struct page *page)
