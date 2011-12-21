From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel panic with PREEMPT_RT_FULL and UIO driver
Date: Wed, 21 Dec 2011 12:38:45 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112211237100.3020@ionos>
References: <4EF1B984.4010102@x2e.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Lukas Erlinghagen <lukas.erlinghagen@x2e.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57162 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1LULir (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Dec 2011 06:38:47 -0500
In-Reply-To: <4EF1B984.4010102@x2e.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 21 Dec 2011, Lukas Erlinghagen wrote:

> Dear list,
> 
> we're getting the kernel panic postet below on our system (Kernel version is
> 3.0.3-rt11, the platform is an embedded PowerPC 440 in a Virtex 5 FPGA, the
> device controlled by the UIO driver is a Freescale MFR4310 controller, and the
> interrupt is triggered by a high-active interrupt pin). This panic only occurs
> when using CONFIG_PREEMPT_RT_FULL, and only under high interrupt load on the
> MFR.
>
> I've also included our IRQ handler (registered with IRQF_ONESHOT) and IRQ
> control function.
> 
> Is there something fundamentally wrong we're doing, and if so, where can I

You are running the UIO interrupt handler with IRQF_NO_THREAD. That
can't work on RT.

Thanks,

	tglx


