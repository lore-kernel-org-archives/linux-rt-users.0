From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Common clock framework API vs RT patchset
Date: Wed, 12 Aug 2015 11:11:51 +0100
Message-ID: <20150812101151.GK7557@n2100.arm.linux.org.uk>
References: <55C0A96F.80307@ti.com>
 <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com>
 <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <55CA4BC2.4020505@ti.com>
 <20150811192514.GB7557@n2100.arm.linux.org.uk>
 <20150811220609.31346.15943@quantum>
 <55CB1A86.2050802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53920 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbbHLKMB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 06:12:01 -0400
Content-Disposition: inline
In-Reply-To: <55CB1A86.2050802@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 12, 2015 at 01:05:58PM +0300, Grygorii Strashko wrote:
> On 08/12/2015 01:06 AM, Michael Turquette wrote:
> > Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
> >>
> >> clk_enable/clk_disable _should_ be usable from atomic contexts.
> 
> Thanks Russell - above is not true on -RT.

What I'm saying is that it _should_ be true.  You _should_ be able to
call clk_enable()/clk_disable() from atomic contexts.  It's been
documented since forever:

/**
 * clk_enable - inform the system when the clock source should be running.
 * @clk: clock source
 *
 * If the clock can not be enabled/disabled, this should return success.
 *
 * May be called from atomic contexts.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

/**
 * clk_disable - inform the system when the clock source is no longer required.
 * @clk: clock source
 *
 * Inform the system that a clock source is no longer required by
 * a driver and may be shut down.
 *
 * May be called from atomic contexts.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If that's not true with CCF, that's a CCF bug, not a usage bug.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
