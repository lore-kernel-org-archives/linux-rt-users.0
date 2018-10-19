From: John Stultz <john.stultz@linaro.org>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 19 Oct 2018 11:48:53 -0700
Message-ID: <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
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
In-Reply-To: <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 19 Oct 2018, Thomas Gleixner wrote:
>> On Mon, 15 Oct 2018, Christopher Hall wrote:
>> > TSC kHz used to calculate mult/shift value: 3312000
>>
>> Now the most interesting information here would be the resulting mult/shift
>> value which the kernel uses. Can you please provide that?
>
> But aside of the actual values it's pretty obvious why this happens. It's a
> simple rounding error. Minimal, but still. To avoid rounding errors you'd
> have to find mult and shift values which exactly result in:
>
>      (freq * mult) >> shift = 1e9
>
> which is impossible for freq = 3312 * 1e6.

Right.

> A possible fix for this is, because the error is in the low PPB range, to
> adjust the error once per second or in some other sensible regular
> interval.

Ehh.. I mean, this is basically what all the complicated ntp_error
logic does for the long-term accuracy compensation.  Part of the
allure of the raw clock is that there is no changes made over time.
Its a very simple constant calculation.

We could try to do something like pre-seed the ntpinterval value so
the default ntp_tick value corrects for this, but that's only going to
effect the monotonic/realtime clock until ntpd or anyone else sets a
different interval rate.

So  I'm not particularly eager in trying to do the type of small
frequency oscillation we do for monotonic/realtime for long-term
accuracy to the raw clock as that feels a bit antithetical to the
point of the raw clock.

I guess I'd want to understand more of the use here and the need to
tie the raw clock back to the hardware counter it abstracts.

thanks
-john
