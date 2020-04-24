Return-Path: <SRS0=WLQy=6I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D7C55186
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE16215A4
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587761700;
	bh=EGMA5JRLf/hF4Mj9LluknOKp1TvHAiE4kqkFt23/aeY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=wPLn5i6OFtYNYgOhyqJYFtB3xl/1Fm+KDMG29AEdvJtrVA0XP9MC1dL0v1jAxVQqX
	 gXtafGOdNjflAhG0/TK9d2kq77nAGPn5q6eT3cSdfAz3Pbtr4IUsEYfV8+Y4rl672v
	 Oik3bgZOX5TmVjgKT8FNJfl05PStX5vY03EBWEZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDXUy4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgDXUy4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Apr 2020 16:54:56 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82BC21556;
        Fri, 24 Apr 2020 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761695;
        bh=EGMA5JRLf/hF4Mj9LluknOKp1TvHAiE4kqkFt23/aeY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JPuzmF8ODRWbAJV/4yBQbzLTXk051Vx6v3hGoLJ2wWJKwjexnyiGpUjd2OdRy77Bx
         44ulo1ydCO1YwL7b5cRYdJh8x3nBtY/ypNdZiVTng6HhmwHl9x+21Jzxt4S7N2qm0H
         PjH5r7kEtAQNr5gzEmxmwUB6fM9VAVQ0j///YZLY=
Date:   Fri, 24 Apr 2020 22:54:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
In-Reply-To: <20200424191945.an42attvo7pdt3qz@linutronix.de>
Message-ID: <nycvar.YFH.7.76.2004242245590.19713@cbobk.fhfr.pm>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de> <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm> <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm> <20200423104559.rgplz6rqk6sg4kz7@linutronix.de> <20200423160707.hqt5wjinzcec2yig@linutronix.de>
 <20200424191945.an42attvo7pdt3qz@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 24 Apr 2020, Sebastian Andrzej Siewior wrote:

> And with the hunk at the bottom it shouldn't trigger as well. So
> PASS_LIMIT and no custom handler is duct tape. This really stops the IRQ
> from being generated.
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e31217e8dce62..eadb12bf0e90b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1741,6 +1741,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  	}
>  
>  	count = up->tx_loadsz;
> +	serial8250_clear_THRI(up);
>  	do {
>  		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> @@ -1755,6 +1756,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  		    !(serial_in(up, UART_LSR) & UART_LSR_THRE))
>  			break;
>  	} while (--count > 0);
> +	serial8250_set_THRI(up);
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);

It's still wonky; with the two hunks above on top of 5.6.4-rt3 (that's 
without the PASS_LIMIT adjustment) flooding the emulated serial console 
still emits the splat below.

Looking at this:

Code: 5b c3 48 8b 47 08 48 03 04 d5 c0 26 4d a1 48 89 c3 48 8b 00 f6 c4 02 
75 09 50 9d e8 19 dd 5e ff eb a1 e8 f2 db 5e ff ff 33 9d <eb> 97 66 66 2e 
0f 1f 84 00 00 00 00 00 66 90 55 53 31 ed 48 8b 1f
All code
========
   0:	5b                   	pop    %rbx
   1:	c3                   	retq   
   2:	48 8b 47 08          	mov    0x8(%rdi),%rax
   6:	48 03 04 d5 c0 26 4d 	add    -0x5eb2d940(,%rdx,8),%rax
   d:	a1 
   e:	48 89 c3             	mov    %rax,%rbx
  11:	48 8b 00             	mov    (%rax),%rax
  14:	f6 c4 02             	test   $0x2,%ah
  17:	75 09                	jne    0x22
  19:	50                   	push   %rax
  1a:	9d                   	popfq  
  1b:	e8 19 dd 5e ff       	callq  0xffffffffff5edd39
  20:	eb a1                	jmp    0xffffffffffffffc3
  22:	e8 f2 db 5e ff       	callq  0xffffffffff5edc19
  27:	ff 33                	pushq  (%rbx)
  29:	9d                   	popfq  
  2a:*	eb 97                	jmp    0xffffffffffffffc3		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)

So now the endless interrupt storm comes at a different point -- exactly 
once IRQs get re-enabled in prb_unlock(). How we reach prb_unlock() from 
serial8250_tx_chars() I still have to understand. Worth involving John?

Thanks.


