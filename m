Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from www.tglx.de ([62.245.132.106]:39963 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab0CFJSy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 6 Mar 2010 04:18:54 -0500
Date: Sat, 6 Mar 2010 10:18:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Re: Disabling lapic timer for a certain core
In-Reply-To: <8898.1267797291298.JavaMail.ngmail@webmail11.arcor-online.net>
Message-ID: <alpine.LFD.2.00.1003061011280.2014@localhost.localdomain>
References: <alpine.LFD.2.00.1003050659380.2014@localhost.localdomain> <6756648.1267736627501.JavaMail.ngmail@webmail08.arcor-online.net> <8898.1267797291298.JavaMail.ngmail@webmail11.arcor-online.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Cc: lclaudio@uudg.org, linux-rt-users@vger.kernel.org

On Fri, 5 Mar 2010, M. Koehrer wrote:
> > In theory it's possible to remove the timer interrupt from such an
> > isolated core completely, but there needs to be some work done vs. the
> > scheduler, accounting, RCU etc. There are people looking into this,
> > but we have no patches yet.
> I have checked the LAPIC addresses via the MSRs.
> All LAPIC addresses for all CPU cores are the same. 
> I assume they share the very same configuration, thus a minimum step 
> would be to make a copy of this configuration data and to let CPU core 3
> point to this copy. This would allow to disable the timer.

Really ? If it would be enough to disable the timer interrupt and not
let it fire, it would have been done years ago.

Did you even try to read what I said above ?

> >                 ...., but there needs to be some work done vs. the
> > scheduler, accounting, RCU etc.

Linux was not designed that way and it requires a non trivial amount
of work to get this sorted out:

> > There are people looking into this, but we have no patches yet.

Thanks,

	tglx
