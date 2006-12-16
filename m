From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 05/10] [ARM] clocksource driver for ep93xx
Date: Sat, 16 Dec 2006 12:25:04 +0100
Message-ID: <1166268305.29505.239.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
	 <20061215224326.947861000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56070 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030874AbWLPLVJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 06:21:09 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215224326.947861000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:37 +0100, Robert Schwebel wrote:
>  
> -	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
> +static struct clocksource clocksource_ep93xx = {
> +	.name           = "ep93xx timer2",

You use timer4, why is it called timer2 ? Also please avoid spaces in
those names, as it breaks the sys/.../clocksource enumeration

	tglx
