From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 2 Nov 2018 12:25:56 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com> <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com> <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
 <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com> <alpine.DEB.2.21.1811011859590.1642@nanos.tec.linutronix.de> <20181102112006.GM19434@localhost>
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
In-Reply-To: <20181102112006.GM19434@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2 Nov 2018, Miroslav Lichvar wrote:
> On Thu, Nov 01, 2018 at 07:03:37PM +0100, Thomas Gleixner wrote:
> > On Thu, 1 Nov 2018, John Stultz wrote:
> > > On Thu, Nov 1, 2018 at 10:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > On Tue, 23 Oct 2018, John Stultz wrote:
> > > >> However, to be correct, the ntp adjustments made would have to be made
> > > >> to both the base interval + error, which mucks the math up a fair bit.
> > > >
> > > > Hmm, confused as usual. Why would you need to do anything like that?
> > > 
> > > Because the NTP adjustment is done off of what is now the raw clock.
> > > If the raw clock is "corrected" the ppb adjustment has to be done off
> > > of that corrected rate.
> > 
> > Sure, but why would that require any change? Right now the raw clock is
> > slightly off and you correct clock monotonic against NTP. So with that
> > extra correction you just see a slightly different raw clock slew and work
> > from there.
> 
> It makes sense to me.
> 
> I think there are basically two different ways how it could be done.
> One is to correct the frequency of the raw clock, on which sits the
> mono/real clock. The other is to create a new raw clock which is
> separate from the mono/real clock, and add an offset to the NTP
> frequency to match the frequencies of the two clocks when not
> synchronized by NTP/PTP. The latter would provide a more stable
> mono/real clock.
> 
> clocksource -> MONOTONIC_RAW -> MONOTONIC/REALTIME
> 
> or 
> 
> clocksource -> ? -> MONOTONIC_RAW
>                  -> MONOTONIC/REALTIME

That's what we have now. At least I don't see how the raw thing is coupled
in NTP.

Thanks,

	tglx
