Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131041C6887;
	Tue, 27 Aug 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770029; cv=none; b=D7MeQJWxZQRRnydK8QFdS8SHsPcOZQJamslqAfheWIWl+TsaIL9fWwiXMQrdtrjVN7QJ5pcydNTsV22weG+Nq1KE6lPineFMfHyw1nxejmUz35wn6EAG31AgvwQpzS3MbiOADwlxHV1dDtU7K8W2SOt4Ols5IUyUxp0l37QaECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770029; c=relaxed/simple;
	bh=yoWBNZ+qOhy/eXS3Ap6ctKWNgbOM4IG/Vh/rinf6NR0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GshB1NmWq5DLZLsTaX0Tr4UNusGd+Nm0csMRga99aD3rcm2v19hfrq6uTE119czuPa9V3zDGZqFe/CxcGgvfQJlLurUXaANHZGYkFFW56/yCDdCQeyNQHnLiLy4bcfpklUUskaaS/MrPyoK62rteQbJ2fJTw9eCb76leZ0Uv7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEP4JylE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxVQ+8HY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEP4JylE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxVQ+8HY"
Date: Tue, 27 Aug 2024 16:47:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724770023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=afOgByPkUS61bny5tG0CWDGID9tncmfXkt4rg0BSCBo=;
	b=nEP4JylEpsvzN+14OXVLZqvw6WPQiIBP4rgBW3prWD7TSXv9/peFxyzlc/Iy1dIbe0h2hk
	2kmJrm7ubWlw3Hxi/5vrLL/fDNKy0+wTGdzQquV3ll3IJJJQ2lUccD9DVlw/jIHTGSHgjU
	QecZpWCbgNVoslVsHLyWprBX91xy0zFUXWnYsvUxSm0lMEhTXCiNgKktz61uAeoIXPTlb9
	WTLWyFpIJylGxFokpPPr9JJr4GCQ1O5T74klTGC3r0eQEsaHYzLb4SH3ri5R6ZR/li70+i
	aZiBpIHzIlsq0VyH8t9BxVjVtEb07eykwGftOjvEz7M5QJmnOS/TlHoMnytxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724770023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=afOgByPkUS61bny5tG0CWDGID9tncmfXkt4rg0BSCBo=;
	b=bxVQ+8HY5bPbdCwqSwMu9JqxbZbJRI3te3xhHpPyfno1DJbPq576sEdiKRPG0Io9Ocmaqh
	+HlB+FGZ43C3irCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.11-rc5-rt5
Message-ID: <20240827144701.PP28eyZv@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.11-rc5-rt5 patch set. 

Changes since v6.11-rc5-rt4:

  - Update John's printk series:

    - Removed "threadprintk" boot argument to force threaded printing of
      legacy console drivers on !CONFIG_PREEMPT_RT.

    - Reverted delayed flushing in emergency mode. For non-panic emergencies
      (WARN, RCU stall, lockdep splat) the emergency message lines are now
      printed synchronously, rather than buffering the full emergency
      message block and then flushing synchronously.
    
    - Switched to the lockless RCU API when detecting if printk threads are
      waiting.
    
    - Re-implemented logic for determining the flush type into a common
      helper function to provide consistent flushing behavior.
    
    - Re-implemented kthread starting/stopping for clean and reliable
      transitions between atomic and threaded printing.

  - Use lockless stats for nft_counter (netfilter).

Known issues
    None.

The delta patch against v6.11-rc5-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/incr/patch-6.11-rc5-rt4-rt5.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.11-rc5-rt5

The RT patch against v6.11-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patch-6.11-rc5-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patches-6.11-rc5-rt5.tar.xz

Sebastian

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 62c814247d7f5..09126bb8cc9ff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6618,18 +6618,6 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
-	threadprintk	[KNL]
-			Force threaded printing of all legacy consoles. Be
-			aware that with this option, the shutdown, reboot, and
-			panic messages may not be printed on the legacy
-			consoles. Also, earlycon/earlyprintk printing will be
-			delayed until a regular console or the kthread is
-			available.
-
-			Users can view /proc/consoles to see if their console
-			driver is legacy or not. Non-legacy (NBCON) console
-			drivers are already threaded and are shown with 'N'.
-
 	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a4e117aad74df..0fef37b6219df 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3492,23 +3492,23 @@ void serial8250_console_write_thread(struct uart_8250_port *up,
 		 */
 		for (i = 0; i < len; i++) {
 			if (!nbcon_enter_unsafe(wctxt)) {
-				nbcon_reacquire(wctxt);
+				nbcon_reacquire_nobuf(wctxt);
 				break;
 			}
 
 			uart_console_write(port, wctxt->outbuf + i, 1, serial8250_console_putchar);
 
 			if (!nbcon_exit_unsafe(wctxt)) {
-				nbcon_reacquire(wctxt);
+				nbcon_reacquire_nobuf(wctxt);
 				break;
 			}
 		}
 	} else {
-		nbcon_reacquire(wctxt);
+		nbcon_reacquire_nobuf(wctxt);
 	}
 
 	while (!nbcon_enter_unsafe(wctxt))
-		nbcon_reacquire(wctxt);
+		nbcon_reacquire_nobuf(wctxt);
 
 	/* Finally, wait for transmitter to become empty and restore IER. */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c9c914bc033c9..9140825e810f8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3567,13 +3567,8 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (c->flags & CON_NBCON) {
-			if (!c->write_atomic && !c->write_thread)
-				continue;
-		} else {
-			if (!c->write)
-				continue;
-		}
+		if (!(c->flags & CON_NBCON) && !c->write)
+			continue;
 		if ((c->flags & CON_ENABLED) == 0)
 			continue;
 		cs[i++] = c;
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index c3c01ec2273c5..b7cab1ad990da 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -28,7 +28,6 @@ static int show_console_dev(struct seq_file *m, void *v)
 	};
 	char flags[ARRAY_SIZE(con_flags) + 1];
 	struct console *con = v;
-	char con_write = '-';
 	unsigned int a;
 	dev_t dev = 0;
 
@@ -59,14 +58,8 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_setwidth(m, 21 - 1);
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
-	if (con->flags & CON_NBCON) {
-		if (con->write_atomic || con->write_thread)
-			con_write = 'W';
-	} else {
-		if (con->write)
-			con_write = 'W';
-	}
-	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-', con_write,
+	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
+		   ((con->flags & CON_NBCON) || con->write) ? 'W' : '-',
 		   con->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
