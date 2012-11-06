From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: scheduler clock for MXS
Date: Tue, 6 Nov 2012 20:20:38 +0000
Message-ID: <20121106202038.GB32398@n2100.arm.linux.org.uk>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <5098CB9F.9030401@meduna.org> <20121106134630.GD27643@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37749 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2KFUU6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 15:20:58 -0500
Content-Disposition: inline
In-Reply-To: <20121106134630.GD27643@S2100-06.ap.freescale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 09:46:31PM +0800, Shawn Guo wrote:
> On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> > Shawn: could you try change the
> >   update_sched_clock();
> > to
> >   sched_clock_poll(sched_clock_timer.data);
> > right after update_sched_clock call in setup_sched_clock?
> > 
> With the change, it still wraps at 2 seconds.

And there's no way that such a change could ever go into mainline; it
can mean that the timer is registered into the timer subsystem before
the timer subsystem has been initialised.  That's why we postpone that
part to time_init().

(And it has _always_ been intended that this sched_clock() implementation
would be usable by the time setup_arch() completes...)
