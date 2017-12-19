From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.9-rt][report] stress-ng: possible circular locking dependency
 detected
Date: Mon, 18 Dec 2017 18:55:24 -0600
Message-ID: <e27d043e-9565-f9fd-0b00-8fa5e123f147@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sekhar Nori <nsekhar@ti.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,

I've tried to run stress-ng on TI am57xx-evm (SMP, 2 cpu) and caught 2  "INFO: possible circular locking dependency detected"

Command 1 (log 1):
## stress-ng --class cpu --all 0 -t 5m &   stress-ng --class memory --all 0 --vm-bytes 90% -t 5m

Command 2 (log 2):
## stress-ng --class os --all 0 -t 5m

actually command 2 often stuck or crushes (Log3 - I've collected 3 different dumps)

-- 
regards,
-grygorii

========Log 1: Command 1 "INFO: possible circular locking dependency detected" ===========================

stress-ng: info:  [790] dispatching hogs: 2 af-alg, 2 atomic, 2 bsearch, 2 context, 2 cpu, 2 cpu-online, 2 crypt, 2 fp-error, 2 getrandom, 2 heapsort, 2 hsearch, 2 longjmp, 2 lsearch, 2 matrix, 2 mergesort, 2 nop, 2 numa, 2 opcb
stress-ng: info:  [790] cache allocate: using built-in defaults as unable to determine cache details
stress-ng: info:  [790] cache allocate: default cache size: 2048K
root@am57xx-evm:~# stress-ng: info:  [803] stress-ng-heapsort: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [816] stress-ng-stream: using built-in defaults as unable to determine cache details
stress-ng: info:  [816] stress-ng-stream: stressor loosely based on a variant of the STREAM benchmark code
stress-ng: info:  [816] stress-ng-stream: do NOT submit any of these results to the STREAM benchmark results
stress-ng: info:  [816] stress-ng-stream: Using CPU cache size of 2048K
stress-ng: info:  [817] stress-ng-tsc: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [814] stress-ng-rdrand: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [809] stress-ng-mergesort: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [811] stress-ng-numa:[   34.724819] CPU1: shutdown
 this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [837] stress-ng-heapsort: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
[   35.387040] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   35.392816] NOHZ: local_softirq_pending 02
[   35.402792] NOHZ: local_softirq_pending 02
[   35.412796] NOHZ: local_softirq_pending 02
[   35.422797] NOHZ: local_softirq_pending 02
[   35.432792] NOHZ: local_softirq_pending 02
[   35.442791] NOHZ: local_softirq_pending 02
[   35.452792] NOHZ: local_softirq_pending 02
[   35.462800] NOHZ: local_softirq_pending 02
[   35.472792] NOHZ: local_softirq_pending 02
[   35.482798] NOHZ: local_softirq_pending 02
stress-ng: info:  [859] stress-ng-tsc: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [842] stress-ng-mergesort: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [851] stress-ng-numa: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
stress-ng: info:  [856] stress-ng-rdrand: this stressor is not implemented on this system: armv7l Linux 4.9.70-rt60-00441-g3148205-dirty
[   36.806639] Alignment trap: stress-ng-opcod (912) PC=0xb6cef03a Instr=0xc188 Address=0x86dadcb2 FSR 0x801
[   37.026960] CPU1: shutdown
[   37.336123] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   37.420693] Unhandled prefetch abort: breakpoint debug exception (0x002) at 0x00000000
[   37.454825] CPU1: shutdown
[   37.856107] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   38.181945] Alignment trap: stress-ng-opcod (955) PC=0xb6cef022 Instr=0xc11d Address=0x000000a9 FSR 0x811
[   38.584581] CPU1: shutdown
[   38.746093] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   38.974976] CPU1: shutdown
[   39.362605] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   39.453989] Alignment trap: stress-ng-opcod (985) PC=0xb6cef102 Instr=0xca59 Address=0x00003609 FSR 0x011
[   39.556349] Alignment trap: stress-ng-opcod (991) PC=0xb6cef12a Instr=0xc060 Address=0xb6cef007 FSR 0x811
[   39.605045] CPU1: shutdown
[   39.846075] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   39.870339] Alignment trap: stress-ng-opcod (1005) PC=0xb6cef0ec Instr=0xc0dd Address=0xb6cef0eb FSR 0x811
[   39.876391] Alignment trap: stress-ng-opcod (1006) PC=0xb6cef058 Instr=0x09004223 Address=0xb6cef042 FSR 0x811
[   40.185530] CPU1: shutdown
[   40.277393] Alignment trap: stress-ng-opcod (1016) PC=0xb6cef028 Instr=0xf8909f4c Address=0xb6cef012 FSR 0x011
[   40.436477] Alignment trap: stress-ng-opcod (1021) PC=0xb6cef068 Instr=0xcb04 Address=0xfff59fff FSR 0x031
[   41.206222] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   41.299333] Alignment trap: stress-ng-opcod (1042) PC=0xb6cef0d4 Instr=0x59a15c0b Address=0x65d57905 FSR 0x801
[   41.304758] CPU1: shutdown
[   41.826670] Alignment trap: stress-ng-opcod (1052) PC=0xb6cef032 Instr=0xcc42 Address=0xffffff4e FSR 0x031
[   41.846143] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   42.566702] CPU1: shutdown
[   42.729036] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   43.056178] CPU1: shutdown
[   43.386103] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   43.577730] Alignment trap: stress-ng-opcod (1117) PC=0xb6cef0e8 Instr=0xca59 Address=0x00003143 FSR 0x011
[   43.617644] CPU1: shutdown
[   43.796584] Alignment trap: stress-ng-opcod (1124) PC=0xb6cef0e6 Instr=0xca59 Address=0x000012eb FSR 0x011
[   44.208391] 
[   44.208393] ======================================================
[   44.208395] [ INFO: possible circular locking dependency detected ]
[   44.208400] 4.9.70-rt60-00441-g3148205-dirty #21 Not tainted
[   44.208402] -------------------------------------------------------
[   44.208406] stress-ng-opcod/812 is trying to acquire lock:
[   44.208424]  (&hp->lock){+.+.+.}, at: [<c0139d1c>] pin_current_cpu+0x44/0x178

[   44.208426] but task is already holding lock:
[   44.208435]  (tasklist_lock){+.+...}, at: [<c013ad84>] release_task+0xd4/0x544

