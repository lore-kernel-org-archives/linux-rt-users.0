Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFFC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BF23B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 18:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLRSQZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 13:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLRSQZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 13:16:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0423C0617A7;
        Fri, 18 Dec 2020 10:15:44 -0800 (PST)
Date:   Fri, 18 Dec 2020 19:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608315341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nKuILNFy1X9mDk1K6U6kyo/gbsj/37ubHMcPjiKGWc4=;
        b=Vx8kSmVJELnDmqrTuBE+1NR68ARWZSIWGC5c24mdCvu+aAubEZoPVcQoL3dtkkMRgd0s9n
        LDMFWch+z6rcLLiT42qvV69mA7JMHT5w4LpUmcSbWUmxl6ng4xpb8yG17jJQzhxhGekLCT
        FRz0tuoe/LJUiQGlVQZhS8/J0IlBzGDTh1qGGTagzwI+Ph3gpJfoZazwS6dIo/Iw0OUlyU
        AvWLmgUul4AMmHXNbLFWiyDY0YZOUe8OmAgfiqL34UT2bHD1pO6mjXFySSNqNH/3Q+KRvv
        bE7EQR20wcCacwHWrj1bYMqEfHiNR3mzPnCrkIn+0oYQszpdUHAFP5nAan8kag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608315341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nKuILNFy1X9mDk1K6U6kyo/gbsj/37ubHMcPjiKGWc4=;
        b=EPsXmF24+YYYbFUdRxdTOMctW6zw4PWoyURqoqM7PwFdnlc/go8Jm8Xl7FnPWiK/pAv7SC
        r2Jz2caWkw28paCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.1-rt20
Message-ID: <20201218181540.a6qjdjtojessvd5r@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.1-rt20 patch set. 

Changes since v5.10.1-rt19:

  - Fix a compile failure in the trace branch profiler introduced in the
    previous release. Reported by kernel test bot.

  - Mike Galbraith reported errors in the z3fold code. Patches by Vitaly
    Wool.

  - Update John Ogness' printk patches.
    - vprintk_store() sync'd with upstream.
    - pr_flush() now auto-detects if it may sleep.
    - pr_flush() is now called for all panic and oops scenarios.
    - @clear_seq changed from atomic64_t to latched_seq to allow
      lockless reader access.
    - @devkmsg_user.seq changed to atomic64_t to guarantee
      consistent values.
    - Now waking all printing threads instead of just one for
      new messages.
    - kmsg dumpers now called using a copy of the iterator.

The issues in the "Known issues" section are not introduced as part of
this release. They were noticed by John during his printk rework.


Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.10.1-rt19 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.1-rt19-rt20.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.1-rt20

The RT patch against v5.10.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.1-rt20.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.1-rt20.tar.xz

Sebastian

diff --git a/include/linux/printk.h b/include/linux/printk.h
index a964b42ccb974..2408f6c956deb 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -476,7 +476,7 @@ extern int kptr_restrict;
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
-bool pr_flush(bool may_sleep, int timeout_ms, bool reset_on_progress);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 
 /*
  * ratelimited messages with local ratelimit_state,
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 515e552879dd3..b5f9604d0c98a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -457,7 +457,6 @@ void __init mount_block_root(char *name, int flags)
 		printk("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
 		       "explicit textual name for \"root=\" boot option.\n");
 #endif
-		pr_flush(true, 1000, true);
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
 	if (!(flags & SB_RDONLY)) {
diff --git a/kernel/panic.c b/kernel/panic.c
index c48865044949b..a14e2f5a9f550 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -177,12 +177,28 @@ static void panic_print_sys_info(void)
 void panic(const char *fmt, ...)
 {
 	static char buf[1024];
+	va_list args2;
 	va_list args;
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
+	console_verbose();
+	pr_emerg("Kernel panic - not syncing:\n");
+	va_start(args2, fmt);
+	va_copy(args, args2);
+	vprintk(fmt, args2);
+	va_end(args2);
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+	/*
+	 * Avoid nested stack-dumping if a panic occurs during oops processing
+	 */
+	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
+		dump_stack();
+#endif
+	pr_flush(1000, true);
+
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
 	 * from deadlocking the first cpu that invokes the panic, since
