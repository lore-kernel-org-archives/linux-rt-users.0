From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] cpu_pm/rt: replace rt rwlock with raw spinlock
Date: Fri, 16 Jun 2017 17:40:33 +0200
Message-ID: <20170616154033.qmrk3pmbrsxovnso@linutronix.de>
References: <1497446539-6378-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497446539-6378-1-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-14 21:22:19 [+0800], Alex Shi wrote:
> This is a quick fix for a bug as 'scheduling while atomic' or
> 'scheduling from the idle thread' on arm/arm64.
> 
> On arm/arm64, rwlock cpu_pm_notifier_lock in cpu_pm cause a potential
> schedule after irq disable in idle call chain:
> 
> cpu_startup_entry
>   cpu_idle_loop
>     local_irq_disable()
>     cpuidle_idle_call
>       call_cpuidle
>         cpuidle_enter
>           cpuidle_enter_state
>             ->enter :arm_enter_idle_state
> 	      cpu_pm_enter/exit
> 	        CPU_PM_CPU_IDLE_ENTER
>                   read_lock(&cpu_pm_notifier_lock); <-- sleep in idle
> 	             __rt_spin_lock();
> 			schedule();
> 
> The kernel panic is here:
> [    4.609601] BUG: scheduling while atomic: swapper/1/0/0x00000002
> [    4.609608] [<ffff0000086fae70>] arm_enter_idle_state+0x18/0x70
> [    4.609614] Modules linked in:
> [    4.609615] [<ffff0000086f9298>] cpuidle_enter_state+0xf0/0x218
> [    4.609620] [<ffff0000086f93f8>] cpuidle_enter+0x18/0x20
> [    4.609626] Preemption disabled at:
> [    4.609627] [<ffff0000080fa234>] call_cpuidle+0x24/0x40
> [    4.609635] [<ffff000008882fa4>] schedule_preempt_disabled+0x1c/0x28
> [    4.609639] [<ffff0000080fa49c>] cpu_startup_entry+0x154/0x1f8
> [    4.609645] [<ffff00000808e004>] secondary_start_kernel+0x15c/0x1a0
> 
> Daniel Lezcano said this notification is needed on arm/arm64 platforms.
> I also tried use local_lock_irq to replace local_irq_disable, but my 2
> boards just die without any output. So maybe it's only quick way to
> make rt kernel work on arm/arm64.
> 
> Since this is quick fix, instead of split out the raw rwlock, to use
> raw_spin_lock is simple and don't cost much.

I must have it disabled on my juno64 (and my 32bit boxes) since I
haven't seen it.
So we end up in IRQ off section and can't do anything about it. So
DEFINE_RAW_SPINLOCK it is? Can we have this upstream, please? Or is that
reader/writer part *so* important? If so would it work to move that part
to atomic_notifier_*() and have rcu_read_lock() instead that
read_lock()?

Sebastian
