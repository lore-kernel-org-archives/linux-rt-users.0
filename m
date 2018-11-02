From: Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 2 Nov 2018 13:31:58 +0100
Message-ID: <20181102123158.GN19434@localhost>
References: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
 <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
 <alpine.DEB.2.21.1811011859590.1642@nanos.tec.linutronix.de>
 <20181102112006.GM19434@localhost>
 <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Stultz <john.stultz@linaro.org>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 02, 2018 at 12:25:56PM +0100, Thomas Gleixner wrote:
> On Fri, 2 Nov 2018, Miroslav Lichvar wrote:
> > clocksource -> MONOTONIC_RAW -> MONOTONIC/REALTIME
> > 
> > or 
> > 
> > clocksource -> ? -> MONOTONIC_RAW
> >                  -> MONOTONIC/REALTIME
> 
> That's what we have now. At least I don't see how the raw thing is coupled
> in NTP.

Oh, right.

So, for the first approach when the raw clock is stepped, the same
step needs to be applied to the mono clock. That means the mono clock
will have two large independent corrections applied to it, which will
make it less stable, e.g. steps of up to 8 ns at 100 Hz instead of 4
ns. Otherwise they would drift from each other when not synchronized
by NTP/PTP.

In the second approach, the corrections of the two clocks are
independent, but the NTP tick length needs to be adjusted before the
multiplier is calculated to match the frequency of the raw clock. If
the correction was applied later, I suspect it would require a +2 mult
adjustment or larger steps as in the first approach.

That tick adjustment generally won't be perfectly accurate, so an
extra small correction would be needed to keep the clocks in sync over
long intervals. This could be a +1 adjustment of the NTP tick length,
or it could be a small forward step. I'm not sure what would be easier
to implement.

Does that make sense?

-- 
Miroslav Lichvar
