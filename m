From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer become inaccurate with RT patch
Date: Mon, 2 Jul 2018 12:14:21 +0200
Message-ID: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
To: gengdongjiu <gengdongjiu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
> patch-4.1.46-rt52.patch.

the 4.1 series is no longer supported (neither RT wise nor non-RT,
https://www.kernel.org/category/releases.html). I suggest to move away.
If you notice this problem now it is hardly a long running project.

> process will not be interrupt. But if the hrtimer is also runs in
> process context the timer is useless when it's inaccurate. so I want to
> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
> handling to a thread?

This depends on your expectations. The timer is defined not to fire
before the programmed time. So it fires as soon as possible _after_ the
programmed time.

> I think this is why hrtimer is run as a thread, I tried to set
> hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
> give some advise? Thanks.

By setting irqsafe to 1 you ensure taht the timer will fire from the
timer interrupt and before doing so you should ensure that the timer is
indeed IRQ safe.
Depending on what you do it is possible that the timer fires early but
the application notices it later (the scheduler will first handle RT
tasks according to their priorities followed by non RT tasks).

Sebastian
