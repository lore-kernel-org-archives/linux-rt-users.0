From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC v2] timers: Don't wake ktimersoftd on every tick
Date: Fri, 23 Dec 2016 18:28:55 +0100
Message-ID: <20161223172855.oulixazoxikkkijp@linutronix.de>
References: <20161213214405.28554-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213214405.28554-1-haris.okanovic@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-13 15:44:05 [-0600], Haris Okanovic wrote:
> Changed the way timers are collected per Julia and Thomas'

I can only see Julia's response to the initial thread.

> recommendation: Expired timers are now collected in interrupt context
> and fired in ktimersoftd to avoid double-walk of `pending_map`.
> 
> This is implemented by storing lists of expired timers in timer_base,
> which carries a memory overhead 9*sizeof(pointer) per CPU. The timer
> system uses hlist's which don't have end-node references, making it
> impossible to merge 2 hlist's in constant time. I.e. Merging requires
> walking one list. I also considered switching `vectors` to regular
> list's which don't have this limitations, but that approach has the same
> memory overhead. list_head is bigger than hlist_head by sizeof(pointer)
> and is instantiated 9+ times per CPU as `vectors`. I believe the only
> way to trim overhead is to spend more CPU cycles in interrupt context
> either in list merging (unbounded operation) or the original double-walk
> implementation. Any suggestions/preferences?
> 
> As before, a 6h run of cyclictest without CPU affinity shows decrease in
> 22-70us latency range. 
what does this mean? Your cyclictest runs on a random CPU with one thread
only?

> No change in max jitter. 
Does this mean your average latency went down 20-70us and your max is
the same?

> No change when `-S` is
> used.

-S gives you one thread per core, makes sure it stays on that core and
uses clock_nanosleep().

clock_nanosleep() should be used no matter what. 


> [Before/after traces]
> 
> ftp://ftp.ni.com/outgoing/tp02-timer-peek-traces.tgz
> (Email me if link dies. Server periodically purges old files.)
> 
> [Hardware/software/config]
> 
>  NI cRIO-9033
>   2 core Intel Atom CPU
> 
>  Kernel 4.8.6-rt5
>   CONFIG_HZ_PERIODIC=y
> 
> [Outstanding concerns/issues/questions]
> 
> I'm relatively new to the timer subsystem, so please feel free to poke
> as many holes as possible in this change. A few things that concern me
> at the moment are:
> 
> Can jiffies change while one or more cpus is inside tick_sched_timer(),
>  in interrupt context? I'm copying jiffies to a local variable in
>  find_expired_timers() to ensure it doesn't run unbounded, but I'm not
>  sure if that's necessary.

It could change. Only the house keeping does update jiffies in
tick_sched_do_timer().

> Any special considerations for testing NO_HZ builds? (Other than letting
> it run idle for a while)
> 
> timers_dead_cpu() presently asserts no timer callback is actively
> running, which suggests that timers must be canceled prior to disabling
> CPUs; otherwise, there's a race between active timers and hotplug
> which can crash the whole kernel. Is this a safe assumption to make and
> are there any special considerations for CPU hotplug testing?

timers_dead_cpu() and hrtimers_dead_cpu() migrate timer away. At that
point the CPU should be down already so a timer can't run on that CPU.

> Other tests/performance benchmark I should run?
> 
> Source: https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v2
> 
> Thanks,
> Haris

Sebastian
