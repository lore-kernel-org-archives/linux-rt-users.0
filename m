From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Mon, 18 Dec 2017 20:01:05 -0600
Message-ID: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:17821 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934714AbdLSCBT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Dec 2017 21:01:19 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

Below results of running stress-ng --class os --all 0 -t 5m on TI am57xx-evm (SMP, 2 cpu)
git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
branch: linux-4.14.y-rt
commit: d3d9904 v4.14.6-rt7
- only config changes applied.

one "WARNING: possible circular locking dependency detected"
[   85.943562] ======================================================
[   85.943564] WARNING: possible circular locking dependency detected
[   85.943568] 4.14.6-rt7-dirty #29 Not tainted
[   85.943570] ------------------------------------------------------
[   85.943573] stress-ng-cpu-o/764 is trying to acquire lock:
[   85.943576]  (&p->pi_lock){-...}, at: [<c0169ce8>] try_to_wake_up+0x28/0x924
[   85.943594] 
[   85.943594] but task is already holding lock:
[   85.943596]  (hrtimer_bases.lock){-...}, at: [<c01c12ac>] hrtimer_interrupt+0x68/0x2b0

one "WARNING: CPU: 0 PID: 3514 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x3e8/0x988"
^ sorry, log not very readable

[  197.432766] [<c0136458>] (warn_slowpath_null) from [<c01b8390>] (rcu_note_context_switch+0x3e8/0x988)
[  197.432775] [<c01b8390>] (rcu_note_context_switch) from [<c08437fc>] (__schedule+0xc4/0xa88)
[  197.432782] [<c08437fc>] (__schedule) from [<c0844218>] (schedule+0x58/0xf4)
[  197.432790] [<c0844218>] (schedule) from [<c084585c>] (rt_spin_lock_slowlock_locked+0xac/0x300)
[  197.432797] [<c084585c>] (rt_spin_lock_slowlock_locked) from [<c08466a4>] (__read_rt_lock+0x84/0xc0)
[  197.432805] [<c08466a4>] (__read_rt_lock) from [<c0139748>] (pin_current_cpu+0x38/0x118)
[  197.432816] [<c0139748>] (pin_current_cpu) from [<c01673a8>] (migrate_disable+0x78/0x1f0)
[  197.432825] [<c01673a8>] (migrate_disable) from [<c0847a9c>] (rt_spin_lock+0x14/0x4c)
[  197.432835] [<c0847a9c>] (rt_spin_lock) from [<c02dd548>] (dput+0x204/0x414)
[  197.432843] [<c02dd548>] (dput) from [<c02d2280>] (walk_component+0x128/0x2bc)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: fail:  [3751] stress-ng-chdir: mkdir failed, errno=28 (No space left on device)
[  197.432849] [<c02d2280>] (walk_component) from [<c02d2578>] (link_path_walk+0x164/0x498)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[  197.432855] [<c02d2578>] (link_path_walk) from [<c02d2e00>] (path_openat+0x74/0x1144)
[  197.432861] [<c02d2e00>] (path_openat) from [<c02d4db8>] (do_filp_open+0x5c/0xc0)
stress-ng: fail:  [3878] stress-ng-chroot: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [3981] stress-ng-copy-file: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [3981] stress-ng-copy-file: rmdir failed, errno=2 (No such file or directory)
[  197.432870] [<c02d4db8>] (do_filp_open) from [<c02c1710>] (do_sys_open+0x100/0x1c8)
[  197.432879] [<c02c1710>] (do_sys_open) from [<c0107b28>] (__sys_trace_return+0x0/0x10)
[  197.432883] ---[ end trace 0000000000000002 ]--



-- 
regards,
-grygorii

========================================================================================
root@am57xx-evm:~# uname -a
Linux am57xx-evm 4.14.6-rt7-dirty #29 SMP PREEMPT RT Mon Dec 18 19:14:33 CST 2017 armv7l GNU/Linux

root@am57xx-evm:~# stress-ng --class os --all 0 -t 5m

[....]

