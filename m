From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 19 Oct 2018 20:57:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: John Stultz <john.stultz@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 19 Oct 2018, John Stultz wrote:
> On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 19 Oct 2018, Thomas Gleixner wrote:
> >> On Mon, 15 Oct 2018, Christopher Hall wrote:
> >> > TSC kHz used to calculate mult/shift value: 3312000
> >>
> >> Now the most interesting information here would be the resulting mult/shift
> >> value which the kernel uses. Can you please provide that?
> >
> > But aside of the actual values it's pretty obvious why this happens. It's a
> > simple rounding error. Minimal, but still. To avoid rounding errors you'd
> > have to find mult and shift values which exactly result in:
> >
> >      (freq * mult) >> shift = 1e9
> >
> > which is impossible for freq = 3312 * 1e6.
> 
> Right.
> 
> > A possible fix for this is, because the error is in the low PPB range, to
> > adjust the error once per second or in some other sensible regular
> > interval.
> 
> Ehh.. I mean, this is basically what all the complicated ntp_error
> logic does for the long-term accuracy compensation.  Part of the
> allure of the raw clock is that there is no changes made over time.
> Its a very simple constant calculation.
> 
> We could try to do something like pre-seed the ntpinterval value so
> the default ntp_tick value corrects for this, but that's only going to
> effect the monotonic/realtime clock until ntpd or anyone else sets a
> different interval rate.
> 
> So  I'm not particularly eager in trying to do the type of small
> frequency oscillation we do for monotonic/realtime for long-term
> accuracy to the raw clock as that feels a bit antithetical to the
> point of the raw clock.

I don't think you need complex oscillation for that. The error is constant
and small enough that it is a fractional nanoseconds thing with an interval
<= 1s. So you can just add that in a regular interval. Due to it being
small you can't observe time jumping I think.

The end-result is 'correct' as much correct it is in relation to real
nanoseconds. :)

> I guess I'd want to understand more of the use here and the need to
> tie the raw clock back to the hardware counter it abstracts.

The problem there is ART which is distributed to PCIe devices and ART time
stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
is a reasonable expectation that MONOTONIC_RAW is accurate.

Thanks,

	tglx
