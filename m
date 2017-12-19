From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 10:02:02 -0500
Message-ID: <20171219100202.3017a79f@gandalf.local.home>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
        <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 Dec 2017 09:27:40 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index c2c344fda487..3971fa0c7194 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1952,6 +1952,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
>  	BUG_ON(cpu_online(scpu));
>  	tick_cancel_sched_timer(scpu);
>  
> +	local_bh_disable();
>  	local_irq_disable();
>  	old_base = &per_cpu(hrtimer_bases, scpu);
>  	new_base = this_cpu_ptr(&hrtimer_bases);
> @@ -1979,6 +1980,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
>  	/* Check, if we got expired work to do */
>  	__hrtimer_peek_ahead_timers();
>  	local_irq_enable();
> +	local_bh_enable();
>  	return 0;
>  }

The above just seems wrong. local_irq_disable() should imply
local_bh_disable(), as it doesn't let softirqs run either.

-- Steve
