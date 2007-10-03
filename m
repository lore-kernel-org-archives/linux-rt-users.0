From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/4] Implement generic time of day clocksource for
 powerpc machines.
Date: Wed, 3 Oct 2007 06:00:56 +0200 (CEST)
Message-ID: <alpine.LRH.0.999.0710030554550.15610@www.tglx.de>
References: <1190345162.620000.305760830507.qpush@thor> <20070921032603.07AF232C889@thor>
 <20070921145212.7e8a7b89.sfr@canb.auug.org.au> <20070921213552.GD9814@bakeyournoodle.com>
 <18178.59123.511480.956928@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tony Breeds <tony@bakeyournoodle.com>,
	John Stultz <johnstul@us.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev@ozlabs.org,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33425 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbXJCEDW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Oct 2007 00:03:22 -0400
In-Reply-To: <18178.59123.511480.956928@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 3 Oct 2007, Paul Mackerras wrote:

> Tony Breeds writes:
> 
> > @@ -982,6 +906,10 @@ void __init time_init(void)
> >  
> >  	write_sequnlock_irqrestore(&xtime_lock, flags);
> >  
> > +	/* Register the clocksource, if we're not running on iSeries */
> > +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> > +		clocksource_init();
> 
> This breaks the 32-bit compile.
> 
> Is it possible to adjust the frequency of a clocksource after it has
> been registered?  Or could the timebase clocksource be unregistered
> and reregistered in iSeries_tb_recal?

There is no unregister interface right now. But we need some mechanism to 
tell the core code that you changed it. I have a look if John does not 
beat me.

	tglx