diff --git a/include/linux/console.h b/include/linux/console.h
index 96c0923d023b8..eba367bf605da 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -355,7 +355,7 @@ struct console {
 	/**
 	 * @write_atomic:
 	 *
-	 * NBCON callback to write out text in any context.
+	 * NBCON callback to write out text in any context. (Optional)
 	 *
 	 * This callback is called with the console already acquired. However,
 	 * a higher priority context is allowed to take it over by default.
@@ -373,8 +373,8 @@ struct console {
 	 * The callback should allow the takeover whenever it is safe. It
 	 * increases the chance to see messages when the system is in trouble.
 	 * If the driver must reacquire ownership in order to finalize or
-	 * revert hardware changes, nbcon_reacquire() can be used. However,
-	 * on reacquire the buffer content is no longer available. A
+	 * revert hardware changes, nbcon_reacquire_nobuf() can be used.
+	 * However, on reacquire the buffer content is no longer available. A
 	 * reacquire cannot be used to resume printing.
 	 *
 	 * The callback can be called from any context (including NMI).
@@ -388,19 +388,29 @@ struct console {
 	 *
 	 * NBCON callback to write out text in task context.
 	 *
-	 * This callback is called after device_lock() and with the nbcon
-	 * console acquired. Any necessary driver synchronization should have
-	 * been performed by the device_lock() callback.
+	 * This callback must be called only in task context with both
+	 * device_lock() and the nbcon console acquired with
+	 * NBCON_PRIO_NORMAL.
 	 *
-	 * This callback is always called from task context but with migration
-	 * disabled.
+	 * The same rules for console ownership verification and unsafe
+	 * sections handling applies as with write_atomic().
 	 *
-	 * The same criteria for console ownership verification and unsafe
-	 * sections applies as with write_atomic(). The difference between
-	 * this callback and write_atomic() is that this callback is used
-	 * during normal operation and is always called from task context.
-	 * This allows drivers to operate in their own locking context for
-	 * synchronizing output to the hardware.
+	 * The console ownership handling is necessary for synchronization
+	 * against write_atomic() which is synchronized only via the context.
+	 *
+	 * The device_lock() provides the primary serialization for operations
+	 * on the device. It might be as relaxed (mutex)[*] or as tight
+	 * (disabled preemption and interrupts) as needed. It allows
+	 * the kthread to operate in the least restrictive mode[**].
+	 *
+	 * [*] Standalone nbcon_context_try_acquire() is not safe with
+	 *     the preemption enabled, see nbcon_owner_matches(). But it
+	 *     can be safe when always called in the preemptive context
+	 *     under the device_lock().
+	 *
+	 * [**] The device_lock() makes sure that nbcon_context_try_acquire()
+	 *      would never need to spin which is important especially with
+	 *      PREEMPT_RT.
 	 */
 	void (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
 
@@ -591,19 +601,17 @@ static inline bool console_is_registered(const struct console *con)
 #ifdef CONFIG_PRINTK
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
-extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
-extern void nbcon_reacquire(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
-static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
-static inline void nbcon_reacquire(struct nbcon_write_context *wctxt) { }
+static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2a40d788034e6..eca9bb2ee637b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -283,7 +283,6 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
-
 static inline void console_try_replay_all(void)
 {
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e7b85f5fd98ee..7963deac33c31 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6703,7 +6703,6 @@ void debug_show_all_locks(void)
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);
-		nbcon_cpu_emergency_flush();
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ee8dde765fbc0..3fcb48502adbd 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,7 +3,6 @@
  * internal.h - printk internal definitions
  */
 #include <linux/console.h>
-#include <linux/jump_label.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
 
@@ -22,11 +21,17 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 		(con->flags & CON_BOOT) ? "boot" : "",		\
 		con->name, con->index, ##__VA_ARGS__)
 
+/*
+ * Identify if legacy printing is forced in a dedicated kthread. If
+ * true, all printing via console lock occurs within a dedicated
+ * legacy printer thread. The only exception is on panic, after the
+ * nbcon consoles have had their chance to print the panic messages
+ * first.
+ */
 #ifdef CONFIG_PREEMPT_RT
-# define force_printkthreads()		(true)
+# define force_legacy_kthread()	(true)
 #else
-DECLARE_STATIC_KEY_FALSE(force_printkthreads_key);
-# define force_printkthreads()		(static_branch_unlikely(&force_printkthreads_key))
+# define force_legacy_kthread()	(false)
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -56,7 +61,7 @@ struct printk_ringbuffer;
 struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
-extern bool printk_threads_enabled;
+extern bool printk_kthreads_running;
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -84,8 +89,7 @@ bool printk_percpu_data_ready(void);
 	} while (0)
 
 void defer_console_output(void);
-
-bool is_printk_deferred(void);
+bool is_printk_legacy_deferred(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
@@ -95,15 +99,14 @@ int console_lock_spinning_disable_and_check(int cookie);
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie, bool use_atomic);
-void nbcon_kthread_create(struct console *con);
-void nbcon_wake_threads(void);
-void nbcon_legacy_kthread_create(void);
+bool nbcon_kthread_create(struct console *con);
+void nbcon_kthread_stop(struct console *con);
+void nbcon_kthreads_wake(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -120,13 +123,16 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 		return false;
 
 	if (flags & CON_NBCON) {
-		if (use_atomic) {
-			if (!con->write_atomic)
-				return false;
-		} else {
-			if (!con->write_thread)
-				return false;
-		}
+		/* The write_atomic() callback is optional. */
+		if (use_atomic && !con->write_atomic)
+			return false;
+
+		/*
+		 * For the !use_atomic case, @printk_kthreads_running is not
+		 * checked because the write_thread() callback is also used
+		 * via the legacy loop when the printer threads are not
+		 * available.
+		 */
 	} else {
 		if (!con->write)
 			return false;
@@ -144,8 +150,8 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 }
 
 /**
- * nbcon_kthread_wake - Wake up a printk thread
- * @con:        Console to operate on
+ * nbcon_kthread_wake - Wake up a console printing thread
+ * @con:	Console to operate on
  */
 static inline void nbcon_kthread_wake(struct console *con)
 {
@@ -169,9 +175,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
 
-static inline void nbcon_kthread_wake(struct console *con) { }
-static inline void nbcon_kthread_create(struct console *con) { }
-#define printk_threads_enabled (false)
+#define printk_kthreads_running (false)
 
 /*
  * In !PRINTK builds we still export console_sem
@@ -182,15 +186,18 @@ static inline void nbcon_kthread_create(struct console *con) { }
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline void defer_console_output(void) { }
+static inline bool is_printk_legacy_deferred(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie, bool use_atomic) { return false; }
+static inline void nbcon_kthread_wake(struct console *con) { }
+static inline void nbcon_kthreads_wake(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
@@ -198,15 +205,99 @@ static inline bool console_is_usable(struct console *con, short flags,
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool have_nbcon_console;
 extern bool have_legacy_console;
+extern bool legacy_allow_panic_sync;
+
+/**
+ * struct console_flush_type - Define available console flush methods
+ * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @nbcon_offload:	Offload flush to printer thread
+ * @legacy_direct:	Call the legacy loop in this context
+ * @legacy_offload:	Offload the legacy loop into IRQ or legacy thread
+ *
+ * Note that the legacy loop also flushes the nbcon consoles.
+ */
+struct console_flush_type {
+	bool	nbcon_atomic;
+	bool	nbcon_offload;
+	bool	legacy_direct;
+	bool	legacy_offload;
+};
 
 /*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
+ * Identify which console flushing methods should be used in the context of
+ * the caller.
  */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
+static inline void printk_get_console_flush_type(struct console_flush_type *ft)
+{
+	memset(ft, 0, sizeof(*ft));
+
+	switch (nbcon_get_default_prio()) {
+	case NBCON_PRIO_NORMAL:
+		if (have_nbcon_console && !have_boot_console) {
+			if (printk_kthreads_running)
+				ft->nbcon_offload = true;
+			else
+				ft->nbcon_atomic = true;
+		}
+
+		/* Legacy consoles are flushed directly when possible. */
+		if (have_legacy_console || have_boot_console) {
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+			else
+				ft->legacy_offload = true;
+		}
+		break;
+
+	case NBCON_PRIO_EMERGENCY:
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		/* Legacy consoles are flushed directly when possible. */
+		if (have_legacy_console || have_boot_console) {
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+			else
+				ft->legacy_offload = true;
+		}
+		break;
+
+	case NBCON_PRIO_PANIC:
+		/*
+		 * In panic, the nbcon consoles will directly print. But
+		 * only allowed if there are no boot consoles.
+		 */
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		if (have_legacy_console || have_boot_console) {
+			/*
+			 * This is the same decision as NBCON_PRIO_NORMAL
+			 * except that offloading never occurs in panic.
+			 *
+			 * Note that console_flush_on_panic() will flush
+			 * legacy consoles anyway, even if unsafe.
+			 */
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+
+			/*
+			 * In panic, if nbcon atomic printing occurs,
+			 * the legacy consoles must remain silent until
+			 * explicitly allowed.
+			 */
+			if (ft->nbcon_atomic && !legacy_allow_panic_sync)
+				ft->legacy_direct = false;
+		}
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
 
 extern struct printk_buffers printk_shared_pbufs;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 0813ce88a49c5..32a383c4f62eb 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -18,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
-#include <linux/syscore_ops.h>
 #include <linux/types.h>
 #include "internal.h"
 #include "printk_ringbuffer.h"
@@ -213,8 +212,6 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 	}
 }
 
-bool printk_threads_enabled __ro_after_init;
-
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
  * @ctxt:	The context of the caller
@@ -245,6 +242,13 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	do {
+		/*
+		 * Panic does not imply that the console is owned. However, it
+		 * is critical that non-panic CPUs during panic are unable to
+		 * acquire ownership in order to satisfy the assumptions of
+		 * nbcon_waiter_matches(). In particular, the assumption that
+		 * lower priorities are ignored during panic.
+		 */
 		if (other_cpu_in_panic())
 			return -EPERM;
 
@@ -276,18 +280,29 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	/*
 	 * The request context is well defined by the @req_prio because:
 	 *
-	 * - Only a context with a higher priority can take over the request.
+	 * - Only a context with a priority higher than the owner can become
+	 *   a waiter.
+	 * - Only a context with a priority higher than the waiter can
+	 *   directly take over the request.
 	 * - There are only three priorities.
 	 * - Only one CPU is allowed to request PANIC priority.
 	 * - Lower priorities are ignored during panic() until reboot.
 	 *
 	 * As a result, the following scenario is *not* possible:
 	 *
-	 * 1. Another context with a higher priority directly takes ownership.
-	 * 2. The higher priority context releases the ownership.
-	 * 3. A lower priority context takes the ownership.
-	 * 4. Another context with the same priority as this context
+	 * 1. This context is currently a waiter.
+	 * 2. Another context with a higher priority than this context
+	 *    directly takes ownership.
+	 * 3. The higher priority context releases the ownership.
+	 * 4. Another lower priority context takes the ownership.
+	 * 5. Another context with the same priority as this context
 	 *    creates a request and starts waiting.
+	 *
+	 * Event #1 implies this context is EMERGENCY.
+	 * Event #2 implies the new context is PANIC.
+	 * Event #3 occurs when panic() has flushed the console.
+	 * Events #4 and #5 are not possible due to the other_cpu_in_panic()
+	 * check in nbcon_context_try_acquire_direct().
 	 */
 
 	return (cur->req_prio == expected_prio);
@@ -595,11 +610,29 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
 				int expected_prio)
 {
 	/*
-	 * Since consoles can only be acquired by higher priorities,
-	 * owning contexts are uniquely identified by @prio. However,
-	 * since contexts can unexpectedly lose ownership, it is
-	 * possible that later another owner appears with the same
-	 * priority. For this reason @cpu is also needed.
+	 * A similar function, nbcon_waiter_matches(), only deals with
+	 * EMERGENCY and PANIC priorities. However, this function must also
+	 * deal with the NORMAL priority, which requires additional checks
+	 * and constraints.
+	 *
+	 * For the case where preemption and interrupts are disabled, it is
+	 * enough to also verify that the owning CPU has not changed.
+	 *
+	 * For the case where preemption or interrupts are enabled, an
+	 * external synchronization method *must* be used. In particular,
+	 * the driver-specific locking mechanism used in device_lock()
+	 * (including disabling migration) should be used. It prevents
+	 * scenarios such as:
+	 *
+	 * 1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X] and
+	 *    is scheduled out.
+	 * 2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
+	 *    and releases it.
+	 * 3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
+	 *    and is scheduled out.
+	 * 4. [Task A] gets running on [CPU X] and sees that the console is
+	 *    still owned by a task on [CPU X] with NBON_PRIO_NORMAL. Thus
+	 *    [Task A] thinks it is the owner when it is not.
 	 */
 
 	if (cur->prio != expected_prio)
@@ -798,6 +831,19 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
+static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	wctxt->outbuf = buf;
+	wctxt->len = len;
+	nbcon_state_read(con, &cur);
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+}
+
 /**
  * nbcon_enter_unsafe - Enter an unsafe region in the driver
  * @wctxt:	The write context that was handed to the write function
@@ -813,8 +859,12 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool is_owner;
 
-	return nbcon_context_enter_unsafe(ctxt);
+	is_owner = nbcon_context_enter_unsafe(ctxt);
+	if (!is_owner)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return is_owner;
 }
 EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 
@@ -833,13 +883,18 @@ EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool ret;
 
-	return nbcon_context_exit_unsafe(ctxt);
+	ret = nbcon_context_exit_unsafe(ctxt);
+	if (!ret)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
 /**
- * nbcon_reacquire - Reacquire a console after losing ownership while printing
+ * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
+ *				while printing
  * @wctxt:	The write context that was handed to the write callback
  *
  * Since ownership can be lost at any time due to handover or takeover, a
@@ -854,21 +909,16 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * output buffer because that has been lost. This function cannot be used to
  * resume printing.
  */
-void nbcon_reacquire(struct nbcon_write_context *wctxt)
+void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-	struct console *con = ctxt->console;
-	struct nbcon_state cur;
 
 	while (!nbcon_context_try_acquire(ctxt))
 		cpu_relax();
 
-	wctxt->outbuf = NULL;
-	wctxt->len = 0;
-	nbcon_state_read(con, &cur);
-	wctxt->unsafe_takeover = cur.unsafe_takeover;
+	nbcon_write_context_set_buf(wctxt, NULL, 0);
 }
-EXPORT_SYMBOL_GPL(nbcon_reacquire);
+EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
@@ -900,6 +950,21 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	unsigned long dropped;
 	unsigned long ulseq;
 
+	/*
+	 * This function should never be called for consoles that have not
+	 * implemented the necessary callback for writing: i.e. legacy
+	 * consoles and, when atomic, nbcon consoles with no write_atomic().
+	 * Handle it as if ownership was lost and try to continue.
+	 *
+	 * Note that for nbcon consoles the write_thread() callback is
+	 * mandatory and was already checked in nbcon_alloc().
+	 */
+	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
+			 !(console_srcu_read_flags(con) & CON_NBCON))) {
+		nbcon_context_release(ctxt);
+		return false;
+	}
+
 	/*
 	 * The printk buffers are filled within an unsafe section. This
 	 * prevents NBCON_PRIO_NORMAL and NBCON_PRIO_EMERGENCY from
@@ -936,7 +1001,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		/*
 		 * Ensure this context is still the owner before trying to
 		 * update @nbcon_prev_seq. Otherwise the value in @ulseq may
-		 * not be from the previous owner.
+		 * not be from the previous owner and instead be some later
+		 * value from the context that took over ownership.
 		 */
 		nbcon_state_read(con, &cur);
 		if (!nbcon_context_can_proceed(ctxt, &cur))
@@ -954,38 +1020,28 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		goto update_con;
 
 	/* Initialize the write context for driver callbacks. */
-	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
-	wctxt->len = pmsg.outbuf_len;
-	nbcon_state_read(con, &cur);
-	wctxt->unsafe_takeover = cur.unsafe_takeover;
+	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
-	if (use_atomic &&
-	    con->write_atomic) {
+	if (use_atomic)
 		con->write_atomic(con, wctxt);
-
-	} else if (!use_atomic &&
-		   con->write_thread) {
+	else
 		con->write_thread(con, wctxt);
 
-	} else {
-		/*
-		 * This function should never be called for legacy consoles.
-		 * Handle it as if ownership was lost and try to continue.
-		 */
-		WARN_ON_ONCE(1);
-		nbcon_context_release(ctxt);
-		return false;
-	}
-
 	if (!wctxt->outbuf) {
 		/*
-		 * Ownership was lost and reacquired by the driver.
-		 * Handle it as if ownership was lost.
+		 * Ownership was lost and reacquired by the driver. Handle it
+		 * as if ownership was lost.
 		 */
 		nbcon_context_release(ctxt);
 		return false;
 	}
 
+	/*
+	 * Ownership may have been lost but _not_ reacquired by the driver.
+	 * This case is detected and handled when entering unsafe to update
+	 * dropped/seq values.
+	 */
+
 	/*
 	 * Since any dropped message was successfully output, reset the
 	 * dropped count for the console.
@@ -1011,6 +1067,63 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/*
+ * nbcon_emit_one - Print one record for an nbcon console using the
+ *			specified callback
+ * @wctxt:	An initialized write context struct to use for this context
+ * @use_atomic:	True if the write_atomic() callback is to be used
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!use_atomic) {
+		con->device_lock(con, &flags);
+
+		/*
+		 * Ensure this stays on the CPU to make handover and
+		 * takeover possible.
+		 */
+		cant_migrate();
+	}
+
+	if (!nbcon_context_try_acquire(ctxt))
+		goto out;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 *
+	 * The higher priority printing context takes over responsibility
+	 * to print the pending records.
+	 */
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
+		goto out;
+
+	nbcon_context_release(ctxt);
+
+	ret = ctxt->backlog;
+out:
+	if (!use_atomic)
+		con->device_unlock(con, flags);
+	return ret;
+}
+
 /**
  * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
  * @con:	Console to operate on
@@ -1062,7 +1175,6 @@ static int nbcon_kthread_func(void *__console)
 	short con_flags;
 	bool backlog;
 	int cookie;
-	int ret;
 
 wait_for_event:
 	/*
@@ -1075,50 +1187,30 @@ static int nbcon_kthread_func(void *__console)
 	 *
 	 * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
 	 */