@@ -213,24 +229,13 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
-	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	if (len && buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
 
-	pr_emerg("Kernel panic - not syncing: %s\n", buf);
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-	/*
-	 * Avoid nested stack-dumping if a panic occurs during oops processing
-	 */
-	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
-		dump_stack();
-#endif
-
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all
 	 * the other CPUs or else we won't be able to debug processes left
@@ -554,6 +559,7 @@ static void print_oops_end_marker(void)
 {
 	init_oops_id();
 	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
+	pr_flush(1000, true);
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dc5da374a005f..56d84a28ca079 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -337,7 +337,7 @@ enum log_flags {
 };
 
 #ifdef CONFIG_PRINTK
-/* The syslog_lock protects syslog_* variables. */
+/* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_SPINLOCK(syslog_lock);
 
 /* Set to enable sync mode. Once set, it is never cleared. */
@@ -350,8 +350,21 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-/* the next printk record to read after the last 'clear' command */
-static atomic64_t clear_seq = ATOMIC64_INIT(0);
+struct latched_seq {
+	seqcount_latch_t	latch;
+	u64			val[2];
+};
+
+/*
+ * The next printk record to read after the last 'clear' command. There are
+ * two copies (updated with seqcount_latch) so that reads can locklessly
+ * access a valid value. Writers are synchronized by @syslog_lock.
+ */
+static struct latched_seq clear_seq = {
+	.latch		= SEQCNT_LATCH_ZERO(clear_seq.latch),
+	.val[0]		= 0,
+	.val[1]		= 0,
+};
 
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
@@ -400,6 +413,31 @@ static bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
+/* Must be called under syslog_lock. */
+void latched_seq_write(struct latched_seq *ls, u64 val)
+{
+	raw_write_seqcount_latch(&ls->latch);
+	ls->val[0] = val;
+	raw_write_seqcount_latch(&ls->latch);
+	ls->val[1] = val;
+}
+
+/* Can be called from any context. */
+u64 latched_seq_read_nolock(struct latched_seq *ls)
+{
+	unsigned int seq;
+	unsigned int idx;
+	u64 val;
+
+	do {
+		seq = raw_read_seqcount_latch(&ls->latch);
+		idx = seq & 0x1;
+		val = ls->val[idx];
+	} while (read_seqcount_latch_retry(&ls->latch, seq));
+
+	return val;
+}
+
 /* Return log buffer address */
 char *log_buf_addr_get(void)
 {
@@ -567,7 +605,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
-	u64 seq;
+	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
@@ -668,21 +706,21 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!prb_read_valid(prb, user->seq, r)) {
+	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
 		}
 
 		ret = wait_event_interruptible(log_wait,
-					prb_read_valid(prb, user->seq, r));
+				prb_read_valid(prb, atomic64_read(&user->seq), r));
 		if (ret)
 			goto out;
 	}
 
-	if (user->seq < prb_first_valid_seq(prb)) {
+	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		ret = -EPIPE;
 		goto out;
 	}
@@ -692,7 +730,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
-	user->seq = r->info->seq + 1;
+	atomic64_set(&user->seq, r->info->seq + 1);
 
 	if (len > count) {
 		ret = -EINVAL;
@@ -730,7 +768,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		break;
 	case SEEK_DATA:
 		/*
@@ -738,11 +776,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = atomic64_read(&clear_seq);
+		atomic64_set(&user->seq, latched_seq_read_nolock(&clear_seq));
 		break;
 	case SEEK_END:
 		/* after the last record */
-		user->seq = prb_next_seq(prb);
+		atomic64_set(&user->seq, prb_next_seq(prb));
 		break;
 	default:
 		ret = -EINVAL;
@@ -760,9 +798,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &log_wait, wait);
 
-	if (prb_read_valid(prb, user->seq, NULL)) {
+	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_valid_seq(prb))
+		if (atomic64_read(&user->seq) < prb_first_valid_seq(prb))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -799,7 +837,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	prb_rec_init_rd(&user->record, &user->info,
 			&user->text_buf[0], sizeof(user->text_buf));
 
-	user->seq = prb_first_valid_seq(prb);
+	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
 	file->private_data = user;
 	return 0;
@@ -850,9 +888,6 @@ void log_buf_vmcoreinfo_setup(void)
 	 * parse it and detect any changes to structure down the line.
 	 */
 
-	VMCOREINFO_SIZE(atomic64_t);
-	VMCOREINFO_TYPE_OFFSET(atomic64_t, counter);
-
 	VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
 	VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
@@ -894,6 +929,9 @@ void log_buf_vmcoreinfo_setup(void)
 
 	VMCOREINFO_SIZE(atomic_long_t);
 	VMCOREINFO_TYPE_OFFSET(atomic_long_t, counter);
+
+	VMCOREINFO_STRUCT_SIZE(latched_seq);
+	VMCOREINFO_OFFSET(latched_seq, val);
 }
 #endif
 
