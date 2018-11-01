From: John Stultz <john.stultz@linaro.org>
Subject: Re: TSC to Mono-raw Drift
Date: Thu, 1 Nov 2018 10:56:20 -0700
Message-ID: <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 1, 2018 at 10:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 23 Oct 2018, John Stultz wrote:
>> On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
>> I spent a little bit of time thinking this out. Unfortunately I don't
>> think its a simple matter of calculating the granularity error on the
>> raw clock and adding it in each interval. The other trouble spot is
>> that the adjusted clocks (monotonic/realtime) are adjusted off of that
>> raw clock. So they would need to have that error added as well,
>> otherwise the raw and a otherwise non-adjusted monotonic clock would
>> drift.
>>
>> However, to be correct, the ntp adjustments made would have to be made
>> to both the base interval + error, which mucks the math up a fair bit.
>
> Hmm, confused as usual. Why would you need to do anything like that?

Because the NTP adjustment is done off of what is now the raw clock.
If the raw clock is "corrected" the ppb adjustment has to be done off
of that corrected rate.

Otherwise with no correction, the raw clock and the monotonic clock
would drift apart.

thanks
-john
