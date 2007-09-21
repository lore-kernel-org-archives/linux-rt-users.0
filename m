From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for powerpc machines.
Date: Fri, 21 Sep 2007 16:43:21 +1000
Message-ID: <20070921064321.GA13740@localhost.localdomain>
References: <20070921032603.07AF232C889@thor> <1190347546.15347.27.camel@imap.mvista.com> <18163.20403.967082.774118@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Walker <dwalker@mvista.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48496 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbXIUGol (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 02:44:41 -0400
Content-Disposition: inline
In-Reply-To: <18163.20403.967082.774118@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Sep 21, 2007 at 02:59:31PM +1000, Paul Mackerras wrote:
> Daniel Walker writes:
> 
> > I don't think the RTC frequency isn't the same as the timebase? Seems
> > like the RTC only case about seconds at the lowest level. If that's the
> > case then the jiffies clock might be better to use .. The other thing I
> > wonder is if the __USE_RTC boards might have lower level clocks that
> > could be used instead ..
> 
> It's OK, the RTC isn't what you think it is, it's a pair of
> CPU-internal registers which count seconds and nanoseconds.  On
> processors with the RTC, tb_ticks_per_sec is initialized to
> 1000000000.  Trust me, this code is OK. :)

Indeed..  I'm wondering if we should do a s/rtc/ppc601rtc/ or
something.  Otherwise people will keep making this mistake and be
confused.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