@@ -1341,11 +1379,11 @@ static int syslog_print(char __user *buf, int size)
 	char *text;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	while (size > 0) {
 		size_t n;
@@ -1414,12 +1452,12 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
 	time = printk_time;
-	clr_seq = atomic64_read(&clear_seq);
+	clr_seq = latched_seq_read_nolock(&clear_seq);
 
 	/*
 	 * Find first record that fits, including all following records,
@@ -1430,24 +1468,19 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		len += get_record_print_text_size(&info, line_count, true, time);
 
 	/*
-	 * Keep track of the latest in case new records are coming in fast
-	 * and overwriting the older records.
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is the best effort
+	 * that prevents an infinite loop.
 	 */
 	newest_seq = seq;
-
-	/*
-	 * Move first record forward until length fits into the buffer. This
-	 * is a best effort attempt. If @newest_seq is reached because the
-	 * ringbuffer is wrapping too fast, just start filling the buffer
-	 * from there.
-	 */
 	prb_for_each_info(clr_seq, prb, seq, &info, &line_count) {
 		if (len <= size || info.seq > newest_seq)
 			break;
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -1469,8 +1502,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 	}
 
-	if (clear)
-		atomic64_set(&clear_seq, seq);
+	if (clear) {
+		spin_lock_irq(&syslog_lock);
+		latched_seq_write(&clear_seq, seq);
+		spin_unlock_irq(&syslog_lock);
+	}
 
 	kfree(text);
 	return len;
@@ -1478,7 +1514,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	atomic64_set(&clear_seq, prb_next_seq(prb));
+	spin_lock_irq(&syslog_lock);
+	latched_seq_write(&clear_seq, prb_next_seq(prb));
+	spin_unlock_irq(&syslog_lock);
 }
 
 int do_syslog(int type, char __user *buf, int len, int source)
@@ -1504,9 +1542,12 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
+
+		/* Get a consistent copy of @syslog_seq. */
 		spin_lock_irq(&syslog_lock);
 		seq = syslog_seq;
 		spin_unlock_irq(&syslog_lock);
+
 		error = wait_event_interruptible(log_wait,
 				prb_read_valid(prb, seq, NULL));
 		if (error)
