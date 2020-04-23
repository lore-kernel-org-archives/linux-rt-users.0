Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFDDC54FD0
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 19:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8555320776
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587671308;
	bh=+ytu+YDAJzv2PrgwpsGZi4ZyQQ6l2Ov2bxefoLHSpwU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=H61rmietLQauYMmNBps1KOxwU2yp68LB5QOp9ZRNW7hT4sLWwoduuCAyjHQ4ERYIS
	 W9SQY0agfoGZ3E+Bxzr4Qv1TofHrZuSMzD7hJ2rlJFahUwDd5xJlb4/bt4iB7E2uVR
	 JcLJWd7WGl1oh6EnmtwXmMZNqZVhsEJ9+sOpEAdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDWTsY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgDWTsY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 15:48:24 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC1A20728;
        Thu, 23 Apr 2020 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587671303;
        bh=+ytu+YDAJzv2PrgwpsGZi4ZyQQ6l2Ov2bxefoLHSpwU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=a0Weh408xx04E+13hfs1LRFJGgLn9GQmwB7C1DXEucIuYMeogJdexcN0DxOH8KSI4
         2Sp9sfRFzQ2bBIJ5TNoe1OBenf3zRRhHYSqJv44cHgtHxTTvmpg08kjzE0wmnDMNA5
         npL8B+rT72WcbuzRGQtv7OVUcZh4D5Yf1dSDqMO8=
Date:   Thu, 23 Apr 2020 21:48:20 +0200 (CEST)
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
In-Reply-To: <20200423160707.hqt5wjinzcec2yig@linutronix.de>
Message-ID: <nycvar.YFH.7.76.2004232141590.19713@cbobk.fhfr.pm>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de> <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm> <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm> <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
 <20200423160707.hqt5wjinzcec2yig@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 23 Apr 2020, Sebastian Andrzej Siewior wrote:

> The IRQ4 is edge and in charge of ttyS0. It is handled by 
> handle_edge_irq() and after ->irq_ack(), the thread is woken up and then 
> we get another ->handle_edge_irq() for IRQ4. With larger PASS_LIMIT the 
> thread runs longer so note_interrupt() will make less IRQ_HANDLED based 
> on ->threads_handled_last. If it observes 100 handled within 100000 
> interrupts then the counters are reset again. On !RT it usually manages 
> to get >100 per 100000 interrupts so it appears good. On RT it gets less 
> and the interrupt gets disabled.
> 
> So it is not RT related, but RT triggers it more reliably (also the 
> PASS_LIMIT change can vanish). I can't tell if this is a qemu bug in 
> emulating the HW or not. I can't reproduce it real HW. I see a second 
> edge interrupt only after the thread completed. I can't tell if this is 
> because it is a real UART and the data is flowing slower or because the 
> edge-IRQ is not triggered repeatedly.

Yeah, it's all strange. In the hope of understanding the issue a little 
bit better, I tried to disable IRQs in serial8250_handle_irq() to mimic 
what !PREEMPT_RT spinlock would do; the idea was that this is some kind of 
strange race / memory ordering (missed ack?) between the threaded irq4 
handler and the do_IRQ() -> handle_edge_irq() -> ... path.

So I did this:

---
 drivers/tty/serial/8250/8250_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e31217e8dce6..1a577305e174 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1813,12 +1813,13 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
-	unsigned long flags;
+	unsigned long flags, f;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
+	local_irq_save(f);
 	spin_lock_irqsave(&port->lock, flags);
 
 	status = serial_port_in(port, UART_LSR);
@@ -1833,6 +1834,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		serial8250_tx_chars(up);
 
 	uart_unlock_and_check_sysrq(port, flags);
+	local_irq_restore(f);
 	return 1;
 }

But curiously enough, that exploded in the oposite order (so first there 
was CPU stall, and only later the disabling of IRQ4 due to spurious 
storm):

