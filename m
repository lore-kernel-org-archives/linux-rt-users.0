Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CBBC54FCB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4B220780
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDWUPo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUPo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 16:15:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8AB20724;
        Thu, 23 Apr 2020 20:15:42 +0000 (UTC)
Date:   Thu, 23 Apr 2020 16:15:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200423161541.49ca0ab3@gandalf.local.home>
In-Reply-To: <nycvar.YFH.7.76.2004232141590.19713@cbobk.fhfr.pm>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
        <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
        <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
        <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
        <20200423160707.hqt5wjinzcec2yig@linutronix.de>
        <nycvar.YFH.7.76.2004232141590.19713@cbobk.fhfr.pm>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 23 Apr 2020 21:48:20 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 23 Apr 2020, Sebastian Andrzej Siewior wrote:
> 
> > The IRQ4 is edge and in charge of ttyS0. It is handled by 
> > handle_edge_irq() and after ->irq_ack(), the thread is woken up and then 
> > we get another ->handle_edge_irq() for IRQ4. With larger PASS_LIMIT the 
> > thread runs longer so note_interrupt() will make less IRQ_HANDLED based 
> > on ->threads_handled_last. If it observes 100 handled within 100000 
> > interrupts then the counters are reset again. On !RT it usually manages 
> > to get >100 per 100000 interrupts so it appears good. On RT it gets less 
> > and the interrupt gets disabled.
> > 
> > So it is not RT related, but RT triggers it more reliably (also the 
> > PASS_LIMIT change can vanish). I can't tell if this is a qemu bug in 
> > emulating the HW or not. I can't reproduce it real HW. I see a second 
> > edge interrupt only after the thread completed. I can't tell if this is 
> > because it is a real UART and the data is flowing slower or because the 
> > edge-IRQ is not triggered repeatedly.  
> 
> Yeah, it's all strange. In the hope of understanding the issue a little 
> bit better, I tried to disable IRQs in serial8250_handle_irq() to mimic 
> what !PREEMPT_RT spinlock would do; the idea was that this is some kind of 
> strange race / memory ordering (missed ack?) between the threaded irq4 
> handler and the do_IRQ() -> handle_edge_irq() -> ... path.
> 
> So I did this:
> 
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e31217e8dce6..1a577305e174 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1813,12 +1813,13 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  {
>  	unsigned char status;
> -	unsigned long flags;
> +	unsigned long flags, f;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
>  	if (iir & UART_IIR_NO_INT)
>  		return 0;
>  
> +	local_irq_save(f);
>  	spin_lock_irqsave(&port->lock, flags);

Note, this would break if there ever was a contention, as the spin lock is
a mutex and would sleep. And we don't want to do that with interrupts
disabled!

>  
>  	status = serial_port_in(port, UART_LSR);
> @@ -1833,6 +1834,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  		serial8250_tx_chars(up);
>  
>  	uart_unlock_and_check_sysrq(port, flags);
> +	local_irq_restore(f);
>  	return 1;
>  }
> 
> But curiously enough, that exploded in the oposite order (so first there 
> was CPU stall, and only later the disabling of IRQ4 due to spurious 
> storm):


Now what may be interesting to try is to enable tracing and
ftrace_dump_on_opps, and set panic_on_warning, as well as
traceoff_on_warning.


 # echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
 # echo 1 > /proc/sys/kernel/panic_on_warn
 # echo 1 > /proc/sys/kernel/traceoff_on_warning
 # echo 1 > /sys/kernel/tracing/events/enable

Enabling all events will include interrupt events and wake ups, and perhaps
give you an idea what interrupts are happening after the uart thread is
woken.

-- Steve