@@ -1743,7 +1784,7 @@ struct printk_recursion {
 static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
 static char printk_recursion_count[NUM_RECURSION_CTX];
 
-static char *get_printk_count(void)
+static char *printk_recursion_counter(void)
 {
 	struct printk_recursion *rec;
 	char *count;
@@ -1764,12 +1805,12 @@ static char *get_printk_count(void)
 	return count;
 }
 
-static bool printk_enter(unsigned long *flags)
+static bool printk_enter_irqsave(unsigned long *flags)
 {
 	char *count;
 
 	local_irq_save(*flags);
-	count = get_printk_count();
+	count = printk_recursion_counter();
 	/* Only 1 level of recursion allowed. */
 	if (*count > 1) {
 		local_irq_restore(*flags);
@@ -1780,11 +1821,11 @@ static bool printk_enter(unsigned long *flags)
 	return true;
 }
 
-static void printk_exit(unsigned long flags)
+static void printk_exit_irqrestore(unsigned long flags)
 {
 	char *count;
 
-	count = get_printk_count();
+	count = printk_recursion_counter();
 	(*count)--;
 	local_irq_restore(flags);
 }
@@ -1795,10 +1836,53 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
+/**
+ * parse_prefix - Parse level and control flags.
+ *
+ * @text:     The terminated text message.
+ * @level:    A pointer to the current level value, will be updated.
+ * @lflags:   A pointer to the current log flags, will be updated.
+ *
+ * @level may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @level must be set to
+ * LOGLEVEL_DEFAULT in order to be updated with the parsed value.
+ *
+ * @lflags may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @lflags will be OR'd with the parsed
+ * value.
+ *
+ * Return: The length of the parsed level and control flags.
+ */
+static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
+{
+	u16 prefix_len = 0;
+	int kern_level;
+
+	while (*text) {
+		kern_level = printk_get_level(text);
+		if (!kern_level)
+			break;
+
+		switch (kern_level) {
+		case '0' ... '7':
+			if (level && *level == LOGLEVEL_DEFAULT)
+				*level = kern_level - '0';
+			break;
+		case 'c':	/* KERN_CONT */
+			if (lflags)
+				*lflags |= LOG_CONT;
+		}
+
+		prefix_len += 2;
+		text += 2;
+	}
+
+	return prefix_len;
+}
+
 static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
 			 const char *fmt, va_list args)
 {
-	char *orig_text = text;
 	u16 text_len;
 
 	text_len = vscnprintf(text, size, fmt, args);
@@ -1809,15 +1893,15 @@ static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lfl
 		*lflags |= LOG_NEWLINE;
 	}
 
-	/* Strip kernel syslog prefix. */
+	/* Strip log level and control flags. */
 	if (facility == 0) {
-		while (text_len >= 2 && printk_get_level(text)) {
-			text_len -= 2;
-			text += 2;
-		}
+		u16 prefix_len;
 
-		if (text != orig_text)
-			memmove(orig_text, text, text_len);
+		prefix_len = parse_prefix(text, NULL, NULL);
+		if (prefix_len) {
+			text_len -= prefix_len;
+			memmove(text, text + prefix_len, text_len);
+		}
 	}
 
 	return text_len;
@@ -1835,47 +1919,41 @@ static int vprintk_store(int facility, int level,
 	struct printk_record r;
 	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
-	char lvlbuf[8];
+	char prefix_buf[8];
+	u16 reserve_size;
 	va_list args2;
 	u16 text_len;
 	int ret = 0;
 	u64 ts_nsec;
 	u64 seq;
 
+	/*
+	 * Since the duration of printk() can vary depending on the message
+	 * and state of the ringbuffer, grab the timestamp now so that it is
+	 * close to the call of printk(). This provides a more deterministic
+	 * timestamp with respect to the caller.
+	 */
 	ts_nsec = local_clock();
 
-	if (!printk_enter(&irqflags))
+	if (!printk_enter_irqsave(&irqflags))
 		return 0;
 
-	va_copy(args2, args);
-
 	/*
-	 * The printf needs to come first; we need the syslog
-	 * prefix which might be passed-in as a parameter.
+	 * The sprintf needs to come first since the syslog prefix might be
+	 * passed in as a parameter. An extra byte must be reserved so that
+	 * later the vscnprintf() into the reserved buffer has room for the
+	 * terminating '\0', which is not counted by vsnprintf().
 	 */
-	text_len = vsnprintf(&lvlbuf[0], sizeof(lvlbuf), fmt, args) + 1;
-	if (text_len > CONSOLE_LOG_MAX)
-		text_len = CONSOLE_LOG_MAX;
+	va_copy(args2, args);
+	reserve_size = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args2) + 1;
+	va_end(args2);
+
+	if (reserve_size > LOG_LINE_MAX)
+		reserve_size = LOG_LINE_MAX;
 
 	/* Extract log level or control flags. */
-	if (facility == 0) {
-		int kern_level;
-		int i;
-
-		for (i = 0; i < sizeof(lvlbuf); i += 2) {
-			kern_level = printk_get_level(&lvlbuf[i]);
-			if (!kern_level)
-				break;
-			switch (kern_level) {
-			case '0' ... '7':
-				if (level == LOGLEVEL_DEFAULT)
-					level = kern_level - '0';
-				break;
-			case 'c':	/* KERN_CONT */
-				lflags |= LOG_CONT;
-			}
-		}
-	}
+	if (facility == 0)
+		parse_prefix(&prefix_buf[0], &level, &lflags);
 
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
@@ -1884,11 +1962,11 @@ static int vprintk_store(int facility, int level,
 		lflags |= LOG_NEWLINE;
 
 	if (lflags & LOG_CONT) {
-		prb_rec_init_wr(&r, text_len);
+		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
 			seq = r.info->seq;
-			text_len = printk_sprint(&r.text_buf[r.info->text_len], text_len,
-						 facility, &lflags, fmt, args2);
+			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
+						 facility, &lflags, fmt, args);
 			r.info->text_len += text_len;
 
 			if (lflags & LOG_NEWLINE) {
@@ -1904,12 +1982,17 @@ static int vprintk_store(int facility, int level,
 		}
 	}
 
-	prb_rec_init_wr(&r, text_len);
+	/*
+	 * Explicitly initialize the record before every prb_reserve() call.
+	 * prb_reserve_in_last() and prb_reserve() purposely invalidate the
+	 * structure when they fail.
+	 */
+	prb_rec_init_wr(&r, reserve_size);
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
-		truncate_msg(&text_len, &trunc_msg_len);
+		truncate_msg(&reserve_size, &trunc_msg_len);
 
-		prb_rec_init_wr(&r, text_len + trunc_msg_len);
+		prb_rec_init_wr(&r, reserve_size + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
 			goto out;
 	}
@@ -1917,7 +2000,7 @@ static int vprintk_store(int facility, int level,
 	seq = r.info->seq;
 
 	/* fill message */
-	text_len = printk_sprint(&r.text_buf[0], text_len, facility, &lflags, fmt, args2);
+	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &lflags, fmt, args);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
@@ -1943,8 +2026,7 @@ static int vprintk_store(int facility, int level,
 	if (facility == 0 && final_commit && any_console_can_sync())
 		print_sync_until(NULL, seq + 1);
 
-	va_end(args2);
-	printk_exit(irqflags);
+	printk_exit_irqrestore(irqflags);
 	return ret;
 }
 
@@ -2174,8 +2256,6 @@ static void console_try_thread(struct console *con)
 
 #else /* CONFIG_PRINTK */
 
-#define LOG_LINE_MAX		0
-#define PREFIX_MAX		0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
@@ -2930,7 +3010,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = __this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible(&log_wait);
+		wake_up_interruptible_all(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
@@ -3107,15 +3187,16 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		}
 
 		/*
-		 * Give the printing threads time to flush, allowing up to 1
-		 * second of no printing forward progress before giving up.
+		 * Give the printing threads time to flush, allowing up to
+		 * 1s of no printing forward progress before giving up.
 		 */
-		pr_flush(false, 100, true);
+		pr_flush(1000, true);
 	}
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
 		enum kmsg_dump_reason max_reason = dumper->max_reason;
+		struct kmsg_dumper dumper_copy;
 
 		/*
 		 * If client has not provided a specific max_reason, default
@@ -3128,16 +3209,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		if (reason > max_reason)
 			continue;
 
-		/* initialize iterator with data about the stored records */
-		dumper->active = true;
+		/*
+		 * Invoke a copy of the dumper to iterate over the records.
+		 * This allows kmsg_dump() to be called simultaneously on
+		 * multiple CPUs.
+		 */
 
-		kmsg_dump_rewind_nolock(dumper);
+		memcpy(&dumper_copy, dumper, sizeof(dumper_copy));
+		INIT_LIST_HEAD(&dumper_copy.list);
+		dumper_copy.active = true;
 
-		/* invoke dumper which will iterate over records */
-		dumper->dump(dumper, reason);
-
-		/* reset iterator */
-		dumper->active = false;
+		kmsg_dump_rewind_nolock(&dumper_copy);
+		dumper_copy.dump(&dumper_copy, reason);
 	}
 	rcu_read_unlock();
 }
