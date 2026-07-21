Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D744607D;
	Tue, 21 Jul 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646559; cv=none; b=eNwWEHUEHtr2FdJigRqTNj6uPiixiY8EzK0rW8ArLPR+ML5X0S8lYVkD9cNd9Zs4F4XlDUdfP4oug/jp+09+YYrxyEodXuENXkrI0S2vF/pHAMzlXOjZSPw6dG8CPyRY/hh0BhR4uT9Gbt18lOJp9GdH5wLz/EUQIvGi8pjWuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646559; c=relaxed/simple;
	bh=xb9lvXzNIVN92FWHjr7yYFP1zI3lxgtI1P8XDTvnttQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZSwpGN5FYesJE1u3/CxFPv0RRyIERrZBbe4MaEDNpskgoqXSUEwzeGlWO0HcznHJZpd8DoiAqM/+31QB2uiCGULksmV98YVPWV4N8aZVtv26wqOz+/+faMs65vGr4/Z1Y6FRwhTmPi/2zsjJ0mR6zXfm6NUdo3Ynu3m+R7kWhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGkO6FVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZR0DmHz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGkO6FVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZR0DmHz"
Date: Tue, 21 Jul 2026 17:09:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784646556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dRd3BvVE6JL0B22IgwttXpAjm8q7DMONyN3c4Kx3iIA=;
	b=MGkO6FVL26HDdc3aTyma7ZHvKVinLKeXkm1WaL3kpzv/HtN9y4gGCBi2SqIsBqRD+/mkhF
	N8S8z7B68hTpI3NcgNGzJhpErIwOKR8psphS3LfT7BtLnv8/FAcBRXahDWHKtVRdVJNAeR
	6vZfIX3kQFbVP4mwA8uunxyS38IgPVksSKd/kOXhzZBsA9N84Fak2FHXFc8HFLoN07V3lE
	6LCKkoc2KIQSIYECQZ5Nz0uBBPvTVeGy4EUEjsoDSkuQIPHdZ4wlmBwBiglB4Y4YV/ktH/
	R3VzLZJNagzG+CF9jjk7gPVyIPAJnNnoePUJ2x8/A81aTQFMfdRx5GcVT4aAIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784646556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dRd3BvVE6JL0B22IgwttXpAjm8q7DMONyN3c4Kx3iIA=;
	b=LZR0DmHzJ4qT8Ayub+rAMaoNW+Nh6Qrfk9AMR/zc5Fo5AeSbInIiG+sxN9r3oQNNkqe68x
	jgVGCfLxKX43HmDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v7.2-rc4-rt3
Message-ID: <20260721150914.gnlewgrV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v7.2-rc4-rt3 patch set. 

Changes since v7.2-rc4-rt2:

  - Update the 8250 nbcon series as per John
	https://lore.kernel.org/lkml/20260720103242.7265-1-john.ogness@linutronix.de/
  - ARM could issue a "sleeping while atomic warning" if user land used
    an "invalid opcode". Patch by Xie Yuanbin.
  - ARM didn't use perform POSIX CPU timers in task_work as it should.
    This was accidentally dropped in v6.18-rc4-rt3. Patch by Karl
    Mehltretter.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v7.2-rc4-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/incr/patch-7.2-rc4-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v7.2-rc4-rt3

The RT patch against v7.2-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patch-7.2-rc4-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patches-7.2-rc4-rt3.tar.xz

Sebastian

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9187240a02db5..f073b5102d4ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -133,6 +133,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index afbd2ebe5c39d..6aa205a929205 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -375,6 +375,7 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
 		unsigned long err, unsigned long trap)
 {
 	if (user_mode(regs)) {
+		local_irq_enable();
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index bf358604f3dff..7598ccd9319e4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -609,6 +609,9 @@ void serial8250_suspend_port(int line)
 	struct uart_8250_port *up = &serial8250_ports[line];
 	struct uart_port *port = &up->port;
 
+	/* No irq_work may be queued when suspending. */
+	up->avoid_modem_status_work = true;
+
 	if (!console_suspend_enabled && uart_console(port) &&
 	    port->type != PORT_8250) {
 		unsigned char canary = 0xa5;
@@ -645,6 +648,12 @@ void serial8250_resume_port(int line)
 		port->uartclk = 921600*16;
 	}
 	uart_resume_port(&serial8250_reg, port);
+
+	/* irq_work allowed again. Handle MSR now if pending. */
+	up->avoid_modem_status_work = false;
+	guard(uart_port_lock_irqsave)(port);
+	if (uart_console(port) && up->msr_saved_flags)
+		serial8250_modem_status(up);
 }
 EXPORT_SYMBOL(serial8250_resume_port);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4263e423a0a38..aa4b0780638fb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3260,8 +3260,8 @@ void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
 		 * the ownership might timeout. The new owner will wait
 		 * for UART_LSR_THRE before reusing the fifo.
 		 */
-               if (wctxt && !nbcon_can_proceed(wctxt))
-                       return;
+		if (wctxt && !nbcon_can_proceed(wctxt))
+			return;
 
 		if (wait_for_lsr(up, UART_LSR_THRE))
 			return;
@@ -3501,10 +3501,21 @@ void serial8250_console_write(struct uart_8250_port *up,
 		 * For atomic, it must be deferred to irq_work because this
 		 * may be a context that does not permit waking up tasks.
 		 */
-		if (is_atomic)
-			irq_work_queue(&up->modem_status_work);
-		else
+		if (is_atomic) {
+			/*
+			 * For atomic, MSR handling must be deferred to
+			 * irq_work because this may be a context that does
+			 * not permit waking up tasks.
+			 *
+			 * But no irq_work may be queued when suspending.
+			 * In that case, the MSR handling will occur during
+			 * resume in serial8250_resume_port().
+			 */
+			if (!up->avoid_modem_status_work)
+				irq_work_queue(&up->modem_status_work);
+		} else {
 			serial8250_modem_status(up);
+		}
 	}
 
 	nbcon_exit_unsafe(wctxt);
@@ -3535,9 +3546,8 @@ static void modem_status_handler(struct irq_work *iwp)
 	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, modem_status_work);
 	struct uart_port *port = &up->port;
 
-	uart_port_lock(port);
+	guard(uart_port_lock)(port);
 	serial8250_modem_status(up);
-	uart_port_unlock(port);
 }
 
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 03b17423fc5af..12c2f6aadd420 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -158,6 +158,9 @@ struct uart_8250_port {
 	 */
 	bool			console_line_ended;
 
+	/* Do not queue irq_work for MSR handling when suspending. */
+	bool			avoid_modem_status_work;
+
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 	struct irq_work		modem_status_work;
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
