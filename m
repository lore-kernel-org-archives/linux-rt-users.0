From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH -rt] perf: make swevent hrtimer run in irq instead of
 softirq
Date: Thu, 05 Jul 2012 10:29:05 +0200
Message-ID: <1341476945.7709.1.camel@twins>
References: <1341476476-5666-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341476476-5666-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-07-05 at 16:21 +0800, Yong Zhang wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fd126f8..451d452 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5403,6 +5403,7 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
>  
>         hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         hwc->hrtimer.function = perf_swevent_hrtimer;
> +       hwc->hrtimer.irqsafe = 1;
>  
>         /*
>          * Since hrtimers have a fixed rate, we can do a static freq->period 

Yes this is correct.. curious we lost that. I'm sure I've done this
before.
