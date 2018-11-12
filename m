From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: arm64 + ARM64_64K_PAGES=y
Date: Mon, 12 Nov 2018 15:22:24 -0600
Message-ID: <ff1646e5-4e38-3064-107b-63f294a49a4b@ti.com>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
 <20181108120040.pzupzyqnsxeuv5ne@linutronix.de>
 <99e0b883-cf9f-2ab9-5003-d4506bfa461d@ti.com>
 <274c9742-0aa9-b4a5-11cb-b506aeef7761@ti.com>
 <20181112142703.0d6ceb57@donnerap.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-rt-users@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112142703.0d6ceb57@donnerap.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/12/18 8:27 AM, Andre Przywara wrote:
> On Fri, 9 Nov 2018 13:15:47 -0600
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
> Hi,
> 
>> On 11/8/18 12:14 PM, Grygorii Strashko wrote:
>>>
>>>
>>> On 11/8/18 6:00 AM, Sebastian Andrzej Siewior wrote:
>>>> On 2018-11-06 15:34:55 [-0600], Grygorii Strashko wrote:
>>>>> Hi All,
>>>> Hi,
>>>>   
>>>>> Do anybody tried to use ARM64 RT with 76K pages enabled?
>>>>
>>>> 75 would be an off by one but this :)
>>>
>>> Ops 8-). at least subj is correct.
>>>    
>>>>   
>>>>> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y
>>>>> increases latencies by ~30%
> 
> That's not really surprising. Performance on systems using a bigger page
> size granules might have some trade-offs (bigger memory overhead, worse
> cache utilization), so 64K pages might not be really great for your
> particular workload. You would probably need a real performance
> analysis (using perf, for instance) to pinpoint TLB misses as your
> bottleneck.
> 
>>>>> cyclictest -n -m -Sp98 -q -D2m with  =y
>>>>>
>>>>>
>>>>> T: 0 (  772) P:98 I:1000 C: 120000 Min:      7 Act:   13 Avg:
>>>>> 10 Max:      85 T: 1 (  773) P:98 I:1500 C:  79998 Min:      7
>>>>> Act:   13 Avg:   10 Max:      71 T: 2 (  774) P:98 I:2000 C:
>>>>> 59997 Min:      7 Act:   11 Avg:   11 Max:      64 T: 3 (  775)
>>>>> P:98 I:2500 C:  47996 Min:      7 Act:   14 Avg:   12 Max:      66
>>>>>
>>>>>
>>>>> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=n
>>>>>
>>>>>
>>>>> T: 0 (  697) P:98 I:1000 C: 120000 Min:      7 Act:   10 Avg:
>>>>> 9 Max:      38 T: 1 (  698) P:98 I:1500 C:  79987 Min:      7
>>>>> Act:   10 Avg:   10 Max:      32 T: 2 (  699) P:98 I:2000 C:
>>>>> 59981 Min:      7 Act:   14 Avg:   11 Max:      46 T: 3 (  700)
>>>>> P:98 I:2500 C:  47977 Min:      6 Act:   11 Avg:   10 Max:
>>>>> 45
>>>>
>>>> So this is an idle system?
>>>
>>> Yes (in general) - it's collected with systemd, so some daemons are
>>> active.
>>>> The Kconfig help says "faster TLB lookup". Interesting.
>>>> Are the 16k pages in between (latency wise) by any chance?
>>>
>>> I'll try it.
>>
>> no i'll not, at least not fast. with 16k pages enabled I can't boot
>> TI 4.14 kernel
>> -  4.14.71-rt44.
>> No msg in log, just "Starting kernel ..."
> 
> You need a core that actually supports 16K pages (supporting
> certain page size granules is architecturally optional).
>  From the Arm Ltd. cores it's Cortex-A73, A75 or A55, possibly other
> newer ones as well. Cortex-A53, A57 and A72 do not support 16k pages.

Thank a lot for you reply.

-- 
regards,
-grygorii