stress-ng: info:  [746] cache allocate: using built-in defaults as unable to determine cache details
stress-ng: info:  [746] cache allocate: default cache size: 2048K
stress-ng: info:  [751] stress-ng-apparmor: this stressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
stress-ng: info:  [754] stress-ng-cap: this stressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
[   80.457621] hrtimer: interrupt took 223179 ns
[   81.070505] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   81.076517] NOHZ: local_softirq_pending 102
[   81.086481] NOHZ: local_softirq_pending 102
[   81.096477] NOHZ: local_softirq_pending 102
[   81.106477] NOHZ: local_softirq_pending 102
[   81.116478] NOHZ: local_softirq_pending 102
[   81.117252] NOHZ: local_softirq_pending 102
[   81.126485] NOHZ: local_softirq_pending 102
[   81.136482] NOHZ: local_softirq_pending 102
[   81.146479] NOHZ: local_softirq_pending 102
[   81.156477] NOHZ: local_softirq_pending 102
stress-ng: info:  [790] stress-ng-exec: running as root, won't run test.
[   81.491413] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   82.010701] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: fail:  [755] stress-ng-chdir: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [808] stress-ng-fault: mkdir failed, errno=28 (No space left on device)
[   82.613772] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   82.984995] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   83.354890] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   83.734523] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   84.040552] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   84.699385] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   85.150263] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   85.314091] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: info:  [1461] stress-ng-key: this stressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
stress-ng: fail:  [1458] stress-ng-kcmp: kcmp: KCMP_FILE failed, errno=38 (Function not implemented)
stress-ng: fail:  [1458] stress-ng-kcmp: kcmp: KCMP_FILE failed, errno=38 (Function not implemented)
stress-ng: fail:  [1458] stress-ng-kcmp: kcmp: KCMP_FILE failed, errno=38 (Function not implemented)
stress-ng: fail:  [1458] stress-ng-kcmp: kcmp: KCMP_FILE failed, errno=38 (Function not implemented)
stress-ng: fail:  [1458] stress-ng-kcmp: kcmp: KCMP_FILES failed, errno=38 (Function not implemented)
info: 5 failures reached, aborting stress process
[   85.943560] 
[   85.943562] ======================================================
[   85.943564] WARNING: possible circular locking dependency detected
[   85.943568] 4.14.6-rt7-dirty #29 Not tainted
[   85.943570] ------------------------------------------------------
[   85.943573] stress-ng-cpu-o/764 is trying to acquire lock:
[   85.943576]  (&p->pi_lock){-...}, at: [<c0169ce8>] try_to_wake_up+0x28/0x924
[   85.943594] 
[   85.943594] but task is already holding lock:
[   85.943596]  (hrtimer_bases.lock){-...}, at: [<c01c12ac>] hrtimer_interrupt+0x68/0x2b0
[   85.943608] 
[   85.943608] which lock already depends on the new lock.
[   85.943608] 
[   85.943609] 
[   85.943609] the existing dependency chain (in reverse order) is:
[   85.943611] 
[   85.943611] -> #3 (hrtimer_bases.lock){-...}:
[   85.943621]        lock_hrtimer_base+0x28/0x58
[   85.943626]        hrtimer_start_range_ns+0x1c/0x45c
[   85.943633]        enqueue_task_rt+0x2b8/0x304
stress-ng: info:  [1615] stress-ng-numa: this stressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
[   85.943638]        __sched_setscheduler+0x270/0x83c
[   85.943644]        _sched_setscheduler+0x80/0x88
[   85.943649]        ktimer_softirqd_set_sched_params+0x28/0x70
[   85.943653]        smpboot_thread_fn+0xe4/0x2c4
[   85.943658]        kthread+0x118/0x154
[   85.943664]        ret_from_fork+0x14/0x38
[   85.943666] 
[   85.943666] -> #2 (&rt_b->rt_runtime_lock){-...}:
[   85.943677]        enqueue_task_rt+0x1b8/0x304
[   85.943682]        __sched_setscheduler+0x270/0x83c
[   85.943686]        _sched_setscheduler+0x80/0x88
[   85.943691]        ktimer_softirqd_set_sched_params+0x28/0x70
[   85.943694]        smpboot_thread_fn+0xe4/0x2c4
[   85.943698]        kthread+0x118/0x154
stress-ng: error: [869] stress-ng-fifo: read timeout!
stress-ng: error: [875] stress-ng-fifo: read timeout!
stress-ng: error: [883] stress-ng-fifo: read timeout!
[   85.943702]        ret_from_fork+0x14/0x38
[   85.943704] 
[   85.943704] -> #1 (&rq->lock){-...}:
[   85.943714]        task_fork_fair+0x2c/0x178
[   85.943719]        sched_fork+0xec/0x298
[   85.943725]        copy_process.part.5+0x460/0x1c44
[   85.943730]        _do_fork+0xa8/0x800
[   85.943734]        kernel_thread+0x28/0x30
[   85.943739]        rest_init+0x1c/0x264
[   85.943746]        start_kernel+0x364/0x3dc
[   85.943750]        0x8000807c
[   85.943751] 
[   85.943751] -> #0 (&p->pi_lock){-...}:
[   85.943762]        _raw_spin_lock_irqsave+0x40/0x54
[   85.943767]        try_to_wake_up+0x28/0x924
[   85.943771]        hrtimer_interrupt+0x110/0x2b0
[   85.943774]        hrtimers_dead_cpu+0x348/0x370
[   85.943780]        cpuhp_invoke_callback+0xfc/0x115c
[   85.943783]        _cpu_down.constprop.6+0xe4/0x22c
[   85.943788]        do_cpu_down+0x30/0x54
[   85.943794]        device_offline+0x84/0xb4
[   85.943798]        online_store+0x44/0x74
[   85.943804]        kernfs_fop_write+0xf8/0x204
[   85.943811]        __vfs_write+0x20/0x128
[   85.943816]        vfs_write+0xa0/0x164
[   85.943821]        SyS_write+0x44/0x9c
[   85.943826]        __sys_trace_return+0x0/0x10
[   85.943828] 
[   85.943828] other info that might help us debug this:
[   85.943828] 
[   85.943829] Chain exists of:
[   85.943829]   &p->pi_lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
[   85.943829] 
[   85.943839]  Possible unsafe locking scenario:
[   85.943839] 
[   85.943841]        CPU0                    CPU1
[   85.943842]        ----                    ----
[   85.943843]   lock(hrtimer_bases.lock);
[   85.943847]                                lock(&rt_b->rt_runtime_lock);
[   85.943851]                                lock(hrtimer_bases.lock);
[   85.943855]   lock(&p->pi_lock);
stress-ng: fail:  [1480] stress-ng-klog: syslog ACTION_READ_ALL returned more data than was requested.
[   85.943859] 
[   85.943859]  *** DEADLOCK ***
[   85.943859] 
[   85.943862] 8 locks held by stress-ng-cpu-o/764:
[   85.943864]  #0:  (sb_writers#4){.+.+}, at: [<c02c42ec>] vfs_write+0x14c/0x164
[   85.943877]  #1:  (&of->mutex){+.+.}, at: [<c0349a94>] kernfs_fop_write+0xbc/0x204
[   85.943888]  #2:  (kn->count#86){.+.+}, at: [<c0349a9c>] kernfs_fop_write+0xc4/0x204
[   85.943899]  #3:  (device_hotplug_lock){+.+.}, at: [<c0592980>] lock_device_hotplug_sysfs+0xc/0x4c
[   85.943910]  #4:  (&dev->mutex){....}, at: [<c0593c8c>] device_offline+0x38/0xb4
[   85.943921]  #5:  (cpu_add_remove_lock){+.+.}, at: [<c0139598>] do_cpu_down+0x14/0x54
[   85.943932]  #6:  (cpu_hotplug_lock.rw_sem){++++}, at: [<c0192600>] percpu_down_write+0x14/0x100
[   85.943944]  #7:  (hrtimer_bases.lock){-...}, at: [<c01c12ac>] hrtimer_interrupt+0x68/0x2b0
[   85.943953] 
[   85.943953] stack backtrace:
stress-ng: info:  [2373] stress-ng-spawn: running as root, won't[   85.943958] CPU: 0 PID: 764 Comm: stress-ng-cpu-o Not tainted 4.14.6-rt7-dirty #29
 run test.
