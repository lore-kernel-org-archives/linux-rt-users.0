Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A450C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F18164E54
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSSja (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:39:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSSj2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 13:39:28 -0500
Date:   Fri, 19 Feb 2021 19:38:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613759923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yb2wb0IRqJhBYDS2lG/yl/eNphx6yS/FLLqjc3s/9QE=;
        b=14BWR8UgO93I4sinrhGrzOJ4jkydKN5J4+VeEAyHI7HxxCx2nQ8NxqyYpmSQQ8a4BwLpJK
        oQn44a0fZBEOFABiC9XkYluDh9OaBqbG3Du3WvSitdgM1J0ZdXHr4iBcTSRs/09/ki02KP
        NmqAsze3bbc9EndjYDAqHEChsWqsDAOz3rJ8XDa1z9bSkOoEnXQ8EEpcRnKrwq1Tk9bKNU
        ro234fO9YYGvpbVp4xWhnUf+Twu/1nJzhmvQB+NnxWQPRjaaEF6V6+hIMH2s54mp+U0EsX
        ywNU7+OfxMdc2gk1SyBtDseOJolC+T1gwxuCSCh33IHjv2WdosoZHB1eGbAMiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613759923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yb2wb0IRqJhBYDS2lG/yl/eNphx6yS/FLLqjc3s/9QE=;
        b=eclwYUvQgbkJVen9s6tYZ/ERcNPbDnRF9bKFcoU9lUovL1GivL++waU9dKmaSZBVgGaMkz
        Iywg/FnFFUvzyNCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.17-rt32
Message-ID: <20210219183841.2h4yszbb4xm5jspu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.17-rt32 patch set. 

Changes since v5.10.17-rt31:

  - Due to tracing rework, the 'L' marker (for need resched lazy) got
    lost and is now back.

  - Update John printk patch.
    With the update I can strike
      kmsg dumpers expecting not to be called in parallel can clobber
      their temp buffer.

    off the known issues list.

Known issues
     - kdb/kgdb can easily deadlock.
     - netconsole triggers WARN.

The delta patch against v5.10.17-rt31 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.17-rt31-rt32.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.17-rt32

The RT patch against v5.10.17 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.17-rt32.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.17-rt32.tar.xz

Sebastian

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 532f226377831..1ef55f4b389a2 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -73,7 +73,8 @@ static const char *nvram_os_partitions[] = {
 };
 
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason);
+			  enum kmsg_dump_reason reason,
+			  struct kmsg_dumper_iter *iter);
 
 static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram
@@ -643,7 +644,8 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
  * partition.  If that's too much, go back and capture uncompressed text.
  */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason)
