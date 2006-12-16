From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] [ARM] enable generic time and generic clock
	events for arm
Date: Sat, 16 Dec 2006 10:27:38 +0100
Message-ID: <1166261259.29505.233.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
	 <20061215224329.875791000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56552 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965357AbWLPJlx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 04:41:53 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215224329.875791000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:37 +0100, Robert Schwebel wrote:
> plain text document attachment
> (high-res-timers-dynticks-enable-arm-support.patch)
> From: Luotao Fu <lfu@pengutronix.de>
> 
> Turns hrt config options on for arm. It does this unconditionally
> so it currently breaks platforms that don't support a clocksource.
> 
> Signed-off-by: Luotao Fu <lfu@pengutronix.de>
> 
> Index: arch/arm/Kconfig
> ===================================================================
> --- arch/arm/Kconfig.orig
> +++ arch/arm/Kconfig
> @@ -21,6 +21,11 @@ config GENERIC_TIME
>  	bool
>  	default n
>  
> +config GENERIC_CLOCKEVENTS
> +	bool
> +	default y

No. This has to be default n like GENERIC_TIME above and selected by the
architecture, which has support for it. I fix that up.

	tglx