[   85.943961] Hardware name: Generic DRA74X (Flattened Device Tree)
[   85.943972] [<c0110258>] (unwind_backtrace) from [<c010c940>] (show_stack+0x10/0x14)
stress-ng: fail:  [1431] stress-ng-ioprio: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1486] stress-ng-locka: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1493] stress-ng-lockf: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1494] stress-ng-lockofd: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1505] stress-ng-madvise: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1518] stress-ng-mknod: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1579] stress-ng-msync: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1724] stress-ng-readahead: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1780] stress-ng-rename: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1785] stress-ng-rlimit: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1786] stress-ng-rmap: mkdi[   85.943982] [<c010c940>] (show_stack) from [<c082dec8>] (dump_stack+0xa4/0xd8)
r failed, errno=28 (No space left on device)
stress-ng: fail:  [1989] stress-ng[   85.943992] [<c082dec8>] (dump_stack) from [<c0194e5c>] (print_circular_bug+0x1c8/0x30c)
-seek: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [2000] stress-ng-sendfile: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [2462] stress-ng-symlink: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1482] stress-ng-lease: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [1485] stress-ng-link: mkdir failed, errno=2[   85.944001] [<c0194e5c>] (print_circular_bug) from [<c019840c>] (__lock_acquire+0x18b0/0x1a5c)
8 (No space left on device)
stress-ng: fail:  [812] stress-ng-fiemap: write failed, errno=28 (No space left on [   85.944011] [<c019840c>] (__lock_acquire) from [<c0198f4c>] (lock_acquire+0xd8/0x2d0)
device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: error: [1582] stress-ng-netlink-proc: kernel does not support netlink, errno=93 (Protocol not supported)
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: info:  [2523] stres[   85.944019] [<c0198f4c>] (lock_acquire) from [<c0847754>] (_raw_spin_lock_irqsave+0x40/0x54)
s-ng-sysfs: running as root, just traversing /sys and not read/writing to /sys files.
stress-ng: fail:  [1702] stress-ng-quota: quotactl command Q_GETQUOTA fai[   85.944027] [<c0847754>] (_raw_spin_lock_irqsave) from [<c0169ce8>] (try_to_wake_up+0x28/0x924)
led: errno=3 (No such process)
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: fail:  [1702] stress-ng-quota: quotactl command Q_GETFMT failed: errno=3 (No such process)
stress-ng: fail:  [1702] stress-ng-quota: quotactl command Q_GETINFO failed: errno=3 (No such process)
[   85.944035] [<c0169ce8>] (try_to_wake_up) from [<c01c1354>] (hrtimer_interrupt+0x110/0x2b0)
[   85.944041] [<c01c1354>] (hrtimer_interrupt) from [<c01c1c94>] (hrtimers_dead_cpu+0x348/0x370)
[   85.944050] [<c01c1c94>] (hrtimers_dead_cpu) from [<c013745c>] (cpuhp_invoke_callback+0xfc/0x115c)
[   85.944057] [<c013745c>] (cpuhp_invoke_callback) from [<c0842a68>] (_cpu_down.constprop.6+0xe4/0x22c)
[   85.944065] [<c0842a68>] (_cpu_down.constprop.6) from [<c01395b4>] (do_cpu_down+0x30/0x54)
[   85.944073] [<c01395b4>] (do_cpu_down) from [<c0593cd8>] (device_offline+0x84/0xb4)
stress-ng: error: [777] stress-ng-dnotify: error[   85.944081] [<c0593cd8>] (device_offline) from [<c0593dd4>] (online_store+0x44/0x74)
 writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[   85.944088] [<c0593dd4>] (online_store) from [<c0349ad0>] (kernfs_fop_write+0xf8/0x204)
stress-ng: error: [2475] stress-ng-sync-file: fallocate failed: errno=28 (No space left on device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[   85.944097] [<c0349ad0>] (kernfs_fop_write) from [<c02c3fc8>] (__vfs_write+0x20/0x128)
[   85.944105] [<c02c3fc8>] (__vfs_write) from [<c02c4240>] (vfs_write+0xa0/0x164)
stress-ng: fail:  [1702] stress-ng-quota: quotactl command Q_SYNC failed: errno=38 (Function not implemented)
stress-ng: error: [1702] stress-ng-quota: quotactl() failed, not available on thi[   85.944114] [<c02c4240>] (vfs_write) from [<c02c4418>] (SyS_write+0x44/0x9c)
s kernel
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[   85.944123] [<c02c4418>] (SyS_write) from [<c0107b28>] (__sys_trace_return+0x0/0x10)
stress-ng: error: [2879] stress-ng-userfaultfd: [   99.876282] Alignment trap: stress-ng-opcod (1995) PC=0xb6d7654a Instr=0xcdce Address=0x00000975 FSR 0x011
userfaultfd failed, errno = 38 (Function not implemented)
stress-ng: fail:  [2881] stress-ng-utime: mkdir failed, errno=28 (No space left on device)
[  101.309591] mmap: stress-ng-remap (1741) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.txt.
stress-ng: info:  [3123] stress-ng-xattr: this s[  103.697655] audit: type=1326 audit(1509251595.529:2): auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2170 comm="stress-ng-secco" exe="/usr/bin/stress-ng" sig=31 arch=40000028 sy
scall=4 compat=0 ip=0xb6e8e3e6 code=0x0
tressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
stress-ng: fail:  [777] stress-ng-dnotify: did not get expected dnotify file descriptor
stress-ng: info:  [3164] stress-ng-yield: limiting to 1 yielder (instance 0)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)[  103.698832] audit: type=1701 audit(1509251595.529:3): auid=4294967295 uid=0 gid=0 
ses=4294967295 pid=2170 comm="stress-ng-secco" exe="/usr/bin/stress-ng" sig=31 res=1

stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[  106.002082] Alignment trap: stress-ng-opcod (2196) PC=0xb6d76024 Instr=0xc271 Address=0x0000007f FSR 0x811
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[  150.803127] audit: type=1701 audit(1509251642.629:4): auid=4294967295 uid=0 gid=0 ses=4294967295 pid=776 comm="stress-ng-dirde" exe="/usr/bin/stress-ng" sig=11 res=1
stress-ng: fail:  [3313] stress-ng-aio: mkdir failed, errno=28 (No space left on device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: fail:  [3314] stress-ng-aiol: mkdir failed, errno=28 (No space left on device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[  189.148251] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: info:  [3444] stress-ng-apparmor: this stressor is not implemented on this system: armv7l Linux 4.14.6-rt7-dirty
[  194.507587] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
[  197.432677] ------------[ cut here ]------------
[  197.432692] WARNING: CPU: 0 PID: 3514 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x3e8/0x988
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: fail:  [777] stress-ng-dnotify: did not get expected dnotify file descriptor
[  197.432695] Modules linked in:
[  197.432705] CPU: 0 PID: 3514 Comm: (agetty) Not tainted 4.14.6-rt7-dirty #29
[  197.432708] Hardware name: Generic DRA74X (Flattened Device Tree)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng[  197.432723] [<c0110258>] (unwind_backtrace) from [<c010c940>] (show_stack+0x10/0x14)
-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: error: [1360] stress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: error: [1360] st[  197.432736] [<c010c940>] (show_stack) from [<c082dec8>] (dump_stack+0xa4/0xd8)
ress-ng-inotify: error writing to file ./tmp-stress-ng-inotify-1360-0/inotify_file: errno=28 (No space left on device)
stress-ng: error: [1360] stress-ng-inotify: cannot mkdir ./tmp-stress-ng-inotify-1360-0/new_dir: errno=28 (No space left on device)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: info:  [3721] stress-ng-cap: this stressor is not imple[  197.432747] [<c082dec8>] (dump_stack) from [<c0136380>] (__warn+0xd4/0x100)
mented on this system: armv7l Linux 4.14.6-rt7-dirty
[  197.432757] [<c0136380>] (__warn) from [<c0136458>] (warn_slowpath_null+0x20/0x28)
[  197.432766] [<c0136458>] (warn_slowpath_null) from [<c01b8390>] (rcu_note_context_switch+0x3e8/0x988)
[  197.432775] [<c01b8390>] (rcu_note_context_switch) from [<c08437fc>] (__schedule+0xc4/0xa88)
[  197.432782] [<c08437fc>] (__schedule) from [<c0844218>] (schedule+0x58/0xf4)
[  197.432790] [<c0844218>] (schedule) from [<c084585c>] (rt_spin_lock_slowlock_locked+0xac/0x300)
[  197.432797] [<c084585c>] (rt_spin_lock_slowlock_locked) from [<c08466a4>] (__read_rt_lock+0x84/0xc0)
[  197.432805] [<c08466a4>] (__read_rt_lock) from [<c0139748>] (pin_current_cpu+0x38/0x118)
[  197.432816] [<c0139748>] (pin_current_cpu) from [<c01673a8>] (migrate_disable+0x78/0x1f0)
[  197.432825] [<c01673a8>] (migrate_disable) from [<c0847a9c>] (rt_spin_lock+0x14/0x4c)
[  197.432835] [<c0847a9c>] (rt_spin_lock) from [<c02dd548>] (dput+0x204/0x414)
[  197.432843] [<c02dd548>] (dput) from [<c02d2280>] (walk_component+0x128/0x2bc)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
stress-ng: fail:  [3751] stress-ng-chdir: mkdir failed, errno=28 (No space left on device)
[  197.432849] [<c02d2280>] (walk_component) from [<c02d2578>] (link_path_walk+0x164/0x498)
stress-ng: error: [777] stress-ng-dnotify: error writing to file ./tmp-stress-ng-dnotify-777-0/dnotify_file: errno=28 (No space left on device)
[  197.432855] [<c02d2578>] (link_path_walk) from [<c02d2e00>] (path_openat+0x74/0x1144)
[  197.432861] [<c02d2e00>] (path_openat) from [<c02d4db8>] (do_filp_open+0x5c/0xc0)
stress-ng: fail:  [3878] stress-ng-chroot: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [3981] stress-ng-copy-file: mkdir failed, errno=28 (No space left on device)
stress-ng: fail:  [3981] stress-ng-copy-file: rmdir failed, errno=2 (No such file or directory)
[  197.432870] [<c02d4db8>] (do_filp_open) from [<c02c1710>] (do_sys_open+0x100/0x1c8)
[  197.432879] [<c02c1710>] (do_sys_open) from [<c0107b28>] (__sys_trace_return+0x0/0x10)
[  197.432883] ---[ end trace 0000000000000002 ]---
stress-ng: fail:  [777] stress-ng-dnotify: did not get expected dnotify file descriptor
[  320.251807] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  329.696696] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: fail:  [1701] stress-ng-pty: open /dev/ptmx failed, errno=24 (Too many open files)
stress-ng: fail:  [1701] stress-ng-pty: open /dev/ptmx failed, errno=24 (Too many open files)
stress-ng: fail:  [1701] stress-ng-pty: open /dev/ptmx failed, errno=24 (Too many open files)
[  367.335558] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  376.843596] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  383.098782] Alignment trap: stress-ng-opcod (4534) PC=0xb6d7607c Instr=0x98327a06 Address=0x00001fe6 FSR 0x011
[  391.634656] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
stress-ng: info:  [762] stress-ng-clone: created[  395.831673] sched: RT throttling activated
 a maximum of 24 clones
stress-ng: fail:  [747] stress-ng-af-alg: socket failed, errno=97 (Address family not supported by protocol)
stress-ng: fail:  [4280] stress-ng-dir: mkdir failed, errno=28 (No space left on[  398.338116] audit: type=1701 audit(1509251890.167:5): auid=4294967295 uid=0 gid=0 ses=4294967295 pid=4353 comm="stress-ng-dirde" exe="/usr/bin/st
ress-ng" sig=11 res=1
 device)
[  402.445659] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  407.263815] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  408.137095] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  409.300929] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[...]