-	ret = rcuwait_wait_event(&con->rcuwait,
-				 nbcon_kthread_should_wakeup(con, ctxt),
-				 TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
-
-	if (kthread_should_stop())
-		return 0;
-
-	/* Wait was interrupted by a spurious signal, go back to sleep. */
-	if (ret)
-		goto wait_for_event;
+	rcuwait_wait_event(&con->rcuwait,
+			   nbcon_kthread_should_wakeup(con, ctxt),
+			   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
 
 	do {
+		if (kthread_should_stop())
+			return 0;
+
 		backlog = false;
 
+		/*
+		 * Keep the srcu read lock around the entire operation so that
+		 * synchronize_srcu() can guarantee that the kthread stopped
+		 * or suspended printing.
+		 */
 		cookie = console_srcu_read_lock();
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false)) {
-			unsigned long lock_flags;
-
-			con->device_lock(con, &lock_flags);
-
-			/*
-			 * Ensure this stays on the CPU to make handover and
-			 * takeover possible.
-			 */
-			cant_migrate();
-
-			if (nbcon_context_try_acquire(ctxt)) {
-				/*
-				 * If the emit fails, this context is no
-				 * longer the owner.
-				 */
-				if (nbcon_emit_next_record(&wctxt, false)) {
-					nbcon_context_release(ctxt);
-					backlog = ctxt->backlog;
-				}
-			}
-
-			con->device_unlock(con, lock_flags);
-		}
+		if (console_is_usable(con, con_flags, false))
+			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
+
 		cond_resched();
 
 	} while (backlog);
@@ -1127,7 +1219,7 @@ static int nbcon_kthread_func(void *__console)
 }
 
 /**
- * nbcon_irq_work - irq work to wake printk thread
+ * nbcon_irq_work - irq work to wake console printer thread
  * @irq_work:	The irq work to operate on
  */
 static void nbcon_irq_work(struct irq_work *irq_work)
@@ -1139,9 +1231,6 @@ static void nbcon_irq_work(struct irq_work *irq_work)
 
 static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 {
-	bool has_sleeper;
-
-	rcu_read_lock();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the rcuwait is empty.
@@ -1154,20 +1243,20 @@ static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 	 * This pairs with nbcon_kthread_func:A.
 	 */
 	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
-	has_sleeper = !!rcu_dereference(w->task);
-	rcu_read_unlock();
-
-	return has_sleeper;
+	return rcuwait_active(w);
 }
 
 /**
- * nbcon_wake_threads - Wake up printing threads using irq_work
+ * nbcon_kthreads_wake - Wake up printing threads using irq_work
  */
-void nbcon_wake_threads(void)
+void nbcon_kthreads_wake(void)
 {
 	struct console *con;
 	int cookie;
 
+	if (!printk_kthreads_running)
+		return;
+
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		/*
@@ -1175,12 +1264,63 @@ void nbcon_wake_threads(void)
 		 * actively waiting. If not waiting, the thread will
 		 * notice by itself that it has work to do.
 		 */
-		if (con->kthread && rcuwait_has_sleeper(&con->rcuwait))
+		if (rcuwait_has_sleeper(&con->rcuwait))
 			irq_work_queue(&con->irq_work);
 	}
 	console_srcu_read_unlock(cookie);
 }
 
