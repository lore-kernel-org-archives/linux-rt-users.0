From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: TSC to Mono-raw Drift
Date: Thu, 1 Nov 2018 18:41:00 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811011813470.1642@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com> <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <20181024145113.GF12019@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Stultz <john.stultz@linaro.org>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Miroslav Lichvar <mlichvar@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024145113.GF12019@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Miroslav,

On Wed, 24 Oct 2018, Miroslav Lichvar wrote:
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
> old days when the clock was updated 1000 times per second that would
> be hidden in the resolution of the clock, but now with tickless
> kernels those steps would be very noticeable.
> 
> If the multiplier was adjusted in the same way as the non-raw clock,
> there wouldn't be any steps in time, but there would be steps in
> frequency and the time error would be proportional to the update
> interval. For a clock updated once per second that's an error of up to
> a few hundreds of nanoseconds.

That only happens when the system was completely idle for a second and in
that case it's a non issue because the clock is updated before it's
used. So nothing will be able to observe the time jumping forward by a few
or even a few hundreds of nanoseconds. For the regular case, where CPUs are
busy and the update happens 100/250/1000 times per second the jump forward
will not be noticable at all.

> I agree with John. I think the raw monotonic clock should be stable.

It is stable. It's still monotonically increasing.

> It would help if we better understood the use case. If I needed a
> clock that ticks in an exact proportion to the tsc, why wouldn't I use
> the tsc directly? Is this about having a fall back in case the tsc
> cannot be used (e.g. due to unsynchronized CPUs)?
> 
> If the frequency error was exported, it could be compensated where
> necessary. Maybe that would work for the original poster?

I'd rather not go there and have yet another magic knob to deal with and we
need to have the same thing in the kernel as well.

> A better fix might be to modify the calculation of time to use a
> second multiplier, effectively increasing its resolution. However,
> that would slow down all users of the clock.

Right, and we carefully try to avoid that.

I really would like to give the adjustment a try. It should solve the
problem Christopher cares about and not have any side effects on other
users of monotonic raw including NTP/PTP etc. Famous last words ....

Thanks,

	tglx