@@ -3277,10 +3360,10 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	}
 
 	/*
-	 * Move first record forward until length fits into the buffer. This
-	 * is a best effort attempt. If @dumper->next_seq is reached because
-	 * the ringbuffer is wrapping too fast, just start filling the buffer
-	 * from there.
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is the best effort
+	 * that prevents an infinite loop.
 	 */
 	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
 		if (len <= size || info.seq >= dumper->next_seq)
@@ -3320,10 +3403,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
+ *
+ * The function is similar to kmsg_dump_rewind(), but grabs no locks.
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = atomic64_read(&clear_seq);
+	dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 	dumper->next_seq = prb_next_seq(prb);
 }
 
@@ -3456,7 +3541,6 @@ static void pr_msleep(bool may_sleep, int ms)
 /**
  * pr_flush() - Wait for printing threads to catch up.
  *
- * @may_sleep:         Context allows msleep() calls.
  * @timeout_ms:        The maximum time (in ms) to wait.
  * @reset_on_progress: Reset the timeout if forward progress is seen.
  *
@@ -3466,19 +3550,21 @@ static void pr_msleep(bool may_sleep, int ms)
  * If @reset_on_progress is true, the timeout will be reset whenever any
  * printer has been seen to make some forward progress.
  *
- * Context: Any context if @timeout_ms is 0 or @may_sleep is false. Otherwise
- * process context.
+ * Context: Any context.
  * Return: true if all enabled printers are caught up.
  */
