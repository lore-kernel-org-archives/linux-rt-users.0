Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E259EC63777
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 17:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7633220789
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 17:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zutzTQWa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7N90X+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgK3Ryb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:54:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgK3Ryb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 12:54:31 -0500
Date:   Mon, 30 Nov 2020 18:53:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606758825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JBcjHicn1jcDhZ522YfRohh7BmwPdGutuZgTW98DKgw=;
        b=zutzTQWal42CI2QXxAaqsYWe/n9d4xc7McrUgH4Vby/Z83K/vYtBVhpN1V80FOIaoubZCv
        kQu46WnZfbtqjqTWbqJXVIzpp3DKVJ6jV6MvgdAvG/zmAsvln3ZoMfDQ5/nnLR2twW+ZgF
        +q7hwO3AFSMYhIbD9BbK5HDzHkucDlCmUgTd9N2Fzim3AD1KoHbmh4xxKHMAcZDGxkOJlh
        /KliLSa6Rf8PZ+o1gy10f9Bf4nAYZ/uZvRE4dXgY8yNUbuo2g/WRRlrmTpYecvpuGw1N1A
        upKT1IASw/622aNEfFi0TVmy/xY95QliWmVYK/oAU98MDzoshDQXQUynJyrXaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606758826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JBcjHicn1jcDhZ522YfRohh7BmwPdGutuZgTW98DKgw=;
        b=A7N90X+LsDezI23/sF7jPPXkMPiYTq9/h7JDC1v6T/PzHJu66he1k62R9GTSIKhf9Ft/GT
        fmXwLlTHtoaP1CDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc6-rt13
Message-ID: <20201130175344.27uunqcpftzpbtle@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc6-rt13 patch set. 

Changes since v5.10-rc6-rt12:

  - John's printk series was updated to his current status.

  - The notifier lock has been made a raw_spinlock_t to avoid a
    acquiring a sleeping lock in atomic context. Patch by Valentin
    Schneider.

  - The lock-lock in zswap lock was not properly initialized since
    v5.9-RT. This was noticed during the investigation of a z3fold
    related failure report Oleksandr Natalenko. According to Mike
    Galbraith this is still broken.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc6-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc6-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc6-rt13

The RT patch against v5.10-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc6-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc6-rt13.tar.xz

Sebastian

diff --git a/include/linux/console.h b/include/linux/console.h
index 9c108b36564b7..e6ff51883dee7 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/printk.h>
 
 struct vc_data;
 struct console_font_op;
@@ -142,7 +143,7 @@ static inline int con_debug_leave(void)
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
-	void	(*write_atomic)(struct console *, const char *, unsigned);
+	void	(*write_atomic)(struct console *co, const char *s, unsigned int count);
 	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
@@ -152,6 +153,9 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
+#ifdef CONFIG_PRINTK
+	char	sync_buf[CONSOLE_LOG_MAX];
+#endif
 	atomic64_t printk_seq;
 	struct task_struct *thread;
 	void	*data;
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 2fb373a5c1ede..723bc2df63882 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -58,7 +58,7 @@ struct notifier_block {
 };
 
 struct atomic_notifier_head {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct notifier_block __rcu *head;
 };
 
@@ -78,7 +78,7 @@ struct srcu_notifier_head {
 };
 
 #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
-		spin_lock_init(&(name)->lock);	\
+		raw_spin_lock_init(&(name)->lock);	\
 		(name)->head = NULL;		\
 	} while (0)
 #define BLOCKING_INIT_NOTIFIER_HEAD(name) do {	\
@@ -95,7 +95,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 		cleanup_srcu_struct(&(name)->srcu);
 
 #define ATOMIC_NOTIFIER_INIT(name) {				\
-		.lock = __SPIN_LOCK_UNLOCKED(name.lock),	\
+		.lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
 		.head = NULL }
 #define BLOCKING_NOTIFIER_INIT(name) {				\
 		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77f66625706e7..a964b42ccb974 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -45,6 +45,7 @@ static inline const char *printk_skip_headers(const char *buffer)
 }
 
 #define CONSOLE_EXT_LOG_MAX	8192
