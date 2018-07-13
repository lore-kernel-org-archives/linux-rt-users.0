From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v5 1/2] timers: Don't wake ktimersoftd on every tick
Date: Fri, 13 Jul 2018 09:37:52 -0500
Message-ID: <cba32de4-7b04-52d3-a068-909d675604f0@ni.com>
References: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
 <20180628164036.27378-1-haris.okanovic@ni.com>
 <alpine.DEB.2.21.1807131354560.2242@somnus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, bigeasy@linutronix.de, tglx@linutronix.de,
        julia.cartwright@ni.com, gratian.crisan@ni.com, daniel@bristot.me,
        efault@gmx.de
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1807131354560.2242@somnus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sounds good. I'll keep an eye out for your patch set and try it on my 
boards as well. CC me if you can.

-- Haris


On 07/13/2018 07:01 AM, Anna-Maria Gleixner wrote:
> Hi Haris,
> 
> On Thu, 28 Jun 2018, Haris Okanovic wrote:
> 
>> Collect expired timers in interrupt context to avoid overhead of waking
>> ktimersoftd on every scheduler tick.
>>
>> This is implemented by storing lists of expired timers in the timer_base
>> struct, which is updated by the interrupt routing on each tick in
>> run_local_timers(). TIMER softirq (ktimersoftd) is then raised only when
>> one or more expired timers are collected.
>>
>> Performance impact on a 2core Intel Atom E3825 system:
>>   * reduction in small latency spikes measured by cyclictest
>>   * ~30% fewer context-switches measured by perf
>>   * run_local_timers() execution time increases by 0.2 measured by TSC
>>
> 
> I'm also working on timer improvements at the moment. When I fixed all
> my bugs in my implementation (there is a last horrible one), I'm very
> interested in integrating your patches into my testing to be able to
> give you a tested-by.
> 
> Thanks,
> 
> 	Anna-Maria
> 