+/*
+ * nbcon_kthread_stop - Stop a console printer thread
+ * @con:	Console to operate on
+ */
+void nbcon_kthread_stop(struct console *con)
+{
+	lockdep_assert_console_list_lock_held();
+
+	if (!con->kthread)
+		return;
+
+	kthread_stop(con->kthread);
+	con->kthread = NULL;
+}
+
+/**
+ * nbcon_kthread_create - Create a console printer thread
+ * @con:	Console to operate on
+ *
+ * Return:	True if the kthread was started or already exists.
+ *		Otherwise false and @con must not be registered.
+ *
+ * If @con was already registered, it must be unregistered before
+ * the global state variable @printk_kthreads_running can be set.
+ */
+bool nbcon_kthread_create(struct console *con)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_console_list_lock_held();
+
+	if (con->kthread)
+		return true;
+
+	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
+	if (WARN_ON(IS_ERR(kt))) {
+		con_printk(KERN_ERR, con, "failed to start printing thread\n");
+		return false;
+	}
+
+	con->kthread = kt;
+
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(con->kthread, -20);
+
+	return true;
+}
+
 /* Track the nbcon emergency nesting per CPU. */
 static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
 static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
@@ -1188,8 +1328,14 @@ static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
 /**
  * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
  *
+ * Context:	For reading, any context. For writing, any context which could
+ *		not be migrated to another CPU.
  * Return:	Either a pointer to the per CPU emergency nesting counter of
  *		the current CPU or to the init data during early boot.
+ *
+ * The function is safe for reading per-CPU variables in any context because
+ * preemption is disabled if the current CPU is in the emergency state. See
+ * also nbcon_cpu_emergency_enter().
  */
 static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 {
@@ -1201,16 +1347,21 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	if (!printk_percpu_data_ready())
 		return &early_nbcon_pcpu_emergency_nesting;
 
-	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
+	/* Open code this_cpu_ptr() without checking migration. */
+	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
 }
 
 /**
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
  *
- * Context:	Any context which could not be migrated to another CPU.
+ * Context:	Any context.
  * Return:	The nbcon_prio to use for acquiring an nbcon console in this
  *		context for printing.
+ *
+ * The function is safe for reading per-CPU data in any context because
+ * preemption is disabled if the current CPU is in the emergency or panic
+ * state.
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
@@ -1226,46 +1377,6 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
-/*
- * nbcon_emit_one - Print one record for an nbcon console using the
- *			specified callback
- * @wctxt:	An initialized write context struct to use for this context
- * @use_atomic:	True if the write_atomic() callback is to be used
- *
- * Return:	True, when a record has been printed and there are still
- *		pending records. The caller might want to continue flushing.
- *
- *		False, when there is no pending record, or when the console
- *		context cannot be acquired, or the ownership has been lost.
- *		The caller should give up. Either the job is done, cannot be
- *		done, or will be handled by the owning context.
- *
- * This is an internal helper to handle the locking of the console before
- * calling nbcon_emit_next_record().
- */
-static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
-{
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-
-	if (!nbcon_context_try_acquire(ctxt))
-		return false;
-
-	/*
-	 * nbcon_emit_next_record() returns false when the console was
-	 * handed over or taken over. In both cases the context is no
-	 * longer valid.
-	 *
-	 * The higher priority printing context takes over responsibility
-	 * to print the pending records.
-	 */
-	if (!nbcon_emit_next_record(wctxt, use_atomic))
-		return false;
-
-	nbcon_context_release(ctxt);
-
-	return ctxt->backlog;
-}
-
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
@@ -1275,7 +1386,13 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
  *		both the console_lock and the SRCU read lock. Otherwise it
  *		is set to false.
  * @cookie:	The cookie from the SRCU read lock.
- * @use_atomic:	True if the write_atomic() callback is to be used
+ * @use_atomic: Set true when called in an atomic or unknown context.
+ *		It affects which nbcon callback will be used: write_atomic()
+ *		or write_thread().
+ *
+ *		When false, the write_thread() callback is used and would be
+ *		called in a preemtible context unless disabled by the
+ *		device_lock. The legacy handover is not allowed in this mode.
  *
  * Context:	Any context except NMI.
  * Return:	True, when a record has been printed and there are still
@@ -1298,30 +1415,28 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	unsigned long flags;
 	bool progress;
 
-	ctxt->console = con;
+	ctxt->console	= con;
+	ctxt->prio	= nbcon_get_default_prio();
 
 	if (use_atomic) {
-		/* Use the same procedure as console_emit_next_record(). */
+		/*
+		 * In an atomic or unknown context, use the same procedure as
+		 * in console_emit_next_record(). It allows to handover.
+		 */
 		printk_safe_enter_irqsave(flags);
 		console_lock_spinning_enable();
 		stop_critical_timings();
+	}
 
-		ctxt->prio = nbcon_get_default_prio();
-		progress = nbcon_emit_one(&wctxt, use_atomic);
+	progress = nbcon_emit_one(&wctxt, use_atomic);
 
+	if (use_atomic) {
 		start_critical_timings();
 		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
 	} else {
+		/* Non-atomic does not perform legacy spinning handovers. */
 		*handover = false;
-
-		con->device_lock(con, &flags);
-		cant_migrate();
-
-		ctxt->prio = nbcon_get_default_prio();
-		progress = nbcon_emit_one(&wctxt, use_atomic);
-
-		con->device_unlock(con, flags);
 	}
 
 	return progress;
