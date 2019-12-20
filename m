Return-Path: <SRS0=WSWX=2K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A2C43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0657218AC
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTNxu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:53:50 -0500
Received: from mail.softplc.com ([206.126.248.66]:3499 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfLTNxu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Dec 2019 08:53:50 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Fri, 20 Dec 2019 08:53:48 -0500
  id 00000000001E0005.000000005DFCD26D.00006BA7
Subject: Re: 8250: set_ier(), clear_ier() and the concept of atomic console
 writes
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com>
 <87woarjucv.fsf@linutronix.de>
From:   Dick Hollenbeck <dick@softplc.com>
Message-ID: <58f88e2b-de16-0c0a-b863-521b13ae45de@softplc.com>
Date:   Fri, 20 Dec 2019 07:53:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87woarjucv.fsf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

I've included a partial patch against Greg KH's tree below just to convey the design
concepts that I introduce below in 4), 5) and 6).

Hopefully this can draw a bridge between mainline, RT and where Greg is going with his
tree, and make everyone happy.


On 12/20/19 2:04 AM, John Ogness wrote:
> (added printk maintainers CC)
> 
> Hi Dick,
> 
> On 2019-12-19, Dick Hollenbeck <dick@softplc.com> wrote:
>> Let's talk serially:
>>
>> When using serial port debug printing, I have always dedicated a
>> serial port for that.  In contrast, I have never tried to dovetail
>> debug messages with actual other use of the serial port.  I don't
>> understand the use case for changing to polled mode on the fly and
>> then changing back.  I could not disconnect the normal use (interrupt
>> driven) serial cable and then rapidly attach another serial cable
>> intended for capturing debug messages in time to see a polled debug
>> message interleaved with normal port usage.  So I think the use case
>> contemplated by the current code is rare if non-existent.  And the
>> result is that the code is super ugly.
> 
> In Linux there are consoles, which I dare say is a common use case for
> UARTs (i.e debug messages interleaved with normal port usage is not rare
> and definitely exists).
> 
>> In fact the serial port code is getting uglier by the month. Its
>> gotten too complex and bulkier for weird apparent requirements.  When
>> those corner case requirements are met such that concurrent use is
>> mandated, the solution is always more complex than if requirements can
>> be considered mutually exclusive.  (e.g. Who prints debug statements
>> onto a serial cable that is already in use for a MODBUS driver?  How
>> would you see those print statements easily?)
>>
>> But for now, I drill down to a specific complaint.
>>
>> I am looking at branch linux-5.2.y-rt-rebase, file:
>>   drivers/tty/serial/8250/8250_core.c
>>   commit 82dfc28946eacceae by John Ogness.
>>
>>
>> Here is a belated partial patch review, and would be some of the
>> reasons I could not accept this patch if I was in charge of mainline:
> 
> Thanks. I've been waiting nearly a year for feedback on these patches.
> 
>> 1) The mutual exclusion used in set_eir() clear_ier() feels like the
>> big kernel lock all over again.  All ports using the same lock....
> 
> Yes, this is a problem. Only consoles should be using the cpu-lock. I
> will address this.
> 
>> 2) Those functions are in an 8250 specific area but do not have 8250
>> specific names, and they are public.
> 
> So you would like to see them renamed to:
> 
>    serial8250_set_ier()
>    serial8250_clear_ier()
>    serial8250_restore_ier()
> 
>> 3) The lock used in set_eir() & clear_eir() puts the CPU into atomic
>> mode and then calls serial_port_out().  This assumes that we know
>> everything there will ever be to know about serial_port_out(), even
>> though it is an abstraction, with multiple implementations now and
>> more in the future.

4) If possible, I'd suggest using the "save prior IER on stack" design pattern rather than
a global for all ports.  If you can use the save on stack pattern, then you should drop
the restore_ier() function and simply re-use set_ier() to restore (but with the new name
for that function.) See attached partial patch.

5) The NMI support enabled via your set_ier() and friends is an out of line function.  I'd
prefer that the normal use case as in mainline be done static inline out of the header
file, and then when configured, you take us into an out of line function for your locking.
 See attached partial patch.

