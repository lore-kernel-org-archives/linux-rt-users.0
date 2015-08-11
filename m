From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Tue, 11 Aug 2015 15:06:09 -0700
Message-ID: <20150811220609.31346.15943@quantum>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <55CA4BC2.4020505@ti.com> <20150811192514.GB7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Nishanth Menon" <nm@ti.com>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, "Felipe Balbi" <balbi@ti.com>,
	"Sekhar Nori" <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"Grygorii Strashko" <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35091 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbbHKWGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Aug 2015 18:06:23 -0400
Received: by pacgr6 with SMTP id gr6so59344799pac.2
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2015 15:06:22 -0700 (PDT)
In-Reply-To: <20150811192514.GB7557@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
> On Tue, Aug 11, 2015 at 10:23:46PM +0300, Grygorii Strashko wrote:
> > Hi All,
> > 
> > On 08/04/2015 06:36 PM, Russell King - ARM Linux wrote:
> > > On Tue, Aug 04, 2015 at 10:23:31AM -0500, Nishanth Menon wrote:
> > >> Consider clk_enable/disable/set_parent/setfreq operations. none of these
> > >> operations are "atomic" from hardware point of view. instead, they are a
> > >> set of steps which culminates to moving from state A to state B of the
> > >> clock tree configuration.
> > > 
> > > There's a world of difference between clk_enable()/clk_disable() and
> > > the rest of the clk API.
> > > 
> > > clk_enable()/clk_disable() _should_ be callable from any context, since
> > > you may need to enable or disable a clock from any context.  The remainder
> > > of the clk API is callable only from contexts where sleeping is permissible.
> > > 
> > > The reason we have this split is because clk_enable()/clk_disable() have
> > > historically been used in interrupt handlers, and they're specifically
> > > not supposed to impose big delays.
> > > 
> > > Things like waiting for a PLL to re-lock is time-consuming, so it's not
> > > something I'd expect to see behind a clk_enable() implementation (the
> > > fact you can't sleep in there is a big hint.)  Such waits should be in
> > > the clk_prepare() stage instead.
> > > 
> > > Now, as for clk_enable() being interrupted - if clk_enable() is interrupted
> > > and another clk_enable() comes along for the same clock, that second
> > > clk_enable() should not return until the clock has actually been enabled,
> > > and it's up to the implementation to decode how to achieve that.  If that
> > > means a RT implementation using a raw spinlock, then that's one option
> > > (which basically would have the side effect of blocking until the preempted
> > > clk_enable() finishes its business.)  Alternatively, if we can preempt
> > > inside clk_enable(), then the clk_enable() implementation should be written
> > > to cope with that (eg, by the second clk_enable() fiddling with the hardware,
> > > and the first thread noticing that it has nothing to do.)
> > > 
> > 
> > Thanks a lot for your comments and explanations.
> > 
> > Now lock object in CCF is not a raw spinlock, so, seems, I have to update 
> > code and try to move clk_enable()/clk_disable() out of atomic context.
> 
> clk_enable/clk_disable _should_ be usable from atomic contexts.

Grygorii,

Note that the common clk implementation allows for the same thread to
re-enter the clock framework even while the lock is held. For instance
if calling clk_enable(foo) resulted in a call to clk_enable(bar), this
would not deadlock. However this re-entrant behavior is ONLY for the
same thread that is already holding the lock.

I doubt that the above bit of trivial will solve your problem and it
probably does not add any new complexity for you either, but it seems
relevant enough for me to add here.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