[   44.208437] which lock already depends on the new lock.
[   44.208437] 
[   44.208438] 
[   44.208438] the existing dependency chain (in reverse order) is:
[   44.208445] 
[   44.208445] -> #1 (tasklist_lock){+.+...}:
[   44.208452]        notify_dead+0x20/0xdc
[   44.208457]        cpuhp_invoke_callback+0xc8/0xc48
[   44.208462]        cpuhp_down_callbacks+0x48/0x74
[   44.208470]        _cpu_down.constprop.7+0x1cc/0x370
[   44.208475]        do_cpu_down+0x30/0x54
[   44.208482]        device_offline+0x84/0xb4
[   44.208487]        online_store+0x44/0x74
[   44.208492]        kernfs_fop_write+0xec/0x1f4
[   44.208498]        __vfs_write+0x20/0x118
[   44.208502]        vfs_write+0xa0/0x164
[   44.208507]        SyS_write+0x44/0x9c
[   44.208513]        __sys_trace_return+0x0/0x10
[   44.208520] 
[   44.208520] -> #0 (&hp->lock){+.+.+.}:
[   44.208525]        rt_spin_lock__no_mg+0x70/0x84
[   44.208530]        pin_current_cpu+0x44/0x178
[   44.208536]        migrate_disable+0x74/0x104
[   44.208540]        __rt_spin_lock+0xc/0x58
[   44.208543]        release_task+0xd4/0x544
[   44.208546]        wait_consider_task+0xafc/0x11dc
[   44.208549]        do_wait+0x118/0x3dc
[   44.208552]        SyS_wait4+0x64/0xc8
[   44.208556]        __sys_trace_return+0x0/0x10
[   44.208559] 
[   44.208559] other info that might help us debug this:
[   44.208559] 
[   44.208560]  Possible unsafe locking scenario:
[   44.208560] 
[   44.208562]        CPU0                    CPU1
[   44.208563]        ----                    ----
[   44.208567]   lock(tasklist_lock);
[   44.208571]                                lock(&hp->lock);
[   44.208575]                                lock(tasklist_lock);
[   44.208578]   lock(&hp->lock);
[   44.208580] 
[   44.208580]  *** DEADLOCK ***
[   44.208580] 
[   44.208584] 1 lock held by stress-ng-opcod/812:
[   44.208593]  #0:  (tasklist_lock){+.+...}, at: [<c013ad84>] release_task+0xd4/0x544
[   44.208594] 
[   44.208594] stack backtrace:
[   44.208600] CPU: 0 PID: 812 Comm: stress-ng-opcod Not tainted 4.9.70-rt60-00441-g3148205-dirty #21
[   44.208602] Hardware name: Generic DRA74X (Flattened Device Tree)
[   44.208612] [<c010fce8>] (unwind_backtrace) from [<c010c59c>] (show_stack+0x10/0x14)
[   44.208620] [<c010c59c>] (show_stack) from [<c04aa9e4>] (dump_stack+0xa4/0xd8)
[   44.208630] [<c04aa9e4>] (dump_stack) from [<c0193be8>] (print_circular_bug+0x1c8/0x30c)
[   44.208638] [<c0193be8>] (print_circular_bug) from [<c01971a4>] (__lock_acquire+0x1828/0x1aa4)
[   44.208645] [<c01971a4>] (__lock_acquire) from [<c0197840>] (lock_acquire+0xd8/0x2d0)
[   44.208652] [<c0197840>] (lock_acquire) from [<c07ea944>] (rt_spin_lock__no_mg+0x70/0x84)
[   44.208661] [<c07ea944>] (rt_spin_lock__no_mg) from [<c0139d1c>] (pin_current_cpu+0x44/0x178)
[   44.208669] [<c0139d1c>] (pin_current_cpu) from [<c0167d60>] (migrate_disable+0x74/0x104)
[   44.208676] [<c0167d60>] (migrate_disable) from [<c07ea848>] (__rt_spin_lock+0xc/0x58)
[   44.208682] [<c07ea848>] (__rt_spin_lock) from [<c013ad84>] (release_task+0xd4/0x544)
[   44.208687] [<c013ad84>] (release_task) from [<c013bcf0>] (wait_consider_task+0xafc/0x11dc)
[   44.208692] [<c013bcf0>] (wait_consider_task) from [<c013c4e8>] (do_wait+0x118/0x3dc)
[   44.208697] [<c013c4e8>] (do_wait) from [<c013dc8c>] (SyS_wait4+0x64/0xc8)
[   44.208705] [<c013dc8c>] (SyS_wait4) from [<c0107b28>] (__sys_trace_return+0x0/0x10)
[   44.254493] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   44.417044] Alignment trap: stress-ng-opcod (1133) PC=0xb6cef0ea Instr=0xe9f16d2a Address=0x57f22823 FSR 0x001
[   44.819709] CPU1: shutdown
[   44.886219] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
============================================================================================================================

