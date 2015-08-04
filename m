From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Common clock framework API vs RT patchset
Date: Tue, 4 Aug 2015 14:06:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508041405290.3983@nanos>
References: <55C0A96F.80307@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, "Menon, Nishanth" <nm@ti.com>,
	Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36689 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933853AbbHDMGu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 08:06:50 -0400
In-Reply-To: <55C0A96F.80307@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 4 Aug 2015, Grygorii Strashko wrote:

> Hi All,
> 
> I'd very appreciated if someone can clarify one point for me.
> 
> Is allowed/expected/prohibited to use CLK API like clk_enable/disable
> in atomic context now on RT-Kernel (HW IRQ or under RAW spinlocks)?

It's not possible, if the spinlock in the clock framework is not a raw
spinlock.
 
> How safe is it to allow CLK API to be preemptive?

The functions are protected by the locks. So it's not an issue at all.

Thanks,

	tglx
