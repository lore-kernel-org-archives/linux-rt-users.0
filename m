From: Mike Galbraith <efault@gmx.de>
Subject: v4.11.12-rt10 - hotplug lockdep splat
Date: Wed, 23 Aug 2017 11:53:44 +0200
Message-ID: <1503482024.4970.5.camel@gmx.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

virt box reminded me this morning to report this gripe.

[  512.629932] ======================================================
[  512.629933] [ INFO: possible circular locking dependency detected ]
[  512.629934] 4.11.12-rt10-virgin #45 Tainted: G            E  
[  512.629934] -------------------------------------------------------
[  512.629935] stress-cpu-hotp/18312 is trying to acquire lock:
[  512.629935]  (&p->pi_lock){-...-.}, at: [<ffffffff810b3eed>] try_to_wake_up+0x2d/0x970
[  512.629948] but task is already holding lock:
[  512.629948]  (hrtimer_bases.lock){-.....}, at: [<ffffffff8111c757>] hrtimer_interrupt+0x77/0x1d0
[  512.629954] which lock already depends on the new lock.
[  512.629954] the existing dependency chain (in reverse order) is:
[  512.629954] -> #3 (hrtimer_bases.lock){-.....}:
[  512.629960]        lock_acquire+0xbd/0x250
[  512.629965]        _raw_spin_lock_irqsave+0x53/0x70
[  512.629966]        lock_hrtimer_base.isra.27+0x29/0x50
[  512.629966]        hrtimer_start_range_ns+0x2f/0x410
[  512.629968]        enqueue_task_rt+0x325/0x360
[  512.629970]        __sched_setscheduler+0x2d5/0xb60
[  512.629971]        _sched_setscheduler+0x68/0x70
[  512.629972]        sched_setscheduler+0x13/0x20
[  512.629974]        ktimer_softirqd_set_sched_params+0x2a/0x60
[  512.629975]        smpboot_thread_fn+0x131/0x320
[  512.629976]        kthread+0x114/0x150
[  512.629979]        ret_from_fork+0x2a/0x40
[  512.629979] -> #2 (&rt_b->rt_runtime_lock){-.....}:
[  512.629980]        lock_acquire+0xbd/0x250
[  512.629981]        _raw_spin_lock+0x3b/0x50
[  512.629982]        enqueue_task_rt+0x1d8/0x360
[  512.629983]        __sched_setscheduler+0x2d5/0xb60
[  512.629984]        _sched_setscheduler+0x68/0x70
[  512.629985]        sched_setscheduler+0x13/0x20
[  512.629985]        ktimer_softirqd_set_sched_params+0x2a/0x60
[  512.629986]        smpboot_thread_fn+0x131/0x320
[  512.629987]        kthread+0x114/0x150
[  512.629988]        ret_from_fork+0x2a/0x40
[  512.629988] -> #1 (&rq->lock){-...-.}:
[  512.629989]        lock_acquire+0xbd/0x250
[  512.629990]        _raw_spin_lock+0x3b/0x50
[  512.629990]        task_fork_fair+0x3a/0x100
[  512.629991]        sched_fork+0x10d/0x2f0
[  512.629995]        copy_process.part.32+0x747/0x20a0
[  512.629996]        _do_fork+0xe4/0x710
[  512.629997]        kernel_thread+0x29/0x30
[  512.629999]        rest_init+0x22/0xe0
[  512.630007]        start_kernel+0x489/0x496
[  512.630009]        x86_64_start_reservations+0x2a/0x2c
[  512.630010]        x86_64_start_kernel+0x13d/0x14c
[  512.630011]        verify_cpu+0x0/0xfc
[  512.630011] -> #0 (&p->pi_lock){-...-.}:
[  512.630013]        __lock_acquire+0x1527/0x1560
[  512.630013]        lock_acquire+0xbd/0x250
[  512.630014]        _raw_spin_lock_irqsave+0x53/0x70
[  512.630014]        try_to_wake_up+0x2d/0x970
[  512.630015]        wake_up_process+0x15/0x20
[  512.630016]        wakeup_timer_softirqd+0x32/0x40
[  512.630016]        wakeup_proper_softirq+0x25/0x30
[  512.630017]        raise_softirq_irqoff+0x3c/0x50
[  512.630019]        __hrtimer_run_queues+0x19c/0x650
[  512.630020]        hrtimer_interrupt+0xb8/0x1d0
[  512.630021]        hrtimers_dead_cpu+0x37a/0x390
[  512.630022]        cpuhp_invoke_callback+0x248/0x9d0
[  512.630022]        cpuhp_down_callbacks+0x42/0x80
[  512.630023]        _cpu_down+0xc5/0x100
[  512.630023]        do_cpu_down+0x3c/0x60
[  512.630024]        cpu_down+0x10/0x20
[  512.630028]        cpu_subsys_offline+0x14/0x20
[  512.630029]        device_offline+0x8a/0xb0
[  512.630030]        online_store+0x40/0x80
[  512.630034]        dev_attr_store+0x18/0x30
[  512.630038]        sysfs_kf_write+0x44/0x60
[  512.630039]        kernfs_fop_write+0x13c/0x1d0
[  512.630042]        __vfs_write+0x28/0x140
[  512.630042]        vfs_write+0xc7/0x1f0
[  512.630043]        SyS_write+0x49/0xa0
[  512.630044]        entry_SYSCALL_64_fastpath+0x1f/0xc2
[  512.630044] other info that might help us debug this:
[  512.630044] Chain exists of: &p->pi_lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
[  512.630045]  Possible unsafe locking scenario:
[  512.630045]        CPU0                    CPU1
[  512.630045]        ----                    ----
[  512.630046]   lock(hrtimer_bases.lock);
[  512.630046]                                lock(&rt_b->rt_runtime_lock);
[  512.630046]                                lock(hrtimer_bases.lock);
[  512.630047]   lock(&p->pi_lock);
[  512.630047] *** DEADLOCK ***
[  512.630048] 8 locks held by stress-cpu-hotp/18312:
[  512.630048]  #0:  (sb_writers#3){.+.+.+}, at: [<ffffffff8127f726>] vfs_write+0x196/0x1f0
[  512.630050]  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff813187ac>] kernfs_fop_write+0x10c/0x1d0
[  512.630051]  #2:  (s_active#139){.+.+.+}, at: [<ffffffff813187b4>] kernfs_fop_write+0x114/0x1d0
[  512.630053]  #3:  (device_hotplug_lock){+.+.+.}, at: [<ffffffff81553e75>] lock_device_hotplug_sysfs+0x15/0x40
[  512.630055]  #4:  (&dev->mutex){......}, at: [<ffffffff815556f8>] device_offline+0x48/0xb0
[  512.630057]  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<ffffffff8107e295>] do_cpu_down+0x25/0x60
[  512.630059]  #6:  (cpu_hotplug_lock.rw_sem){++++++}, at: [<ffffffff810de1e6>] percpu_down_write+0x26/0x120
[  512.630062]  #7:  (hrtimer_bases.lock){-.....}, at: [<ffffffff8111c757>] hrtimer_interrupt+0x77/0x1d0
[  512.630064] stack backtrace:
[  512.630065] CPU: 0 PID: 18312 Comm: stress-cpu-hotp Tainted: G            E   4.11.12-rt10-virgin #45
[  512.630066] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[  512.630067] Call Trace:
[  512.630074]  dump_stack+0x85/0xc8
[  512.630080]  print_circular_bug+0x1f9/0x207
[  512.630082]  __lock_acquire+0x1527/0x1560
[  512.630085]  lock_acquire+0xbd/0x250
[  512.630085]  ? try_to_wake_up+0x2d/0x970
[  512.630087]  _raw_spin_lock_irqsave+0x53/0x70
[  512.630088]  ? try_to_wake_up+0x2d/0x970
[  512.630089]  try_to_wake_up+0x2d/0x970
[  512.630091]  wake_up_process+0x15/0x20
[  512.630092]  wakeup_timer_softirqd+0x32/0x40
[  512.630093]  wakeup_proper_softirq+0x25/0x30
[  512.630094]  raise_softirq_irqoff+0x3c/0x50
[  512.630096]  __hrtimer_run_queues+0x19c/0x650
[  512.630098]  hrtimer_interrupt+0xb8/0x1d0
[  512.630100]  hrtimers_dead_cpu+0x37a/0x390
[  512.630102]  ? hrtimers_prepare_cpu+0x90/0x90
[  512.630103]  cpuhp_invoke_callback+0x248/0x9d0
[  512.630112]  ? flow_cache_lookup+0x430/0x430
[  512.630114]  cpuhp_down_callbacks+0x42/0x80
[  512.630116]  _cpu_down+0xc5/0x100
[  512.630117]  do_cpu_down+0x3c/0x60
[  512.630118]  cpu_down+0x10/0x20
[  512.630120]  cpu_subsys_offline+0x14/0x20
[  512.630121]  device_offline+0x8a/0xb0
[  512.630123]  online_store+0x40/0x80
[  512.630124]  dev_attr_store+0x18/0x30
[  512.630125]  sysfs_kf_write+0x44/0x60
[  512.630127]  kernfs_fop_write+0x13c/0x1d0
[  512.630128]  __vfs_write+0x28/0x140
[  512.630130]  ? rcu_read_lock_sched_held+0x98/0xa0
[  512.630131]  ? rcu_sync_lockdep_assert+0x32/0x60
[  512.630134]  ? __sb_start_write+0x1d2/0x290
[  512.630134]  ? vfs_write+0x196/0x1f0
[  512.630137]  ? security_file_permission+0x3b/0xc0
[  512.630138]  vfs_write+0xc7/0x1f0
[  512.630139]  ? trace_hardirqs_on_caller+0xf9/0x1c0
[  512.630141]  SyS_write+0x49/0xa0
[  512.630142]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  512.630143] RIP: 0033:0x7fdac1c54d10
[  512.630144] RSP: 002b:00007ffd545bf5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  512.630144] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdac1c54d10
[  512.630145] RDX: 0000000000000002 RSI: 00007fdac27c2000 RDI: 0000000000000001
[  512.630145] RBP: 00007ffd545bebb0 R08: 000000000000000a R09: 00007fdac277c700
[  512.630145] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000002657d86
[  512.630146] R13: 00007ffd545bebc8 R14: 0000000002657d86 R15: 00007ffd545bebb4
