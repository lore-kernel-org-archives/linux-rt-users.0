From: Mike Galbraith <efault@gmx.de>
Subject: Re: v4.11.12-rt10 - hotplug lockdep splat
Date: Sat, 02 Sep 2017 09:00:39 +0200
Message-ID: <1504335639.16793.11.camel@gmx.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
         <1503482024.4970.5.camel@gmx.de>
         <20170831161834.t7ymwsnpbko6und5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831161834.t7ymwsnpbko6und5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-08-31 at 18:18 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-08-23 11:53:44 [+0200], Mike Galbraith wrote:
> > virt box reminded me this morning to report this gripe.
> 
> if you can reproduce it, then this should make it go away:

Bug yawns, stretches: "Huh? Make what go away?" ;-)

[  186.049162] ======================================================
[  186.049163] [ INFO: possible circular locking dependency detected ]
[  186.049164] 4.11.12-rt11-virgin #47 Tainted: G            E  
[  186.049164] -------------------------------------------------------
[  186.049165] stress-cpu-hotp/3338 is trying to acquire lock:
[  186.049165]  (&p->pi_lock){-...-.}, at: [<ffffffff810b3eed>] try_to_wake_up+0x2d/0x970
[  186.049179] 
[  186.049179] but task is already holding lock:
[  186.049179]  (hrtimer_bases.lock/1){......}, at: [<ffffffff8111cb6d>] hrtimers_dead_cpu+0x7d/0x390
[  186.049186] 
[  186.049186] which lock already depends on the new lock.
[  186.049186] 
[  186.049186] 
[  186.049186] the existing dependency chain (in reverse order) is:
[  186.049186] 
[  186.049186] -> #4 (hrtimer_bases.lock/1){......}:
[  186.049189]        lock_acquire+0xbd/0x250
[  186.049194]        _raw_spin_lock_nested+0x41/0x60
[  186.049195]        hrtimers_dead_cpu+0x7d/0x390
[  186.049196]        cpuhp_invoke_callback+0x248/0x9d0
[  186.049197]        cpuhp_down_callbacks+0x42/0x80
[  186.049198]        _cpu_down+0xc5/0x100
[  186.049199]        do_cpu_down+0x3c/0x60
[  186.049199]        cpu_down+0x10/0x20
[  186.049203]        cpu_subsys_offline+0x14/0x20
[  186.049204]        device_offline+0x8a/0xb0
[  186.049205]        online_store+0x40/0x80
[  186.049209]        dev_attr_store+0x18/0x30
[  186.049213]        sysfs_kf_write+0x44/0x60
[  186.049214]        kernfs_fop_write+0x13c/0x1d0
[  186.049217]        __vfs_write+0x28/0x140
[  186.049218]        vfs_write+0xc7/0x1f0
[  186.049219]        SyS_write+0x49/0xa0
[  186.049221]        entry_SYSCALL_64_fastpath+0x1f/0xc2
[  186.049221] 
[  186.049221] -> #3 (hrtimer_bases.lock){-.....}:
[  186.049226]        lock_acquire+0xbd/0x250
[  186.049226]        _raw_spin_lock_irqsave+0x53/0x70
[  186.049227]        lock_hrtimer_base.isra.27+0x29/0x50
[  186.049228]        hrtimer_start_range_ns+0x2f/0x410
[  186.049229]        enqueue_task_rt+0x325/0x360
[  186.049232]        __sched_setscheduler+0x2d5/0xb60
[  186.049233]        _sched_setscheduler+0x68/0x70
[  186.049234]        sched_setscheduler+0x13/0x20
[  186.049235]        ktimer_softirqd_set_sched_params+0x2a/0x60
[  186.049236]        smpboot_thread_fn+0x131/0x320
[  186.049238]        kthread+0x114/0x150
[  186.049239]        ret_from_fork+0x2a/0x40
[  186.049239] 
[  186.049239] -> #2 (&rt_b->rt_runtime_lock){-.....}:
[  186.049241]        lock_acquire+0xbd/0x250
[  186.049242]        _raw_spin_lock+0x3b/0x50
[  186.049242]        enqueue_task_rt+0x1d8/0x360
[  186.049243]        __sched_setscheduler+0x2d5/0xb60
[  186.049244]        _sched_setscheduler+0x68/0x70
[  186.049245]        sched_setscheduler+0x13/0x20
[  186.049246]        ktimer_softirqd_set_sched_params+0x2a/0x60
[  186.049247]        smpboot_thread_fn+0x131/0x320
[  186.049248]        kthread+0x114/0x150
[  186.049248]        ret_from_fork+0x2a/0x40
[  186.049248] 
[  186.049248] -> #1 (&rq->lock){-...-.}:
[  186.049250]        lock_acquire+0xbd/0x250
[  186.049250]        _raw_spin_lock+0x3b/0x50
[  186.049251]        task_fork_fair+0x3a/0x100
[  186.049252]        sched_fork+0x10d/0x2f0
[  186.049255]        copy_process.part.32+0x747/0x20a0
[  186.049256]        _do_fork+0xe4/0x710
[  186.049257]        kernel_thread+0x29/0x30
[  186.049258]        rest_init+0x22/0xe0
[  186.049266]        start_kernel+0x489/0x496
[  186.049268]        x86_64_start_reservations+0x2a/0x2c
[  186.049269]        x86_64_start_kernel+0x13d/0x14c
[  186.049271]        verify_cpu+0x0/0xfc
[  186.049271] 
[  186.049271] -> #0 (&p->pi_lock){-...-.}:
[  186.049272]        __lock_acquire+0x1527/0x1560
[  186.049273]        lock_acquire+0xbd/0x250
[  186.049273]        _raw_spin_lock_irqsave+0x53/0x70
[  186.049274]        try_to_wake_up+0x2d/0x970
[  186.049274]        wake_up_process+0x15/0x20
[  186.049275]        wakeup_timer_softirqd+0x32/0x40
[  186.049276]        wakeup_proper_softirq+0x25/0x30
[  186.049277]        raise_softirq_irqoff+0x3c/0x50
[  186.049278]        hrtimers_dead_cpu+0x289/0x390
[  186.049278]        cpuhp_invoke_callback+0x248/0x9d0
[  186.049279]        cpuhp_down_callbacks+0x42/0x80
[  186.049279]        _cpu_down+0xc5/0x100
[  186.049280]        do_cpu_down+0x3c/0x60
[  186.049280]        cpu_down+0x10/0x20
[  186.049281]        cpu_subsys_offline+0x14/0x20
[  186.049282]        device_offline+0x8a/0xb0
[  186.049283]        online_store+0x40/0x80
[  186.049284]        dev_attr_store+0x18/0x30
[  186.049284]        sysfs_kf_write+0x44/0x60
[  186.049285]        kernfs_fop_write+0x13c/0x1d0
[  186.049285]        __vfs_write+0x28/0x140
[  186.049286]        vfs_write+0xc7/0x1f0
[  186.049287]        SyS_write+0x49/0xa0
[  186.049287]        entry_SYSCALL_64_fastpath+0x1f/0xc2
[  186.049288] 
[  186.049288] other info that might help us debug this:
[  186.049288] 
[  186.049288] Chain exists of:
[  186.049288]   &p->pi_lock --> hrtimer_bases.lock --> hrtimer_bases.lock/1
[  186.049288] 
[  186.049289]  Possible unsafe locking scenario:
[  186.049289] 
[  186.049289]        CPU0                    CPU1
[  186.049290]        ----                    ----
[  186.049290]   lock(hrtimer_bases.lock/1);
[  186.049290]                                lock(hrtimer_bases.lock);
[  186.049291]                                lock(hrtimer_bases.lock/1);
[  186.049291]   lock(&p->pi_lock);
[  186.049292] 
[  186.049292]  *** DEADLOCK ***
[  186.049292] 
[  186.049292] 9 locks held by stress-cpu-hotp/3338:
[  186.049292]  #0:  (sb_writers#3){.+.+.+}, at: [<ffffffff8127f746>] vfs_write+0x196/0x1f0
[  186.049294]  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff813187cc>] kernfs_fop_write+0x10c/0x1d0
[  186.049295]  #2:  (s_active#139){.+.+.+}, at: [<ffffffff813187d4>] kernfs_fop_write+0x114/0x1d0
[  186.049296]  #3:  (device_hotplug_lock){+.+.+.}, at: [<ffffffff81553e95>] lock_device_hotplug_sysfs+0x15/0x40
[  186.049297]  #4:  (&dev->mutex){......}, at: [<ffffffff81555718>] device_offline+0x48/0xb0
[  186.049299]  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<ffffffff8107e295>] do_cpu_down+0x25/0x60
[  186.049300]  #6:  (cpu_hotplug_lock.rw_sem){++++++}, at: [<ffffffff810de1e6>] percpu_down_write+0x26/0x120
[  186.049301]  #7:  (hrtimer_bases.lock){-.....}, at: [<ffffffff8111cb60>] hrtimers_dead_cpu+0x70/0x390
[  186.049303]  #8:  (hrtimer_bases.lock/1){......}, at: [<ffffffff8111cb6d>] hrtimers_dead_cpu+0x7d/0x390
[  186.049304] 
[  186.049304] stack backtrace:
[  186.049305] CPU: 0 PID: 3338 Comm: stress-cpu-hotp Tainted: G            E   4.11.12-rt11-virgin #47
[  186.049306] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  186.049306] Call Trace:
[  186.049312]  dump_stack+0x85/0xc8
[  186.049317]  print_circular_bug+0x1f9/0x207
[  186.049318]  __lock_acquire+0x1527/0x1560
[  186.049320]  lock_acquire+0xbd/0x250
[  186.049321]  ? try_to_wake_up+0x2d/0x970
[  186.049322]  _raw_spin_lock_irqsave+0x53/0x70
[  186.049322]  ? try_to_wake_up+0x2d/0x970
[  186.049323]  try_to_wake_up+0x2d/0x970
[  186.049324]  wake_up_process+0x15/0x20
[  186.049325]  wakeup_timer_softirqd+0x32/0x40
[  186.049326]  wakeup_proper_softirq+0x25/0x30
[  186.049327]  raise_softirq_irqoff+0x3c/0x50
[  186.049328]  hrtimers_dead_cpu+0x289/0x390
[  186.049329]  ? hrtimers_prepare_cpu+0x90/0x90
[  186.049330]  cpuhp_invoke_callback+0x248/0x9d0
[  186.049335]  ? flow_cache_lookup+0x430/0x430
[  186.049336]  cpuhp_down_callbacks+0x42/0x80
[  186.049337]  _cpu_down+0xc5/0x100
[  186.049338]  do_cpu_down+0x3c/0x60
[  186.049339]  cpu_down+0x10/0x20
[  186.049340]  cpu_subsys_offline+0x14/0x20
[  186.049341]  device_offline+0x8a/0xb0
[  186.049341]  online_store+0x40/0x80
[  186.049343]  dev_attr_store+0x18/0x30
[  186.049343]  sysfs_kf_write+0x44/0x60
[  186.049344]  kernfs_fop_write+0x13c/0x1d0
[  186.049345]  __vfs_write+0x28/0x140
[  186.049346]  ? rcu_read_lock_sched_held+0x98/0xa0
[  186.049347]  ? rcu_sync_lockdep_assert+0x32/0x60
[  186.049348]  ? __sb_start_write+0x1d2/0x290
[  186.049349]  ? vfs_write+0x196/0x1f0
[  186.049352]  ? security_file_permission+0x3b/0xc0
[  186.049353]  vfs_write+0xc7/0x1f0
[  186.049354]  ? trace_hardirqs_on_caller+0xf9/0x1c0
[  186.049355]  SyS_write+0x49/0xa0
[  186.049356]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  186.049357] RIP: 0033:0x7fde821d0d10
[  186.049358] RSP: 002b:00007ffc2ee807e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  186.049359] RAX: ffffffffffffffda RBX: 0000000001fae090 RCX: 00007fde821d0d10
[  186.049360] RDX: 0000000000000002 RSI: 00007fde82d3e000 RDI: 0000000000000001
[  186.049360] RBP: 00007ffc2ee80800 R08: 000000000000000a R09: 00007fde82cf8700
[  186.049360] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000007
[  186.049361] R13: 0000000000000001 R14: 0000000000000009 R15: 000000000000000a
