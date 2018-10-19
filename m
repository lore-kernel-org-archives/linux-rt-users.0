From: John Stultz <john.stultz@linaro.org>
Subject: Re: TSC to Mono-raw Drift
Date: Fri, 19 Oct 2018 11:34:55 -0700
Message-ID: <CALAqxLU-riM7e2u3c-eOnsSJwvvHvq75aYpwELCCmMTSdGAdxw@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
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
In-Reply-To: <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Oct 19, 2018 at 8:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Christopher,
>
> Please Cc LKML on such issues in the future.
>
> On Mon, 15 Oct 2018, Christopher Hall wrote:
>
> Leaving context around for new readers:
>
>> Problem Statement:
>>
>> The TSC clocksource mult/shift values are derived from CPUID[15H], but the
>> monotonic raw clock value is not equal to TSC in nominal nanoseconds, i.e.
>> the timekeeping code is not accurately transforming TSC ticks to nominal
>> nanoseconds based on CPUID[15H}.
>>
>> The included code calculates the drift between nominal TSC nanoseconds and
>> the monotonic raw clock.
>>
>> Background:
>>
>> Starting with 6th generation Intel CPUs, the TSC is "phase locked" to the
>> Always Running Timer (ART). The relation between TSC and ART is read from
>> CPUID[15H]. Details of the TSC-ART relation are in the "Invariant
>> Timekeeping" section of the SDM.
>>
>> CPUID[15H].ECX returns the nominal frequency of ART (or crystal frequency).
>> CPU feature TSC_KNOWN_FREQ indicates that tsc_khz (tsc.c) is derived from
>> CPUID[15H]. The calculation is in tsc.c:native_calibrate_tsc().
>>
>> When the TSC clocksource is selected, the timekeeping code uses mult/shift
>> values to transform TSC into nanoseconds. The mult/shift value is determined
>> using tsc_khz.
>>
>> Example Output:
>>
>> Running for 3 seconds trial 1
>> Scaled TSC delta: 3000328845
>> Monotonic raw delta: 3000329117
>> Ran for 3 seconds with 272 ns skew
>>
>> Running for 3 seconds trial 2
>> Scaled TSC delta: 3000295209
>> Monotonic raw delta: 3000295482
>> Ran for 3 seconds with 273 ns skew
>>
>> Running for 3 seconds trial 3
>> Scaled TSC delta: 3000262870
>> Monotonic raw delta: 3000263142
>> Ran for 3 seconds with 272 ns skew
>>
>> Running for 300 seconds trial 4
>> Scaled TSC delta: 300000281725
>> Monotonic raw delta: 300000308905
>> Ran for 300 seconds with 27180 ns skew
>>
>> The skew between tsc and monotonic raw is about 91 PPB.
>>
>> System Information:
>>
>> CPU model string: Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz
>> Kernel version tested: 4.14.71-rt44
>>       NOTE: The skew seems to be insensitive to kernel version after
>>               introduction of TSC_KNOWN_FREQ capability
>>
>> >From CPUID[15H]:
>>       Time Stamp Counter/Core Crystal Clock Information (0x15):
>>               TSC/clock ratio = 276/2
>>               nominal core crystal clock = 24000000 Hz (table lookup)
>>
>> TSC kHz used to calculate mult/shift value: 3312000

So, just to understand, your saying the problem that we calculate a
tsc_khz value before calculating the mult/shift and the intermediate
step is losing some precision?

Or is the cause from something else?

thanks
-john
