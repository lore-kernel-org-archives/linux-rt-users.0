From: Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: TSC to Mono-raw Drift
Date: Thu, 25 Oct 2018 13:49:44 +0200
Message-ID: <20181025114944.GH12019@localhost>
References: <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <20181024145113.GF12019@localhost>
 <20181024173248.GB6121@artvirt.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Christopher Hall <christopher.s.hall@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024173248.GB6121@artvirt.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 24, 2018 at 01:32:48PM -0400, Christopher Hall wrote:
> On Wed, Oct 24, 2018 at 04:51:13PM +0200, Miroslav Lichvar wrote:
> > The error is too large to be corrected by stepping on clock updates.
> > For a typical TSC frequency we have multiplier in the range of few
> > millions, so that's a frequency error of up to few hundred ppb. In the
> 
> For this example, a i5-6600 CPU @ 3.30GHz I measured 90 ppb. That is the
> largest I've seen since measuring this on a few platforms. 20-40 PPB seems
> more typical.

It looks like there is rounding in the calculation of the multiplier,
so for frequencies in the range of 3-5GHz the error will be up to
about 149 ppb. Without rounding it would be twice as much, but always
fast or slow.

> > A better fix might be to modify the calculation of time to use a
> > second multiplier, effectively increasing its resolution. However,
> 
> I'm not sure, I'm understanding. Like cascading transforms? While this
> would increase the precision, I think it would still drift over days. We
> could probably fix up every second though.

I was thinking about using a wider multiplier, but avoiding a full
64x64 bit multiplication.

For example, in your case with the 3312MHz clock

nsec = (cycles * 5065585) >> 24

could be replaced with

nsec = (cycles * 5065584) >> 24 + (cycles * 4538763) >> 47

This would take few hours to drift by one nanosecond. If something
like this was implemented for the raw clock, it would probably make
sense to switch the other clocks too.

> > that would slow down all users of the clock.
> 
> Couldn't some clocksources specify an additional multiplier/precision and
> others use lower precision?

I guess it could, but I'm not sure if people here would be happy with
the extra complexity.

-- 
Miroslav Lichvar
