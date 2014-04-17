From: Stanislav Meduna <stano@meduna.org>
Subject: Re: BUG: spinlock trylock failure on UP - reverting timer patches
 helps
Date: Thu, 17 Apr 2014 18:29:56 +0200
Message-ID: <53500184.4050309@meduna.org>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org> <534DADF1.6060608@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bigeasy@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	triplesquarednine@gmail.com
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <534DADF1.6060608@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 16.04.2014 00:08, Stanislav Meduna wrote:

>>> BUG: spinlock trylock failure on UP on CPU#0, ksoftirqd/0/3
> 
> I am now getting this quite reproducibly a few seconds into
> the boot and the path is always similar. Depending on what modules
> I am loading the source changes, but it is nearly always
> a schedule_timeout with a following timer interrupt.

Note: the bug goes away reverting the very same patches that are
helping the Jordan's problms. I did follow

http://www.spinics.net/lists/linux-rt-users/msg11639.html

and no BUG while booting anymore. I'll try to let it run some
more time.

> [   11.797460] BUG: spinlock trylock failure on UP on CPU#0, rcu_preempt/11
> [   11.797522]  lock: boot_tvec_bases+0x0/0x10c0, .magic: dead4ead, .owner: rcu_preempt/11, .owner_cpu: 0
> [   11.797550] CPU: 0 PID: 11 Comm: rcu_preempt Not tainted 3.12.15-rt25+ #52
> [   11.797630] [<c00151bc>] (unwind_backtrace+0x0/0xf4) from [<c0012c00>] (show_stack+0x10/0x14)
> [   11.797691] [<c0012c00>] (show_stack+0x10/0x14) from [<c01b2758>] (do_raw_spin_trylock+0x4c/0x58)
> [   11.797748] [<c01b2758>] (do_raw_spin_trylock+0x4c/0x58) from [<c02e0194>] (_raw_spin_trylock+0x20/0x98)
> [   11.797792] [<c02e0194>] (_raw_spin_trylock+0x20/0x98) from [<c02df734>] (rt_spin_trylock+0x14/0xd0)
> [   11.797851] [<c02df734>] (rt_spin_trylock+0x14/0xd0) from [<c0028e7c>] (run_local_timers+0x24/0x78)
> [   11.797892] [<c0028e7c>] (run_local_timers+0x24/0x78) from [<c0028f04>] (update_process_times+0x34/0x68)
> [   11.797940] [<c0028f04>] (update_process_times+0x34/0x68) from [<c0060920>] (tick_sched_timer+0x58/0x22c)
> [   11.797990] [<c0060920>] (tick_sched_timer+0x58/0x22c) from [<c0040820>] (__run_hrtimer+0x88/0x2b8)
> [   11.798029] [<c0040820>] (__run_hrtimer+0x88/0x2b8) from [<c0040bb0>] (hrtimer_interrupt+0x104/0x30c)
> [   11.798076] [<c0040bb0>] (hrtimer_interrupt+0x104/0x30c) from [<c0246c50>] (mxs_timer_interrupt+0x20/0x2c)
> [   11.798123] [<c0246c50>] (mxs_timer_interrupt+0x20/0x2c) from [<c00534d8>] (handle_irq_event_percpu+0x80/0x2f8)
> [   11.798161] [<c00534d8>] (handle_irq_event_percpu+0x80/0x2f8) from [<c005378c>] (handle_irq_event+0x3c/0x5c)
> [   11.798201] [<c005378c>] (handle_irq_event+0x3c/0x5c) from [<c0055f68>] (handle_level_irq+0x8c/0x118)
> [   11.798239] [<c0055f68>] (handle_level_irq+0x8c/0x118) from [<c0053448>] (generic_handle_irq+0x28/0x30)
> [   11.798281] [<c0053448>] (generic_handle_irq+0x28/0x30) from [<c00101dc>] (handle_IRQ+0x30/0x84)
> [   11.798322] [<c00101dc>] (handle_IRQ+0x30/0x84) from [<c0013484>] (__irq_svc+0x44/0x88)
> [   11.798364] [<c0013484>] (__irq_svc+0x44/0x88) from [<c02deb18>] (rt_spin_lock_slowlock+0x60/0x204)
> [   11.798402] [<c02deb18>] (rt_spin_lock_slowlock+0x60/0x204) from [<c02df4d0>] (rt_spin_lock+0x28/0x60)
> [   11.798451] [<c02df4d0>] (rt_spin_lock+0x28/0x60) from [<c0028874>] (lock_timer_base+0x28/0x48)
> [   11.798494] [<c0028874>] (lock_timer_base+0x28/0x48) from [<c02dcb28>] (schedule_timeout+0x78/0x254)
> [   11.798531] [<c02dcb28>] (schedule_timeout+0x78/0x254) from [<c00763a4>] (rcu_gp_kthread+0x2d4/0x5f0)
> [   11.798578] [<c00763a4>] (rcu_gp_kthread+0x2d4/0x5f0) from [<c003cf24>] (kthread+0xa0/0xa8)
> [   11.798621] [<c003cf24>] (kthread+0xa0/0xa8) from [<c000f3e0>] (ret_from_fork+0x14/0x34)

Thanks
-- 
                                                      Stano
