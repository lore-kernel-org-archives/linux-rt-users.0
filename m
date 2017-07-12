From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
Date: Wed, 12 Jul 2017 23:30:56 +0200
Message-ID: <5232233.WFeFAu20WR@aspire.rjw.lan>
References: <1499820498-7983-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: open list <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1499820498-7983-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday, July 12, 2017 08:48:18 AM Alex Shi wrote:
> This patch replace a rwlock and raw notifier by atomic notifier which
> protected by spin_lock and rcu.
> 
> The first to reason to have this replace is due to a 'scheduling while
>  atomic' bug of RT kernel on arm/arm64 platform. On arm/arm64, rwlock
> cpu_pm_notifier_lock in cpu_pm cause a potential schedule after irq
> disable in idle call chain:
> 
> cpu_startup_entry
>   cpu_idle_loop
>     local_irq_disable()
>     cpuidle_idle_call
>       call_cpuidle
>         cpuidle_enter
>           cpuidle_enter_state
>             ->enter :arm_enter_idle_state
>               cpu_pm_enter/exit
>                 CPU_PM_CPU_IDLE_ENTER
>                   read_lock(&cpu_pm_notifier_lock); <-- sleep in idle
>                      __rt_spin_lock();
>                         schedule();
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
> Sebastian suggested using atomic_notifier instead of rwlock, which is not
> only removing the sleeping in idle, but also getting better latency
> improvement.
> 
> This patch passed Fengguang's 0day testing.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied (although you have forgotten to CC me actually).

Thanks,
Rafael