6) Greg KH has some similarly named functions in play in his tree, I think we have the
best chance of an RT merge if we follow his lead WRT function naming.

My serial8250_set_IER() introduces two concepts:

a) it returns the prior value for saving on the stack if needed, and I suspect this gets
optimized out if not used at a particular usage site.

b) it religiously tracks the value being sent to the hardware so that we can nearly always
forego reading from the IER hardware.  There are one or two exceptions which pertain to
the tests for hardware personality.  As to the performance hit of this additional write to
the C structure, this is less than the out of line function call that you introduced, and
will be offset by a faster reading of the contents of the IER since it is cached in the
struct (although those cases are rare).  And lastly it cleans up the code by removing the
setting of the up->ier before outputting the modified value.  The function makes the
modification with the setting a combined operation, although one should not assume this is
always atomic.


> 
> Mainline serial8250_console_write() calls serial_port_out() in atomic
> context as well. So this is already a requirement of serial_port_out(),
> at least for consoles. And if the cpu-lock is only taken for consoles
> (see my response to #1), then this should not introduce any new issues.
> 
>> In fact, the future is now.  I have expanded serial_port_out() to use
>> a spinlock because my UART is in an FPGA, along with other peripherals
>> which share a common FPGA interface.  The spinlock gets remapped to
>> rt_mutex.  When there is a collision on that mutex somebody must get
>> suspended, and then I see the kernel report of:
>>
>> BUG: scheduling while atomic: irq/56-ttyS5/592/0x00000002
> 
> If your FPGA-UART should be a console, then it is a bug in your
> implementation (for mainline as well). I don't know if non-consoles also
> have atomic requirements.
> 
>> fpga_write() is where the rt_mutex is, aka spinlock in true source
>> representation.  I can run a couple million bytes through that
>> function for UARTs and other peripherals, but you know RT, if can go
>> wrong it will, and it eventually does.
>>
>> The atomic mode was entered in the common (shared_by_all_ports) serial
>> lock in console_atomic_lock().  This is because the author was trying
>> to provide mutual exclusion between debug messages and actual normal
>> serial port use.  I think that is fool's gold.  I have no problem with
>> serial port debug messages, but I don't share a port when I am using
>> them.
> 
> You don't use your debug serial port as a console. That is a wise
> choice that unfortunately most people will not make.
> 
>> So the next question is, do I go to a raw spin lock in my
>> fpga_write(), or do I try and fix the usage of console_atomic_lock()
>> in set_eir() and clear_eir()?
> 
> - I will change the functions to only take the cpu-lock if the 8250 is a
>   console.
> 
> - I will rename the functions to serial8250_*.
> 
> I believe that will address your main points. However, if you want to
> use your FPGA-UART as a console, you will need to change to a raw spin
> lock (even for mainline).
> 
> Thanks for the feedback.
> 
> John Ogness
> 


diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 33ad9d6de..e035e91ac 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -130,12 +130,31 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 	up->dl_write(up, value);
 }

+/* All write access to IER comes through here, for instrumentation sake. */
+static inline unsigned char serial8250_set_IER(struct uart_8250_port *up, unsigned char ier)
+{
+#ifdef CONFIG_NMI_CONSOLE_CORNER_CASE
+	return __serial9250_set_IER(p, ier)
+#else
+	unsigned char prior = up->ier;
+
+	up->ier = ier;	/* struct's ier field is always current with hardware */
+	serial_out(up, UART_IER, ier);
+	return prior;
+#endif
+}
+
+static inline unsigned char serial8250_clear_IER(struct uart_8250_port *up)
+{
+	return serial8250_set_IER(up, up->capabilities & UART_CAP_UUE ? UART_IER_UUE : 0);
+}
+
 static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 {
 	if (up->ier & UART_IER_THRI)
 		return false;
-	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+
+	serial8250_set_IER(up, up->ier | UART_IER_THRI);
 	return true;
 }

@@ -143,8 +162,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 {
 	if (!(up->ier & UART_IER_THRI))
 		return false;
-	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier & ~UART_IER_THRI);
 	return true;
 }

@@ -343,3 +361,7 @@ static inline int serial_index(struct uart_port *port)
 {
 	return port->minor - 64;
 }
