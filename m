From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 19 Oct 2018 20:37:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
To: Christopher Hall <christopher.s.hall@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 19 Oct 2018, Thomas Gleixner wrote:
> On Mon, 15 Oct 2018, Christopher Hall wrote:
> > TSC kHz used to calculate mult/shift value: 3312000
> 
> Now the most interesting information here would be the resulting mult/shift
> value which the kernel uses. Can you please provide that?

But aside of the actual values it's pretty obvious why this happens. It's a
simple rounding error. Minimal, but still. To avoid rounding errors you'd
have to find mult and shift values which exactly result in:

     (freq * mult) >> shift = 1e9

which is impossible for freq = 3312 * 1e6.

A possible fix for this is, because the error is in the low PPB range, to
adjust the error once per second or in some other sensible regular
interval.

John?

Thanks,

	tglx