======== Log 2: Command 2 "INFO: possible circular locking dependency detected" ===========================
[  180.050616] 
[  180.050618] =========================================================
[  180.050620] [ INFO: possible irq lock inversion dependency detected ]
[  180.050625] 4.9.68-rt60-dirty #20 Not tainted
[  180.050627] ---------------------------------------------------------
[  180.050632] stress-ng-resou/2028 just changed the state of lock:
[  180.050654]  (&ei->i_es_lock){+.+.-.}, at: [<c0388d8c>] ext4_es_remove_extent+0x78/0x258
but this lock took another, RECLAIM_FS-unsafe lock in the past:
[  180.050663]  (&hp->lock){+.+.+.}
[  180.050663] 
[  180.050663] and interrupts could create inverse lock ordering between them.
[  180.050663] 
[  180.050665] 
[  180.050665] other info that might help us debug this:
[  180.050667]  Possible interrupt unsafe locking scenario:
[  180.050667] 
[  180.050668]        CPU0                    CPU1
[  180.050670]        ----                    ----
[  180.050674]   lock(&hp->lock);
[  180.050676]                                local_irq_disable();
[  180.050680]                                lock(&ei->i_es_lock);
[  180.050683]                                lock(&hp->lock);
[  180.050685]   <Interrupt>
[  180.050688]     lock(&ei->i_es_lock);
[  180.050690] 
[  180.050690]  *** DEADLOCK ***
[  180.050690] 
[  180.050693] 4 locks held by stress-ng-resou/2028:
[  180.050708]  #0:  (sb_writers#6){.+.+.+}, at: [<c02a4638>] vfs_fallocate+0x124/0x20c
[  180.050721]  #1:  (&sb->s_type->i_mutex_key#9){++++++}, at: [<c025e658>] shmem_fallocate+0x3c/0x5ec
[  180.050735]  #2:  (shrinker_rwsem){++++..}, at: [<c0253060>] shrink_slab+0x74/0x820
[  180.050746]  #3:  (&type->s_umount_key#22){++++.+}, at: [<c02aae30>] trylock_super+0x14/0x58
[  180.050748] 
[  180.050748] the shortest dependencies between 2nd lock and 1st lock:
[  180.050770]  -> (&hp->lock){+.+.+.} ops: 15 {
[  180.050774]     HARDIRQ-ON-W at:
[  180.050781]                       rt_spin_lock__no_mg+0x70/0x84
[  180.050789]                       takedown_cpu+0x74/0x164
[  180.050796]                       cpuhp_invoke_callback+0xc8/0xc48
[  180.050801]                       cpuhp_down_callbacks+0x48/0x74
[  180.050807]                       _cpu_down.constprop.7+0x1cc/0x370
[  180.050813]                       do_cpu_down+0x30/0x54
[  180.050819]                       device_offline+0x84/0xb4
[  180.050824]                       online_store+0x44/0x74
[  180.050830]                       kernfs_fop_write+0xec/0x1f4
[  180.050835]                       __vfs_write+0x20/0x118
[  180.050840]                       vfs_write+0xa0/0x164
[  180.050845]                       SyS_write+0x44/0x9c
[  180.050851]                       __sys_trace_return+0x0/0x10
[  180.050855]     SOFTIRQ-ON-W at:
[  180.050859]                       rt_spin_lock__no_mg+0x70/0x84
[  180.050864]                       takedown_cpu+0x74/0x164
[  180.050869]                       cpuhp_invoke_callback+0xc8/0xc48
[  180.050874]                       cpuhp_down_callbacks+0x48/0x74
[  180.050879]                       _cpu_down.constprop.7+0x1cc/0x370
[  180.050884]                       do_cpu_down+0x30/0x54
[  180.050889]                       device_offline+0x84/0xb4
[  180.050893]                       online_store+0x44/0x74
[  180.050897]                       kernfs_fop_write+0xec/0x1f4
[  180.050902]                       __vfs_write+0x20/0x118
[  180.050906]                       vfs_write+0xa0/0x164
[  180.050911]                       SyS_write+0x44/0x9c
[  180.050915]                       __sys_trace_return+0x0/0x10
[  180.050919]     RECLAIM_FS-ON-W at:
[  180.050926]                          __kmalloc_track_caller+0x44/0x444
[  180.050932]                          kvasprintf+0x48/0x98
[  180.050939]                          kobject_set_name_vargs+0x2c/0xa4
[  180.050944]                          kobject_add+0x38/0x98
[  180.050953]                          blk_mq_register_hctx+0x3c/0xa0
[  180.050958]                          blk_mq_sysfs_register+0x40/0x60
[  180.050963]                          blk_mq_queue_reinit_work+0xb8/0x110
[  180.050968]                          blk_mq_queue_reinit_dead+0x18/0x28
[  180.050974]                          cpuhp_invoke_callback+0xc8/0xc48
[  180.050979]                          cpuhp_down_callbacks+0x48/0x74
[  180.050985]                          _cpu_down.constprop.7+0x1cc/0x370
[  180.050990]                          do_cpu_down+0x30/0x54
[  180.050995]                          device_offline+0x84/0xb4
[  180.050999]                          online_store+0x44/0x74
[  180.051003]                          kernfs_fop_write+0xec/0x1f4
[  180.051008]                          __vfs_write+0x20/0x118
[  180.051013]                          vfs_write+0xa0/0x164
[  180.051017]                          SyS_write+0x44/0x9c
[  180.051022]                          __sys_trace_return+0x0/0x10
[  180.051025]     INITIAL USE at:
[  180.051029]                      rt_spin_lock__no_mg+0x70/0x84
[  180.051034]                      takedown_cpu+0x74/0x164
[  180.051040]                      cpuhp_invoke_callback+0xc8/0xc48
[  180.051044]                      cpuhp_down_callbacks+0x48/0x74
[  180.051050]                      _cpu_down.constprop.7+0x1cc/0x370
[  180.051055]                      do_cpu_down+0x30/0x54
[  180.051060]                      device_offline+0x84/0xb4
[  180.051064]                      online_store+0x44/0x74
[  180.051068]                      kernfs_fop_write+0xec/0x1f4
[  180.051073]                      __vfs_write+0x20/0x118
[  180.051077]                      vfs_write+0xa0/0x164
[  180.051081]                      SyS_write+0x44/0x9c
[  180.051086]                      __sys_trace_return+0x0/0x10
[  180.051088]   }
[  180.051096]   ... key      at: [<c0cd084c>] __key.39419+0x0/0x8
[  180.051098]   ... acquired at:
[  180.051103]    pin_current_cpu+0x44/0x178
[  180.051110]    migrate_disable+0x74/0x104
[  180.051114]    __rt_spin_lock+0xc/0x58
[  180.051118]    rt_read_lock+0x54/0x68
[  180.051123]    ext4_es_find_delayed_extent_range+0x78/0x4d8
[  180.051126]    ext4_fiemap+0x1d0/0x634
[  180.051131]    do_vfs_ioctl+0x638/0xa88
[  180.051134]    SyS_ioctl+0x6c/0x7c
[  180.051138]    __sys_trace_return+0x0/0x10
[  180.051140] 
[  180.051148] -> (&ei->i_es_lock){+.+.-.} ops: 832423 {
[  180.051151]    HARDIRQ-ON-W at:
[  180.051155]                     rt_read_lock+0x4c/0x68
[  180.051160]                     ext4_es_lookup_extent+0x64/0x4ec
[  180.051164]                     ext4_map_blocks+0x4c/0x638
[  180.051168]                     _ext4_get_block+0x74/0xd0
[  180.051173]                     generic_block_bmap+0x44/0x50
[  180.051176]                     ext4_bmap+0x8c/0xf8
[  180.051184]                     jbd2_journal_init_inode+0x18/0xe0
[  180.051191]                     ext4_fill_super+0x239c/0x349c
[  180.051195]                     mount_bdev+0x15c/0x190
[  180.051199]                     ext4_mount+0x14/0x20
[  180.051203]                     mount_fs+0x44/0x168
[  180.051208]                     vfs_kern_mount+0x4c/0xf8
[  180.051212]                     do_mount+0x178/0xb9c
[  180.051216]                     SyS_mount+0x74/0x9c
[  180.051223]                     mount_block_root+0x100/0x268
[  180.051227]                     mount_root+0xf8/0x124
[  180.051231]                     prepare_namespace+0x164/0x1c8
[  180.051235]                     kernel_init_freeable+0x2d4/0x328
[  180.051240]                     kernel_init+0x8/0x114
[  180.051245]                     ret_from_fork+0x14/0x3c
[  180.051248]    SOFTIRQ-ON-W at:
[  180.051252]                     rt_read_lock+0x4c/0x68
[  180.051257]                     ext4_es_lookup_extent+0x64/0x4ec
[  180.051260]                     ext4_map_blocks+0x4c/0x638
[  180.051264]                     _ext4_get_block+0x74/0xd0
[  180.051267]                     generic_block_bmap+0x44/0x50
[  180.051271]                     ext4_bmap+0x8c/0xf8
[  180.051276]                     jbd2_journal_init_inode+0x18/0xe0
[  180.051281]                     ext4_fill_super+0x239c/0x349c
[  180.051285]                     mount_bdev+0x15c/0x190
[  180.051289]                     ext4_mount+0x14/0x20
[  180.051293]                     mount_fs+0x44/0x168
[  180.051297]                     vfs_kern_mount+0x4c/0xf8
[  180.051302]                     do_mount+0x178/0xb9c
[  180.051305]                     SyS_mount+0x74/0x9c
[  180.051310]                     mount_block_root+0x100/0x268
[  180.051315]                     mount_root+0xf8/0x124
[  180.051319]                     prepare_namespace+0x164/0x1c8
[  180.051324]                     kernel_init_freeable+0x2d4/0x328
[  180.051329]                     kernel_init+0x8/0x114
[  180.051333]                     ret_from_fork+0x14/0x3c
[  180.051337]    IN-RECLAIM_FS-W at:
[  180.051341]                        rt_write_lock+0x30/0x40
[  180.051346]                        ext4_es_remove_extent+0x78/0x258
[  180.051351]                        ext4_clear_inode+0x34/0x70
[  180.051359]                        evict+0x9c/0x15c
[  180.051363]                        dispose_list+0x34/0x44
[  180.051369]                        prune_icache_sb+0x40/0x50
[  180.051372]                        super_cache_scan+0x138/0x178
[  180.051378]                        shrink_slab+0x31c/0x820
[  180.051382]                        shrink_node+0x100/0x340
[  180.051386]                        do_try_to_free_pages+0xbc/0x380
[  180.051389]                        try_to_free_pages+0x224/0x744
[  180.051393]                        __alloc_pages_nodemask+0x534/0x1058
[  180.051398]                        shmem_getpage_gfp+0x604/0xcdc
[  180.051401]                        shmem_fallocate+0x528/0x5ec
[  180.051406]                        vfs_fallocate+0x148/0x20c
[  180.051410]                        SyS_fallocate+0x40/0x68
[  180.051415]                        __sys_trace_return+0x0/0x10
[  180.051418]    INITIAL USE at:
[  180.051422]                    rt_read_lock+0x4c/0x68
[  180.051427]                    ext4_es_lookup_extent+0x64/0x4ec
[  180.051430]                    ext4_map_blocks+0x4c/0x638
[  180.051434]                    _ext4_get_block+0x74/0xd0
[  180.051437]                    generic_block_bmap+0x44/0x50
[  180.051440]                    ext4_bmap+0x8c/0xf8
[  180.051446]                    jbd2_journal_init_inode+0x18/0xe0
[  180.051451]                    ext4_fill_super+0x239c/0x349c
[  180.051454]                    mount_bdev+0x15c/0x190
[  180.051458]                    ext4_mount+0x14/0x20
[  180.051461]                    mount_fs+0x44/0x168
[  180.051465]                    vfs_kern_mount+0x4c/0xf8
[  180.051469]                    do_mount+0x178/0xb9c
[  180.051473]                    SyS_mount+0x74/0x9c
[  180.051478]                    mount_block_root+0x100/0x268
[  180.051481]                    mount_root+0xf8/0x124
[  180.051486]                    prepare_namespace+0x164/0x1c8
[  180.051490]                    kernel_init_freeable+0x2d4/0x328
[  180.051495]                    kernel_init+0x8/0x114
[  180.051500]                    ret_from_fork+0x14/0x3c
[  180.051501]  }
[  180.051507]  ... key      at: [<c149a2e4>] __key.59812+0x0/0x8
[  180.051508]  ... acquired at:
[  180.051518]    __lock_acquire+0x310/0x1aa4
[  180.051522]    lock_acquire+0xd8/0x2d0
[  180.051526]    rt_write_lock+0x30/0x40
[  180.051531]    ext4_es_remove_extent+0x78/0x258
[  180.051535]    ext4_clear_inode+0x34/0x70
[  180.051540]    evict+0x9c/0x15c
[  180.051544]    dispose_list+0x34/0x44
[  180.051548]    prune_icache_sb+0x40/0x50
[  180.051552]    super_cache_scan+0x138/0x178
[  180.051557]    shrink_slab+0x31c/0x820
[  180.051560]    shrink_node+0x100/0x340
[  180.051563]    do_try_to_free_pages+0xbc/0x380
[  180.051567]    try_to_free_pages+0x224/0x744
[  180.051570]    __alloc_pages_nodemask+0x534/0x1058
[  180.051574]    shmem_getpage_gfp+0x604/0xcdc
[  180.051577]    shmem_fallocate+0x528/0x5ec
[  180.051581]    vfs_fallocate+0x148/0x20c
[  180.051585]    SyS_fallocate+0x40/0x68
[  180.051589]    __sys_trace_return+0x0/0x10
[  180.051590] 
[  180.051592] 
[  180.051592] stack backtrace:
[  180.051597] CPU: 1 PID: 2028 Comm: stress-ng-resou Not tainted 4.9.68-rt60-dirty #20
[  180.051600] Hardware name: Generic DRA74X (Flattened Device Tree)
[  180.051611] [<c010fce8>] (unwind_backtrace) from [<c010c59c>] (show_stack+0x10/0x14)
[  180.051619] [<c010c59c>] (show_stack) from [<c04aa904>] (dump_stack+0xa4/0xd8)
[  180.051628] [<c04aa904>] (dump_stack) from [<c0193ff4>] (print_irq_inversion_bug+0x198/0x214)
[  180.051636] [<c0193ff4>] (print_irq_inversion_bug) from [<c0194114>] (check_usage_forwards+0xa4/0x114)
[  180.051644] [<c0194114>] (check_usage_forwards) from [<c0194fc4>] (mark_lock+0x344/0x6c0)
[  180.051651] [<c0194fc4>] (mark_lock) from [<c0195c18>] (__lock_acquire+0x310/0x1aa4)
[  180.051659] [<c0195c18>] (__lock_acquire) from [<c01977cc>] (lock_acquire+0xd8/0x2d0)
[  180.051666] [<c01977cc>] (lock_acquire) from [<c07eb128>] (rt_write_lock+0x30/0x40)
[  180.051674] [<c07eb128>] (rt_write_lock) from [<c0388d8c>] (ext4_es_remove_extent+0x78/0x258)
[  180.051683] [<c0388d8c>] (ext4_es_remove_extent) from [<c03600f8>] (ext4_clear_inode+0x34/0x70)
[  180.051691] [<c03600f8>] (ext4_clear_inode) from [<c02c60a4>] (evict+0x9c/0x15c)
[  180.051699] [<c02c60a4>] (evict) from [<c02c6198>] (dispose_list+0x34/0x44)
[  180.051708] [<c02c6198>] (dispose_list) from [<c02c75a0>] (prune_icache_sb+0x40/0x50)
[  180.051715] [<c02c75a0>] (prune_icache_sb) from [<c02aafac>] (super_cache_scan+0x138/0x178)
[  180.051723] [<c02aafac>] (super_cache_scan) from [<c0253308>] (shrink_slab+0x31c/0x820)
[  180.051730] [<c0253308>] (shrink_slab) from [<c025730c>] (shrink_node+0x100/0x340)
[  180.051736] [<c025730c>] (shrink_node) from [<c0257608>] (do_try_to_free_pages+0xbc/0x380)
[  180.051741] [<c0257608>] (do_try_to_free_pages) from [<c0257af0>] (try_to_free_pages+0x224/0x744)
[  180.051748] [<c0257af0>] (try_to_free_pages) from [<c0244d30>] (__alloc_pages_nodemask+0x534/0x1058)
[  180.051755] [<c0244d30>] (__alloc_pages_nodemask) from [<c025ca64>] (shmem_getpage_gfp+0x604/0xcdc)
[  180.051761] [<c025ca64>] (shmem_getpage_gfp) from [<c025eb44>] (shmem_fallocate+0x528/0x5ec)
[  180.051768] [<c025eb44>] (shmem_fallocate) from [<c02a465c>] (vfs_fallocate+0x148/0x20c)
[  180.051775] [<c02a465c>] (vfs_fallocate) from [<c02a552c>] (SyS_fallocate+0x40/0x68)
[  180.051783] [<c02a552c>] (SyS_fallocate) from [<c0107b28>] (__sys_trace_return+0x0/0x10)
[  192.680020] stress-ng-resou: 
[  192.680031] stress-ng-resou: page allocation stalls for 11330ms, order:0, mode:0x24200ca(GFP_HIGHUSER_MOVABLE)
[  192.680038] CPU: 1 PID: 2659 Comm: stress-ng-resou Not tainted 4.9.68-rt60-dirty #20
============================================================================================================================