@@ -1402,6 +1517,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 					   bool allow_unsafe_takeover)
 {
+	struct console_flush_type ft;
 	unsigned long flags;
 	int err;
 
@@ -1434,7 +1550,8 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	 * context must flush those remaining records if the printer thread
 	 * is not available do it.
 	 */
-	if ((!con->kthread || (system_state > SYSTEM_RUNNING)) &&
+	printk_get_console_flush_type(&ft);
+	if (!ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
@@ -1475,8 +1592,9 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
  *				write_atomic() callback
  *
  * Flush the backlog up through the currently newest record. Any new
- * records added while flushing will not be flushed. This is to avoid
- * one CPU printing unbounded because other CPUs continue to add records.
+ * records added while flushing will not be flushed if there is another
+ * context available to handle the flushing. This is to avoid one CPU
+ * printing unbounded because other CPUs continue to add records.
  */
 void nbcon_atomic_flush_pending(void)
 {
@@ -1497,16 +1615,12 @@ void nbcon_atomic_flush_unsafe(void)
 
 /**
  * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
- *				messages for that CPU are only stored
- *
- * Upon exiting the emergency section, all stored messages are flushed.
+ *				messages for that CPU are flushed directly
  *
  * Context:	Any context. Disables preemption.
  *
- * When within an emergency section, no printing occurs on that CPU. This
- * is to allow all emergency messages to be dumped into the ringbuffer before
- * flushing the ringbuffer. The actual printing occurs when exiting the
- * outermost emergency section.
+ * When within an emergency section, printk() calls will attempt to flush any
+ * pending messages in the ringbuffer.
  */
 void nbcon_cpu_emergency_enter(void)
 {
@@ -1519,178 +1633,52 @@ void nbcon_cpu_emergency_enter(void)
 }
 
 /**
- * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
- *				stored messages
+ * nbcon_cpu_emergency_exit - Exit an emergency section
  *
- * Flushing only occurs when exiting all nesting for the CPU.
- *
- * Context:	Any context. Enables preemption.
+ * Context:	Within an emergency section. Enables preemption.
  */
 void nbcon_cpu_emergency_exit(void)
 {
 	unsigned int *cpu_emergency_nesting;
-	bool do_trigger_flush = false;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 
-	/*
-	 * Flush the messages before enabling preemtion to see them ASAP.
-	 *
-	 * Reduce the risk of potential softlockup by using the
-	 * flush_pending() variant which ignores messages added later. It is
-	 * called before decrementing the counter so that the printing context
-	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
-	 */
-	if (*cpu_emergency_nesting == 1) {
-		nbcon_atomic_flush_pending();
-
-		/*
-		 * Safely attempt to flush the legacy consoles in this
-		 * context. Otherwise an irq_work context is triggered
-		 * to handle it.
-		 */
-		do_trigger_flush = true;
-		if (!force_printkthreads() &&
-		    printing_via_unlock &&
-		    !is_printk_deferred()) {
-			if (console_trylock()) {
-				do_trigger_flush = false;
-				console_unlock();
-			}
-		}
-	}
-
 	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
 		(*cpu_emergency_nesting)--;
 
 	preempt_enable();
-
-	if (do_trigger_flush)
-		printk_trigger_flush();
 }
 
 /**
- * nbcon_cpu_emergency_flush - Explicitly flush consoles while
- *				within emergency context
+ * nbcon_alloc - Allocate and init the nbcon console specific data
+ * @con:	Console to initialize
  *
- * Both nbcon and legacy consoles are flushed.
+ * Return:	True if the console was fully allocated and initialized.
+ *		Otherwise @con must not be registered.
  *
- * It should be used only when there are too many messages printed
- * in emergency context, for example, printing backtraces of all
- * CPUs or processes. It is typically needed when the watchdogs
- * need to be touched as well.
- */
-void nbcon_cpu_emergency_flush(void)
-{
-	bool is_emergency;
-
-	/*
-	 * If this context is not an emergency context, preemption might be
-	 * enabled. To be sure, disable preemption when checking if this is
-	 * an emergency context.
-	 */
-	preempt_disable();
-	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
-	preempt_enable();
-
-	/* The explicit flush is needed only in the emergency context. */
-	if (!is_emergency)
-		return;
-
-	nbcon_atomic_flush_pending();
-
-	if (!force_printkthreads() &&
-	    printing_via_unlock &&
-	    !is_printk_deferred()) {
-		if (console_trylock())
-			console_unlock();
-	}
-}
-
-/*
- * nbcon_kthread_stop - Stop a printer thread
- * @con:	Console to operate on
- */
-static void nbcon_kthread_stop(struct console *con)
-{
-	lockdep_assert_console_list_lock_held();
-
-	if (!con->kthread)
-		return;
-
-	kthread_stop(con->kthread);
-	con->kthread = NULL;
-}
-
-/**
- * nbcon_kthread_create - Create a printer thread
- * @con:	Console to operate on
- *
- * If it fails, let the console proceed. The atomic part might
- * be usable and useful.
- */
-void nbcon_kthread_create(struct console *con)
-{
-	struct task_struct *kt;
-
-	lockdep_assert_console_list_lock_held();
-
-	if (!(con->flags & CON_NBCON) || !con->write_thread)
-		return;
-
-	if (!printk_threads_enabled || con->kthread)
-		return;
-
-	/*
-	 * Printer threads cannot be started as long as any boot console is
-	 * registered because there is no way to synchronize the hardware
-	 * registers between boot console code and regular console code.
-	 */
-	if (have_boot_console)
-		return;
-
-	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
-	if (IS_ERR(kt)) {
-		con_printk(KERN_ERR, con, "failed to start printing thread\n");
-		return;
-	}
-
-	con->kthread = kt;
-
-	/*
-	 * It is important that console printing threads are scheduled
-	 * shortly after a printk call and with generous runtime budgets.
-	 */
-	sched_set_normal(con->kthread, -20);
-}
-
-static int __init printk_setup_threads(void)
-{
-	struct console *con;
-
-	console_list_lock();
-	printk_threads_enabled = true;
-	for_each_console(con)
-		nbcon_kthread_create(con);
-	if (force_printkthreads() && printing_via_unlock)
-		nbcon_legacy_kthread_create();
-	console_list_unlock();
-	return 0;
-}
-early_initcall(printk_setup_threads);
-
-/**
- * nbcon_alloc - Allocate buffers needed by the nbcon console
- * @con:	Console to allocate buffers for
- *
- * Return:	True on success. False otherwise and the console cannot
- *		be used.
- *
- * This is not part of nbcon_init() because buffer allocation must
- * be performed earlier in the console registration process.
+ * When allocation and init was successful, the console must be properly
+ * freed using nbcon_free() once it is no longer needed.
  */
 bool nbcon_alloc(struct console *con)
 {
+	struct nbcon_state state = { };
+
+	/* The write_thread() callback is mandatory. */
+	if (WARN_ON(!con->write_thread))
+		return false;
+
+	rcuwait_init(&con->rcuwait);
+	init_irq_work(&con->irq_work, nbcon_irq_work);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
+	nbcon_state_set(con, &state);
+
+	/*
+	 * Initialize @nbcon_seq to the highest possible sequence number so
+	 * that practically speaking it will have nothing to print until a
+	 * desired initial sequence number has been set via nbcon_seq_force().
+	 */
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), ULSEQ_MAX(prb));
+
 	if (con->flags & CON_BOOT) {
 		/*
 		 * Boot console printing is synchronized with legacy console
@@ -1704,34 +1692,18 @@ bool nbcon_alloc(struct console *con)
 			con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
 			return false;
 		}
+
+		if (printk_kthreads_running) {
+			if (!nbcon_kthread_create(con)) {
+				kfree(con->pbufs);
+				return false;
+			}
+		}
 	}
 
 	return true;
 }
 
-/**
- * nbcon_init - Initialize the nbcon console specific data
- * @con:	Console to initialize
- * @init_seq:	Sequence number of the first record to be emitted
- *
- * nbcon_alloc() *must* be called and succeed before this function
- * is called.
- */
-void nbcon_init(struct console *con, u64 init_seq)
-{
-	struct nbcon_state state = { };
-
-	/* nbcon_alloc() must have been called and successful! */
-	BUG_ON(!con->pbufs);
-
-	rcuwait_init(&con->rcuwait);
-	init_irq_work(&con->irq_work, nbcon_irq_work);
-	nbcon_seq_force(con, init_seq);
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
-	nbcon_state_set(con, &state);
-	nbcon_kthread_create(con);
-}
-
 /**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
@@ -1740,7 +1712,9 @@ void nbcon_free(struct console *con)
 {
 	struct nbcon_state state = { };
 
-	nbcon_kthread_stop(con);
+	if (printk_kthreads_running)
+		nbcon_kthread_stop(con);
+
 	nbcon_state_set(con, &state);
 
 	/* Boot consoles share global printk buffers. */
@@ -1796,6 +1770,7 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	struct console_flush_type ft;
 	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1805,45 +1780,28 @@ void nbcon_device_release(struct console *con)
 
 	/*
 	 * This context must flush any new records added while the console
-	 * was locked. The console_srcu_read_lock must be taken to ensure
-	 * the console is usable throughout flushing.
+	 * was locked if the printer thread is not available to do it. The
+	 * console_srcu_read_lock must be taken to ensure the console is
+	 * usable throughout flushing.
 	 */
 	cookie = console_srcu_read_lock();
+	printk_get_console_flush_type(&ft);
 	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
-	    (!con->kthread || (system_state > SYSTEM_RUNNING)) &&
+	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
-		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
+		/*
+		 * If nbcon_atomic flushing is not available, fallback to
+		 * using the legacy loop.
+		 */
+		if (ft.nbcon_atomic) {
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
+		} else if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		} else if (ft.legacy_offload) {
+			printk_trigger_flush();
+		}
 	}
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
-
-/**
- * printk_kthread_shutdown - shutdown all threaded printers
- *
- * On system shutdown all threaded printers are stopped. This allows printk
- * to transition back to atomic printing, thus providing a robust mechanism
- * for the final shutdown/reboot messages to be output.
- */
-static void printk_kthread_shutdown(void)
-{
-	struct console *con;
-
-	console_list_lock();
-	for_each_console(con) {
-		if (con->flags & CON_NBCON)
-			nbcon_kthread_stop(con);
-	}
-	console_list_unlock();
-}
-
-static struct syscore_ops printk_syscore_ops = {
-	.shutdown = printk_kthread_shutdown,
-};
-
-static int __init printk_init_ops(void)
-{
-	register_syscore_ops(&printk_syscore_ops);
-	return 0;
-}
-device_initcall(printk_init_ops);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c92c646c79ba0..8458f4a224193 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
+#include <linux/syscore_ops.h>
 #include <linux/vmcore_info.h>
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
@@ -195,17 +196,6 @@ static int __init control_devkmsg(char *str)
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
-#if !defined(CONFIG_PREEMPT_RT)
-DEFINE_STATIC_KEY_FALSE(force_printkthreads_key);
-
-static int __init setup_forced_printkthreads(char *arg)
-{
-	static_branch_enable(&force_printkthreads_key);
-	return 0;
-}
-early_param("threadprintk", setup_forced_printkthreads);
-#endif
-
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
@@ -486,7 +476,7 @@ bool have_legacy_console;
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-static bool have_nbcon_console;
+bool have_nbcon_console;
 
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -496,17 +486,21 @@ static bool have_nbcon_console;
  */
 bool have_boot_console;
 
+/* See printk_legacy_allow_panic_sync() for details. */
+bool legacy_allow_panic_sync;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
-
 static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
-
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+/* True when _all_ printer threads are available for printing. */
+bool printk_kthreads_running;
+
 struct latched_seq {
 	seqcount_latch_t	latch;
 	u64			val[2];
@@ -2338,8 +2332,6 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
-static bool legacy_allow_panic_sync;
-
 /*
  * This acts as a one-way switch to allow legacy consoles to print from
  * the printk() caller context on a panic CPU. It also attempts to flush
@@ -2347,9 +2339,12 @@ static bool legacy_allow_panic_sync;
  */
 void printk_legacy_allow_panic_sync(void)
 {
+	struct console_flush_type ft;
+
 	legacy_allow_panic_sync = true;
 
-	if (printing_via_unlock && !in_nmi()) {
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -2359,8 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock = !force_printkthreads() &&
-				 printing_via_unlock;
+	struct console_flush_type ft;
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2375,87 +2369,49 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
+	printk_get_console_flush_type(&ft);
+
+	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		/* If called from the scheduler, we can not call up(). */
-		do_trylock_unlock = false;
+		ft.legacy_offload |= ft.legacy_direct;
+		ft.legacy_direct = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	if (have_nbcon_console && !have_boot_console) {
-		bool is_panic_context = this_cpu_in_panic();
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 
-		/*
-		 * In panic, the legacy consoles are not allowed to print from
-		 * the printk calling context unless explicitly allowed. This
-		 * gives the safe nbcon consoles a chance to print out all the
-		 * panic messages first. This restriction only applies if
-		 * there are nbcon consoles registered.
-		 */
-		if (is_panic_context)
-			do_trylock_unlock &= legacy_allow_panic_sync;
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
 
-		/*
-		 * There are situations where nbcon atomic printing should
-		 * happen in the printk() caller context:
-		 *
-		 * - When this CPU is in panic.
-		 *
-		 * - When booting, before the printing threads have been
-		 *   started.
-		 *
-		 * - During shutdown, since the printing threads may not get
-		 *   a chance to print the final messages.
-		 *
-		 * Note that if boot consoles are registered, the console
-		 * lock/unlock dance must be relied upon instead because nbcon
-		 * consoles cannot print simultaneously with boot consoles.
-		 */
-		if (is_panic_context ||
-		    !printk_threads_enabled ||
-		    (system_state > SYSTEM_RUNNING)) {
-			nbcon_atomic_flush_pending();
-		}
-	}
-
-	nbcon_wake_threads();
-
-	if (do_trylock_unlock) {
+	if (ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
-		 *
-		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
-
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
 		 * spinning variant, this context tries to take over the
 		 * printing from another printing context.
-		 *
-		 * Skip it in EMERGENCY priority. The console will be
-		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
-			if (console_trylock_spinning())
-				console_unlock();
-		}
-
+		if (console_trylock_spinning())
+			console_unlock();
 		preempt_enable();
 	}
 
-	if (do_trylock_unlock)
-		wake_up_klogd();
-	else
+	if (ft.legacy_offload)
 		defer_console_output();
+	else
+		wake_up_klogd();
 
 	return printed_len;
 }
@@ -2483,14 +2439,6 @@ EXPORT_SYMBOL(_printk);
 static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
-static struct task_struct *nbcon_legacy_kthread;
-
-static inline void wake_up_legacy_kthread(void)
-{
-	if (nbcon_legacy_kthread)
-		wake_up_interruptible(&legacy_wait);
-}
-
 #else /* CONFIG_PRINTK */
 
 #define printk_time		false
@@ -2503,9 +2451,8 @@ static u64 syslog_seq;
 
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
+static inline void legacy_kthread_wake(void) { }
 
-static inline void nbcon_legacy_kthread_create(void) { }
-static inline void wake_up_legacy_kthread(void) { }
 #endif /* CONFIG_PRINTK */
 
 #ifdef CONFIG_EARLY_PRINTK
@@ -2790,9 +2737,8 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	struct console_flush_type ft;
 	struct console *con;
-	short flags;
-	int cookie;
 
 	if (!console_suspend_enabled)
 		return;
@@ -2809,19 +2755,11 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
-	/*
-	 * Since this runs in task context, wake the threaded printers
-	 * directly rather than scheduling irq_work to do it.
-	 */
-	cookie = console_srcu_read_lock();
-	for_each_console_srcu(con) {
-		flags = console_srcu_read_flags(con);
-		if (flags & CON_NBCON)
-			nbcon_kthread_wake(con);
-	}
-	console_srcu_read_unlock(cookie);
-
-	wake_up_legacy_kthread();
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+	if (ft.legacy_offload)
+		defer_console_output();
 
 	pr_flush(1000, true);
 }
@@ -2837,12 +2775,16 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!force_printkthreads() &&
-	    !cpuhp_tasks_frozen &&
-	    printing_via_unlock) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+	struct console_flush_type ft;
+
+	if (!cpuhp_tasks_frozen) {
+		printk_get_console_flush_type(&ft);
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
+		if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 	return 0;
 }
@@ -2905,25 +2847,31 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with the message in
- * @pmsg->pbufs->scratchbuf. This is achieved by shifting the existing message
- * over and inserting the scratchbuf message.
+ * Prepend the message in @pmsg->pbufs->outbuf. This is achieved by shifting
+ * the existing message over and inserting the scratchbuf message.
  *
- * @pmsg is the printk message to prepend.
+ * @pmsg is the original printk message.
+ * @fmt is the printf format of the message which will prepend the existing one.
  *
- * @len is the length of the message in @pmsg->pbufs->scratchbuf.
- *
- * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the scratchbuf message, the message text will be sufficiently truncated.
+ * If there is not enough space in @pmsg->pbufs->outbuf, the existing
+ * message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-static void __console_prepend_scratch(struct printk_message *pmsg, size_t len)
+__printf(2, 3)
+static void console_prepend_message(struct printk_message *pmsg, const char *fmt, ...)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
+	va_list args;
+	size_t len;
+
+	va_start(args, fmt);
+	len = vscnprintf(scratchbuf, scratchbuf_sz, fmt, args);
+	va_end(args);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2955,15 +2903,7 @@ static void __console_prepend_scratch(struct printk_message *pmsg, size_t len)
  */
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
-	struct printk_buffers *pbufs = pmsg->pbufs;
-	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
-	char *scratchbuf = &pbufs->scratchbuf[0];
-	size_t len;
-
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
-
-	__console_prepend_scratch(pmsg, len);
+	console_prepend_message(pmsg, "** %lu printk messages dropped **\n", dropped);
 }
 
 /*
@@ -2974,15 +2914,7 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
  */
 void console_prepend_replay(struct printk_message *pmsg)
 {
-	struct printk_buffers *pbufs = pmsg->pbufs;
-	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
-	char *scratchbuf = &pbufs->scratchbuf[0];
-	size_t len;
-
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-			"** replaying previous printk message **\n");
-
-	__console_prepend_scratch(pmsg, len);
+	console_prepend_message(pmsg, "** replaying previous printk message **\n");
 }
 
 /*
@@ -3056,22 +2988,23 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  * false positive. For PREEMPT_RT the false positive condition does not
  * occur.
  *
- * This map is used to establish LD_WAIT_SLEEP context for the console write
- * callbacks when legacy printing to avoid false positive lockdep complaints,
- * thus allowing lockdep to continue to function for real issues.
+ * This map is used to temporarily establish LD_WAIT_SLEEP context for the
+ * console write() callback when legacy printing to avoid false positive
+ * lockdep complaints, thus allowing lockdep to continue to function for
+ * real issues.
  */
 #ifdef CONFIG_PREEMPT_RT
