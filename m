Return-Path: <SRS0=WLQy=6I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D6C55186
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0982420857
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgDXTTu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXTTu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Apr 2020 15:19:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7EC09B048;
        Fri, 24 Apr 2020 12:19:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jS3rW-00040k-1m; Fri, 24 Apr 2020 21:19:46 +0200
Date:   Fri, 24 Apr 2020 21:19:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200424191945.an42attvo7pdt3qz@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
 <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
 <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
 <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
 <20200423160707.hqt5wjinzcec2yig@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200423160707.hqt5wjinzcec2yig@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-23 18:07:07 [+0200], To Jiri Kosina wrote:
> The IRQ4 is edge and in charge of ttyS0. It is handled by
> handle_edge_irq() and after ->irq_ack(), the thread is woken up and then
> we get another ->handle_edge_irq() for IRQ4. With larger PASS_LIMIT the
> thread runs longer so note_interrupt() will make less IRQ_HANDLED based
> on ->threads_handled_last. If it observes 100 handled within 100000
> interrupts then the counters are reset again. On !RT it usually manages
> to get >100 per 100000 interrupts so it appears good. On RT it gets less
> and the interrupt gets disabled.

so the EDGE interrupt shouldn't retrigger unless something happened that
*retriggers* the situation. I think the problem is that qemu is too
fast. Based on tracing: The IRQ happens, the threaded-handler fires up.
The threaded handler writes something into the TX FIFO. QEMU probably
transmits that byte immediately so the FIFO is empty again *and* another
interrupt is fired. It makes sense because I see one one byte written to
the FIFO followed by an interrupt, followed by another byte, followed by
an interrupt, ….
This does not happen on real hardware because it takes some time to
transmit the data so.

I already dropped PASS_LIMIT from the RT queue so it might not trigger
again. I think I'm going to make the chain-handler depend on ISA so it
the thread is invoked more often.
According to the comment it is/was required to handle some ISA issues.
I'm not sure if back then there was no SA_SHARED handling in the IRQ
core was limited or $REASON. As of today I don't see a reason to keep it
for !ISA hardware. On Debian CONFIG_ISA_BUS is disabled, I guess the
same is true for SUSE.

And with the hunk at the bottom it shouldn't trigger as well. So
PASS_LIMIT and no custom handler is duct tape. This really stops the IRQ
from being generated.

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e31217e8dce62..eadb12bf0e90b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1741,6 +1741,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	}
 
 	count = up->tx_loadsz;
+	serial8250_clear_THRI(up);
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -1755,6 +1756,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 		    !(serial_in(up, UART_LSR) & UART_LSR_THRE))
 			break;
 	} while (--count > 0);
+	serial8250_set_THRI(up);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
Sebastian