========Log 3: Command 2 crash dum 1 =========================================================

[   95.829975] ------------[ cut here ]------------
[   95.829980] kernel BUG at kernel/locking/rtmutex.c:1400!
[   95.829983] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   95.830075] Modules linked in: cbc algif_skcipher md5 md4 sha512_generic sha512_arm sha256_generic sha1_generic sha1_arm_neon sha1_arm algif_hash af_alg xhci_plat_hcd xhci_hcd usbcore xfrm_user xfrm4_tunnel dwc3 ipcomp udc_co
re xfrm_ipcomp usb_common esp4 ah4 rpmsg_rpc af_key xfrm_algo prueth pru_rproc pruss pruss_intc snd_soc_omap_hdmi_audio bluetooth c_can_platform c_can ahci_platform libahci_platform can_dev libahci omap_sham omap_aes_driver liba
ta pruss_soc_bus scsi_mod omap_wdt ti_vip ti_vpe ti_sc ti_csc ti_vpdma dwc3_omap rtc_omap extcon_palmas rtc_palmas extcon_core gpio_pisosr gpio_tpic2810 omap_des ov2659 des_generic crypto_engine omap_remoteproc virtio_rpmsg_bus 
rpmsg_core remoteproc sch_fq_codel
[   95.830082] CPU: 1 PID: 1543 Comm: stress-ng-mmapf Not tainted 4.9.70-rt60-02884-g2d6971d-dirty #27
[   95.830084] Hardware name: Generic DRA74X (Flattened Device Tree)
[   95.830088] task: ea301e00 task.stack: ea322000
[   95.830101] PC is at task_blocks_on_rt_mutex+0x2a8/0x310
[   95.830106] LR is at task_blocks_on_rt_mutex+0x40/0x310
[   95.830111] pc : [<c017cc0c>]    lr : [<c017c9a4>]    psr: a00e0093
[   95.830111] sp : ea323938  ip : ea323938  fp : ea32396c
[   95.830115] r10: 00000000  r9 : 0000059c  r8 : 00000000
[   95.830118] r7 : ea3239c0  r6 : c0c64c54  r5 : 00000000  r4 : ea301e00
[   95.830121] r3 : ea323ad0  r2 : 00001791  r1 : 00000000  r0 : ea30239c
[   95.830125] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   95.830129] Control: 10c5387d  Table: aa32806a  DAC: 00000051
[   95.830132] Process stress-ng-mmapf (pid: 1543, stack limit = 0xea322210)
[   95.830135] Stack: (0xea323938 to 0xea324000)
[   95.830139] 3920:                                                       00000000 00000078
[   95.830146] 3940: 00000000 00000000 c0c64c54 00000000 00000002 600e0013 00000002 00000000
[   95.830152] 3960: ea3239b4 ea323970 c07bd830 c017c970 c0162bf8 c01606b4 000cbec7 00000000
[   95.830158] 3980: 000cbec7 00000000 00000005 00000000 00000000 c0c64c54 ea3239c0 600e0013
[   95.830164] 39a0: 00000002 00000000 ea323a1c ea3239b8 c07bd9ec c07bd794 00000000 ea3239c0
[   95.830170] 39c0: ea3239c0 00000000 c0c044c0 ea3239cc ea323a54 ea3239e0 00000000 c0167268
[   95.830176] 39e0: 00000000 eed4bc78 eed4bc78 c0b5cc40 ffffffff c0c64c54 00000002 c0c64a40
[   95.830181] 3a00: c0b582f0 ea322000 00000001 eacf1ae8 ea323a34 ea323a20 c07bdce8 c07bd998
[   95.830187] 3a20: ea301e00 c0b582f0 ea323a44 ea323a38 c07bdd24 c07bdc60 ea323a54 ea323a48
[   95.830192] 3a40: c07bf4d4 c07bdd1c ea323a84 ea323a58 c0156cb0 c07bf4d0 ea323a8c ea323a68
[   95.830198] 3a60: c017baf8 c03da8dc 17d80a9f eed472f0 c0b582f0 ea323a88 ea323aac ea323a88
[   95.830204] 3a80: c01312b8 c0156c68 ea301e00 ea30239c ea301e00 ea323ad0 eaaf6181 00000001
[   95.830209] 3aa0: ea323ac4 ea323ab0 c0155294 c01311d0 e8d09140 ea30239c ea323b2c ea323ac8
[   95.830215] 3ac0: c07bd638 c0155224 024200ca ea322008 ea2dda59 00000000 00000000 ea323adc
[   95.830221] 3ae0: 00000000 00000000 ea301e00 e8d09140 ea301e01 00000078 00000000 00000000
[   95.830227] 3b00: 00000000 e8d09140 e8d09140 ffffffff e8a5cb3c 00000000 00000000 c0b5bf88
[   95.830233] 3b20: ea323b44 ea323b30 c07bf2b8 c07bd470 e8d09140 e8d09140 ea323b64 ea323b48
[   95.830238] 3b40: c0203afc c07bf268 00000000 00000000 ea323bc0 e8a5cb3c ea323b84 ea323b68
[   95.830244] 3b60: c0235a60 c0203adc 00000000 00000000 00000400 e8a5cb3c ea323bfc ea323b88
[   95.830250] 3b80: c01eeb58 c0235a10 ee006900 00001a3a 00000080 c0c91c14 c0c28fd8 00000000
[   95.830256] 3ba0: 00000000 00000000 026080c2 00000000 ee00a800 00000000 000002e1 00000000
[   95.830262] 3bc0: 026080c2 00000000 00000000 ee00a800 eed4adf8 ea323cd0 ee00a800 00000000
[   95.830268] 3be0: 00000000 00000000 ea323c2c 00001a39 ea323c64 ea323c00 c01f212c c01eea24
[   95.830274] 3c00: 00001a39 ea323c00 ea301e00 c0c91ba0 c0c04240 ea323db8 00000000 00000000
[   95.830280] 3c20: 00000000 c0c5eac0 00001a39 c0c5eac0 0000000c 00000292 eedc2b80 ea323cd0
[   95.830285] 3c40: c0c5f600 c0c5ee80 c0c5eac0 026080c2 c0c5f600 00000000 ea323cb4 ea323c68
[   95.830291] 3c60: c01f2458 c01f2014 c0b5bf20 0000000c c0c8c374 00200010 c0c94708 c0c8bf44
[   95.830297] 3c80: c0c5f600 00000000 c0c5eac0 00000001 026080c2 c0c5f600 00000000 c0c5eac0
[   95.830303] 3ca0: c0c5eac0 00000001 ea323d24 ea323cb8 c01f2838 c01f2364 00000001 00000001
[   95.830309] 3cc0: c0c293f8 c0c8bf44 024000c0 00000000 00000020 026080c2 00000000 00000000
[   95.830314] 3ce0: 00000000 0000000c 00000001 00000007 00000000 00000000 c01e1ae0 00000000
[   95.830320] 3d00: 00000000 026080c2 c0c04660 c0c045d8 00000000 c0c04660 ea323e04 ea323d28
[   95.830326] 3d20: c01e48d0 c01f26f8 00080000 eeda8000 ea323db8 00000050 00000000 00000000
[   95.830332] 3d40: 00000010 00000040 c0c90e80 00000000 00000000 00000001 c0c045d8 000003e8
[   95.830338] 3d60: c0c8bf78 c0c8bf44 02000000 c0c04100 ffffafe1 00000001 00080000 00000000
[   95.830344] 3d80: 38e38e39 00000040 00000040 ea323da0 026080c2 026080c2 ea301e00 00000200
[   95.830350] 3da0: c0c5f600 00000000 c0c5f600 00000000 00000001 00000000 00000000 ea341d68
[   95.830355] 3dc0: b65ff000 00001052 ea323e04 ea323dd8 c0155558 c0131348 ffffffff ea341d68
[   95.830361] 3de0: 000009f1 000009f1 00000000 b6600000 00000000 00000a00 ea323e6c ea323e08
[   95.830367] 3e00: c020a8e0 c01e4440 eedc2b80 ea341d68 b65ff000 00001052 ea323e6c ea323e28
[   95.830373] 3e20: c02050a8 ea341d68 b6600000 00000004 ea32ad98 00000000 00000000 00000000
[   95.830378] 3e40: 0000072d 00000286 00001052 ea341d68 b6600000 000009f1 ea301e00 ea322000
[   95.830384] 3e60: ea323ec4 ea323e70 c0205294 c020a0f0 000000fb b5c0f000 ea2a6430 c0c04678
[   95.830389] 3e80: c0c06ec4 c0c90e80 ea322030 ea314600 ea2a6430 00000000 00000000 00000000
[   95.830395] 3ea0: ea323f04 00001002 b6886000 ea314600 ea31464c 00000001 ea323ef4 ea323ec8
[   95.830401] 3ec0: c0205af8 c02051a4 00001052 00000000 00000000 ea323f04 00000000 ea341d68
[   95.830407] 3ee0: b5c0f000 b6886000 ea323f34 ea323ef8 c0205ba8 c0205a8c ea31464c 00000001
[   95.830413] 3f00: ea323f24 00000001 c017d628 ea31464c b5c0f000 00000000 00c76a80 00000003
[   95.830419] 3f20: ea322000 00000000 ea323f74 ea323f38 c01f953c c0205b0c 00008021 00000000
[   95.830425] 3f40: 00000000 ea323f4c 00002f80 00c77000 7df22000 00008021 00000000 00c76a80
[   95.830430] 3f60: 00000003 c0107f44 ea323fa4 ea323f78 c020e1c0 c01f94a0 00008021 00000000
[   95.830436] 3f80: 00000006 ffffffff 00000000 00c76a80 000000c0 c0107f44 00000000 ea323fa8
[   95.830442] 3fa0: c0107d60 c020e17c ffffffff 00000000 00000000 00c76a80 00000003 00008021
[   95.830448] 3fc0: ffffffff 00000000 00c76a80 000000c0 0009dd58 00000000 00080bb8 be8f4928
[   95.830454] 3fe0: 000000c0 be8f4424 b6d72b07 b6cf8ab6 400b0030 00000000 00000000 00000000
[   95.830457] Backtrace: 
[   95.830470] [<c017c964>] (task_blocks_on_rt_mutex) from [<c07bd830>] (rt_mutex_slowlock_locked+0xa8/0x204)
[   95.830477]  r10:00000000 r9:00000002 r8:600e0013 r7:00000002 r6:00000000 r5:c0c64c54
[   95.830479]  r4:00000000
[   95.830487] [<c07bd788>] (rt_mutex_slowlock_locked) from [<c07bd9ec>] (rt_mutex_slowlock.constprop.8+0x60/0x98)
[   95.830492]  r10:00000000 r9:00000002 r8:600e0013 r7:ea3239c0 r6:c0c64c54 r5:00000000
[   95.830494]  r4:00000000
[   95.830502] [<c07bd98c>] (rt_mutex_slowlock.constprop.8) from [<c07bdce8>] (rt_mutex_lock_state+0x94/0xbc)
[   95.830507]  r10:eacf1ae8 r9:00000001 r8:ea322000 r7:c0b582f0 r6:c0c64a40 r5:00000002
[   95.830509]  r4:c0c64c54
[   95.830516] [<c07bdc54>] (rt_mutex_lock_state) from [<c07bdd24>] (rt_mutex_lock+0x14/0x18)
[   95.830519]  r5:c0b582f0 r4:ea301e00
[   95.830527] [<c07bdd10>] (rt_mutex_lock) from [<c07bf4d4>] (_mutex_lock+0x10/0x14)
[   95.830534] [<c07bf4c4>] (_mutex_lock) from [<c0156cb0>] (migrate_me+0x54/0x1bc)
[   95.830542] [<c0156c5c>] (migrate_me) from [<c01312b8>] (pin_current_cpu+0xf4/0x178)
[   95.830545]  r6:ea323a88 r5:c0b582f0 r4:eed472f0
[   95.830554] [<c01311c4>] (pin_current_cpu) from [<c0155294>] (migrate_disable+0x7c/0x108)
[   95.830558]  r9:00000001 r8:eaaf6181 r7:ea323ad0 r6:ea301e00 r5:ea30239c r4:ea301e00
[   95.830566] [<c0155218>] (migrate_disable) from [<c07bd638>] (rt_spin_lock_slowlock+0x1d4/0x324)
[   95.830569]  r5:ea30239c r4:e8d09140
[   95.830576] [<c07bd464>] (rt_spin_lock_slowlock) from [<c07bf2b8>] (rt_spin_lock+0x5c/0x60)
[   95.830581]  r10:c0b5bf88 r9:00000000 r8:00000000 r7:e8a5cb3c r6:ffffffff r5:e8d09140
[   95.830583]  r4:e8d09140
[   95.830591] [<c07bf25c>] (rt_spin_lock) from [<c0203afc>] (list_lru_count_one+0x2c/0x78)
[   95.830593]  r5:e8d09140 r4:e8d09140
[   95.830601] [<c0203ad0>] (list_lru_count_one) from [<c0235a60>] (super_cache_count+0x5c/0xac)
[   95.830605]  r7:e8a5cb3c r6:ea323bc0 r5:00000000 r4:00000000
[   95.830614] [<c0235a04>] (super_cache_count) from [<c01eeb58>] (shrink_slab+0x140/0x3b8)
[   95.830618]  r7:e8a5cb3c r6:00000400 r5:00000000 r4:00000000
[   95.830625] [<c01eea18>] (shrink_slab) from [<c01f212c>] (shrink_node+0x124/0x350)
[   95.830630]  r10:00001a39 r9:ea323c2c r8:00000000 r7:00000000 r6:00000000 r5:ee00a800
[   95.830631]  r4:ea323cd0
[   95.830636] [<c01f2008>] (shrink_node) from [<c01f2458>] (do_try_to_free_pages+0x100/0x394)
[   95.830641]  r10:00000000 r9:c0c5f600 r8:026080c2 r7:c0c5eac0 r6:c0c5ee80 r5:c0c5f600
[   95.830643]  r4:ea323cd0
[   95.830648] [<c01f2358>] (do_try_to_free_pages) from [<c01f2838>] (try_to_free_pages+0x14c/0x328)
[   95.830652]  r10:00000001 r9:c0c5eac0 r8:c0c5eac0 r7:00000000 r6:c0c5f600 r5:026080c2
[   95.830654]  r4:00000001
[   95.830661] [<c01f26ec>] (try_to_free_pages) from [<c01e48d0>] (__alloc_pages_nodemask+0x49c/0xdd8)
[   95.830665]  r10:c0c04660 r9:00000000 r8:c0c045d8 r7:c0c04660 r6:026080c2 r5:00000000
[   95.830667]  r4:00000000
[   95.830674] [<c01e4434>] (__alloc_pages_nodemask) from [<c020a8e0>] (handle_mm_fault+0x7fc/0xd1c)
[   95.830679]  r10:00000a00 r9:00000000 r8:b6600000 r7:00000000 r6:000009f1 r5:000009f1
[   95.830681]  r4:ea341d68
[   95.830687] [<c020a0e4>] (handle_mm_fault) from [<c0205294>] (__get_user_pages+0xfc/0x4a0)
[   95.830692]  r10:ea322000 r9:ea301e00 r8:000009f1 r7:b6600000 r6:ea341d68 r5:00001052
[   95.830694]  r4:00000286
[   95.830701] [<c0205198>] (__get_user_pages) from [<c0205af8>] (populate_vma_page_range+0x78/0x80)
[   95.830706]  r10:00000001 r9:ea31464c r8:ea314600 r7:b6886000 r6:00001002 r5:ea323f04
[   95.830707]  r4:00000000
[   95.830714] [<c0205a80>] (populate_vma_page_range) from [<c0205ba8>] (__mm_populate+0xa8/0x144)
[   95.830717]  r6:b6886000 r5:b5c0f000 r4:ea341d68
[   95.830724] [<c0205b00>] (__mm_populate) from [<c01f953c>] (vm_mmap_pgoff+0xa8/0xac)
[   95.830729]  r10:00000000 r9:ea322000 r8:00000003 r7:00c76a80 r6:00000000 r5:b5c0f000
[   95.830731]  r4:ea31464c
[   95.830738] [<c01f9494>] (vm_mmap_pgoff) from [<c020e1c0>] (SyS_mmap_pgoff+0x50/0xc8)
[   95.830743]  r8:c0107f44 r7:00000003 r6:00c76a80 r5:00000000 r4:00008021
[   95.830752] [<c020e170>] (SyS_mmap_pgoff) from [<c0107d60>] (ret_fast_syscall+0x0/0x50)
[   95.830756]  r8:c0107f44 r7:000000c0 r6:00c76a80 r5:00000000 r4:ffffffff
[   95.830763] Code: eb18fd19 e3e0000a e24bd028 e89daff0 (e7f001f2) 
============================================================================================================================