+#define CONSOLE_LOG_MAX		1024
 
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
@@ -475,6 +476,8 @@ extern int kptr_restrict;
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
+bool pr_flush(bool may_sleep, int timeout_ms, bool reset_on_progress);
+
 /*
  * ratelimited messages with local ratelimit_state,
  * no local ratelimit_state used in the !PRINTK case
diff --git a/init/do_mounts.c b/init/do_mounts.c
index b5f9604d0c98a..515e552879dd3 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -457,6 +457,7 @@ void __init mount_block_root(char *name, int flags)
 		printk("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
 		       "explicit textual name for \"root=\" boot option.\n");
 #endif
+		pr_flush(true, 1000, true);
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
 	if (!(flags & SB_RDONLY)) {
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594a..c20782f076432 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -142,9 +142,9 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_register(&nh->head, n);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
@@ -164,9 +164,9 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_unregister(&nh->head, n);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
 }
@@ -182,9 +182,9 @@ int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
 	 * Musn't use RCU; because then the notifier list can
 	 * change between the up and down traversal.
 	 */
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_call_chain_robust(&nh->head, val_up, val_down, v);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
 
 	return ret;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 84186a9acb8a2..dc5da374a005f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -45,11 +45,11 @@
 #include <linux/ctype.h>
 #include <linux/uio.h>
 #include <linux/kthread.h>
+#include <linux/kdb.h>
 #include <linux/clocksource.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
-#include <linux/kdb.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -80,9 +80,6 @@ EXPORT_SYMBOL(ignore_console_lock_warning);
 int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
-/* Set to enable sync mode. Once set, it is never cleared. */
-static bool sync_mode;
-
 /*
  * console_sem protects the console_drivers list, and also
  * provides serialisation for access to the entire console
@@ -339,14 +336,13 @@ enum log_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+#ifdef CONFIG_PRINTK
 /* The syslog_lock protects syslog_* variables. */
 static DEFINE_SPINLOCK(syslog_lock);
-#define syslog_lock_irq() spin_lock_irq(&syslog_lock)
-#define syslog_unlock_irq() spin_unlock_irq(&syslog_lock)
-#define syslog_lock_irqsave(flags) spin_lock_irqsave(&syslog_lock, flags)
-#define syslog_unlock_irqrestore(flags) spin_unlock_irqrestore(&syslog_lock, flags)
 