-bool pr_flush(bool may_sleep, int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	int remaining = timeout_ms;
 	struct console *con;
 	u64 last_diff = 0;
+	bool may_sleep;
 	u64 printk_seq;
 	u64 diff;
 	u64 seq;
 
+	may_sleep = (preemptible() && !in_softirq());
+
 	seq = prb_next_seq(prb);
 
 	for (;;) {
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index eff099123aa27..0de1e9c4d381b 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -37,7 +37,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	struct ring_buffer_event *event;
 	struct trace_branch *entry;
 	unsigned long flags;
-	int pc;
+	unsigned int pc;
 	const char *p;
 
 	if (current->trace_recursion & TRACE_BRANCH_BIT)
@@ -59,10 +59,10 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	if (atomic_read(&data->disabled))
 		goto out;
 
-	pc = preempt_count();
+	trace_ctx = _tracing_gen_ctx_flags(flags);
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_BRANCH,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		goto out;
 
diff --git a/lib/bug.c b/lib/bug.c
index 7103440c0ee1a..baf61c307a6a2 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -205,6 +205,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	else
 		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
+	pr_flush(1000, true);
 
 	return BUG_TRAP_TYPE_BUG;
 }
diff --git a/localversion-rt b/localversion-rt
index 483ad771f201a..e095ab8197147 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt19
+-rt20
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18feaa0bc5377..dacb0d70fa61c 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -90,7 +90,7 @@ struct z3fold_buddy_slots {
 	 * be enough slots to hold all possible variants
 	 */
 	unsigned long slot[BUDDY_MASK + 1];
-	unsigned long pool; /* back link + flags */
+	unsigned long pool; /* back link */
 	rwlock_t lock;
 };
 #define HANDLE_FLAG_MASK	(0x03)
@@ -185,7 +185,7 @@ enum z3fold_page_flags {
  * handle flags, go under HANDLE_FLAG_MASK
  */
 enum z3fold_handle_flags {
-	HANDLES_ORPHANED = 0,
+	HANDLES_NOFREE = 0,
 };
 
 /*
@@ -303,10 +303,9 @@ static inline void put_z3fold_header(struct z3fold_header *zhdr)
 		z3fold_page_unlock(zhdr);
 }
 
-static inline void free_handle(unsigned long handle)
+static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 {
 	struct z3fold_buddy_slots *slots;
-	struct z3fold_header *zhdr;
 	int i;
 	bool is_free;
 
@@ -316,22 +315,19 @@ static inline void free_handle(unsigned long handle)
 	if (WARN_ON(*(unsigned long *)handle == 0))
 		return;
 
-	zhdr = handle_to_z3fold_header(handle);
 	slots = handle_to_slots(handle);
 	write_lock(&slots->lock);
 	*(unsigned long *)handle = 0;
-	if (zhdr->slots == slots) {
+
+	if (test_bit(HANDLES_NOFREE, &slots->pool)) {
 		write_unlock(&slots->lock);
 		return; /* simple case, nothing else to do */
 	}
 
-	/* we are freeing a foreign handle if we are here */
-	zhdr->foreign_handles--;
+	if (zhdr->slots != slots)
+		zhdr->foreign_handles--;
+
 	is_free = true;
-	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
-		write_unlock(&slots->lock);
-		return;
-	}
 	for (i = 0; i <= BUDDY_MASK; i++) {
 		if (slots->slot[i]) {
 			is_free = false;
@@ -343,6 +339,8 @@ static inline void free_handle(unsigned long handle)
 	if (is_free) {
 		struct z3fold_pool *pool = slots_to_pool(slots);
 
+		if (zhdr->slots == slots)
+			zhdr->slots = NULL;
 		kmem_cache_free(pool->c_handle, slots);
 	}
 }
@@ -525,8 +523,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 {
 	struct page *page = virt_to_page(zhdr);
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	bool is_free = true;
-	int i;
 
 	WARN_ON(!list_empty(&zhdr->buddy));
 	set_bit(PAGE_STALE, &page->private);
@@ -536,21 +532,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 		list_del_init(&page->lru);
 	spin_unlock(&pool->lock);
 
-	/* If there are no foreign handles, free the handles array */
-	read_lock(&zhdr->slots->lock);
-	for (i = 0; i <= BUDDY_MASK; i++) {
-		if (zhdr->slots->slot[i]) {
-			is_free = false;
-			break;
-		}
-	}
-	if (!is_free)
-		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
-	read_unlock(&zhdr->slots->lock);
-
-	if (is_free)
-		kmem_cache_free(pool->c_handle, zhdr->slots);
-
 	if (locked)
 		z3fold_page_unlock(zhdr);
 
@@ -642,17 +623,41 @@ static inline void add_to_unbuddied(struct z3fold_pool *pool,
 {
 	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
 			zhdr->middle_chunks == 0) {
-		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
-
+		struct list_head *unbuddied;
 		int freechunks = num_free_chunks(zhdr);
+
+		migrate_disable();
+		unbuddied = this_cpu_ptr(pool->unbuddied);
 		spin_lock(&pool->lock);
 		list_add(&zhdr->buddy, &unbuddied[freechunks]);
 		spin_unlock(&pool->lock);
 		zhdr->cpu = smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
+		migrate_enable();
 	}
 }
 
+static inline enum buddy get_free_buddy(struct z3fold_header *zhdr, int chunks)
+{
+	enum buddy bud = HEADLESS;
+
+	if (zhdr->middle_chunks) {
+		if (!zhdr->first_chunks &&
+		    chunks <= zhdr->start_middle - ZHDR_CHUNKS)
+			bud = FIRST;
+		else if (!zhdr->last_chunks)
+			bud = LAST;
+	} else {
+		if (!zhdr->first_chunks)
+			bud = FIRST;
+		else if (!zhdr->last_chunks)
+			bud = LAST;
+		else
+			bud = MIDDLE;
+	}
+
+	return bud;
+}
+
 static inline void *mchunk_memmove(struct z3fold_header *zhdr,
 				unsigned short dst_chunk)
 {
@@ -714,18 +719,7 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		if (WARN_ON(new_zhdr == zhdr))
 			goto out_fail;
 
-		if (new_zhdr->first_chunks == 0) {
-			if (new_zhdr->middle_chunks != 0 &&
-					chunks >= new_zhdr->start_middle) {
-				new_bud = LAST;
-			} else {
-				new_bud = FIRST;
-			}
-		} else if (new_zhdr->last_chunks == 0) {
-			new_bud = LAST;
-		} else if (new_zhdr->middle_chunks == 0) {
-			new_bud = MIDDLE;
-		}
+		new_bud = get_free_buddy(new_zhdr, chunks);
 		q = new_zhdr;
 		switch (new_bud) {
 		case FIRST:
@@ -847,9 +841,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 		return;
 	}
 
-	if (unlikely(PageIsolated(page) ||
-		     test_bit(PAGE_CLAIMED, &page->private) ||
-		     test_bit(PAGE_STALE, &page->private))) {
+	if (test_bit(PAGE_STALE, &page->private) ||
+	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -858,13 +851,16 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
 		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 			atomic64_dec(&pool->pages_nr);
-		else
+		else {
+			clear_bit(PAGE_CLAIMED, &page->private);
 			z3fold_page_unlock(zhdr);
+		}
 		return;
 	}
 
 	z3fold_compact_page(zhdr);
 	add_to_unbuddied(pool, zhdr);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	z3fold_page_unlock(zhdr);
 }
 
@@ -886,8 +882,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 	int chunks = size_to_chunks(size), i;
 
 lookup:
+	migrate_disable();
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied = get_cpu_ptr(pool->unbuddied);
+	unbuddied = this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l = &unbuddied[i];
 
@@ -905,7 +902,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -919,7 +916,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -934,7 +931,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();
 
 	if (!zhdr) {
 		int cpu;
@@ -973,6 +970,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		}
 	}
 
+	if (zhdr && !zhdr->slots)
+		zhdr->slots = alloc_slots(pool,
+					can_sleep ? GFP_NOIO : GFP_ATOMIC);
 	return zhdr;
 }
 
@@ -1109,17 +1109,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 retry:
 		zhdr = __z3fold_alloc(pool, size, can_sleep);
 		if (zhdr) {
-			if (zhdr->first_chunks == 0) {
-				if (zhdr->middle_chunks != 0 &&
-				    chunks >= zhdr->start_middle)
-					bud = LAST;
-				else
-					bud = FIRST;
-			} else if (zhdr->last_chunks == 0)
-				bud = LAST;
-			else if (zhdr->middle_chunks == 0)
-				bud = MIDDLE;
-			else {
+			bud = get_free_buddy(zhdr, chunks);
+			if (bud == HEADLESS) {
 				if (kref_put(&zhdr->refcount,
 					     release_z3fold_page_locked))
 					atomic64_dec(&pool->pages_nr);
@@ -1265,12 +1256,11 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		pr_err("%s: unknown bud %d\n", __func__, bud);
 		WARN_ON(1);
 		put_z3fold_header(zhdr);
-		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
 	}
 
 	if (!page_claimed)
-		free_handle(handle);
+		free_handle(handle, zhdr);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
 		atomic64_dec(&pool->pages_nr);
 		return;
@@ -1280,8 +1270,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		z3fold_page_unlock(zhdr);
 		return;
 	}
-	if (unlikely(PageIsolated(page)) ||
-	    test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
+	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		put_z3fold_header(zhdr);
 		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
@@ -1345,6 +1334,10 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 	struct page *page = NULL;
 	struct list_head *pos;
 	unsigned long first_handle = 0, middle_handle = 0, last_handle = 0;
+	struct z3fold_buddy_slots slots __attribute__((aligned(SLOTS_ALIGN)));
+
+	rwlock_init(&slots.lock);
+	slots.pool = (unsigned long)pool | (1 << HANDLES_NOFREE);
 
 	spin_lock(&pool->lock);
 	if (!pool->ops || !pool->ops->evict || retries == 0) {
@@ -1359,35 +1352,36 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
 
-			/* this bit could have been set by free, in which case
-			 * we pass over to the next page in the pool.
-			 */
-			if (test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-				page = NULL;
-				continue;
-			}
-
-			if (unlikely(PageIsolated(page))) {
-				clear_bit(PAGE_CLAIMED, &page->private);
-				page = NULL;
-				continue;
-			}
 			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
 				break;
 
+			if (kref_get_unless_zero(&zhdr->refcount) == 0) {
+				zhdr = NULL;
+				break;
+			}
 			if (!z3fold_page_trylock(zhdr)) {
-				clear_bit(PAGE_CLAIMED, &page->private);
+				if (kref_put(&zhdr->refcount,
+						release_z3fold_page))
+					atomic64_dec(&pool->pages_nr);
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
-			if (zhdr->foreign_handles) {
-				clear_bit(PAGE_CLAIMED, &page->private);
-				z3fold_page_unlock(zhdr);
+
+			/* test_and_set_bit is of course atomic, but we still
+			 * need to do it under page lock, otherwise checking
+			 * that bit in __z3fold_alloc wouldn't make sense
+			 */
+			if (zhdr->foreign_handles ||
+			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+				if (kref_put(&zhdr->refcount,
+						release_z3fold_page))
+					atomic64_dec(&pool->pages_nr);
+				else
+					z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				continue; /* can't evict such page */
 			}
-			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
 			break;
@@ -1409,12 +1403,16 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			first_handle = 0;
 			last_handle = 0;
 			middle_handle = 0;
+			memset(slots.slot, 0, sizeof(slots.slot));
 			if (zhdr->first_chunks)
-				first_handle = encode_handle(zhdr, FIRST);
+				first_handle = __encode_handle(zhdr, &slots,
+								FIRST);
 			if (zhdr->middle_chunks)
-				middle_handle = encode_handle(zhdr, MIDDLE);
+				middle_handle = __encode_handle(zhdr, &slots,
+								MIDDLE);
 			if (zhdr->last_chunks)
-				last_handle = encode_handle(zhdr, LAST);
+				last_handle = __encode_handle(zhdr, &slots,
+								LAST);
 			/*
 			 * it's safe to unlock here because we hold a
 			 * reference to this page
@@ -1429,19 +1427,16 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			ret = pool->ops->evict(pool, middle_handle);
 			if (ret)
 				goto next;
-			free_handle(middle_handle);
 		}
 		if (first_handle) {
 			ret = pool->ops->evict(pool, first_handle);
 			if (ret)
 				goto next;
-			free_handle(first_handle);
 		}
 		if (last_handle) {
 			ret = pool->ops->evict(pool, last_handle);
 			if (ret)
 				goto next;
-			free_handle(last_handle);
 		}
 next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
@@ -1455,9 +1450,11 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_unlock(&pool->lock);
 			clear_bit(PAGE_CLAIMED, &page->private);
 		} else {
+			struct z3fold_buddy_slots *slots = zhdr->slots;
 			z3fold_page_lock(zhdr);
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
+				kmem_cache_free(pool->c_handle, slots);
 				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
@@ -1573,8 +1570,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	if (test_bit(PAGE_HEADLESS, &page->private) ||
-	    test_bit(PAGE_CLAIMED, &page->private))
+	if (test_bit(PAGE_HEADLESS, &page->private))
 		return false;
 
 	zhdr = page_address(page);
@@ -1586,6 +1582,8 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0)
 		goto out;
 
+	if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+		goto out;
 	pool = zhdr_to_pool(zhdr);
 	spin_lock(&pool->lock);
 	if (!list_empty(&zhdr->buddy))
@@ -1612,16 +1610,17 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &page->private), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
 
-	if (!z3fold_page_trylock(zhdr)) {
+	if (!z3fold_page_trylock(zhdr))
 		return -EAGAIN;
-	}
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
 		z3fold_page_unlock(zhdr);
+		clear_bit(PAGE_CLAIMED, &page->private);
 		return -EBUSY;
 	}
 	if (work_pending(&zhdr->work)) {
@@ -1663,6 +1662,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
 	page_mapcount_reset(page);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	put_page(page);
 	return 0;
 }
@@ -1686,6 +1686,7 @@ static void z3fold_page_putback(struct page *page)
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
 	spin_unlock(&pool->lock);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	z3fold_page_unlock(zhdr);
 }
 
