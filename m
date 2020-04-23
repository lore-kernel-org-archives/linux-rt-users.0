Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE2CC2BA19
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 08:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71E121582
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587631930;
	bh=RlcGZeBi4Rq0AybHXz9T7N9sfn9VttmDWE7FbE8WSH8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZCyFTUYf8DV5xPWTF14uO77UdlNpQUVZhx+2bTLCPW+d1CTuft/fuoPK0U7Ao6hFv
	 deSPwtvd5xaG6uJuBj/qhfyFKvW4dWtVI91c/RG2DSW40oWHCyfU241hgIVSvBSeks
	 YGfYkQ/5NjP9osFu/UdtaP/KLVPoO8K69gvry6Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDWIwG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIwE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 04:52:04 -0400
Received: from twin.jikos.hovorcovice.czf (twin.jikos.cz [91.219.245.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D062084D;
        Thu, 23 Apr 2020 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587631924;
        bh=RlcGZeBi4Rq0AybHXz9T7N9sfn9VttmDWE7FbE8WSH8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pQ68sDy+xZjlIxU+L1teWuY9MNVdyxpr68VRC6ZE66i6if4bl6KWQecmN89UGeJ6x
         NJQCrMfbud+v6QkOU6d7nl0VRTroqcS/GTHVD16WnEQK7LUdPKNZjzZMEKRw4X1k8I
         HFsxn58zwmDWZxb6iI/BaQAs2WQ5T+gv6ZAP672I=
Date:   Thu, 23 Apr 2020 10:51:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was Re:
 [ANNOUNCE] v5.4.28-rt19)
In-Reply-To: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
Message-ID: <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 30 Mar 2020, Sebastian Andrzej Siewior wrote:

> I'm pleased to announce the v5.4.28-rt19 patch set. 

First, I don't believe this is necessarily a regression coming with this 
particular version, but this is the first kernel where I tried this and it 
crashed.

When running this kernel in KVM guest, and flooding its 8250-based ttyS0 
serial console quickly leads to

[   52.674358] 000: irq 4: nobody cared (try booting with the "irqpoll" option)
[   52.674381] 000: CPU: 0 PID: 155 Comm: irq/4-ttyS0 Not tainted 5.4.28-rt19+ #7
[   52.674389] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   52.674398] 000: Call Trace:
[   52.674417] 000:  <IRQ>
[   52.674426] 000:  dump_stack+0x50/0x6b
[   52.674446] 000:  __report_bad_irq+0x2b/0xb0
[   52.674454] 000:  note_interrupt+0x22e/0x280
[   52.674457] 000:  ? io_serial_out+0x11/0x20
[   52.674463] 000:  handle_irq_event_percpu+0x6e/0x90
[   52.674471] 000:  handle_irq_event+0x48/0x90
[   52.674473] 000:  handle_edge_irq+0x95/0x1f0
[   52.674476] 000:  do_IRQ+0x6c/0x120
[   52.674487] 000:  common_interrupt+0xf/0xf
[   52.674496] 000:  </IRQ>
[   52.674497] 000: RIP: 0010:io_serial_out+0x11/0x20
[   52.674503] 000: Code: 8b 57 30 d3 e6 01 f2 ec 0f b6 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f b6 8f e1 00 00 00 89 d0 8b 57 30 d3 e6 01 f2 ee <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f b6 87 e2 00 00 00
[   52.674507] 000: RSP: 0018:ffffa860c03a7de8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdb
[   52.674508] 000: RAX: 0000000000000034 RBX: ffffffffb05a3bc0 RCX: 0000000000000000
[   52.674510] 000: RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffffb05a3bc0
[   52.674514] 000: RBP: ffff98c1b9718000 R08: ffffffffafa0b8e0 R09: ffffa860c03a7d80
[   52.674515] 000: R10: ffffa860c03a7c40 R11: 0000000000000000 R12: 0000000000000009
[   52.674516] 000: R13: 0000000000000020 R14: 0000000000000001 R15: ffff98c13714a8b8
[   52.674524] 000:  ? io_serial_in+0x20/0x20
[   52.674529] 000:  serial8250_tx_chars+0x121/0x310
[   52.674535] 000:  ? migrate_disable+0x33/0x90
1339913399133991[   52.674540] 000:  
serial8250_handle_irq.part.27+0xc2/0xe0
[   52.674543] 000:  serial8250_default_handle_irq+0x45/0x50
[   52.674545] 000:  serial8250_interrupt+0x51/0xa0
[   52.674548] 000:  ? irq_finalize_oneshot.part.46+0xd0/0xd0
[   52.674550] 000:  irq_forced_thread_fn+0x2b/0x70
[   52.674552] 000:  irq_thread+0xd8/0x170
[   52.674554] 000:  ? wake_threads_waitq+0x30/0x30
[   52.674556] 000:  ? irq_thread_dtor+0x90/0x90
[   52.674558] 000:  kthread+0x10e/0x130
[   52.674563] 000:  ? kthread_park+0x80/0x80
[   52.674565] 000:  ret_from_fork+0x35/0x40
[   52.674571] 000: handlers:
[   52.674579] 000: [<00000000d13c0583>] irq_default_primary_handler threaded [<00000000f172db97>] serial8250_interrupt
[   52.674580] 000: Disabling IRQ #4

(and things go downhill afterwards with RCU stall on the affected CPU, 
etc).

Reproducing it is as easy as firing up qemu with '-serial stdio', booting 
with console set to ttyS0, and then doing e.g.

	i=0; while test $i -lt 100000; do /usr/bin/echo $i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i$i; i=$((i+1)); done

in the serial console terminal. It explodes within a few tens of seconds.

Now, whenever this happens, we always seem to be interrupted in 
0010:io_serial_out+0x11/0x20, which is this in Code

	... d3 e6 01 f2 ee <c3> 66 66 2e 0f ...

where '0xee' is the actual outb. So it looks like outb would take so long 
that 99k IRQ4s trigger in the meantime, which would seem to point to KVM / 
qemu 
issue. 

*However* after either

- turning CONFIG_PREEMPT_RT off 

	or

- starting qemu-kvm without any '-smp' args (i.e. starting the guest as 
  UP)

this issue never reproduces any more; the reason for it almost certainly 
never triggering with !CONFIG_PREEMPT_RT is that the above pattern 
obviously can't happen, because we never interrupt that io_serial_out, 
because the spin_lock_irqsave() in serial8250_handle_irq() disables IRQ in 
this region. Why it doesn't reproduce on UP I don't understand.

I haven't done much debugging on this yet, but reporting this right away 
in case anyone has any idea what's happening here.

Thanks,

-- 
Jiri Kosina
SUSE Labs
