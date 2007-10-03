From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 2/4] Implement generic time of day clocksource for powerpc machines.
Date: Wed, 3 Oct 2007 10:48:51 +1000
Message-ID: <18178.59123.511480.956928@cargo.ozlabs.ibm.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<20070921032603.07AF232C889@thor>
	<20070921145212.7e8a7b89.sfr@canb.auug.org.au>
	<20070921213552.GD9814@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: tony@bakeyournoodle.com (Tony Breeds)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34686 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbXJCAsx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 20:48:53 -0400
In-Reply-To: <20070921213552.GD9814@bakeyournoodle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Tony Breeds writes:

> @@ -982,6 +906,10 @@ void __init time_init(void)
>  
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
>  
> +	/* Register the clocksource, if we're not running on iSeries */
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +		clocksource_init();

This breaks the 32-bit compile.

Is it possible to adjust the frequency of a clocksource after it has
been registered?  Or could the timebase clocksource be unregistered
and reregistered in iSeries_tb_recal?

Paul.
