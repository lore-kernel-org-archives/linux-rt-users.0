From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: patch-2.6.20-rt5: time warp detected!
Date: Tue, 20 Feb 2007 11:14:53 +0100
Message-ID: <1171966493.30834.225.camel@localhost.localdomain>
References: <45D9D7B5.9020404@grandegger.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:49645 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932809AbXBTKJy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Feb 2007 05:09:54 -0500
In-Reply-To: <45D9D7B5.9020404@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-02-19 at 18:00 +0100, Wolfgang Grandegger wrote:
> Hello,
> 
> sometimes I get the following message when calling ktime_get_real() from 
> my interrupt handler:

SMP machine ?

> BUG: time warp detected!
> prev > now, 104357354c79dfed > 1043573435312fb2:
> = 4685606971 delta, on CPU#0
>   [<c0103d51>] dump_trace+0x68/0x1d9
>   [<c0103edd>] show_trace_log_lvl+0x1b/0x36
>   [<c01044dd>] show_trace+0xf/0x11
>   [<c010455e>] dump_stack+0x12/0x14
>   [<c012f1b2>] ktime_get_real+0x10/0x2c
>   [<e09c03ad>] rtcan_rcv+0x12/0x99 [xeno_can]
>   [<e09c951d>] rtcan_sja_interrupt+0x220/0x43e [xeno_can_sja1000]
>   [<e0992018>] _rtdm_irq_trampoline+0x15/0x34 [xeno_rtdm]
>   [<c0145eb7>] handle_IRQ_event+0x41/0xb7
>   [<c0146334>] thread_simple_irq+0x31/0x5f
>   [<c01468f8>] do_irqd+0xbd/0x249
>   [<c012c531>] kthread+0xa0/0xcb
>   [<c010397b>] kernel_thread_helper+0x7/0x10
>   =======================
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
> 
> Any idea how this can happen?

Can you please provide a boot log ?

	tglx