========Log 3: Command 2 crash dum 2 =========================================================

[   81.723791] ------------[ cut here ]------------
[   81.723797] Kernel BUG at c017caa0 [verbose debug info unavailable]
[   81.723803] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   81.723894] Modules linked in: sha256_generic(+) sha1_generic sha1_arm_neon sha1_arm algif_hash af_alg xhci_plat_hcd xhci_hcd usbcore xfrm_user xfrm4_tunnel ipcomp xfrm_ipcomp esp4 rpmsg_rpc dwc3 ah4 udc_core usb_common af_ke
y xfrm_algo prueth pru_rproc pruss pruss_intc snd_soc_omap_hdmi_audio bluetooth ahci_platform libahci_platform libahci libata c_can_platform c_can omap_sham pruss_soc_bus omap_aes_driver can_dev omap_wdt scsi_mod ti_vip ti_vpe t
i_sc dwc3_omap extcon_palmas ti_csc ti_vpdma extcon_core rtc_omap rtc_palmas gpio_pisosr ov2659 gpio_tpic2810 omap_des des_generic crypto_engine omap_remoteproc virtio_rpmsg_bus rpmsg_core remoteproc sch_fq_codel
[   81.723901] CPU: 1 PID: 6886 Comm: stress-ng-resou Not tainted 4.9.70-rt60-02884-g2d6971d-dirty #25
[   81.723904] Hardware name: Generic DRA74X (Flattened Device Tree)
[   81.723907] task: eab2ad00 task.stack: e503a000
[   81.723919] PC is at task_blocks_on_rt_mutex+0x1d8/0x30c
[   81.723925] LR is at task_blocks_on_rt_mutex+0x40/0x30c
[   81.723930] pc : [<c017caa0>]    lr : [<c017c908>]    psr: a00e0093
[   81.723930] sp : e503bdf8  ip : e503bdf8  fp : e503be2c
[   81.723932] r10: 0000059c  r9 : 0000059c  r8 : 00000000
[   81.723935] r7 : e503be38  r6 : eed47320  r5 : ecff7080  r4 : eab2ad00
[   81.723938] r3 : e503bef0  r2 : 00000008  r1 : 00000000  r0 : eab2b29c
[   81.723943] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   81.723946] Control: 10c5387d  Table: aa38006a  DAC: 00000051
[   81.723949] Process stress-ng-resou (pid: 6886, stack limit = 0xe503a210)
[   81.723953] Stack: (0xe503bdf8 to 0xe503c000)
[   81.723957] bde0:                                                       c016c12c c0167210
[   81.723964] be00: 00000000 eed47320 eab2b29c eab2ad00 e503be38 a00e0013 00000000 0000059c
[   81.723969] be20: e503be94 e503be30 c07bc5d4 c017c8d4 c01531a8 c07bdff0 e503be38 00000002
[   81.723975] be40: e503be74 e503be44 c014f314 eed4bc40 00000000 e519b480 ea8f4a01 e9568600
[   81.723981] be60: 00000016 eed4bc40 e503becc eed47320 c0b582f0 e503bea8 c0b582f0 e503a000
[   81.723987] be80: 00000001 e52bfe30 e503bea4 e503be98 c07be2c8 c07bc4f0 e503becc e503bea8
[   81.723992] bea0: c0131260 c07be288 eab2ad00 eab2b29c eab2ad00 e503bef0 eaa5e181 00000001
[   81.723998] bec0: e503bee4 e503bed0 c0155248 c01311c8 c0c02040 eab2b29c e503bf4c e503bee8
[   81.724003] bee0: c07bc6b8 c01551d8 00000000 e503a028 e517bed1 00000000 00000000 e503befc
[   81.724009] bf00: 00000000 00000000 eab2ad00 c0c02040 eab2ad01 00000078 00000000 00000000
[   81.724014] bf20: 00000000 c0c02040 eab2b284 00000000 e503bf78 00000000 e956864c 00000000
[   81.724020] bf40: e503bf64 e503bf50 c07be388 c07bc4f0 eab2ad00 eab2b284 e503bf74 e503bf68
[   81.724026] bf60: c07be668 c07be338 e503bf94 e503bf78 c0133854 c07be664 e503bf78 e503bf78
[   81.724031] bf80: 00000000 00000001 e503bfa4 e503bf98 c0133f50 c0133518 00000000 e503bfa8
[   81.724037] bfa0: c0107d60 c0133f44 00800000 00000000 00000000 007fa000 00000000 00000001
[   81.724042] bfc0: 00800000 00000000 00000000 00000001 00000000 b6949fb0 beaca800 00000000
[   81.724048] bfe0: 00000001 b6949e78 b6ea9681 b6eb2366 00010030 00000000 00000000 00000000
[   81.724051] Backtrace: 
[   81.724063] [<c017c8c8>] (task_blocks_on_rt_mutex) from [<c07bc5d4>] (rt_spin_lock_slowlock+0xf0/0x314)
[   81.724071]  r10:0000059c r9:00000000 r8:a00e0013 r7:e503be38 r6:eab2ad00 r5:eab2b29c
[   81.724072]  r4:eed47320
[   81.724083] [<c07bc4e4>] (rt_spin_lock_slowlock) from [<c07be2c8>] (rt_spin_lock__no_mg+0x4c/0x50)
[   81.724099]  r10:e52bfe30 r9:00000001 r8:e503a000 r7:c0b582f0 r6:e503bea8 r5:c0b582f0
[   81.724104]  r4:eed47320
[   81.724116] [<c07be27c>] (rt_spin_lock__no_mg) from [<c0131260>] (pin_current_cpu+0xa4/0x178)
[   81.724127] [<c01311bc>] (pin_current_cpu) from [<c0155248>] (migrate_disable+0x7c/0x108)
[   81.724132]  r9:00000001 r8:eaa5e181 r7:e503bef0 r6:eab2ad00 r5:eab2b29c r4:eab2ad00
[   81.724144] [<c01551cc>] (migrate_disable) from [<c07bc6b8>] (rt_spin_lock_slowlock+0x1d4/0x314)
[   81.724151]  r5:eab2b29c r4:c0c02040
[   81.724163] [<c07bc4e4>] (rt_spin_lock_slowlock) from [<c07be388>] (__rt_spin_lock+0x5c/0x60)
[   81.724168]  r10:00000000 r9:e956864c r8:00000000 r7:e503bf78 r6:00000000 r5:eab2b284
[   81.724171]  r4:c0c02040
[   81.724185] [<c07be32c>] (__rt_spin_lock) from [<c07be668>] (rt_write_lock+0x10/0x14)
[   81.724189]  r5:eab2b284 r4:eab2ad00
[   81.724197] [<c07be658>] (rt_write_lock) from [<c0133854>] (do_exit+0x348/0xa08)
[   81.724206] [<c013350c>] (do_exit) from [<c0133f50>] (do_group_exit+0x0/0xc4)
[   81.724208]  r7:00000001
[   81.724220] [<c0133f38>] (SyS_exit) from [<c0107d60>] (ret_fast_syscall+0x0/0x50)
[   81.724227] Code: e3120002 0a000002 eb18f992 eaffffcb (e7f001f2)

