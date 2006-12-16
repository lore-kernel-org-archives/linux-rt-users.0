From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/10] [ARM] clockevent driver for arm/ep93xx
Date: Sat, 16 Dec 2006 12:36:28 +0100
Message-ID: <1166268988.29505.248.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
	 <20061215224329.323692000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:47947 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753629AbWLPLcc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 06:32:32 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215224329.323692000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:37 +0100, Robert Schwebel wrote:
> +static void ep93xx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
> +{
> +	clockevent_mode = mode;
> +}

Please implement set mode correctly.

	tglx
