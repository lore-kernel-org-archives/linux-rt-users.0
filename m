From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: scheduler clock for MXS
Date: Tue, 6 Nov 2012 09:45:25 +0000
Message-ID: <20121106094525.GM28327@n2100.arm.linux.org.uk>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <5098CB9F.9030401@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Guo <shawn.guo@linaro.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37423 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2KFJqv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 04:46:51 -0500
Content-Disposition: inline
In-Reply-To: <5098CB9F.9030401@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> On 05.11.2012 23:28, Russell King - ARM Linux wrote:
> 
> > It most certainly does handle the wrapping correctly - it was designed
> > to from the very start.
> 
> I'm not an expert on Linux kernel and its core infrastructure,
> but how is the sched_clock_timer armed for the first time
> after calling setup_sched_clock?
> 
> The explicitely called update_sched_clock() does _not_ arm it.

Correct, but sched_clock_postinit() does, which is called from time_init().
