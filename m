From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Common clock framework API vs RT patchset
Date: Mon, 21 Sep 2015 15:06:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509211255530.5606@nanos>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos> <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nishanth Menon <nm@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-rt-users@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20150804153641.GR7557@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 4 Aug 2015, Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2015 at 10:23:31AM -0500, Nishanth Menon wrote:
> > Consider clk_enable/disable/set_parent/setfreq operations. none of these
> > operations are "atomic" from hardware point of view. instead, they are a
> > set of steps which culminates to moving from state A to state B of the
> > clock tree configuration.
> 
> There's a world of difference between clk_enable()/clk_disable() and
> the rest of the clk API.
> 
> clk_enable()/clk_disable() _should_ be callable from any context, since
> you may need to enable or disable a clock from any context.  The remainder
> of the clk API is callable only from contexts where sleeping is permissible.
> 
> The reason we have this split is because clk_enable()/clk_disable() have
> historically been used in interrupt handlers, and they're specifically
> not supposed to impose big delays.
> 
> Things like waiting for a PLL to re-lock is time-consuming, so it's not
> something I'd expect to see behind a clk_enable() implementation (the
> fact you can't sleep in there is a big hint.)  Such waits should be in
> the clk_prepare() stage instead.

You wish. Drivers with loop/udelays in the enable/disable callbacks:

   drivers/clk/keystone/gate.c::keystone_clk_enable() -> psc_config()
   drivers/clk/shmobile/clk-mstp.c::cpg_mstp_clock_endisable()
   drivers/clk/qcom/clk-branch.c::clk_branch_enable() -> clk_branch_wait()
   drivers/clk/qcom/clk-pll.c::clk_pll_vote_enable() -> wait_for_pll()
   drivers/clk/ti/fapll.c::ti_fapll_enable() -> ti_fapll_wait_lock()
   drivers/clk/mmp/clk-gate.c::mmp_clk_gate_enable()
   drivers/clk/tegra/clk-pll.c::clk_pll_enable() -> clk_pll_wait_for_lock()
   drivers/clk/tegra/clk-pll.c::clk_plle_enable() -> clk_plle_training() [1]
   drivers/clk/zynq/pll.c::zynq_pll_enable()
   drivers/clk/ux500/clk-prcc.c::clk_prcc_pclk_enable()
   drivers/clk/clk-nomadik.c::src_clk_enable()
   drivers/clk/samsung/clk-pll.c::samsung_s3c2410_pll_enable()
   drivers/clk/sirf/clk-common.c::usb_pll_clk_enable()
   drivers/clk/st/clkgen-fsyn.c::quadfs_pll_enable()
   drivers/clk/st/clkgen-mux.c::clkgena_divmux_enable()
   drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_pll.c::mpd4_lvds_pll_enable()
   drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c::hdmi_pll_enable()
   
   [1] Worst case: timeout = jiffies + msecs_to_jiffies(100);

I'm sure that I missed quite some, but the above is horrible enough.

> Now, as for clk_enable() being interrupted - if clk_enable() is interrupted
> and another clk_enable() comes along for the same clock, that second
> clk_enable() should not return until the clock has actually been enabled,
> and it's up to the implementation to decode how to achieve that.  If that
> means a RT implementation using a raw spinlock, then that's one option
> (which basically would have the side effect of blocking until the preempted
> clk_enable() finishes its business.)  Alternatively, if we can preempt
> inside clk_enable(), then the clk_enable() implementation should be written
> to cope with that (eg, by the second clk_enable() fiddling with the hardware,
> and the first thread noticing that it has nothing to do.)

clk_enable() and clk_disable() take the enable_lock, so that's not
different in RT from !RT. The second caller to clk_enable() has to
wait for the first one to finish.

Now what's different in RT is that the enable_lock gets converted to a
'sleeping spinlock', which is again fine to take from interrupt
handlers as interrupt handlers are forced into threads on RT and are
preemptible.

The problem Grygorii is seeing is when code, which runs in atomic
context even on RT (demux handlers, interrupt disabled sections ..)
calls clk_en/disable. That results obviously in a
might_sleep/scheduling while atomic splat.

Of course we could solve that by making enable_lock a raw_spinlock,
but looking at the various implementations of clk_ops.enable tells me
that this is not a brilliant idea. See the PLL loops/delays crap
above. There is another issue:

Some callbacks have their own spinlocks which then need to be
converted to raw_spinlocks as well. Not a big deal, but some of the
clk drivers use that very same spinlock, which is supposed to protect
register access, for all kind of other crap, which is going to
introduce latencies. And that's a ratsnest of locks down to
regmap->lock ....

So for RT the only sensible choice at the moment is to leave
enable_lock as non raw spinlock and deal with the very few places
where clk_enable/disable() is really called from atomic context.

Thanks,

	tglx