+
+#ifdef CONFIG_NMI_CONSOLE_CORNER_CASE
+unsigned char __serial8250_set_IER(struct uart_8250_port *up, unsigned char ier);
+#endif
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 90655910b..61ace3349 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -721,7 +721,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 			serial_out(p, UART_EFR, UART_EFR_ECB);
 			serial_out(p, UART_LCR, 0);
 		}
-		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
+		serial8250_set_IER(p, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
 			serial_out(p, UART_EFR, efr);
@@ -1113,13 +1113,13 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * already a 1 and maybe locked there before we even start start.
 	 */
 	iersave = serial_in(up, UART_IER);
-	serial_out(up, UART_IER, iersave & ~UART_IER_UUE);
+	serial825_set_IER(up, iersave & ~UART_IER_UUE);
 	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
 		/*
 		 * OK it's in a known zero state, try writing and reading
 		 * without disturbing the current state of the other bits.
 		 */
-		serial_out(up, UART_IER, iersave | UART_IER_UUE);
+		serial8250_set_IER(up, iersave | UART_IER_UUE);
 		if (serial_in(up, UART_IER) & UART_IER_UUE) {
 			/*
 			 * It's an Xscale.
@@ -1137,7 +1137,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		 */
 		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
 	}
-	serial_out(up, UART_IER, iersave);
+	serial8250_set_IER(up, iersave);

 	/*
 	 * We distinguish between 16550A and U6 16550A by counting
@@ -1194,7 +1194,7 @@ static void autoconfig(struct uart_8250_port *up)
 		 * and the device is in "PC" mode.
 		 */
 		scratch = serial_in(up, UART_IER);
-		serial_out(up, UART_IER, 0);
+		serial8250_set_IER(up, 0);
 #ifdef __i386__
 		outb(0xff, 0x080);
 #endif
@@ -1203,12 +1203,12 @@ static void autoconfig(struct uart_8250_port *up)
 		 * 16C754B) allow only to modify them if an EFR bit is set.
 		 */
 		scratch2 = serial_in(up, UART_IER) & 0x0f;
-		serial_out(up, UART_IER, 0x0F);
+		serial8250_set_IER(up, 0x0F);
 #ifdef __i386__
 		outb(0, 0x080);
 #endif
 		scratch3 = serial_in(up, UART_IER) & 0x0f;
-		serial_out(up, UART_IER, scratch);
+		serial8250_set_IER(up, scratch);
 		if (scratch2 != 0 || scratch3 != 0x0F) {
 			/*
 			 * We failed; there's nothing here
@@ -1304,10 +1304,7 @@ static void autoconfig(struct uart_8250_port *up)
 	serial8250_out_MCR(up, save_mcr);
 	serial8250_clear_fifos(up);
 	serial_in(up, UART_RX);
-	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
-	else
-		serial_out(up, UART_IER, 0);
+	serial8250_clear_IER(up);

 out_lock:
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1361,7 +1358,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		serial8250_out_MCR(up,
 			UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
-	serial_out(up, UART_IER, 0x0f);	/* enable all intrs */
+	serial8250_set_IER(up, 0x0f);	/* enable all intrs */
 	serial_in(up, UART_LSR);
 	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
@@ -1371,7 +1368,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	irq = probe_irq_off(irqs);

 	serial8250_out_MCR(up, save_mcr);
-	serial_out(up, UART_IER, save_ier);
+	serial8250_set_IER(up, save_ier);

 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
@@ -1388,10 +1385,8 @@ static void serial8250_stop_rx(struct uart_port *port)

 	serial8250_rpm_get(up);

-	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_port_out(port, UART_IER, up->ier);
-
+	serial8250_set_IER(up, up->ier & ~(UART_IER_RLSI | UART_IER_RDI));
 	serial8250_rpm_put(up);
 }

@@ -1406,9 +1401,7 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		serial8250_clear_and_reinit_fifos(p);
-
-		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_port_out(&p->port, UART_IER, p->ier);
+		serial8250_set_IER(p, p->ier | UART_IER_RLSI | UART_IER_RDI);
 	}
 }
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
@@ -1615,8 +1608,7 @@ static void serial8250_disable_ms(struct uart_port *port)

 	mctrl_gpio_disable_ms(up->gpios);

