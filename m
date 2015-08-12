From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Wed, 12 Aug 2015 09:46:49 -0700
Message-ID: <20150812164649.31346.9236@quantum>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <55CA4BC2.4020505@ti.com> <20150811192514.GB7557@n2100.arm.linux.org.uk>
 <20150811220609.31346.15943@quantum> <55CB1A86.2050802@ti.com>
 <20150812101151.GK7557@n2100.arm.linux.org.uk>
 <20150812150253.GE13884@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Grygorii Strashko" <grygorii.strashko@ti.com>,
	"Nishanth Menon" <nm@ti.com>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, "Felipe Balbi" <balbi@ti.com>,
	"Sekhar Nori" <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: <balbi@ti.com>, Felipe Balbi <balbi@ti.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33174 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933703AbbHLQrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 12:47:04 -0400
Received: by pabyb7 with SMTP id yb7so18009715pab.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2015 09:47:03 -0700 (PDT)
In-Reply-To: <20150812150253.GE13884@saruman.tx.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Quoting Felipe Balbi (2015-08-12 08:02:53)
> On Wed, Aug 12, 2015 at 11:11:51AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Aug 12, 2015 at 01:05:58PM +0300, Grygorii Strashko wrote:
> > > On 08/12/2015 01:06 AM, Michael Turquette wrote:
> > > > Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
> > > >>
> > > >> clk_enable/clk_disable _should_ be usable from atomic contexts.
> > > 
> > > Thanks Russell - above is not true on -RT.
> > 
> > What I'm saying is that it _should_ be true.  You _should_ be able to
> > call clk_enable()/clk_disable() from atomic contexts.  It's been
> > documented since forever:
> > 
> > /**
> >  * clk_enable - inform the system when the clock source should be running.
> >  * @clk: clock source
> >  *
> >  * If the clock can not be enabled/disabled, this should return success.
> >  *
> >  * May be called from atomic contexts.
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > /**
> >  * clk_disable - inform the system when the clock source is no longer required.
> >  * @clk: clock source
> >  *
> >  * Inform the system that a clock source is no longer required by
> >  * a driver and may be shut down.
> >  *
> >  * May be called from atomic contexts.
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > If that's not true with CCF, that's a CCF bug, not a usage bug.
> 
> in that case, CCF's clock need to be converted to raw_spin_locks, that's
> the only way to prevent its locks from being reimplemented as rt
> mutexes.

I do not keep up much with rt stuff, so I am going to ask a naive
question: is it common to simply do s/spin_lock/raw_spin_lock/g for
driver subsystems when using rt? Sounds like that is all that is
required...

Regards,
Mike

> 
> -- 
> balbi