====== cut here ========
[   75.286440] 000: rcu: INFO: rcu_preempt self-detected stall on CPU
[   75.286533] 000: rcu: 	0-....: (1 GPs behind) idle=94a/1/0x4000000000000002 softirq=0/0 fqs=5167 
[   75.286556] 000: 	(t=21000 jiffies g=15213 q=25248)
[   75.286557] 000: NMI backtrace for cpu 0
[   75.286567] 000: CPU: 0 PID: 1209 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19-00003-g5cf51e8702ad #16
[   75.286570] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   75.286578] 000: Call Trace:
[   75.288543] 000:  <IRQ>
[   75.288557] 000:  dump_stack+0x71/0x9b
[   75.288574] 000:  nmi_cpu_backtrace+0x8a/0x90
[   75.288578] 000:  ? lapic_can_unplug_cpu+0xd0/0xd0
[   75.288585] 000:  nmi_trigger_cpumask_backtrace+0xe9/0x130
[   75.288587] 000:  rcu_dump_cpu_stacks+0x93/0xcd
[   75.288592] 000:  rcu_sched_clock_irq+0x70f/0xae0
[   75.288595] 000:  ? cpuacct_account_field+0x1b/0x70
[   75.288603] 000:  ? tick_sched_do_timer+0x60/0x60
[   75.288607] 000:  update_process_times+0x24/0x50
[   75.288610] 000:  tick_sched_handle+0x34/0x50
[   75.288612] 000:  tick_sched_timer+0x43/0x80
[   75.288617] 000:  __hrtimer_run_queues+0x123/0x3c0
[   75.288620] 000:  hrtimer_interrupt+0xef/0x250
[   75.288622] 000:  smp_apic_timer_interrupt+0x89/0x200
[   75.288631] 000:  apic_timer_interrupt+0xf/0x20
[   75.288636] 000:  </IRQ>
[   75.288637] 000: RIP: 0010:prb_unlock+0x71/0x80
[   75.288642] 000: Code: 5b c3 48 8b 47 08 48 03 04 d5 c0 26 4d a1 48 89 c3 48 8b 00 f6 c4 02 75 09 50 9d e8 19 dd 5e ff eb a1 e8 f2 db 5e ff ff 33 9d <eb> 97 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 55 53 31 ed 48 8b 1f
[   75.288648] 000: RSP: 0018:ffffbc8cc08cbde0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[   75.288649] 000: RAX: 0000000000000000 RBX: ffff9dd2fcc18a48 RCX: 0000000000000000
[   75.288650] 000: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0d7220e
[   75.288651] 000: RBP: ffff9dd2f8878000 R08: 0000000000000001 R09: 0000000000000001
[   75.288652] 000: R10: 0000000000000001 R11: 0000000000292836 R12: 0000000000000000
[   75.288653] 000: R13: 0000000000000020 R14: 0000000000000001 R15: ffff9dd276c10078
[   75.288656] 000:  ? prb_unlock+0x6e/0x80
[   75.288658] 000:  serial8250_tx_chars+0x3b5/0x410
[   75.288663] 000:  serial8250_handle_irq.part.26+0xc0/0xd0
[   75.288665] 000:  serial8250_default_handle_irq+0x4a/0x60
[   75.288667] 000:  serial8250_interrupt+0x56/0xa0
[   75.288669] 000:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
[   75.288671] 000:  irq_forced_thread_fn+0x30/0x80
[   75.288673] 000:  irq_thread+0xdd/0x180
[   75.288675] 000:  ? wake_threads_waitq+0x30/0x30
[   75.288676] 000:  ? irq_thread_dtor+0x90/0x90
[   75.288677] 000:  kthread+0x113/0x130
[   75.288680] 000:  ? kthread_park+0x90/0x90
[   75.288682] 000:  ret_from_fork+0x3a/0x50
[  134.432670] 000: irq 4: nobody cared (try booting with the "irqpoll" option)
[  134.432685] 000: CPU: 0 PID: 1209 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19-00003-g5cf51e8702ad #16
[  134.432690] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[  134.432696] 000: Call Trace:
[  134.432715] 000:  <IRQ>
[  134.432726] 000:  dump_stack+0x71/0x9b
[  134.432743] 000:  __report_bad_irq+0x30/0xc0
[  134.432748] 000:  note_interrupt+0x233/0x280
[  134.432752] 000:  ? prb_unlock+0x71/0x80
[  134.432756] 000:  handle_irq_event_percpu+0x73/0xa0
[  134.432758] 000:  handle_irq_event+0x4d/0x90
[  134.432760] 000:  handle_edge_irq+0x9a/0x1f0
[  134.432764] 000:  do_IRQ+0x71/0x120
[  134.432771] 000:  common_interrupt+0xf/0xf
[  134.432776] 000:  </IRQ>
[  134.432777] 000: RIP: 0010:prb_unlock+0x71/0x80
[  134.432782] 000: Code: 5b c3 48 8b 47 08 48 03 04 d5 c0 26 4d a1 48 89 c3 48 8b 00 f6 c4 02 75 09 50 9d e8 19 dd 5e ff eb a1 e8 f2 db 5e ff ff 33 9d <eb> 97 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 55 53 31 ed 48 8b 1f
[  134.432785] 000: RSP: 0018:ffffbc8cc08cbde0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffdb
[  134.432786] 000: RAX: 0000000000000000 RBX: ffff9dd2fcc18a48 RCX: 0000000000000000
[  134.432790] 000: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0d7220e
[  134.432791] 000: RBP: ffff9dd2f8878000 R08: 0000000000000001 R09: ffffbc8cc08cbd80
[  134.432792] 000: R10: 0000000000000001 R11: 000000000000010e R12: 0000000000000000
[  134.432795] 000: R13: 0000000000000020 R14: 0000000000000001 R15: ffff9dd276c10078
[  134.432796] 000:  ? prb_unlock+0x6e/0x80
[  134.432799] 000:  serial8250_tx_chars+0x3b5/0x410
[  134.432804] 000:  serial8250_handle_irq.part.26+0xc0/0xd0
[  134.432809] 000:  serial8250_default_handle_irq+0x4a/0x60
[  134.432810] 000:  serial8250_interrupt+0x56/0xa0
[  134.432813] 000:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
[  134.432814] 000:  irq_forced_thread_fn+0x30/0x80
[  134.432816] 000:  irq_thread+0xdd/0x180
[  134.432817] 000:  ? wake_threads_waitq+0x30/0x30
[  134.432819] 000:  ? irq_thread_dtor+0x90/0x90
[  134.432819] 000:  kthread+0x113/0x130
[  134.432823] 000:  ? kthread_park+0x90/0x90
[  134.432824] 000:  ret_from_fork+0x3a/0x50
[  134.432827] 000: handlers:
[  134.432832] 000: [<0000000099290260>] irq_default_primary_handler threaded [<00000000733fcb60>] serial8250_interrupt
[  134.432833] 000: Disabling IRQ #4
[  138.287552] 000: rcu: INFO: rcu_preempt self-detected stall on CPU
[  138.287561] 000: rcu: 	0-....: (1 GPs behind) idle=94a/1/0x4000000000000002 softirq=0/0 fqs=20687 
[  138.287565] 000: 	(t=84003 jiffies g=15213 q=90211)
[  138.287566] 000: NMI backtrace for cpu 0
[  138.287572] 000: CPU: 0 PID: 1209 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19-00003-g5cf51e8702ad #16
[  138.287573] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[  138.287578] 000: Call Trace:
[  138.287590] 000:  <IRQ>
[  138.287598] 000:  dump_stack+0x71/0x9b
[  138.287607] 000:  nmi_cpu_backtrace+0x8a/0x90
[  138.287609] 000:  ? lapic_can_unplug_cpu+0xd0/0xd0
[  138.287612] 000:  nmi_trigger_cpumask_backtrace+0xe9/0x130
[  138.287616] 000:  rcu_dump_cpu_stacks+0x93/0xcd
[  138.287620] 000:  rcu_sched_clock_irq+0x70f/0xae0
[  138.287622] 000:  ? cpuacct_account_field+0x1b/0x70
[  138.287627] 000:  ? tick_sched_do_timer+0x60/0x60
[  138.287632] 000:  update_process_times+0x24/0x50
[  138.287636] 000:  tick_sched_handle+0x34/0x50
[  138.287638] 000:  tick_sched_timer+0x43/0x80
[  138.287639] 000:  __hrtimer_run_queues+0x123/0x3c0
[  138.287644] 000:  hrtimer_interrupt+0xef/0x250
[  138.287646] 000:  smp_apic_timer_interrupt+0x89/0x200
[  138.287650] 000:  apic_timer_interrupt+0xf/0x20
[  138.287652] 000:  </IRQ>
[  138.287655] 000: RIP: 0010:prb_unlock+0x71/0x80
[  138.287659] 000: Code: 5b c3 48 8b 47 08 48 03 04 d5 c0 26 4d a1 48 89 c3 48 8b 00 f6 c4 02 75 09 50 9d e8 19 dd 5e ff eb a1 e8 f2 db 5e ff ff 33 9d <eb> 97 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 55 53 31 ed 48 8b 1f
[  138.287664] 000: RSP: 0018:ffffbc8cc08cbde0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[  138.287666] 000: RAX: 0000000000000000 RBX: ffff9dd2fcc18a48 RCX: 0000000000000000
[  138.287667] 000: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0d7220e
[  138.287668] 000: RBP: ffff9dd2f8878000 R08: 0000000000000001 R09: ffffbc8cc08cbd80
[  138.287669] 000: R10: 0000000000000001 R11: 00000000000003e1 R12: 0000000000000010
[  138.287670] 000: R13: 0000000000000020 R14: 0000000000000001 R15: ffff9dd276c10078
[  138.287671] 000:  ? prb_unlock+0x6e/0x80
[  138.287673] 000:  serial8250_tx_chars+0x384/0x410
[  138.287675] 000:  serial8250_handle_irq.part.26+0xc0/0xd0
[  138.287677] 000:  serial8250_default_handle_irq+0x4a/0x60
[  138.287679] 000:  serial8250_interrupt+0x56/0xa0
[  138.287680] 000:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
[  138.287682] 000:  irq_forced_thread_fn+0x30/0x80
[  138.287683] 000:  irq_thread+0xdd/0x180
[  138.287684] 000:  ? wake_threads_waitq+0x30/0x30
[  138.287685] 000:  ? irq_thread_dtor+0x90/0x90
[  138.287686] 000:  kthread+0x113/0x130
[  138.287688] 000:  ? kthread_park+0x90/0x90
[  138.287689] 000:  ret_from_fork+0x3a/0x50
====== cut here ========

-- 
Jiri Kosina
SUSE Labs

