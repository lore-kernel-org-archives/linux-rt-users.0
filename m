From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Common clock framework API vs RT patchset
Date: Mon, 21 Sep 2015 14:52:27 +0100
Message-ID: <20150921135226.GN21084@n2100.arm.linux.org.uk>
References: <55C0A96F.80307@ti.com>
 <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com>
 <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1509211255530.5606@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nishanth Menon <nm@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-rt-users@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36597 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687AbbIUNwe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 09:52:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509211255530.5606@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 21, 2015 at 03:06:18PM +0200, Thomas Gleixner wrote:
> On Tue, 4 Aug 2015, Russell King - ARM Linux wrote:
> > On Tue, Aug 04, 2015 at 10:23:31AM -0500, Nishanth Menon wrote:
> > > Consider clk_enable/disable/set_parent/setfreq operations. none of these
> > > operations are "atomic" from hardware point of view. instead, they are a
> > > set of steps which culminates to moving from state A to state B of the
> > > clock tree configuration.
> > 
> > There's a world of difference between clk_enable()/clk_disable() and
> > the rest of the clk API.
> > 
> > clk_enable()/clk_disable() _should_ be callable from any context, since
> > you may need to enable or disable a clock from any context.  The remainder
> > of the clk API is callable only from contexts where sleeping is permissible.
> > 
> > The reason we have this split is because clk_enable()/clk_disable() have
> > historically been used in interrupt handlers, and they're specifically
> > not supposed to impose big delays.
> > 
> > Things like waiting for a PLL to re-lock is time-consuming, so it's not
> > something I'd expect to see behind a clk_enable() implementation (the
> > fact you can't sleep in there is a big hint.)  Such waits should be in
> > the clk_prepare() stage instead.
> 
> You wish. Drivers with loop/udelays in the enable/disable callbacks:

Most of what I've said above is entirely factual.  What idiotic games
people play inside clk_enable() is not my problem (I'm not even the CCF
maintainer - something which Linaro "took over".)

> Of course we could solve that by making enable_lock a raw_spinlock,
> but looking at the various implementations of clk_ops.enable tells me
> that this is not a brilliant idea. See the PLL loops/delays crap
> above. There is another issue:
> 
> Some callbacks have their own spinlocks which then need to be
> converted to raw_spinlocks as well. Not a big deal, but some of the
> clk drivers use that very same spinlock, which is supposed to protect
> register access, for all kind of other crap, which is going to
> introduce latencies. And that's a ratsnest of locks down to
> regmap->lock ....
> 
> So for RT the only sensible choice at the moment is to leave
> enable_lock as non raw spinlock and deal with the very few places
> where clk_enable/disable() is really called from atomic context.

Right.  Let's put it in the most direct and blunt way possible.  Those
responsible for this mess won't like it.  They're not _meant_ to like
this statement, because they're supposed to feel bad about the situation
they've created.  Maybe, in the face of this leve of humiliation, they'll
assess whether they _should_ be doing better, and try to step up their
game.

We have:

clk_enable() & clk_disable() - which are _supposed_ to be the atomic
  level operators, which take a spinlock and are supposed to be _fast_.

clk_prepare() & clk_unprepare() - which are _supposed_ to be the
  time consuming bits of clk_enable()/clk_disable()

However, due to the generally idiotic nature of Linux programmers, they've
totally destroyed the reason for clk_enable() and clk_disable() existing.
So, we now need a _third_ level of API to work around their idiotic nature,
maybe clk_atomic_enable() and clk_atomic_disable(), which do what the
original clk_enable() and clk_disable() do.

So, we end up needing three levels because Linux programmers are basically
idiots.

And yes, if what you've found is correct, I think those who have created
the crap have very much earned the prestigious title of being an "idiotic
programmer".

I'm pissed at these idiotic programmers.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
