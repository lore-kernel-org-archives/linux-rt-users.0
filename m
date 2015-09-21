From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Common clock framework API vs RT patchset\
Date: Mon, 21 Sep 2015 18:08:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509211729240.5606@nanos>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos> <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk> <alpine.DEB.2.11.1509211255530.5606@nanos> <20150921135226.GN21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nishanth Menon <nm@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-rt-users@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20150921135226.GN21084@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 21 Sep 2015, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2015 at 03:06:18PM +0200, Thomas Gleixner wrote:
> However, due to the generally idiotic nature of Linux programmers, they've
> totally destroyed the reason for clk_enable() and clk_disable() existing.
> So, we now need a _third_ level of API to work around their idiotic nature,
> maybe clk_atomic_enable() and clk_atomic_disable(), which do what the
> original clk_enable() and clk_disable() do.
> 
> So, we end up needing three levels because Linux programmers are basically
> idiots.
> 
> And yes, if what you've found is correct, I think those who have created
> the crap have very much earned the prestigious title of being an "idiotic
> programmer".
> 
> I'm pissed at these idiotic programmers.

I'm even more pissed at the CCF "maintainers" for giving a shit about
the sanity of the stuff they are maintaining.

One reason for this mess is that clk related patches go often
unreviewed through SoC trees, which again is a problem of the
maintainers who just let that happen.

It's not enough to have an entry in MAINTAINERS along with a git tree
in which random patches get collected.

This 'shove crap in no matter what' mentality needs to stop if we
don't want to end up with a completely unmaintainable nightmare.

Thanks,

	tglx