+			  enum kmsg_dump_reason reason,
+			  struct kmsg_dumper_iter *iter)
 {
 	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
 	static unsigned int oops_count = 0;
@@ -681,13 +683,13 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		return;
 
 	if (big_oops_buf) {
-		kmsg_dump_get_buffer(dumper, false,
+		kmsg_dump_get_buffer(iter, false,
 				     big_oops_buf, big_oops_buf_sz, &text_len);
 		rc = zip_oops(text_len);
 	}
 	if (rc != 0) {
-		kmsg_dump_rewind(dumper);
-		kmsg_dump_get_buffer(dumper, false,
+		kmsg_dump_rewind(iter);
+		kmsg_dump_get_buffer(iter, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
 		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index 6c3bc4b4da983..ec862846bc82c 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -20,7 +20,8 @@
  * message, it just ensures that OPAL completely flushes the console buffer.
  */
 static void kmsg_dump_opal_console_flush(struct kmsg_dumper *dumper,
-				     enum kmsg_dump_reason reason)
+					 enum kmsg_dump_reason reason,
+					 struct kmsg_dumper_iter *iter)
 {
 	/*
 	 * Outside of a panic context the pollers will continue to run,
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 5559edf36756c..d62b8e053d4c8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3005,7 +3005,7 @@ print_address(unsigned long addr)
 static void
 dump_log_buf(void)
 {
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper_iter iter = { .active = 1 };
 	unsigned char buf[128];
 	size_t len;
 
@@ -3017,9 +3017,9 @@ dump_log_buf(void)
 	catch_memory_errors = 1;
 	sync();
 
-	kmsg_dump_rewind_nolock(&dumper);
+	kmsg_dump_rewind(&iter);
 	xmon_start_pagination();
-	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
+	while (kmsg_dump_get_line(&iter, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index e4abac6c9727c..173999422ed84 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,15 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
+#include <linux/spinlock.h>
 #include <linux/console.h>
 #include <shared/init.h>
 #include <shared/kern.h>
 #include <os.h>
 
 static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
-				enum kmsg_dump_reason reason)
+				enum kmsg_dump_reason reason,
+				struct kmsg_dumper_iter *iter)
 {
+	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
+	unsigned long flags;
 	size_t len = 0;
 
 	/* only dump kmsg when no console is available */
@@ -24,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (con)
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	printf("kmsg_dump:\n");
-	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
+	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static struct kmsg_dumper kmsg_dumper = {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a4769419828dd..d0763ea99ded4 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1362,7 +1362,8 @@ static void vmbus_isr(void)
  * buffer and call into Hyper-V to transfer the data.
  */
 static void hv_kmsg_dump(struct kmsg_dumper *dumper,
-			 enum kmsg_dump_reason reason)
+			 enum kmsg_dump_reason reason,
+			 struct kmsg_dumper_iter *iter)
 {
 	size_t bytes_written;
 	phys_addr_t panic_pa;
@@ -1377,7 +1378,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 774970bfcf859..6bc2c728adb73 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -267,7 +267,8 @@ static void find_next_position(struct mtdoops_context *cxt)
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-			    enum kmsg_dump_reason reason)
+			    enum kmsg_dump_reason reason,
+			    struct kmsg_dumper_iter *iter)
 {
 	struct mtdoops_context *cxt = container_of(dumper,
 			struct mtdoops_context, dump);
@@ -276,7 +277,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
-	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
+	kmsg_dump_get_buffer(iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
 			     record_size - MTDOOPS_HEADER_SIZE, NULL);
 
 	if (reason != KMSG_DUMP_OOPS) {
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df37d5d8..a939559b0c9a7 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -383,7 +383,8 @@ void pstore_record_init(struct pstore_record *record,
  * end of the buffer.
  */
 static void pstore_dump(struct kmsg_dumper *dumper,
-			enum kmsg_dump_reason reason)
+			enum kmsg_dump_reason reason,
+			struct kmsg_dumper_iter *iter)
 {
 	unsigned long	total = 0;
 	const char	*why;
@@ -435,7 +436,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		dst_size -= header_size;
 
 		/* Write dump contents. */
-		if (!kmsg_dump_get_buffer(dumper, true, dst + header_size,
+		if (!kmsg_dump_get_buffer(iter, true, dst + header_size,
 					  dst_size, &dump_size))
 			break;
 
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585ea..86673930c8ea2 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -29,6 +29,18 @@ enum kmsg_dump_reason {
 	KMSG_DUMP_MAX
 };
 
+/**
+ * struct kmsg_dumper_iter - iterator for kernel crash message dumper
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	Points to the oldest message to dump (private)
+ * @next_seq:	Points after the newest message to dump (private)
+ */
+struct kmsg_dumper_iter {
+	bool	active;
+	u64	cur_seq;
+	u64	next_seq;
+};
+
 /**
  * struct kmsg_dumper - kernel crash message dumper structure
  * @list:	Entry in the dumper list (private)
@@ -39,33 +51,22 @@ enum kmsg_dump_reason {
  */
 struct kmsg_dumper {
 	struct list_head list;
-	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
+	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason,
+		     struct kmsg_dumper_iter *iter);
 	enum kmsg_dump_reason max_reason;
-	bool active;
 	bool registered;
-
-	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
-	u64 cur_seq;
-	u64 next_seq;
 };
 
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
-			       char *line, size_t size, size_t *len);
-
-bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
-bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
-			  char *buf, size_t size, size_t *len);
+bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
+			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper);
-
-void kmsg_dump_rewind(struct kmsg_dumper *dumper);
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
@@ -77,30 +78,19 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper,
-					     bool syslog, const char *line,
-					     size_t size, size_t *len)
-{
-	return false;
-}
-
-static inline bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
+static inline bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
+static inline bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 					char *buf, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
-{
-}
-
-static inline void kmsg_dump_rewind(struct kmsg_dumper *dumper)
+static inline void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 }
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2408f6c956deb..7e4352467d831 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -45,7 +45,12 @@ static inline const char *printk_skip_headers(const char *buffer)
 }
 
 #define CONSOLE_EXT_LOG_MAX	8192
-#define CONSOLE_LOG_MAX		1024
+
+/*
+ * The maximum size of a record formatted for console printing
+ * (i.e. with the prefix prepended to every line).
+ */
+#define CONSOLE_LOG_MAX		4096
 
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 930ac1b25ec7c..dbf1d126ac5e1 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2101,7 +2101,7 @@ static int kdb_dmesg(int argc, const char **argv)
 	int adjust = 0;
 	int n = 0;
 	int skip = 0;
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper_iter iter = { .active = 1 };
 	size_t len;
 	char buf[201];
 
@@ -2126,8 +2126,8 @@ static int kdb_dmesg(int argc, const char **argv)
 		kdb_set(2, setargs);
 	}
 
-	kmsg_dump_rewind_nolock(&dumper);
-	while (kmsg_dump_get_line_nolock(&dumper, 1, NULL, 0, NULL))
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, NULL, 0, NULL))
 		n++;
 
 	if (lines < 0) {
@@ -2159,8 +2159,8 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (skip >= n || skip < 0)
 		return 0;
 
-	kmsg_dump_rewind_nolock(&dumper);
-	while (kmsg_dump_get_line_nolock(&dumper, 1, buf, sizeof(buf), &len)) {
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, sizeof(buf), &len)) {
 		if (skip) {
 			skip--;
 			continue;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 15ea9139538f5..f56fd2e34cc73 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -371,7 +371,9 @@ static struct latched_seq clear_seq = {
 #else
 #define PREFIX_MAX		32
 #endif
-#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
+
+/* the maximum size allowed to be reserved for a record */
+#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -414,7 +416,7 @@ static bool printk_percpu_data_ready(void)
 }
 
 /* Must be called under syslog_lock. */
-void latched_seq_write(struct latched_seq *ls, u64 val)
+static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
 	ls->val[0] = val;
@@ -423,7 +425,7 @@ void latched_seq_write(struct latched_seq *ls, u64 val)
 }
 
 /* Can be called from any context. */
-u64 latched_seq_read_nolock(struct latched_seq *ls)
+static u64 latched_seq_read_nolock(struct latched_seq *ls)
 {
 	unsigned int seq;
 	unsigned int idx;
@@ -718,9 +720,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			goto out;
 	}
 
-	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
+	if (r->info->seq != atomic64_read(&user->seq)) {
 		/* our last seen message is gone, return error and reset */
-		atomic64_set(&user->seq, prb_first_valid_seq(prb));
+		atomic64_set(&user->seq, r->info->seq);
 		ret = -EPIPE;
 		goto out;
 	}
@@ -791,6 +793,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 {
 	struct devkmsg_user *user = file->private_data;
+	struct printk_info info;
 	__poll_t ret = 0;
 
 	if (!user)
@@ -798,9 +801,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &log_wait, wait);
 
-	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {
+	if (prb_read_valid_info(prb, atomic64_read(&user->seq), &info, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (atomic64_read(&user->seq) < prb_first_valid_seq(prb))
+		if (info.seq != atomic64_read(&user->seq))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -1390,6 +1393,50 @@ static size_t get_record_print_text_size(struct printk_info *info,
 	return ((prefix_len * line_count) + info->text_len + 1);
 }
 
+/*
+ * Beginning with @start_seq, find the first record where it and all following
+ * records up to (but not including) @max_seq fit into @size.
+ *
+ * @max_seq is simply an upper bound and does not need to exist. If the caller
+ * does not require an upper bound, -1 can be used for @max_seq.
+ */
+static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
+				  bool syslog, bool time)
+{
+	struct printk_info info;
+	unsigned int line_count;
+	size_t len = 0;
+	u64 seq;
+
+	/* Determine the size of the records up to @max_seq. */
+	prb_for_each_info(start_seq, prb, seq, &info, &line_count) {
+		if (info.seq >= max_seq)
+			break;
+		len += get_record_print_text_size(&info, line_count, syslog, time);
+	}
+
+	/*
+	 * Adjust the upper bound for the next loop to avoid subtracting
+	 * lengths that were never added.
+	 */
+	if (seq < max_seq)
+		max_seq = seq;
+
+	/*
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is a best effort
+	 * that prevents an infinite loop that could occur with a retry.
+	 */
+	prb_for_each_info(start_seq, prb, seq, &info, &line_count) {
+		if (len <= size || info.seq >= max_seq)
+			break;
+		len -= get_record_print_text_size(&info, line_count, syslog, time);
+	}
+
+	return seq;
+}
+
 static int syslog_print(char __user *buf, int size)
 {
 	struct printk_info info;
@@ -1461,10 +1508,7 @@ static int syslog_print(char __user *buf, int size)
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
-	u64 newest_seq;
-	u64 clr_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1475,28 +1519,12 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return -ENOMEM;
 
 	time = printk_time;
-	clr_seq = latched_seq_read_nolock(&clear_seq);
-
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-
-	prb_for_each_info(clr_seq, prb, seq, &info, &line_count)
-		len += get_record_print_text_size(&info, line_count, true, time);
-
-	/*
-	 * Move first record forward until length fits into the buffer. Ignore
-	 * newest messages that were not counted in the above cycle. Messages
-	 * might appear and get lost in the meantime. This is the best effort
-	 * that prevents an infinite loop.
-	 */
-	newest_seq = seq;
-	prb_for_each_info(clr_seq, prb, seq, &info, &line_count) {
-		if (len <= size || info.seq > newest_seq)
-			break;
-		len -= get_record_print_text_size(&info, line_count, true, time);
-	}
+	seq = find_first_fitting_seq(latched_seq_read_nolock(&clear_seq), -1,
+				     size, true, time);
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
@@ -1537,12 +1565,24 @@ static void syslog_clear(void)
 	spin_unlock_irq(&syslog_lock);
 }
 
+/* Return a consistent copy of @syslog_seq. */
+static u64 read_syslog_seq_irq(void)
+{
+	u64 seq;
+
+	spin_lock_irq(&syslog_lock);
+	seq = syslog_seq;
+	spin_unlock_irq(&syslog_lock);
+
+	return seq;
+}
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
+	struct printk_info info;
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
-	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1561,13 +1601,8 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		if (!access_ok(buf, len))
 			return -EFAULT;
 
-		/* Get a consistent copy of @syslog_seq. */
-		spin_lock_irq(&syslog_lock);
-		seq = syslog_seq;
-		spin_unlock_irq(&syslog_lock);
-
 		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, seq, NULL));
+				prb_read_valid(prb, read_syslog_seq_irq(), NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1616,9 +1651,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		spin_lock_irq(&syslog_lock);
-		if (syslog_seq < prb_first_valid_seq(prb)) {
+		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
+			/* No unread messages. */
+			spin_unlock_irq(&syslog_lock);
+			return 0;
+		}
+		if (info.seq != syslog_seq) {
 			/* messages are gone, move to first one */
-			syslog_seq = prb_first_valid_seq(prb);
+			syslog_seq = info.seq;
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -1630,7 +1670,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			error = prb_next_seq(prb) - syslog_seq;
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
-			struct printk_info info;
 			unsigned int line_count;
 			u64 seq;
 
@@ -1711,17 +1750,6 @@ static bool call_sync_console_driver(struct console *con, const char *text, size
 	return true;
 }
 
-static bool any_console_can_sync(void)
-{
-	struct console *con;
-
-	for_each_console(con) {
-		if (console_can_sync(con))
-			return true;
-	}
-	return false;
-}
-
 static bool have_atomic_console(void)
 {
 	struct console *con;
@@ -1769,14 +1797,6 @@ static void print_sync_until(struct console *con, u64 seq)
 	unsigned int flags;
 	u64 printk_seq;
 
-	if (!con) {
-		for_each_console(con) {
-			if (console_can_sync(con))
-				print_sync_until(con, seq);
-		}
-		return;
-	}
-
 	console_atomic_lock(&flags);
 	for (;;) {
 		printk_seq = atomic64_read(&con->printk_seq);
@@ -2041,8 +2061,14 @@ static int vprintk_store(int facility, int level,
 	ret = text_len + trunc_msg_len;
 out:
 	/* only the kernel may perform synchronous printing */
-	if (facility == 0 && final_commit && any_console_can_sync())
-		print_sync_until(NULL, seq + 1);
+	if (facility == 0 && final_commit) {
+		struct console *con;
+
+		for_each_console(con) {
+			if (console_can_sync(con))
+				print_sync_until(con, seq + 1);
+		}
+	}
 
 	printk_exit_irqrestore(irqflags);
 	return ret;
@@ -2267,21 +2293,15 @@ static void console_try_thread(struct console *con)
 	 * The printing threads have not been started yet. If this console
 	 * can print synchronously, print all unprinted messages.
 	 */
-
 	if (console_can_sync(con))
 		print_sync_until(con, prb_next_seq(prb));
 }
 
 #else /* CONFIG_PRINTK */
 
-#define printk_time		false
-
-#define prb_read_valid(rb, seq, r)	false
 #define prb_first_valid_seq(rb)		0
 #define prb_next_seq(rb)		0
 
-#define kernel_sync_mode()	false
-
 #define console_try_thread(con)
 
 #endif /* CONFIG_PRINTK */
@@ -3191,6 +3211,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
  */
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
+	struct kmsg_dumper_iter iter;
 	struct kmsg_dumper *dumper;
 
 	if (!oops_in_progress) {
@@ -3214,7 +3235,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
 		enum kmsg_dump_reason max_reason = dumper->max_reason;
-		struct kmsg_dumper dumper_copy;
 
 		/*
 		 * If client has not provided a specific max_reason, default
@@ -3227,25 +3247,19 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		if (reason > max_reason)
 			continue;
 
-		/*
-		 * Invoke a copy of the dumper to iterate over the records.
-		 * This allows kmsg_dump() to be called simultaneously on
-		 * multiple CPUs.
-		 */
+		/* initialize iterator with data about the stored records */
+		iter.active = true;
+		kmsg_dump_rewind(&iter);
 
-		memcpy(&dumper_copy, dumper, sizeof(dumper_copy));
-		INIT_LIST_HEAD(&dumper_copy.list);
-		dumper_copy.active = true;
-
-		kmsg_dump_rewind_nolock(&dumper_copy);
-		dumper_copy.dump(&dumper_copy, reason);
+		/* invoke dumper which will iterate over records */
+		dumper->dump(dumper, reason, &iter);
 	}
 	rcu_read_unlock();
 }
 
 /**
- * kmsg_dump_get_line_nolock - retrieve one kmsg log line (unlocked version)
- * @dumper: registered kmsg dumper
+ * kmsg_dump_get_line - retrieve one kmsg log line
+ * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3259,11 +3273,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  *
  * A return value of FALSE indicates that there are no more records to
  * read.
- *
- * The function is similar to kmsg_dump_get_line(), but grabs no locks.
  */
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
-			       char *line, size_t size, size_t *len)
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+			char *line, size_t size, size_t *len)
 {
 	struct printk_info info;
 	unsigned int line_count;
@@ -3273,16 +3285,16 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 	prb_rec_init_rd(&r, &info, line, size);
 
-	if (!dumper->active)
+	if (!iter->active)
 		goto out;
 
 	/* Read text or count text lines? */
 	if (line) {
-		if (!prb_read_valid(prb, dumper->cur_seq, &r))
+		if (!prb_read_valid(prb, iter->cur_seq, &r))
 			goto out;
 		l = record_print_text(&r, syslog, printk_time);
 	} else {
-		if (!prb_read_valid_info(prb, dumper->cur_seq,
+		if (!prb_read_valid_info(prb, iter->cur_seq,
 					 &info, &line_count)) {
 			goto out;
 		}
@@ -3291,41 +3303,18 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 	}
 
-	dumper->cur_seq = r.info->seq + 1;
+	iter->cur_seq = r.info->seq + 1;
 	ret = true;
 out:
 	if (len)
 		*len = l;
 	return ret;
 }
-
-/**
- * kmsg_dump_get_line - retrieve one kmsg log line
- * @dumper: registered kmsg dumper
- * @syslog: include the "<4>" prefixes
- * @line: buffer to copy the line to
- * @size: maximum size of the buffer
- * @len: length of line placed into buffer
- *
- * Start at the beginning of the kmsg buffer, with the oldest kmsg
- * record, and copy one record into the provided buffer.
- *
- * Consecutive calls will return the next available record moving
- * towards the end of the buffer with the youngest messages.
- *
- * A return value of FALSE indicates that there are no more records to
- * read.
- */
-bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
-			char *line, size_t size, size_t *len)
-{
-	return kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
-}
 EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
 /**
  * kmsg_dump_get_buffer - copy kmsg log lines
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @buf: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3342,11 +3331,10 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * A return value of FALSE indicates that there are no more records to
  * read.
  */
-bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
 	u64 seq;
 	u64 next_seq;
@@ -3354,49 +3342,40 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	if (!dumper->active || !buf || !size)
+	if (!iter->active || !buf || !size)
 		goto out;
 
-	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
-		/* messages are gone, move to first available one */
-		dumper->cur_seq = prb_first_valid_seq(prb);
+	if (prb_read_valid_info(prb, iter->cur_seq, &info, NULL)) {
+		if (info.seq != iter->cur_seq) {
+			/* messages are gone, move to first available one */
+			iter->cur_seq = info.seq;
+		}
 	}
 
 	/* last entry */
-	if (dumper->cur_seq >= dumper->next_seq)
+	if (iter->cur_seq >= iter->next_seq)
 		goto out;
 
 	/*
 	 * Find first record that fits, including all following records,
-	 * into the user-provided buffer for this dump.
+	 * into the user-provided buffer for this dump. Pass in size-1
+	 * because this function (by way of record_print_text()) will
+	 * not write more than size-1 bytes of text into @buf.
 	 */
-
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (info.seq >= dumper->next_seq)
-			break;
-		len += get_record_print_text_size(&info, line_count, syslog, time);
-	}
+	seq = find_first_fitting_seq(iter->cur_seq, iter->next_seq,
+				     size - 1, syslog, time);
 
 	/*
-	 * Move first record forward until length fits into the buffer. Ignore
-	 * newest messages that were not counted in the above cycle. Messages
-	 * might appear and get lost in the meantime. This is the best effort
-	 * that prevents an infinite loop.
+	 * Next kmsg_dump_get_buffer() invocation will dump block of
+	 * older records stored right before this one.
 	 */
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (len <= size || info.seq >= dumper->next_seq)
-			break;
-		len -= get_record_print_text_size(&info, line_count, syslog, time);
-	}
-
-	/* Keep track of the last message for the next iteration. */
 	next_seq = seq;
 
 	prb_rec_init_rd(&r, &info, buf, size);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
-		if (r.info->seq >= dumper->next_seq)
+		if (r.info->seq >= iter->next_seq)
 			break;
 
 		len += record_print_text(&r, syslog, time);
@@ -3405,7 +3384,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		prb_rec_init_rd(&r, &info, buf + len, size - len);
 	}
 