-#ifdef CONFIG_PRINTK
+/* Set to enable sync mode. Once set, it is never cleared. */
+static bool sync_mode;
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -362,7 +358,7 @@ static atomic64_t clear_seq = ATOMIC64_INIT(0);
 #else
 #define PREFIX_MAX		32
 #endif
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -1355,9 +1351,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		syslog_lock_irq();
+		spin_lock_irq(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
-			syslog_unlock_irq();
+			spin_unlock_irq(&syslog_lock);
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1386,7 +1382,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
-		syslog_unlock_irq();
+		spin_unlock_irq(&syslog_lock);
 
 		if (!n)
 			break;
@@ -1508,9 +1504,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
-		syslog_lock_irq();
+		spin_lock_irq(&syslog_lock);
 		seq = syslog_seq;
-		syslog_unlock_irq();
+		spin_unlock_irq(&syslog_lock);
 		error = wait_event_interruptible(log_wait,
 				prb_read_valid(prb, seq, NULL));
 		if (error)
@@ -1560,7 +1556,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		syslog_lock_irq();
+		spin_lock_irq(&syslog_lock);
 		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
 			syslog_seq = prb_first_valid_seq(prb);
@@ -1587,7 +1583,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
-		syslog_unlock_irq();
+		spin_unlock_irq(&syslog_lock);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -1606,129 +1602,6 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
-/*
- * The per-cpu sprint buffers are used with interrupts disabled, so each CPU
- * only requires 2 buffers: for non-NMI and NMI contexts. Recursive printk()
- * calls are handled by the global sprint buffers.
- */
-#define SPRINT_CTX_DEPTH 2
-
-/* Static sprint buffers for early boot (only 1 CPU) and recursion. */
-static DECLARE_BITMAP(sprint_global_buffer_map, SPRINT_CTX_DEPTH);
-static char sprint_global_buffer[SPRINT_CTX_DEPTH][PREFIX_MAX + LOG_LINE_MAX];
-
-struct sprint_buffers {
-	char		buf[SPRINT_CTX_DEPTH][PREFIX_MAX + LOG_LINE_MAX];
-	atomic_t	index;
-};
-
-static DEFINE_PER_CPU(struct sprint_buffers, percpu_sprint_buffers);
-
-/*
- * Acquire an unused buffer, returning its index. If no buffer is
- * available, @count is returned.
- */
-static int _get_sprint_buf(unsigned long *map, int count)
-{
-	int index;
-
-	do {
-		index = find_first_zero_bit(map, count);
-		if (index == count)
-			break;
-	/*
-	 * Guarantee map changes are ordered for the other CPUs.
-	 * Pairs with clear_bit() in _put_sprint_buf().
-	 */
-	} while (test_and_set_bit(index, map));
-
-	return index;
-}
-
-/* Mark the buffer @index as unused. */
-static void _put_sprint_buf(unsigned long *map, unsigned int count, unsigned int index)
-{
-	/*
-	 * Guarantee map changes are ordered for the other CPUs.
-	 * Pairs with test_and_set_bit() in _get_sprint_buf().
-	 */
-	clear_bit(index, map);
-}
-
-/*
- * Get a buffer sized PREFIX_MAX+LOG_LINE_MAX for sprinting. On success, @id
- * is set and interrupts are disabled. @id is used to put back the buffer.
- *
- * @id is non-negative for per-cpu buffers, negative for global buffers.
- */
-static char *get_sprint_buf(int *id, unsigned long *flags)
-{
-	struct sprint_buffers *bufs;
-	unsigned int index;
-	unsigned int cpu;
-
-	local_irq_save(*flags);
-	cpu = get_cpu();
-
-	if (printk_percpu_data_ready()) {
-
-		/*
-		 * First try with per-cpu pool. Note that the last
-		 * buffer is reserved for NMI context.
-		 */
-		bufs = per_cpu_ptr(&percpu_sprint_buffers, cpu);
-		index = atomic_read(&bufs->index);
-		if (index < (SPRINT_CTX_DEPTH - 1) ||
-		    (in_nmi() && index < SPRINT_CTX_DEPTH)) {
-			atomic_set(&bufs->index, index + 1);
-			*id = cpu;
-			return &bufs->buf[index][0];
-		}
-	}
-
-	/*
-	 * Fallback to global pool.
-	 *
-	 * The global pool will only ever be used if per-cpu data is not ready
-	 * yet or printk recurses. Recursion will not occur unless printk is
-	 * having internal issues.
-	 */
-	index = _get_sprint_buf(sprint_global_buffer_map, SPRINT_CTX_DEPTH);
-	if (index != SPRINT_CTX_DEPTH) {
-		/* Convert to global buffer representation. */
-		*id = -index - 1;
-		return &sprint_global_buffer[index][0];
-	}
-
-	/* Failed to get a buffer. */
-	put_cpu();
-	local_irq_restore(*flags);
-	return NULL;
-}
-
-/* Put back an sprint buffer and restore interrupts. */
-static void put_sprint_buf(int id, unsigned long flags)
-{
-	struct sprint_buffers *bufs;
-	unsigned int index;
-	unsigned int cpu;
-
-	if (id >= 0) {
-		cpu = id;
-		bufs = per_cpu_ptr(&percpu_sprint_buffers, cpu);
-		index = atomic_read(&bufs->index);
-		atomic_set(&bufs->index, index - 1);
-	} else {
-		/* Convert from global buffer representation. */
-		index = -id - 1;
-		_put_sprint_buf(sprint_global_buffer_map,
-				SPRINT_CTX_DEPTH, index);
-	}
-
-	put_cpu();
-	local_irq_restore(flags);
-}
-
 int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(int level)
@@ -1803,20 +1676,20 @@ static bool have_atomic_console(void)
 	return false;
 }
 
