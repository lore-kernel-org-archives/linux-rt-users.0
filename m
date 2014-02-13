From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Couple of questions about details of the RT patch
Date: Thu, 13 Feb 2014 23:05:29 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402132304110.21991@ionos.tec.linutronix.de>
References: <52F3D1A7.8020809@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBMWFW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Feb 2014 17:05:22 -0500
In-Reply-To: <52F3D1A7.8020809@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 6 Feb 2014, Corey Minyard wrote:

> I was looking over the RT patch and I had a couple of questions:
> 
> Is there a reason that the PREEMPT_LAZY code is not ifdef-ed out when
> PREEMPT_LAZY is disabled.  I can't see a reason to leave it in, it's
> just dead code at that point.  I'd be happy to do a patch to fix this.
> 
> Why does preempt_disable_rt() become a barrier when PREEMPT_RT is
> disabled?  Why isn't it just nothing?

Because I'm a lazy bastard and I fundamentaly hate #ifdefs :)

Thanks,

	tglx