-	dumper->next_seq = next_seq;
+	iter->next_seq = next_seq;
 	ret = true;
 out:
 	if (len_out)
@@ -3414,33 +3393,18 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
-/**
- * kmsg_dump_rewind_nolock - reset the iterator (unlocked version)
- * @dumper: registered kmsg dumper
- *
- * Reset the dumper's iterator so that kmsg_dump_get_line() and
- * kmsg_dump_get_buffer() can be called again and used multiple
- * times within the same dumper.dump() callback.
- *
- * The function is similar to kmsg_dump_rewind(), but grabs no locks.
- */
-void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
-{
-	dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
-	dumper->next_seq = prb_next_seq(prb);
-}
-
 /**
  * kmsg_dump_rewind - reset the iterator
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  *
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
  */
-void kmsg_dump_rewind(struct kmsg_dumper *dumper)
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
-	kmsg_dump_rewind_nolock(dumper);
+	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
+	iter->next_seq = prb_next_seq(prb);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e47bbb00e5438..24166ab833048 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2606,6 +2606,11 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
 
+#ifdef CONFIG_PREEMPT_LAZY
+	if (need_resched_lazy())
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
+#endif
+
 	return (pc & 0xff) |
 		(migration_disable_value() & 0xff) << 8 |
 		(preempt_lazy_count() & 0xff) << 16 |
diff --git a/localversion-rt b/localversion-rt
index a68b4337d4ce1..ce6a482618d5a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt31
+-rt32