[  107.308525] 000: rcu: INFO: rcu_preempt self-detected stall on CPU
[  107.308542] 000: rcu: 	0-....: (20985 ticks this GP) idle=b2a/1/0x4000000000000002 softirq=0/0 fqs=4841 
[  107.308563] 000: 	(t=21000 jiffies g=16217 q=22343)
[  107.308565] 000: NMI backtrace for cpu 0
[  107.308570] 000: CPU: 0 PID: 1213 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19+ #11
[  107.308577] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[  107.308579] 000: Call Trace:
[  107.308599] 000:  <IRQ>
[  107.308608] 000:  dump_stack+0x50/0x6b
[  107.308630] 000:  nmi_cpu_backtrace+0x8a/0x90
[  107.308639] 000:  ? lapic_can_unplug_cpu+0xd0/0xd0
[  107.308644] 000:  nmi_trigger_cpumask_backtrace+0xe9/0x130
[  107.308647] 000:  rcu_dump_cpu_stacks+0x8e/0xbc
[  107.308658] 000:  rcu_sched_clock_irq+0x70a/0xad0
[  107.308661] 000:  ? cpuacct_account_field+0x16/0x70
[  107.308667] 000:  ? tick_sched_do_timer+0x60/0x60
[  107.308675] 000:  update_process_times+0x1f/0x40
[  107.308680] 000:  tick_sched_handle+0x2f/0x40
[  107.308685] 000:  tick_sched_timer+0x3e/0x80
[  107.308687] 000:  __hrtimer_run_queues+0x11e/0x3c0
[  107.308691] 000:  hrtimer_interrupt+0xea/0x250
[  107.308694] 000:  smp_apic_timer_interrupt+0x84/0x200
[  107.308704] 000:  apic_timer_interrupt+0xf/0x20
[  107.308709] 000:  </IRQ>
[  107.308713] 000: RIP: 0010:serial8250_handle_irq.part.26+0x9e/0xd0
[  107.308719] 000: Code: 48 85 c0 74 09 80 b8 e9 00 00 00 00 74 0f 41 83 e5 20 74 09 f6 83 36 02 00 00 02 75 2d 31 f6 48 89 df e8 65 87 ff ff 41 54 9d <b8> 01 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 48 8b 40 08 48 89 df e8
[  107.308723] 000: RSP: 0018:ffffb6ffc0a63e20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  107.308726] 000: RAX: ffff90b23734e040 RBX: ffffffff9f5a0de0 RCX: 0000000000000000
[  107.308728] 000: RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff9f5a0de0
[  107.308729] 000: RBP: 0000000000000060 R08: ffffffff9ea0b7a0 R09: ffffb6ffc0a63d78
[  107.308730] 000: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000246
[  107.308731] 000: R13: 0000000000000020 R14: 00000000000000c2 R15: ffff90b2ba711e58
[  107.308739] 000:  serial8250_default_handle_irq+0x45/0x50
[  107.308741] 000:  serial8250_interrupt+0x51/0xa0
[  107.308749] 000:  ? irq_finalize_oneshot.part.46+0xd0/0xd0
[  107.308755] 000:  irq_forced_thread_fn+0x2b/0x70
[  107.308758] 000:  irq_thread+0xd8/0x170
[  107.308760] 000:  ? wake_threads_waitq+0x30/0x30
[  107.308761] 000:  ? irq_thread_dtor+0x90/0x90
[  107.308763] 000:  kthread+0x10e/0x130
[  107.308769] 000:  ? kthread_park+0x80/0x80
[  107.308770] 000:  ret_from_fork+0x35/0x40
[  165.360370] 000: irq 4: nobody cared (try booting with the "irqpoll" option)
[  165.360392] 000: CPU: 0 PID: 1213 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19+ #11
[  165.360398] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[  165.360599] 000: Call Trace:
[  165.361639] 000:  <IRQ>
[  165.361651] 000:  dump_stack+0x50/0x6b
[  165.361670] 000:  __report_bad_irq+0x2b/0xb0
[  165.361678] 000:  note_interrupt+0x22e/0x280
[  165.361680] 000:  ? serial8250_handle_irq.part.26+0x9e/0xd0
[  165.361685] 000:  handle_irq_event_percpu+0x6e/0x90
[  165.361693] 000:  handle_irq_event+0x48/0x90
[  165.361695] 000:  handle_edge_irq+0x95/0x1f0
[  165.361700] 000:  do_IRQ+0x6c/0x120
[  165.361709] 000:  common_interrupt+0xf/0xf
[  165.361719] 000:  </IRQ>
[  165.361720] 000: RIP: 0010:serial8250_handle_irq.part.26+0x9e/0xd0
[  165.361727] 000: Code: 48 85 c0 74 09 80 b8 e9 00 00 00 00 74 0f 41 83 e5 20 74 09 f6 83 36 02 00 00 02 75 2d 31 f6 48 89 df e8 65 87 ff ff 41 54 9d <b8> 01 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 48 8b 40 08 48 89 df e8
[  165.361731] 000: RSP: 0018:ffffb6ffc0a63e20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdb
[  165.361732] 000: RAX: ffff90b23734e040 RBX: ffffffff9f5a0de0 RCX: 0000000000000001
[  165.361736] 000: RDX: 0000000000000003 RSI: 0000000000000097 RDI: 00000000ffffffff
[  165.361737] 000: RBP: 0000000000000060 R08: ffffffff9ea0b7a0 R09: ffffb6ffc0a63d78
[  165.361739] 000: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000246
[  165.361740] 000: R13: 0000000000000020 R14: 00000000000000c2 R15: ffff90b2ba711e58
[  165.361749] 000:  serial8250_default_handle_irq+0x45/0x50
[  165.361752] 000:  serial8250_interrupt+0x51/0xa0
[  165.361759] 000:  ? irq_finalize_oneshot.part.46+0xd0/0xd0
[  165.361762] 000:  irq_forced_thread_fn+0x2b/0x70
[  165.361767] 000:  irq_thread+0xd8/0x170
[  165.361771] 000:  ? wake_threads_waitq+0x30/0x30
[  165.361773] 000:  ? irq_thread_dtor+0x90/0x90
[  165.361775] 000:  kthread+0x10e/0x130
[  165.361780] 000:  ? kthread_park+0x80/0x80
[  165.361782] 000:  ret_from_fork+0x35/0x40
[  165.361787] 000: handlers:
[  165.361793] 000: [<00000000005f10ab>] irq_default_primary_handler threaded [<00000000853a4a7e>] serial8250_interrupt
[  165.361795] 000: Disabling IRQ #4

So this time the storm + stall apparently was triggered by the 'popf' 
coming from my added local_irq_restore().

It's really curious.

I'd be happy to blame it on some qemu breakage, but it seems to be 
happening on any randomly chosen version so far.

Thanks,

-- 
Jiri Kosina
SUSE Labs

