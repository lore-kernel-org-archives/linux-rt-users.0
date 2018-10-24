From: Christopher Hall <christopher.s.hall@intel.com>
Subject: Re: TSC to Mono-raw Drift
Date: Wed, 24 Oct 2018 13:32:48 -0400
Message-ID: <20181024173248.GB6121@artvirt.jf.intel.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <20181024145113.GF12019@localhost>
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
To: Miroslav Lichvar <mlichvar@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024145113.GF12019@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 24, 2018 at 04:51:13PM +0200, Miroslav Lichvar wrote:
> On Tue, Oct 23, 2018 at 11:31:00AM -0700, John Stultz wrote:
> > On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
> > > On Fri, Oct 19, 2018 at 1:50 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> On Fri, 19 Oct 2018, John Stultz wrote:
> > >>> We might be able to reduce the degree in this case, but I worry the
> > >>> extra complexity may only cause problems for others.
> > >>
> > >> Is it really that complex to add a fixed correction value periodically?
> 
> The error is too large to be corrected by stepping on clock updates.
> For a typical TSC frequency we have multiplier in the range of few
> millions, so that's a frequency error of up to few hundred ppb. In the

For this example, a i5-6600 CPU @ 3.30GHz I measured 90 ppb. That is the
largest I've seen since measuring this on a few platforms. 20-40 PPB seems
more typical.

> old days when the clock was updated 1000 times per second that would
> be hidden in the resolution of the clock, but now with tickless
> kernels those steps would be very noticeable.
> 
> If the multiplier was adjusted in the same way as the non-raw clock,
> there wouldn't be any steps in time, but there would be steps in
> frequency and the time error would be proportional to the update
> interval. For a clock updated once per second that's an error of up to
> a few hundreds of nanoseconds.
> 
> I agree with John. I think the raw monotonic clock should be stable.
> 
> It would help if we better understood the use case. If I needed a

There may be other future use cases, but the most immediate use is timed
GPIO. Current shipping hardware has a timed GPIO device that uses ART/TSC
directly to schedule output events and time-stamp input events. There isn't
a device clock like PHC, as an example.

An example application is synchronizing TGPIO across two networked devices
sync'd with PTP. It's possible to use existing the existing PHC interface to
compute the network time in terms of raw monotonic and vice versa.

Now we need to add a TSC to monotonic raw relation in order to interact
with the TGPIO hardware. To me this doesn't make sense because they use the
same hardware clock.

> clock that ticks in an exact proportion to the tsc, why wouldn't I use
> the tsc directly? Is this about having a fall back in case the tsc

I think this would work OK. This would need some additional API to expose the
relation between monotonic raw and TSC. In the kernel that would probably mean
plumbing ktime_get_snapshot() to the application. Or, another option:
add TSC as another clock to the get_device_system_crosststamp() interface.

The second option would be more precise, but for the proposed application
(or similar) would require changes to the supporting stacks like PTP.

> cannot be used (e.g. due to unsynchronized CPUs)?

No.
> 
> If the frequency error was exported, it could be compensated where
> necessary. Maybe that would work for the original poster?

This would be the same as plumbing ktime_get_snapshot() except that the
math would be done in the kernel.

> 
> A better fix might be to modify the calculation of time to use a
> second multiplier, effectively increasing its resolution. However,

I'm not sure, I'm understanding. Like cascading transforms? While this
would increase the precision, I think it would still drift over days. We
could probably fix up every second though.

> that would slow down all users of the clock.

Couldn't some clocksources specify an additional multiplier/precision and
others use lower precision?

> 
> -- 
> Miroslav Lichvar
