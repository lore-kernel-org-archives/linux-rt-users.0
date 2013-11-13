From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: mod_timer in interrupt context
Date: Wed, 13 Nov 2013 22:53:04 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311132246030.30673@ionos.tec.linutronix.de>
References: <42FC60A7A1C0DD469DA8DF3D4125035F012614404F67@SPOCK.usa.Arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Wade Cherry <Wade.Cherry@arm.com>
To: Drew Richardson <Drew.Richardson@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56103 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3KMVxI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Nov 2013 16:53:08 -0500
In-Reply-To: <42FC60A7A1C0DD469DA8DF3D4125035F012614404F67@SPOCK.usa.Arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 12 Nov 2013, Drew Richardson wrote:
> I am using a 16 core ARM Cortex-A15 dev board with a PREEMPT_RT
> patched kernel. When I call mod_timer in the sched_switch tracepoint
> from a kernel module the board locks up.

This sounds ass backwards to begin with. Why on earth are you calling
mod_timer from a tracepoint in the guts of the scheduler core?

> The mod_timer function calls lock_timer_base which calls
> spin_lock. This is fine in non-RT kernels, but in RT_FULL it's a
> mutex which could block. Is it illegal to call mod_timer in this
> context?

It's not illegal in any jurisdiction AFAICT, but it's a nono on
RT. And no, we are not going to change this.

Thanks,

	tglx