-static inline void printk_legacy_lock_map_acquire_try(void) { }
-static inline void printk_legacy_lock_map_release(void) { }
+static inline void printk_legacy_allow_spinlock_enter(void) { }
+static inline void printk_legacy_allow_spinlock_exit(void) { }
 #else
 static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
 
-static inline void printk_legacy_lock_map_acquire_try(void)
+static inline void printk_legacy_allow_spinlock_enter(void)
 {
 	lock_map_acquire_try(&printk_legacy_map);
 }
 
-static inline void printk_legacy_lock_map_release(void)
+static inline void printk_legacy_allow_spinlock_exit(void)
 {
 	lock_map_release(&printk_legacy_map);
 }
@@ -3128,11 +3061,12 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 	/* Write everything out to the hardware. */
 
-	if (force_printkthreads()) {
+	if (force_legacy_kthread() && !panic_in_progress()) {
 		/*
-		 * With forced threading this function is either in a thread
-		 * or panic context. So there is no need for concern about
-		 * printk reentrance, handovers, or lockdep complaints.
+		 * With forced threading this function is in a task context
+		 * (either legacy kthread or get_init_console_seq()). There
+		 * is no need for concern about printk reentrance, handovers,
+		 * or lockdep complaints.
 		 */
 
 		con->write(con, outbuf, pmsg.outbuf_len);
@@ -3154,9 +3088,9 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		/* Do not trace print latency. */
 		stop_critical_timings();
 
-		printk_legacy_lock_map_acquire_try();
+		printk_legacy_allow_spinlock_enter();
 		con->write(con, outbuf, pmsg.outbuf_len);
-		printk_legacy_lock_map_release();
+		printk_legacy_allow_spinlock_exit();
 
 		start_critical_timings();
 
@@ -3177,6 +3111,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	return false;
 }
 
+static inline void printk_kthreads_check_locked(void) { }
+
 #endif /* CONFIG_PRINTK */
 
 /*
@@ -3204,6 +3140,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
+	struct console_flush_type ft;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -3215,6 +3152,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
+		printk_get_console_flush_type(&ft);
+
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
@@ -3222,10 +3161,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			bool progress;
 
 			/*
-			 * console_flush_all() is only for legacy consoles,
-			 * unless the nbcon console has no kthread printer.
+			 * console_flush_all() is only for legacy consoles when
+			 * the nbcon consoles have their printer threads.
 			 */
-			if ((flags & CON_NBCON) && con->kthread)
+			if ((flags & CON_NBCON) && ft.nbcon_offload)
 				continue;
 
 			if (!console_is_usable(con, flags, !do_cond_resched))
@@ -3273,7 +3212,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	return false;
 }
 
-static void console_flush_and_unlock(void)
+static void __console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
 	bool handover;
@@ -3319,29 +3258,26 @@ static void console_flush_and_unlock(void)
 }
 
 /**
- * console_unlock - unblock the console subsystem from printing
+ * console_unlock - unblock the legacy console subsystem from printing
  *
  * Releases the console_lock which the caller holds to block printing of
- * the console subsystem.
+ * the legacy console subsystem.
  *
  * While the console_lock was held, console output may have been buffered
- * by printk().  If this is the case, console_unlock(); emits
- * the output prior to releasing the lock.
+ * by printk(). If this is the case, console_unlock() emits the output on
+ * legacy consoles prior to releasing the lock.
  *
  * console_unlock(); may be called from any context.
  */
 void console_unlock(void)
 {
-	/*
-	 * Forced threading relies on kthread and atomic consoles for
-	 * printing. It never attempts to print from console_unlock().
-	 */
-	if (force_printkthreads()) {
-		__console_unlock();
-		return;
-	}
+	struct console_flush_type ft;
 
-	console_flush_and_unlock();
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct)
+		__console_flush_and_unlock();
+	else
+		__console_unlock();
 }
 EXPORT_SYMBOL(console_unlock);
 
@@ -3465,6 +3401,7 @@ static void __console_rewind_all(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console_flush_type ft;
 	bool handover;
 	u64 next_seq;
 
@@ -3488,9 +3425,12 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
-	nbcon_atomic_flush_pending();
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 
-	if (printing_via_unlock)
+	/* Flush legacy consoles once allowed, even when dangerous. */
+	if (legacy_allow_panic_sync)
 		console_flush_all(false, &next_seq, &handover);
 }
 
