From: John Stultz <john.stultz@linaro.org>
Subject: Re: hrtimer become inaccurate with RT patch
Date: Mon, 2 Jul 2018 12:25:27 -0700
Message-ID: <CALAqxLVK=EghPr=GVTKzX511XMO2NM4Ehh3pVP9QumpKRBP+rA@mail.gmail.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com> <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, anna-maria@linutronix.de,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
To: gengdongjiu <gengdongjiu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 2, 2018 at 2:34 AM, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Thomas/Anna/John,
>
>   Recently I found that the hrtimer become inaccurate when there is a RT
> process runs on the same cpu core, and the kernel has applied preempt_rt
> patch.
>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
> patch-4.1.46-rt52.patch.
>   I know that in the preempt_rt environment the interrupt handlers no
> longer run in interrupt context but in process context, so that RT
> process will not be interrupt. But if the hrtimer is also runs in
> process context the timer is useless when it's inaccurate. so I want to
> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
> handling to a thread?

I've not looked at the PREEMPT_RT code in a long time, but years ago
there was a tension in that there is not an easy way track ownership
of timers. Thus timers all fired at the same priority of the hrtimer
irq thread. This thread could be moved up or down in priority, but the
problem was all timers would fire with the same priority. So either
the thread priority was so high that low-priority process could
generate a bunch of timers which would interrupt higher priority
tasks, or the thread priority was lower, so a high priority task could
block all timers.

There was some handwavy talk of trying to keep per-process timer
lists, so the hrtimer irq could still be in irq context but the firing
logic it didn't do anything but mark its task as runnable and do the
the actual timer firing logic before we eventually run the task (in
proper rt priority order), in a fashion similar to signals. But I'm
not sure if any attempts were made in that direction. I also think it
was an open question if there's any logic in kernel that depend on
strict in-order kernel timer processing, so its possible there could
be odd inversion issues where high priority timer logic is waiting on
/expecting lower priority timers to fire, etc, so its probably an area
of research.

thanks
-john