-static bool print_sync(struct console *con, char *buf, size_t buf_size, u64 *seq)
+static bool print_sync(struct console *con, u64 *seq)
 {
 	struct printk_info info;
 	struct printk_record r;
 	size_t text_len;
 
-	prb_rec_init_rd(&r, &info, buf, buf_size);
+	prb_rec_init_rd(&r, &info, &con->sync_buf[0], sizeof(con->sync_buf));
 
 	if (!prb_read_valid(prb, *seq, &r))
 		return false;
 
 	text_len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 
-	if (!call_sync_console_driver(con, buf, text_len))
+	if (!call_sync_console_driver(con, &con->sync_buf[0], text_len))
 		return false;
 
 	*seq = r.info->seq;
@@ -1832,7 +1705,7 @@ static bool print_sync(struct console *con, char *buf, size_t buf_size, u64 *seq
 	return true;
 }
 
-static void print_sync_until(u64 seq, struct console *con, char *buf, size_t buf_size)
+static void print_sync_until(struct console *con, u64 seq)
 {
 	unsigned int flags;
 	u64 printk_seq;
@@ -1840,7 +1713,7 @@ static void print_sync_until(u64 seq, struct console *con, char *buf, size_t buf
 	if (!con) {
 		for_each_console(con) {
 			if (console_can_sync(con))
-				print_sync_until(seq, con, buf, buf_size);
+				print_sync_until(con, seq);
 		}
 		return;
 	}
@@ -1850,19 +1723,106 @@ static void print_sync_until(u64 seq, struct console *con, char *buf, size_t buf
 		printk_seq = atomic64_read(&con->printk_seq);
 		if (printk_seq >= seq)
 			break;
-		if (!print_sync(con, buf, buf_size, &printk_seq))
+		if (!print_sync(con, &printk_seq))
 			break;
 		atomic64_set(&con->printk_seq, printk_seq + 1);
 	}
 	console_atomic_unlock(flags);
 }
 
+#ifdef CONFIG_PRINTK_NMI
+#define NUM_RECURSION_CTX 2
+#else
+#define NUM_RECURSION_CTX 1
+#endif
+
+struct printk_recursion {
+	char	count[NUM_RECURSION_CTX];
+};
+
+static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
+static char printk_recursion_count[NUM_RECURSION_CTX];
+
+static char *get_printk_count(void)
+{
+	struct printk_recursion *rec;
+	char *count;
+
+	if (!printk_percpu_data_ready()) {
+		count = &printk_recursion_count[0];
+	} else {
+		rec = this_cpu_ptr(&percpu_printk_recursion);
+
+		count = &rec->count[0];
+	}
+
+#ifdef CONFIG_PRINTK_NMI
+	if (in_nmi())
+		count++;
+#endif
+
+	return count;
+}
+
+static bool printk_enter(unsigned long *flags)
+{
+	char *count;
+
+	local_irq_save(*flags);
+	count = get_printk_count();
+	/* Only 1 level of recursion allowed. */
+	if (*count > 1) {
+		local_irq_restore(*flags);
+		return false;
+	}
+	(*count)++;
+
+	return true;
+}
+
+static void printk_exit(unsigned long flags)
+{
+	char *count;
+
+	count = get_printk_count();
+	(*count)--;
+	local_irq_restore(flags);
+}
+
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
 		0x80000000 + raw_smp_processor_id();
 }
 
+static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
+			 const char *fmt, va_list args)
+{
+	char *orig_text = text;
+	u16 text_len;
+
+	text_len = vscnprintf(text, size, fmt, args);
+
+	/* Mark and strip a trailing newline. */
+	if (text_len && text[text_len - 1] == '\n') {
+		text_len--;
+		*lflags |= LOG_NEWLINE;
+	}
+
+	/* Strip kernel syslog prefix. */
+	if (facility == 0) {
+		while (text_len >= 2 && printk_get_level(text)) {
+			text_len -= 2;
+			text += 2;
+		}
+
+		if (text != orig_text)
+			memmove(orig_text, text, text_len);
+	}
+
+	return text_len;
+}
+
 __printf(4, 0)
 static int vprintk_store(int facility, int level,
 			 const struct dev_printk_info *dev_info,
@@ -1872,40 +1832,40 @@ static int vprintk_store(int facility, int level,
 	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
 	bool final_commit = false;
-	unsigned long irqflags;
 	struct printk_record r;
+	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
-	int sprint_id;
+	char lvlbuf[8];
+	va_list args2;
 	u16 text_len;
-	u64 ts_nsec;
 	int ret = 0;
-	char *text;
+	u64 ts_nsec;
 	u64 seq;
 
 	ts_nsec = local_clock();
 
-	/* No buffer is available if printk has recursed too much. */
-	text = get_sprint_buf(&sprint_id, &irqflags);
-	if (!text)
+	if (!printk_enter(&irqflags))
 		return 0;
 
+	va_copy(args2, args);
+
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
 	 */
-	text_len = vscnprintf(text, LOG_LINE_MAX, fmt, args);
+	text_len = vsnprintf(&lvlbuf[0], sizeof(lvlbuf), fmt, args) + 1;
+	if (text_len > CONSOLE_LOG_MAX)
+		text_len = CONSOLE_LOG_MAX;
 
-	/* mark and strip a trailing newline */
-	if (text_len && text[text_len-1] == '\n') {
-		text_len--;
-		lflags |= LOG_NEWLINE;
-	}
-
-	/* strip kernel syslog prefix and extract log level or control flags */
+	/* Extract log level or control flags. */
 	if (facility == 0) {
 		int kern_level;
+		int i;
 
-		while ((kern_level = printk_get_level(text)) != 0) {
+		for (i = 0; i < sizeof(lvlbuf); i += 2) {
+			kern_level = printk_get_level(&lvlbuf[i]);
+			if (!kern_level)
+				break;
 			switch (kern_level) {
 			case '0' ... '7':
 				if (level == LOGLEVEL_DEFAULT)
@@ -1914,9 +1874,6 @@ static int vprintk_store(int facility, int level,
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
 			}
-
-			text_len -= 2;
-			text += 2;
 		}
 	}
 
@@ -1930,8 +1887,10 @@ static int vprintk_store(int facility, int level,
 		prb_rec_init_wr(&r, text_len);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
 			seq = r.info->seq;
-			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			text_len = printk_sprint(&r.text_buf[r.info->text_len], text_len,
+						 facility, &lflags, fmt, args2);
 			r.info->text_len += text_len;
+
 			if (lflags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
 				prb_final_commit(&e);
@@ -1939,20 +1898,18 @@ static int vprintk_store(int facility, int level,
 			} else {
 				prb_commit(&e);
 			}
+
 			ret = text_len;
 			goto out;
 		}
 	}
 
-	/* Store it in the record log */
-
 	prb_rec_init_wr(&r, text_len);
-
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
 		truncate_msg(&text_len, &trunc_msg_len);
+
 		prb_rec_init_wr(&r, text_len + trunc_msg_len);
-		/* survive when the log buffer is too small for trunc_msg */
 		if (!prb_reserve(&e, prb, &r))
 			goto out;
 	}
@@ -1960,7 +1917,7 @@ static int vprintk_store(int facility, int level,
 	seq = r.info->seq;
 
 	/* fill message */
-	memcpy(&r.text_buf[0], text, text_len);
+	text_len = printk_sprint(&r.text_buf[0], text_len, facility, &lflags, fmt, args2);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
@@ -1972,8 +1929,8 @@ static int vprintk_store(int facility, int level,
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
-	/* insert message */
-	if ((lflags & LOG_CONT) || !(lflags & LOG_NEWLINE)) {
+	/* A message without a trailing newline can be continued. */
+	if (!(lflags & LOG_NEWLINE)) {
 		prb_commit(&e);
 	} else {
 		prb_final_commit(&e);
@@ -1984,9 +1941,10 @@ static int vprintk_store(int facility, int level,
 out:
 	/* only the kernel may perform synchronous printing */
 	if (facility == 0 && final_commit && any_console_can_sync())
-		print_sync_until(seq + 1, NULL, text, PREFIX_MAX + LOG_LINE_MAX);
+		print_sync_until(NULL, seq + 1);
 
-	put_sprint_buf(sprint_id, irqflags);
+	va_end(args2);
+	printk_exit(irqflags);
 	return ret;
 }
 
@@ -2010,7 +1968,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(vprintk_emit);
 
- __printf(1, 0)
+__printf(1, 0)
 static int vprintk_default(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
@@ -2067,6 +2025,153 @@ asmlinkage __visible int printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(printk);
 
+static int printk_kthread_func(void *data)
+{
+	struct console *con = data;
+	unsigned long dropped = 0;
+	char *dropped_text = NULL;
+	struct printk_info info;
+	struct printk_record r;
+	char *ext_text = NULL;
+	size_t dropped_len;
+	int ret = -ENOMEM;
+	char *text = NULL;
+	char *write_text;
+	u64 printk_seq;
+	size_t len;
+	int error;
+	u64 seq;
+
+	if (con->flags & CON_EXTENDED) {
+		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!ext_text)
+			goto out;
+	}
+	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	dropped_text = kmalloc(64, GFP_KERNEL);
+	if (!text || !dropped_text)
+		goto out;
+
+	if (con->flags & CON_EXTENDED)
+		write_text = ext_text;
+	else
+		write_text = text;
+
+	seq = atomic64_read(&con->printk_seq);
+
+	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+
+	for (;;) {
+		error = wait_event_interruptible(log_wait,
+				prb_read_valid(prb, seq, &r) || kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		if (error)
+			continue;
+
+		if (seq != r.info->seq) {
+			dropped += r.info->seq - seq;
+			seq = r.info->seq;
+		}
+
+		seq++;
+
+		if (!(con->flags & CON_ENABLED))
+			continue;
+
+		if (suppress_message_printing(r.info->level))
+			continue;
+
+		if (con->flags & CON_EXTENDED) {
+			len = info_print_ext_header(ext_text,
+				CONSOLE_EXT_LOG_MAX,
+				r.info);
+			len += msg_print_ext_body(ext_text + len,
+				CONSOLE_EXT_LOG_MAX - len,
+				&r.text_buf[0], r.info->text_len,
+				&r.info->dev_info);
+		} else {
+			len = record_print_text(&r,
+				console_msg_format & MSG_FORMAT_SYSLOG,
+				printk_time);
+		}
+
+		printk_seq = atomic64_read(&con->printk_seq);
+
+		console_lock();
+		console_may_schedule = 0;
+
+		if (kernel_sync_mode() && con->write_atomic) {
+			console_unlock();
+			break;
+		}
+
+		if (!(con->flags & CON_EXTENDED) && dropped) {
+			dropped_len = snprintf(dropped_text, 64,
+					       "** %lu printk messages dropped **\n",
+					       dropped);
+			dropped = 0;
+
+			con->write(con, dropped_text, dropped_len);
+			printk_delay(r.info->level);
+		}
+
+		con->write(con, write_text, len);
+		if (len)
+			printk_delay(r.info->level);
+
+		atomic64_cmpxchg_relaxed(&con->printk_seq, printk_seq, seq);
+
+		console_unlock();
+	}
+out:
+	kfree(dropped_text);
+	kfree(text);
+	kfree(ext_text);
+	pr_info("%sconsole [%s%d]: printing thread stopped\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+	return ret;
+}
+
+/* Must be called within console_lock(). */
+static void start_printk_kthread(struct console *con)
+{
+	con->thread = kthread_run(printk_kthread_func, con,
+				  "pr/%s%d", con->name, con->index);
+	if (IS_ERR(con->thread)) {
+		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
+			(con->flags & CON_BOOT) ? "boot" : "",
+			con->name, con->index);
+		return;
+	}
+	pr_info("%sconsole [%s%d]: printing thread started\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+}
+
+/* protected by console_lock */
+static bool kthreads_started;
+
+/* Must be called within console_lock(). */
+static void console_try_thread(struct console *con)
+{
+	if (kthreads_started) {
+		start_printk_kthread(con);
+		return;
+	}
+
+	/*
+	 * The printing threads have not been started yet. If this console
+	 * can print synchronously, print all unprinted messages.
+	 */
+
+	if (console_can_sync(con))
+		print_sync_until(con, prb_next_seq(prb));
+}
+
 #else /* CONFIG_PRINTK */
 
 #define LOG_LINE_MAX		0
@@ -2075,25 +2180,11 @@ EXPORT_SYMBOL(printk);
 
 #define prb_read_valid(rb, seq, r)	false
 #define prb_first_valid_seq(rb)		0
+#define prb_next_seq(rb)		0
 
-static u64 syslog_seq;
+#define kernel_sync_mode()	false
 
-static size_t record_print_text(const struct printk_record *r,
-				bool syslog, bool time)
-{
-	return 0;
-}
-static ssize_t info_print_ext_header(char *buf, size_t size,
-				     struct printk_info *info)
-{
-	return 0;
-}
-static ssize_t msg_print_ext_body(char *buf, size_t size,
-				  char *text, size_t text_len,
-				  struct dev_printk_info *dev_info) { return 0; }
-static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len) {}
-static bool suppress_message_printing(int level) { return false; }
+#define console_try_thread(con)
 
 #endif /* CONFIG_PRINTK */
 
@@ -2531,8 +2622,6 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 	return -ENOENT;
 }
 
-static void console_try_thread(struct console *con);
-
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2770,154 +2859,6 @@ void __init console_init(void)
 	}
 }
 
-static int printk_kthread_func(void *data)
-{
-	struct console *con = data;
-	unsigned long dropped = 0;
-	struct printk_info info;
-	struct printk_record r;
-	char *ext_text = NULL;
-	size_t dropped_len;
-	char *dropped_text;
-	int ret = -ENOMEM;
-	char *write_text;
-	u64 printk_seq;
-	size_t len;
-	char *text;
-	int error;
-	u64 seq;
-
-	if (con->flags & CON_EXTENDED) {
-		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
-		if (!ext_text)
-			return ret;
-	}
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	dropped_text = kmalloc(64, GFP_KERNEL);
-	if (!text || !dropped_text)
-		goto out;
-
-	if (con->flags & CON_EXTENDED)
-		write_text = ext_text;
-	else
-		write_text = text;
-
-	seq = atomic64_read(&con->printk_seq);
-
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
-
-	for (;;) {
-		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, seq, &r) || kthread_should_stop());
-
-		if (kthread_should_stop())
-			break;
-
-		if (error)
-			continue;
-
-		if (seq != r.info->seq) {
-			dropped += r.info->seq - seq;
-			seq = r.info->seq;
-		}
-
-		seq++;
-
-		if (!(con->flags & CON_ENABLED))
-			continue;
-
-		if (suppress_message_printing(r.info->level))
-			continue;
-
-		if (con->flags & CON_EXTENDED) {
-			len = info_print_ext_header(ext_text,
-				CONSOLE_EXT_LOG_MAX,
-				r.info);
-			len += msg_print_ext_body(ext_text + len,
-				CONSOLE_EXT_LOG_MAX - len,
-				&r.text_buf[0], r.info->text_len,
-				&r.info->dev_info);
-		} else {
-			len = record_print_text(&r,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time);
-		}
-
-		printk_seq = atomic64_read(&con->printk_seq);
-
-		console_lock();
-		console_may_schedule = 0;
-
-		if (kernel_sync_mode() && con->write_atomic) {
-			console_unlock();
-			break;
-		}
-
-		if (!(con->flags & CON_EXTENDED) && dropped) {
-			dropped_len = snprintf(dropped_text, 64,
-					       "** %lu printk messages dropped **\n",
-					       dropped);
-			dropped = 0;
-
-			con->write(con, dropped_text, dropped_len);
-			printk_delay(r.info->level);
-		}
-
-		con->write(con, write_text, len);
-		if (len)
-			printk_delay(r.info->level);
-
-		atomic64_cmpxchg_relaxed(&con->printk_seq, printk_seq, seq);
-
-		console_unlock();
-	}
-out:
-	kfree(dropped_text);
-	kfree(text);
-	kfree(ext_text);
-	pr_info("%sconsole [%s%d]: printing thread stopped\n",
-		(con->flags & CON_BOOT) ? "boot" : "" ,
-		con->name, con->index);
-	return ret;
-}
-
-static void start_printk_kthread(struct console *con)
-{
-	con->thread = kthread_run(printk_kthread_func, con,
-				  "pr/%s%d", con->name, con->index);
-	if (IS_ERR(con->thread)) {
-		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
-			(con->flags & CON_BOOT) ? "boot" : "" ,
-			con->name, con->index);
-		return;
-	}
-	pr_info("%sconsole [%s%d]: printing thread started\n",
-		(con->flags & CON_BOOT) ? "boot" : "" ,
-		con->name, con->index);
-}
-
-static bool kthreads_started;
-
-static void console_try_thread(struct console *con)
-{
-	unsigned long irqflags;
-	int sprint_id;
-	char *buf;
-
-	if (kthreads_started) {
-		start_printk_kthread(con);
-		return;
-	}
-
-	buf = get_sprint_buf(&sprint_id, &irqflags);
-	if (!buf)
-		return;
-
-	print_sync_until(prb_next_seq(prb), con, buf, PREFIX_MAX + LOG_LINE_MAX);
-
-	put_sprint_buf(sprint_id, irqflags);
-}
-
 /*
  * Some boot consoles access data that is in the init section and which will
  * be discarded after the initcalls have been run. To make sure that no code
@@ -2958,11 +2899,13 @@ static int __init printk_late_init(void)
 		}
 	}
 
+#ifdef CONFIG_PRINTK
 	console_lock();
 	for_each_console(con)
 		start_printk_kthread(con);
 	kthreads_started = true;
 	console_unlock();
+#endif
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
@@ -3162,6 +3105,12 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 			sync_mode = true;
 			pr_info("enabled sync mode\n");
 		}
+
+		/*
+		 * Give the printing threads time to flush, allowing up to 1
+		 * second of no printing forward progress before giving up.
+		 */
+		pr_flush(false, 100, true);
 	}
 
 	rcu_read_lock();
@@ -3339,7 +3288,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
 
-	/* Keep track of the last message for the next interation. */
+	/* Keep track of the last message for the next iteration. */
 	next_seq = seq;
 
 	prb_rec_init_rd(&r, &info, buf, size);
@@ -3493,3 +3442,75 @@ void console_atomic_unlock(unsigned int flags)
 	prb_unlock(&printk_cpulock, flags);
 }
 EXPORT_SYMBOL(console_atomic_unlock);
+
+static void pr_msleep(bool may_sleep, int ms)
+{
+	if (may_sleep) {
+		msleep(ms);
+	} else {
+		while (ms--)
+			udelay(1000);
+	}
+}
+
+/**
+ * pr_flush() - Wait for printing threads to catch up.
+ *
+ * @may_sleep:         Context allows msleep() calls.
+ * @timeout_ms:        The maximum time (in ms) to wait.
+ * @reset_on_progress: Reset the timeout if forward progress is seen.
+ *
+ * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
+ * represents infinite waiting.
+ *
+ * If @reset_on_progress is true, the timeout will be reset whenever any
+ * printer has been seen to make some forward progress.
+ *
+ * Context: Any context if @timeout_ms is 0 or @may_sleep is false. Otherwise
+ * process context.
+ * Return: true if all enabled printers are caught up.
+ */
+bool pr_flush(bool may_sleep, int timeout_ms, bool reset_on_progress)
+{
+	int remaining = timeout_ms;
+	struct console *con;
+	u64 last_diff = 0;
+	u64 printk_seq;
+	u64 diff;
+	u64 seq;
+
+	seq = prb_next_seq(prb);
+
+	for (;;) {
+		diff = 0;
+
+		for_each_console(con) {
+			if (!(con->flags & CON_ENABLED))
+				continue;
+			printk_seq = atomic64_read(&con->printk_seq);
+			if (printk_seq < seq)
+				diff += seq - printk_seq;
+		}
+
+		if (diff != last_diff && reset_on_progress)
+			remaining = timeout_ms;
+
+		if (!diff || remaining == 0)
+			break;
+
+		if (remaining < 0) {
+			pr_msleep(may_sleep, 100);
+		} else if (remaining < 100) {
+			pr_msleep(may_sleep, remaining);
+			remaining = 0;
+		} else {
+			pr_msleep(may_sleep, 100);
+			remaining -= 100;
+		}
+
+		last_diff = diff;
+	}
+
+	return (diff == 0);
+}
+EXPORT_SYMBOL(pr_flush);
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
diff --git a/mm/zswap.c b/mm/zswap.c
index 78a20f7b00f2c..b24f761b9241c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -394,7 +394,9 @@ struct zswap_comp {
 	u8 *dstmem;
 };
 
-static DEFINE_PER_CPU(struct zswap_comp, zswap_comp);
+static DEFINE_PER_CPU(struct zswap_comp, zswap_comp) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 static int zswap_dstmem_prepare(unsigned int cpu)
 {