-	up->ier &= ~UART_IER_MSI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier & ~UART_IER_MSI);
 }

 static void serial8250_enable_ms(struct uart_port *port)
@@ -1629,10 +1621,9 @@ static void serial8250_enable_ms(struct uart_port *port)

 	mctrl_gpio_enable_ms(up->gpios);

-	up->ier |= UART_IER_MSI;
-
 	serial8250_rpm_get(up);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier | UART_IER_MSI);
+
 	serial8250_rpm_put(up);
 }

@@ -2026,16 +2017,14 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	struct uart_8250_port *up = up_to_u8250p(port);

 	serial8250_rpm_get(up);
+
 	/*
-	 *	First save the IER then disable the interrupts
+	 *	Save existing IER and disable the interrupts
 	 */
-	ier = serial_port_in(port, UART_IER);
-	if (up->capabilities & UART_CAP_UUE)
-		serial_port_out(port, UART_IER, UART_IER_UUE);
-	else
-		serial_port_out(port, UART_IER, 0);
+	ier = serial8250_clear_IER(up);

 	wait_for_xmitr(up, BOTH_EMPTY);
+
 	/*
 	 *	Send the character out.
 	 */
@@ -2046,7 +2035,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_port_out(port, UART_IER, ier);
+	serial9250_set_IER(up, ier);
 	serial8250_rpm_put(up);
 }

@@ -2076,7 +2065,7 @@ int serial8250_do_startup(struct uart_port *port)
 		up->acr = 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
-		serial_port_out(port, UART_IER, 0);
+		serial8250_set_IER(up, 0);
 		serial_port_out(port, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -2086,7 +2075,7 @@ int serial8250_do_startup(struct uart_port *port)

 	if (port->type == PORT_DA830) {
 		/* Reset the port */
-		serial_port_out(port, UART_IER, 0);
+		serial8250_set_IER(up, 0);
 		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
 		mdelay(10);

@@ -2196,11 +2185,11 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
 		iir1 = serial_port_in(port, UART_IIR);
-		serial_port_out(port, UART_IER, 0);
+		serial8250_set_IER(up, 0);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow a working UART time to re-assert THRE */
 		iir = serial_port_in(port, UART_IIR);
-		serial_port_out(port, UART_IER, 0);
+		serial8250_set_IER(up, 0);

 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
@@ -2257,10 +2246,10 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Do a quick test to see if we receive an interrupt when we enable
 	 * the TX irq.
 	 */
-	serial_port_out(port, UART_IER, UART_IER_THRI);
+	serial8250_set_IER(up, UART_IER_THRI);
 	lsr = serial_port_in(port, UART_LSR);
 	iir = serial_port_in(port, UART_IIR);
-	serial_port_out(port, UART_IER, 0);
+	serial8250_set_IER(up, 0);

 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
@@ -2339,8 +2328,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Disable interrupts from this port
 	 */
 	spin_lock_irqsave(&port->lock, flags);
-	up->ier = 0;
-	serial_port_out(port, UART_IER, 0);
+	serial8250_set_IER(up, 0);
 	spin_unlock_irqrestore(&port->lock, flags);

 	synchronize_irq(port->irq);
@@ -2625,7 +2613,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios
*termios,
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;

-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);

 	if (up->capabilities & UART_CAP_EFR) {
 		unsigned char efr = 0;
@@ -3142,14 +3130,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		spin_lock_irqsave(&port->lock, flags);

 	/*
-	 *	First save the IER then disable the interrupts
+	 *	Save the existing IER and disable the interrupts
 	 */
-	ier = serial_port_in(port, UART_IER);
-
-	if (up->capabilities & UART_CAP_UUE)
-		serial_port_out(port, UART_IER, UART_IER_UUE);
-	else
-		serial_port_out(port, UART_IER, 0);
+	ier = serial8250_clear_IER(up);

 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3164,7 +3147,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_port_out(port, UART_IER, ier);
+	serial8250_set_IER(up, ier);

 	/*
 	 *	The receive handling will happen properly because the