@@ -3548,11 +3488,12 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
-	short flags;
-	int cookie;
+	struct console_flush_type ft;
+	bool is_nbcon;
 
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	is_nbcon = console->flags & CON_NBCON;
 	console_list_unlock();
 
 	/*
@@ -3562,38 +3503,46 @@ void console_start(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
-	cookie = console_srcu_read_lock();
-	flags = console_srcu_read_flags(console);
-	if (flags & CON_NBCON)
+	printk_get_console_flush_type(&ft);
+	if (is_nbcon && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
-	else
-		wake_up_legacy_kthread();
-	console_srcu_read_unlock(cookie);
+	else if (!is_nbcon && ft.legacy_offload)
+		defer_console_output();
 
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
 
 #ifdef CONFIG_PRINTK
-static bool printer_should_wake(void)
+static int unregister_console_locked(struct console *console);
+
+/* True when system boot is far enough to create printer threads. */
+static bool printk_kthreads_ready __ro_after_init;
+
+static struct task_struct *printk_legacy_kthread;
+
+static bool legacy_kthread_should_wakeup(void)
 {
-	bool available = false;
+	struct console_flush_type ft;
 	struct console *con;
+	bool ret = false;
 	int cookie;
 
 	if (kthread_should_stop())
 		return true;
 
+	printk_get_console_flush_type(&ft);
+
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		short flags = console_srcu_read_flags(con);
 		u64 printk_seq;
 
 		/*
-		 * The legacy printer thread is only for legacy consoles,
-		 * unless the nbcon console has no kthread printer.
+		 * The legacy printer thread is only for legacy consoles when
+		 * the nbcon consoles have their printer threads.
 		 */
-		if ((flags & CON_NBCON) && con->kthread)
+		if ((flags & CON_NBCON) && ft.nbcon_offload)
 			continue;
 
 		if (!console_is_usable(con, flags, false))
@@ -3610,61 +3559,162 @@ static bool printer_should_wake(void)
 		}
 
 		if (prb_read_valid(prb, printk_seq, NULL)) {
-			available = true;
+			ret = true;
 			break;
 		}
 	}
 	console_srcu_read_unlock(cookie);
 
-	return available;
+	return ret;
 }
 
-static int nbcon_legacy_kthread_func(void *unused)
+static int legacy_kthread_func(void *unused)
 {
-	int error;
-
 	for (;;) {
-		error = wait_event_interruptible(legacy_wait, printer_should_wake());
+		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
 
 		if (kthread_should_stop())
 			break;
 
-		if (error)
-			continue;
-
 		console_lock();
-		console_flush_and_unlock();
+		__console_flush_and_unlock();
 	}
 
 	return 0;
 }
 
-void nbcon_legacy_kthread_create(void)
+static bool legacy_kthread_create(void)
 {
 	struct task_struct *kt;
 
-	lockdep_assert_held(&console_mutex);
+	lockdep_assert_console_list_lock_held();
 
-	if (!force_printkthreads())
-		return;
-
-	if (!printk_threads_enabled || nbcon_legacy_kthread)
-		return;
-
-	kt = kthread_run(nbcon_legacy_kthread_func, NULL, "pr/legacy");
-	if (IS_ERR(kt)) {
-		pr_err("unable to start legacy printing thread\n");
-		return;
+	kt = kthread_run(legacy_kthread_func, NULL, "pr/legacy");
+	if (WARN_ON(IS_ERR(kt))) {
+		pr_err("failed to start legacy printing thread\n");
+		return false;
 	}
 
-	nbcon_legacy_kthread = kt;
+	printk_legacy_kthread = kt;
 
 	/*
 	 * It is important that console printing threads are scheduled
 	 * shortly after a printk call and with generous runtime budgets.
 	 */
-	sched_set_normal(nbcon_legacy_kthread, -20);
+	sched_set_normal(printk_legacy_kthread, -20);
+
+	return true;
 }
+
+/**
+ * printk_kthreads_shutdown - shutdown all threaded printers
+ *
+ * On system shutdown all threaded printers are stopped. This allows printk
+ * to transition back to atomic printing, thus providing a robust mechanism
+ * for the final shutdown/reboot messages to be output.
+ */
+static void printk_kthreads_shutdown(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	if (printk_kthreads_running) {
+		printk_kthreads_running = false;
+
+		for_each_console(con) {
+			if (con->flags & CON_NBCON)
+				nbcon_kthread_stop(con);
+		}
+
+		/*
+		 * The threads may have been stopped while printing a
+		 * backlog. Flush any records left over.
+		 */
+		nbcon_atomic_flush_pending();
+	}
+	console_list_unlock();
+}
+
+static struct syscore_ops printk_syscore_ops = {
+	.shutdown = printk_kthreads_shutdown,
+};
+
+/*
+ * If appropriate, start nbcon kthreads and set @printk_kthreads_running.
+ * If any kthreads fail to start, those consoles are unregistered.
+ *
+ * Must be called under console_list_lock().
+ */
+static void printk_kthreads_check_locked(void)
+{
+	struct hlist_node *tmp;
+	struct console *con;
+
+	lockdep_assert_console_list_lock_held();
+
+	if (!printk_kthreads_ready)
+		return;
+
+	if (have_legacy_console || have_boot_console) {
+		if (!printk_legacy_kthread &&
+		    force_legacy_kthread() &&
+		    !legacy_kthread_create()) {
+			/*
+			 * All legacy consoles must be unregistered. If there
+			 * are any nbcon consoles, they will set up their own
+			 * kthread.
+			 */
+			hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+				if (con->flags & CON_NBCON)
+					continue;
+
+				unregister_console_locked(con);
+			}
+		}
+	} else if (printk_legacy_kthread) {
+		kthread_stop(printk_legacy_kthread);
+		printk_legacy_kthread = NULL;
+	}
+
+	/*
+	 * Printer threads cannot be started as long as any boot console is
+	 * registered because there is no way to synchronize the hardware
+	 * registers between boot console code and regular console code.
+	 * It can only be known that there will be no new boot consoles when
+	 * an nbcon console is registered.
+	 */
+	if (have_boot_console || !have_nbcon_console) {
+		/* Clear flag in case all nbcon consoles unregistered. */
+		printk_kthreads_running = false;
+		return;
+	}
+
+	if (printk_kthreads_running)
+		return;
+
+	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+		if (!(con->flags & CON_NBCON))
+			continue;
+
+		if (!nbcon_kthread_create(con))
+			unregister_console_locked(con);
+	}
+
+	printk_kthreads_running = true;
+}
+
+static int __init printk_set_kthreads_ready(void)
+{
+	register_syscore_ops(&printk_syscore_ops);
+
+	console_list_lock();
+	printk_kthreads_ready = true;
+	printk_kthreads_check_locked();
+	console_list_unlock();
+
+	return 0;
+}
+early_initcall(printk_set_kthreads_ready);
 #endif /* CONFIG_PRINTK */
 
 static int __read_mostly keep_bootcon;
@@ -3955,11 +4005,10 @@ void register_console(struct console *newcon)
 
 	if (newcon->flags & CON_NBCON) {
 		have_nbcon_console = true;
-		nbcon_init(newcon, init_seq);
+		nbcon_seq_force(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
 		newcon->seq = init_seq;
-		nbcon_legacy_kthread_create();
 	}
 
 	if (newcon->flags & CON_BOOT)
@@ -4026,6 +4075,9 @@ void register_console(struct console *newcon)
 				unregister_console_locked(con);
 		}
 	}
+
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
 unlock:
 	console_list_unlock();
 }
@@ -4035,7 +4087,6 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
-	bool is_boot_con = (console->flags & CON_BOOT);
 	bool found_legacy_con = false;
 	bool found_nbcon_con = false;
 	bool found_boot_con = false;
@@ -4053,11 +4104,16 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
+	if (!console_is_registered_locked(console))
+		res = -ENODEV;
+	else if (console_is_usable(console, console->flags, true))
+		__pr_flush(console, 1000, true);
+
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
-	if (!console_is_registered_locked(console))
-		return -ENODEV;
+	if (res < 0)
+		return res;
 
 	/*
 	 * Use the driver synchronization to ensure that the hardware is not
@@ -4118,21 +4174,8 @@ static int unregister_console_locked(struct console *console)
 	if (!found_nbcon_con)
 		have_nbcon_console = found_nbcon_con;
 
-	/*
-	 * When the last boot console unregisters, start up the
-	 * printing threads.
-	 */
-	if (is_boot_con && !have_boot_console) {
-		for_each_console(c)
-			nbcon_kthread_create(c);
-	}
-
-#ifdef CONFIG_PRINTK
-	if (!printing_via_unlock && nbcon_legacy_kthread) {
-		kthread_stop(nbcon_legacy_kthread);
-		nbcon_legacy_kthread = NULL;
-	}
-#endif
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
 
 	return res;
 }
