From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new generic_handle_irq_rt_wa()
 api
Date: Mon, 2 Nov 2015 20:38:20 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511022036500.4032@nanos>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com> <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40803 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbKBTjB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2015 14:39:01 -0500
In-Reply-To: <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2 Nov 2015, Grygorii Strashko wrote:
> Now in kernel below code pattern is used by many drivers:
> static irqreturn_t driver_xx_hw_irq_handler(int irq, void *arg)
> {
> 	<read IRQ status register>
>   	<perform HW specific operations>
> 
> 	for (<each set bit in IRQ status register>) {
> 		<get Linux IRQ number>
> 		generic_handle_irq(<Linux IRQ number>);
> 		|- handle_simple_irq()
> 		|-or- handle_level_irq()
> 		|-or- handle_edge_irq()
> 		   |-handle_irq_event()
> 		     |-handle_irq_event_percpu()
> ===
> "WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
>  irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts"
> ===
> 	}
> }
> 
> On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
> will be forced threaded (by default) and, as result, generic_handle_irq()
> will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
> be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).
> 
> Instead of spreading this W/A directly in many drivers this patch
> introduces -RT specific version of generic_handle_irq() API -
> generic_handle_irq_rt_wa(). This new generic_handle_irq_rt_wa() just calls
> generic_handle_irq() surrounded by raw_spin_lock_irqsave/irqrestore().
> If -RT is disabled It will fallback to generic_handle_irq().

Why aren't you simply marking these demultiplex handlers with IRQ_NO_THREAD?

Thanks,

	tglx
