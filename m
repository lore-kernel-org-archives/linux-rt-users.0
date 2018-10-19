From: John Stultz <john.stultz@linaro.org>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 19 Oct 2018 12:21:47 -0700
Message-ID: <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com> <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Oct 19, 2018 at 11:57 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 19 Oct 2018, John Stultz wrote:
>> On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 19 Oct 2018, Thomas Gleixner wrote:
>> >> On Mon, 15 Oct 2018, Christopher Hall wrote:
>> >> > TSC kHz used to calculate mult/shift value: 3312000
>> >>
>> >> Now the most interesting information here would be the resulting mult/shift
>> >> value which the kernel uses. Can you please provide that?
>> >
>> > But aside of the actual values it's pretty obvious why this happens. It's a
>> > simple rounding error. Minimal, but still. To avoid rounding errors you'd
>> > have to find mult and shift values which exactly result in:
>> >
>> >      (freq * mult) >> shift = 1e9
>> >
>> > which is impossible for freq = 3312 * 1e6.
>>
>> Right.
>>
>> > A possible fix for this is, because the error is in the low PPB range, to
>> > adjust the error once per second or in some other sensible regular
>> > interval.
>>
>> Ehh.. I mean, this is basically what all the complicated ntp_error
>> logic does for the long-term accuracy compensation.  Part of the
>> allure of the raw clock is that there is no changes made over time.
>> Its a very simple constant calculation.
>>
>> We could try to do something like pre-seed the ntpinterval value so
>> the default ntp_tick value corrects for this, but that's only going to
>> effect the monotonic/realtime clock until ntpd or anyone else sets a
>> different interval rate.
>>
>> So  I'm not particularly eager in trying to do the type of small
>> frequency oscillation we do for monotonic/realtime for long-term
>> accuracy to the raw clock as that feels a bit antithetical to the
>> point of the raw clock.
>
> I don't think you need complex oscillation for that. The error is constant
> and small enough that it is a fractional nanoseconds thing with an interval
> <= 1s. So you can just add that in a regular interval. Due to it being
> small you can't observe time jumping I think.

Well, from the examples the trouble is we seem to be a bit fast,
rather then slow.
So we'll have to reduce mult by one, and rework the calculations, but
maybe something like this (correcting the raw_interval value) would
work.

But this also sort of breaks, fundamental argument that the raw clock
is a simple mult/shift transformation of the underlying clocksource
counter. Its not the accuracy of the clock but the consistency that
was key.

The counter argument is that the raw clock is abstracting the
underlying hardware so folks who would have used the TSC directly can
now use the raw clock and have a generic abstracted hardware-counter
interface. So userland shouldn't really be worried about the
occasional injections made since they shouldn't be trying to
re-generate the abstraction from the hardware themselves.  <--
Remember this point as we move to the next comment:)

> The end-result is 'correct' as much correct it is in relation to real
> nanoseconds. :)
>
>> I guess I'd want to understand more of the use here and the need to
>> tie the raw clock back to the hardware counter it abstracts.
>
> The problem there is ART which is distributed to PCIe devices and ART time
> stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
> is a reasonable expectation that MONOTONIC_RAW is accurate.

Which is maybe sort of my issue here. The raw clock provided a
abstraction away from the hardware for generic usage, but then its
being re-used with other un-abstracted hardware references. So unless
they use the same method of transformation, there will be problems (of
varying degree).

We might be able to reduce the degree in this case, but I worry the
extra complexity may only cause problems for others.

thanks
-john