@@ -4280,6 +4323,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 {
 	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
 	unsigned long remaining_jiffies = timeout_jiffies;
+	struct console_flush_type ft;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -4288,16 +4332,17 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 diff;
 	u64 seq;
 
+	/* Sorry, pr_flush() will not work this early. */
+	if (system_state < SYSTEM_SCHEDULING)
+		return false;
+
 	might_sleep();
 
 	seq = prb_next_reserve_seq(prb);
 
-	/*
-	 * Flush the consoles so that records up to @seq are printed.
-	 * Otherwise this function will just wait for the threaded printers
-	 * to print up to @seq.
-	 */
-	if (printing_via_unlock) {
+	/* Flush the consoles so that records up to @seq are printed. */
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
 	}
@@ -4305,26 +4350,22 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	for (;;) {
 		unsigned long begin_jiffies;
 		unsigned long slept_jiffies;
-		bool use_console_lock = printing_via_unlock;
-
-		/*
-		 * Ensure the compiler does not optimize @use_console_lock to
-		 * be @printing_via_unlock since the latter can change at any
-		 * time.
-		 */
-		barrier();
 
 		diff = 0;
 
-		if (use_console_lock) {
-			/*
-			 * Hold the console_lock to guarantee safe access to
-			 * console->seq. Releasing console_lock flushes more
-			 * records in case @seq is still not printed on all
-			 * usable consoles.
-			 */
-			console_lock();
-		}
+		/*
+		 * Hold the console_lock to guarantee safe access to
+		 * console->seq. Releasing console_lock flushes more
+		 * records in case @seq is still not printed on all
+		 * usable consoles.
+		 *
+		 * Holding the console_lock is not necessary if there
+		 * are no legacy or boot consoles. However, such a
+		 * console could register at any time. Always hold the
+		 * console_lock as a precaution rather than
+		 * synchronizing against register_console().
+		 */
+		console_lock();
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -4346,7 +4387,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
-				WARN_ON_ONCE(!use_console_lock);
 				printk_seq = c->seq;
 			}
 
@@ -4358,8 +4398,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		if (use_console_lock)
-			console_unlock();
+		console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining_jiffies == 0)
@@ -4406,18 +4445,20 @@ static bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 static DEFINE_PER_CPU(int, printk_pending);
 
+static void legacy_kthread_wake(void)
+{
+	if (printk_legacy_kthread)
+		wake_up_interruptible(&legacy_wait);
+}
+
 static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
-		if (force_printkthreads()) {
-			wake_up_legacy_kthread();
+		if (force_legacy_kthread()) {
+			legacy_kthread_wake();
 		} else {
-			/*
-			 * If trylock fails, some other context
-			 * will do the printing.
-			 */
 			if (console_trylock())
 				console_unlock();
 		}
@@ -4436,7 +4477,6 @@ static void __wake_up_klogd(int val)
 		return;
 
 	preempt_disable();
-
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the wait queue is empty.
@@ -4448,22 +4488,11 @@ static void __wake_up_klogd(int val)
 	 *
 	 * This pairs with devkmsg_read:A and syslog_print:A.
 	 */
-	if (!wq_has_sleeper(&log_wait)) /* LMM(__wake_up_klogd:A) */
-		val &= ~PRINTK_PENDING_WAKEUP;
-
-	/*
-	 * Simple read is safe. register_console() would flush a newly
-	 * registered legacy console when writing the message about it
-	 * being enabled.
-	 */
-	if (!printing_via_unlock)
-		val &= ~PRINTK_PENDING_OUTPUT;
-
-	if (val) {
+	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
+	    (val & PRINTK_PENDING_OUTPUT)) {
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
-
 	preempt_enable();
 }
 
@@ -4505,7 +4534,6 @@ void defer_console_output(void)
 
 void printk_trigger_flush(void)
 {
-	nbcon_wake_threads();
 	defer_console_output();
 }
 
@@ -4839,9 +4867,15 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
  */
 void console_try_replay_all(void)
 {
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
 	if (console_trylock()) {
 		__console_rewind_all();
-		nbcon_wake_threads();
+		if (ft.nbcon_offload)
+			nbcon_kthreads_wake();
+		if (ft.legacy_offload)
+			defer_console_output();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index bd2a892deac1a..ba778e2ef28b9 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -403,10 +403,12 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #define __u64seq_to_ulseq(u64seq) (u64seq)
 #define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+#define ULSEQ_MAX(rb) (-1)
 
 #else /* CONFIG_64BIT */
 
 #define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+#define ULSEQ_MAX(rb) __u64seq_to_ulseq(prb_first_seq(rb) + 0x80000000UL)
 
 static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 {
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index f47fef7012652..2b35a9d3919d8 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,13 +38,15 @@ void __printk_deferred_exit(void)
 	__printk_safe_exit();
 }
 
-bool is_printk_deferred(void)
+bool is_printk_legacy_deferred(void)
 {
 	/*
 	 * The per-CPU variable @printk_context can be read safely in any
-	 * context. The CPU migration always disabled when set.
+	 * context. CPU migration is always disabled when set.
 	 */
-	return (this_cpu_read(printk_context) || in_nmi());
+	return (force_legacy_kthread() ||
+		this_cpu_read(printk_context) ||
+		in_nmi());
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)
@@ -59,7 +61,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (is_printk_deferred())
+	if (is_printk_legacy_deferred())
 		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be2d251e84f84..f6b35a0585a8b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -643,7 +643,6 @@ static void synchronize_rcu_expedited_wait(void)
 				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 				dump_cpu_task(cpu);
 				preempt_enable();
-				nbcon_cpu_emergency_flush();
 			}
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
@@ -819,7 +818,6 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
-		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c6fb4863ed8bc..b3a6943127bca 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -261,7 +261,6 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
-		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
@@ -525,7 +524,6 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 
 	print_cpu_stat_info(cpu);
-	nbcon_cpu_emergency_flush();
 }
 
 /* Complain about starvation of grace-period kthread.  */
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index eab0dc66bee6b..cc73253294963 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/seqlock.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
@@ -17,6 +17,11 @@
 #include <net/netfilter/nf_tables_offload.h>
 
 struct nft_counter {
+	u64_stats_t	bytes;
+	u64_stats_t	packets;
+};
+
+struct nft_counter_tot {
 	s64		bytes;
 	s64		packets;
 };
@@ -25,25 +30,24 @@ struct nft_counter_percpu_priv {
 	struct nft_counter __percpu *counter;
 };
 
-static DEFINE_PER_CPU(seqcount_t, nft_counter_seq);
+static DEFINE_PER_CPU(struct u64_stats_sync, nft_counter_sync);
 
 static inline void nft_counter_do_eval(struct nft_counter_percpu_priv *priv,
 				       struct nft_regs *regs,
 				       const struct nft_pktinfo *pkt)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	write_seqcount_begin(myseq);
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->bytes, pkt->skb->len);
+	u64_stats_inc(&this_cpu->packets);
+	u64_stats_update_end(nft_sync);
 
-	this_cpu->bytes += pkt->skb->len;
-	this_cpu->packets++;
-
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
@@ -66,17 +70,16 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
+	this_cpu = raw_cpu_ptr(cpu_stats);
 	if (tb[NFTA_COUNTER_PACKETS]) {
-	        this_cpu->packets =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS]));
+		u64_stats_set(&this_cpu->packets,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS])));
 	}
 	if (tb[NFTA_COUNTER_BYTES]) {
-		this_cpu->bytes =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES]));
+		u64_stats_set(&this_cpu->bytes,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES])));
 	}
-	preempt_enable();
+
 	priv->counter = cpu_stats;
 	return 0;
 }
@@ -104,40 +107,41 @@ static void nft_counter_obj_destroy(const struct nft_ctx *ctx,
 }
 
 static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
+
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, -total->packets);
+	u64_stats_add(&this_cpu->bytes, -total->bytes);
+	u64_stats_update_end(nft_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets -= total->packets;
-	this_cpu->bytes -= total->bytes;
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
 static void nft_counter_fetch(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
 	struct nft_counter *this_cpu;
-	const seqcount_t *myseq;
 	u64 bytes, packets;
 	unsigned int seq;
 	int cpu;
 
 	memset(total, 0, sizeof(*total));
 	for_each_possible_cpu(cpu) {
-		myseq = per_cpu_ptr(&nft_counter_seq, cpu);
+		struct u64_stats_sync *nft_sync = per_cpu_ptr(&nft_counter_sync, cpu);
+
 		this_cpu = per_cpu_ptr(priv->counter, cpu);
 		do {
-			seq	= read_seqcount_begin(myseq);
-			bytes	= this_cpu->bytes;
-			packets	= this_cpu->packets;
-		} while (read_seqcount_retry(myseq, seq));
+			seq	= u64_stats_fetch_begin(nft_sync);
+			bytes	= u64_stats_read(&this_cpu->bytes);
+			packets	= u64_stats_read(&this_cpu->packets);
+		} while (u64_stats_fetch_retry(nft_sync, seq));
 
 		total->bytes	+= bytes;
 		total->packets	+= packets;
@@ -148,7 +152,7 @@ static int nft_counter_do_dump(struct sk_buff *skb,
 			       struct nft_counter_percpu_priv *priv,
 			       bool reset)
 {
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -237,7 +241,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -245,11 +249,9 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
-	this_cpu->packets = total.packets;
-	this_cpu->bytes = total.bytes;
-	preempt_enable();
+	this_cpu = raw_cpu_ptr(cpu_stats);
+	u64_stats_set(&this_cpu->packets, total.packets);
+	u64_stats_set(&this_cpu->bytes, total.bytes);
 
 	priv_clone->counter = cpu_stats;
 	return 0;
@@ -267,17 +269,17 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 				      const struct flow_stats *stats)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets += stats->pkts;
-	this_cpu->bytes += stats->bytes;
-	write_seqcount_end(myseq);
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, stats->pkts);
+	u64_stats_add(&this_cpu->bytes, stats->bytes);
+	u64_stats_update_end(nft_sync);
 	local_bh_enable();
 }
 
@@ -286,7 +288,7 @@ void nft_counter_init_seqcount(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
+		u64_stats_init(per_cpu_ptr(&nft_counter_sync, cpu));
 }
 
 struct nft_expr_type nft_counter_type;
