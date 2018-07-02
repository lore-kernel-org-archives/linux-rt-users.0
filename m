From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: hrtimer become inaccurate with RT patch
Date: Mon, 2 Jul 2018 19:19:07 +0800
Message-ID: <75928d33-ade0-3bc7-33df-43abf5442c32@huawei.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <anna-maria@linutronix.de>, <john.stultz@linaro.org>,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        <yangchuanlong@huawei.com>,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        <liupeifeng3@huawei.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ouyangzhaowei (Charles)" <ouyangzhaowei@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian ,
   Thanks for the answer.

On 2018/7/2 18:14, Sebastian Andrzej Siewior wrote:
> On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
>> patch-4.1.46-rt52.patch.
> 
> the 4.1 series is no longer supported (neither RT wise nor non-RT,
> https://www.kernel.org/category/releases.html). I suggest to move away.
> If you notice this problem now it is hardly a long running project.
yes, I Know, but we found the latest RT 4.14 series also has the same problem,
so this is common issue.

> 
>> process will not be interrupt. But if the hrtimer is also runs in
>> process context the timer is useless when it's inaccurate. so I want to
>> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
>> handling to a thread?
> 
> This depends on your expectations. The timer is defined not to fire
> before the programmed time. So it fires as soon as possible _after_ the
> programmed time.
It is reasonable that the timer is defined not to fire before the programmed time.
but we found it fires long _after_ the programmed time. For example, we define it to
fire after 2s, but it will fire after 5s, so it is very later than the expectations. I think the reason may be
that the timer handler thread is preempted by another higher priority thread. so from for this issue,
the timer handler should be in IRQ context instead of the process context or increase the timer handler thread priority, right?

> 
>> I think this is why hrtimer is run as a thread, I tried to set
>> hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
>> give some advise? Thanks.
> 
> By setting irqsafe to 1 you ensure taht the timer will fire from the
> timer interrupt and before doing so you should ensure that the timer is
> indeed IRQ safe.
> Depending on what you do it is possible that the timer fires early but
> the application notices it later (the scheduler will first handle RT
> tasks according to their priorities followed by non RT tasks).

(I will continue check this comments, thanks)

> 
> Sebastian
> 
> .
> 