============================================================================================================================

========Log 3: Command 2 crash dum 3 =========================================================
[   36.468583] ------------[ cut here ]------------
[   36.468586] Kernel BUG at c017caa0 [verbose debug info unavailable]
[   36.468590] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   36.468667] Modules linked in: sha512_generic sha512_arm sha256_generic sha1_generic sha1_arm_neon sha1_arm algif_hash af_alg xhci_plat_hcd xhci_hcd usbcore rpmsg_rpc dwc3 udc_core usb_common xfrm_user xfrm4_tunnel ipcomp xfr
m_ipcomp esp4 ah4 af_key xfrm_algo prueth pru_rproc bluetooth pruss pruss_intc snd_soc_omap_hdmi_audio ahci_platform libahci_platform libahci libata c_can_platform c_can omap_aes_driver scsi_mod pruss_soc_bus can_dev omap_sham o
map_wdt ti_vip ti_vpe ti_sc ti_csc ti_vpdma dwc3_omap rtc_omap extcon_palmas gpio_pisosr extcon_core omap_des rtc_palmas gpio_tpic2810 des_generic ov2659 crypto_engine omap_remoteproc virtio_rpmsg_bus rpmsg_core remoteproc sch_f
q_codel
[   36.468674] CPU: 1 PID: 1248 Comm: stress-ng-memfd Not tainted 4.9.70-rt60-02884-g2d6971d-dirty #25
[   36.468676] Hardware name: Generic DRA74X (Flattened Device Tree)
[   36.468679] task: ead53480 task.stack: ead78000
[   36.468690] PC is at task_blocks_on_rt_mutex+0x1d8/0x30c
[   36.468696] LR is at task_blocks_on_rt_mutex+0x40/0x30c
[   36.468701] pc : [<c017caa0>]    lr : [<c017c908>]    psr: a00e0093
[   36.468701] sp : ead79b38  ip : ead79b38  fp : ead79b6c
[   36.468704] r10: 0000059c  r9 : 0000059c  r8 : 00000000
[   36.468707] r7 : ead79b78  r6 : eed47320  r5 : ecf67080  r4 : ead53480
[   36.468710] r3 : ead79c30  r2 : 00000011  r1 : 00000000  r0 : ead53a1c
[   36.468715] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   36.468718] Control: 10c5387d  Table: aad7c06a  DAC: 00000051
[   36.468721] Process stress-ng-memfd (pid: 1248, stack limit = 0xead78210)
[   36.468724] Stack: (0xead79b38 to 0xead7a000)
[   36.468729] 9b20:                                                       c016c12c c0167210
[   36.468735] 9b40: 00000000 eed47320 ead53a1c ead53480 ead79b78 a00e0013 00000000 0000059c
[   36.468741] 9b60: ead79bd4 ead79b70 c07bc5d4 c017c8d4 c01531a8 c07bdff0 ead79b78 00000002
[   36.468747] 9b80: ead79bb4 ead79b84 c014f314 eed4bc40 00000000 ea913480 ea9e3e01 eac49600
[   36.468753] 9ba0: 00000005 eed4bc40 ead79c0c eed47320 c0b582f0 ead79be8 c0b582f0 ead78000
[   36.468758] 9bc0: 00000001 ecfcfcd0 ead79be4 ead79bd8 c07be2c8 c07bc4f0 ead79c0c ead79be8
[   36.468764] 9be0: c0131260 c07be288 ead53480 ead53a1c ead53480 ead79c30 ea9f2d01 00000001
[   36.468769] 9c00: ead79c24 ead79c10 c0155248 c01311c8 ee012c00 ead53a1c ead79c8c ead79c28
[   36.468775] 9c20: c07bc6b8 c01551d8 eb441d20 ead78028 eab4bc31 eab7dc30 00000000 ead79c3c
[   36.468781] 9c40: 00000000 00000000 ead53480 ee012c00 ead53401 00000078 00000000 00000000
[   36.468787] 9c60: 00000011 ee012c00 ead53480 eb441d20 ead5348c 00000011 ead79eb0 00000000
[   36.468793] 9c80: ead79ca4 ead79c90 c07be328 c07bc4f0 eb486aa0 ead53480 ead79cbc ead79ca8
[   36.468798] 9ca0: c024e1b0 c07be2d8 eb486aa0 ead53480 ead79cd4 ead79cc0 c0250418 c024e1a0
[   36.468804] 9cc0: eb441d20 ead53480 ead79cfc ead79cd8 c028f8f4 c0250404 ed8011e0 c0c9336c
[   36.468810] 9ce0: 00000000 eb441d20 ed824020 eb441d20 ead79d14 ead79d00 c028f9f8 c028f8e8
[   36.468815] 9d00: ead53480 ed824020 ead79d34 ead79d18 c0290e0c c028f9e8 ed824020 eb441d20
[   36.468821] 9d20: 00000011 ed8011e0 ead79d54 ead79d38 c028c590 c0290d3c eb441d20 ed824020
[   36.468826] 9d40: ed8240a0 ed8011e0 ead79d94 ead79d58 c023d6f8 c028c580 ead79ef0 00000000
[   36.468832] 9d60: ead79d60 ead79d60 c02963fc 00000003 ead79ea8 00000000 efcd3c6d 3880961f
[   36.468837] 9d80: efcd3c6d 93fc9c50 ead79dc4 ead79d98 c0240900 c023d674 ead79ef0 eaaf8980
[   36.468843] 9da0: ead79ea8 ed8241e0 c9c5093f ee05a01b ead79ea8 efcd3c6d ead79e14 ead79dc8
[   36.468849] 9dc0: c0240c7c c0240700 ed6f3a00 61c88647 00000000 00000004 ead79ea8 ee05a010
[   36.468855] 9de0: ead79e14 ead79df0 c023f5dc ee05a010 ead79f5c ead79f5c 00000001 c0107f44
[   36.468860] 9e00: ed6f3a00 ead79ea8 ead79ea4 ead79e18 c02412a8 c02409dc c0118740 c01552e0
[   36.468866] 9e20: ea9c4268 00000100 f741759f 00000040 ead79ea4 ead78000 c020a86c c01186f0                                      
[   36.468872] 9e40: a0080013 00000041 00000001 ed6f3a00 ead79e74 ead79e60 00000000 ea9c4268                                      
[   36.468877] 9e60: 0005f000 00000054 ead7c000 c0400f20 200b0013 ffffffff ead79ec4 00000004                                      
[   36.468883] 9e80: ead79ea8 ead79f5c 00000001 c0107f44 ead78000 00000000 ead79f4c ead79ea8                                      
[   36.468888] 9ea0: c024308c c0241234 ed4d1c10 ed8011e0 3880961f 00000004 eaaf8980 ead79ec8                                      
[   36.468894] 9ec0: ed116710 ed843960 ed824020 00000011 00000002 000006ea 00000000 00000001
[   36.468900] 9ee0: 00000001 ead79ee8 ed4d1c10 ed801280 c025c278 eaaf8980 ee05a01b 00000002
[   36.468905] 9f00: c0251ef4 c07be4b0 c02423bc 00000001 00000001 00000001 ee05a000 00000000
[   36.468911] 9f20: ed8241e0 00000002 ffffff9c 00000000 00000004 ffffff9c ee05a000 00000005
[   36.468917] 9f40: ead79f94 ead79f50 c0232064 c0243030 ecf76000 ead53480 ead53480 00000001
[   36.468922] 9f60: ead70000 00000002 00000100 00000001 00000001 0009dd58 bec409a8 00000005
[   36.468928] 9f80: c0107f44 ead78000 ead79fa4 ead79f98 c0232134 c0231f58 00000000 ead79fa8
[   36.468934] 9fa0: c0107d60 c0232120 00000001 0009dd58 0007f4e8 00000001 00000000 004b6560
[   36.468939] 9fc0: 00000001 0009dd58 bec409a8 00000005 00000000 00000000 0007568c 00000000
[   36.468945] 9fe0: 00000000 bec408b4 0005cd08 b6e65d46 200b0030 0007f4e8 00000000 00000000
[   36.468948] Backtrace: 
[   36.468960] [<c017c8c8>] (task_blocks_on_rt_mutex) from [<c07bc5d4>] (rt_spin_lock_slowlock+0xf0/0x314)
[   36.468967]  r10:0000059c r9:00000000 r8:a00e0013 r7:ead79b78 r6:ead53480 r5:ead53a1c
[   36.468968]  r4:eed47320
[   36.468979] [<c07bc4e4>] (rt_spin_lock_slowlock) from [<c07be2c8>] (rt_spin_lock__no_mg+0x4c/0x50)
[   36.468984]  r10:ecfcfcd0 r9:00000001 r8:ead78000 r7:c0b582f0 r6:ead79be8 r5:c0b582f0
[   36.468986]  r4:eed47320
[   36.468996] [<c07be27c>] (rt_spin_lock__no_mg) from [<c0131260>] (pin_current_cpu+0xa4/0x178)
[   36.469005] [<c01311bc>] (pin_current_cpu) from [<c0155248>] (migrate_disable+0x7c/0x108)
[   36.469010]  r9:00000001 r8:ea9f2d01 r7:ead79c30 r6:ead53480 r5:ead53a1c r4:ead53480
[   36.469018] [<c01551cc>] (migrate_disable) from [<c07bc6b8>] (rt_spin_lock_slowlock+0x1d4/0x314)
[   36.469021]  r5:ead53a1c r4:ee012c00
[   36.469028] [<c07bc4e4>] (rt_spin_lock_slowlock) from [<c07be328>] (rt_spin_lock+0x5c/0x60)
[   36.469034]  r10:00000000 r9:ead79eb0 r8:00000011 r7:ead5348c r6:eb441d20 r5:ead53480
[   36.469036]  r4:ee012c00
[   36.469044] [<c07be2cc>] (rt_spin_lock) from [<c024e1b0>] (inode_sb_list_add+0x1c/0x50)
[   36.469047]  r5:ead53480 r4:eb486aa0
[   36.469053] [<c024e194>] (inode_sb_list_add) from [<c0250418>] (new_inode+0x20/0x28)
[   36.469056]  r5:ead53480 r4:eb486aa0
[   36.469065] [<c02503f8>] (new_inode) from [<c028f8f4>] (proc_pid_make_inode+0x18/0x100)
[   36.469067]  r5:ead53480 r4:eb441d20
[   36.469076] [<c028f8dc>] (proc_pid_make_inode) from [<c028f9f8>] (proc_pid_instantiate+0x1c/0xc4)
[   36.469079]  r6:eb441d20 r5:ed824020 r4:eb441d20
[   36.469087] [<c028f9dc>] (proc_pid_instantiate) from [<c0290e0c>] (proc_pid_lookup+0xdc/0x144)
[   36.469090]  r5:ed824020 r4:ead53480
[   36.469098] [<c0290d30>] (proc_pid_lookup) from [<c028c590>] (proc_root_lookup+0x1c/0x38)
[   36.469101]  r7:ed8011e0 r6:00000011 r5:eb441d20 r4:ed824020
[   36.469109] [<c028c574>] (proc_root_lookup) from [<c023d6f8>] (lookup_slow+0x90/0x144)
[   36.469112]  r7:ed8011e0 r6:ed8240a0 r5:ed824020 r4:eb441d20
[   36.469119] [<c023d668>] (lookup_slow) from [<c0240900>] (walk_component+0x20c/0x2dc)
[   36.469123]  r10:93fc9c50 r9:efcd3c6d r8:3880961f r7:efcd3c6d r6:00000000 r5:ead79ea8
[   36.469125]  r4:00000003
[   36.469131] [<c02406f4>] (walk_component) from [<c0240c7c>] (link_path_walk+0x2ac/0x4b8)
[   36.469135]  r7:efcd3c6d r6:ead79ea8 r5:ee05a01b r4:c9c5093f
[   36.469141] [<c02409d0>] (link_path_walk) from [<c02412a8>] (path_openat+0x80/0x1004)
[   36.469146]  r10:ead79ea8 r9:ed6f3a00 r8:c0107f44 r7:00000001 r6:ead79f5c r5:ead79f5c
[   36.469148]  r4:ee05a010
[   36.469154] [<c0241228>] (path_openat) from [<c024308c>] (do_filp_open+0x68/0xcc)
[   36.469159]  r10:00000000 r9:ead78000 r8:c0107f44 r7:00000001 r6:ead79f5c r5:ead79ea8
[   36.469161]  r4:00000004
[   36.469167] [<c0243024>] (do_filp_open) from [<c0232064>] (do_sys_open+0x118/0x1c8)
[   36.469171]  r7:00000005 r6:ee05a000 r5:ffffff9c r4:00000004
[   36.469176] [<c0231f4c>] (do_sys_open) from [<c0232134>] (SyS_open+0x20/0x24)
[   36.469181]  r9:ead78000 r8:c0107f44 r7:00000005 r6:bec409a8 r5:0009dd58 r4:00000001
[   36.469188] [<c0232114>] (SyS_open) from [<c0107d60>] (ret_fast_syscall+0x0/0x50)
[   36.469194] Code: e3120002 0a000002 eb18f992 eaffffcb (e7f001f2) 
