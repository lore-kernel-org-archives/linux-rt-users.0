From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [btrfs/rt] lockdep false positive
Date: Sun, 22 Jan 2017 09:46:33 +0100
Message-ID: <1485074793.4467.49.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34991 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdAVIqi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Jan 2017 03:46:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings btrfs/lockdep wizards,

RT trees have trouble with the BTRFS lockdep positive avoidance lock
class dance (see disk-io.c).  Seems the trouble is due to RT not having
a means of telling lockdep that its rwlocks are recursive for read by
the lock owner only, combined with the BTRFS lock class dance assuming
that read_lock() is annotated rwlock_acquire_read(), which RT cannot
do, as that would be a big fat lie.

Creating a rt_read_lock_shared() for btrfs_clear_lock_blocking_rw() did
indeed make lockdep happy as a clam for test purposes.  (hm, submitting
that would be excellent way to replenish frozen shark supply:)

Ideas?

The below is tip-rt, but that's irrelevant.  Any RT tree will do, you
just might hit the recently fixed log_mutex gripe instead of the btrfs
-tree-00/btrfs-csum-00 variants you'll eventually hit with log_mutex
splat fixed.

[  433.956516] =============================================
[  433.956516] [ INFO: possible recursive locking detected ]
[  433.956518] 4.10.0-rt1-tip-rt #36 Tainted: G            E  
[  433.956518] ---------------------------------------------
[  433.956519] kworker/u8:2/555 is trying to acquire lock:
[  433.956519]  (btrfs-csum-00){+.+...}, at: [<ffffffffa037fd14>] btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956540] 
               but task is already holding lock:
[  433.956540]  (btrfs-csum-00){+.+...}, at: [<ffffffffa037fd14>] btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956551] 
               other info that might help us debug this:
[  433.956551]  Possible unsafe locking scenario:

[  433.956552]        CPU0
[  433.956552]        ----
[  433.956552]   lock(btrfs-csum-00);
[  433.956552]   lock(btrfs-csum-00);
[  433.956553] 
                *** DEADLOCK ***

[  433.956553]  May be due to missing lock nesting notation

[  433.956554] 6 locks held by kworker/u8:2/555:
[  433.956554]  #0:  ("%s-%s""btrfs", name){.+.+..}, at: [<ffffffff8109f771>] process_one_work+0x171/0x700
[  433.956565]  #1:  ((&work->normal_work)){+.+...}, at: [<ffffffff8109f771>] process_one_work+0x171/0x700
[  433.956567]  #2:  (sb_internal){.+.+..}, at: [<ffffffffa033d4d7>] start_transaction+0x2a7/0x5a0 [btrfs]
[  433.956576]  #3:  (btrfs-csum-02){+.+...}, at: [<ffffffffa037fd14>] btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956585]  #4:  (btrfs-csum-01){+.+...}, at: [<ffffffffa037fd14>] btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956593]  #5:  (btrfs-csum-00){+.+...}, at: [<ffffffffa037fd14>] btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956601] 

Lock class assignment leadin
 btrfs-transacti-623   [002] .......   406.637399: btrfs_set_buffer_lockdep_class: set &eb->lock: ffff88014a087ce0 level: 0 to btrfs-extent-00
    kworker/u8:5-558   [000] .......   429.673871: btrfs_set_buffer_lockdep_class: set &eb->lock: ffff880007073ce0 level: 2 to btrfs-csum-02
    kworker/u8:5-558   [000] .......   429.673904: btrfs_set_buffer_lockdep_class: set &eb->lock: ffff88014a087ce0 level: 1 to btrfs-csum-01
    kworker/u8:0-5     [002] .......   433.022595: btrfs_set_buffer_lockdep_class: set &eb->lock: ffff88009bd98fe0 level: 0 to btrfs-csum-00 *
    kworker/u8:2-555   [001] .......   433.838082: btrfs_set_buffer_lockdep_class: set &eb->lock: ffff880096e924e0 level: 0 to btrfs-csum-00

Our hero about to go splat
    kworker/u8:2-555   [000] .......   434.043172: btrfs_clear_lock_blocking_rw: read_lock(&eb->lock: ffff880007073ce0)  == btrfs-csum-02
    kworker/u8:2-555   [000] .....11   434.043172: btrfs_clear_lock_blocking_rw: read_lock(&eb->lock: ffff88014a087ce0)  == btrfs-csum-01
    kworker/u8:2-555   [000] .....12   434.043173: btrfs_clear_lock_blocking_rw: read_lock(&eb->lock: ffff88009bd98fe0)  == btrfs-csum-00  set by kworker/u8:0-5
    kworker/u8:2-555   [000] .....13   434.043173: btrfs_clear_lock_blocking_rw: read_lock(&eb->lock: ffff880096e924e0)  == btrfs-csum-00  set by hero - two locks, one key - splat

               stack backtrace:
[  433.956602] CPU: 0 PID: 555 Comm: kworker/u8:2 Tainted: G            E   4.10.0-rt1-tip-rt #36
[  433.956603] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.1-0-g4adadbd-20161202_174313-build11a 04/01/2014
[  433.956611] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[  433.956612] Call Trace:
[  433.956618]  dump_stack+0x85/0xc8
[  433.956622]  __lock_acquire+0x9f9/0x1550
[  433.956627]  ? ring_buffer_lock_reserve+0x115/0x3b0
[  433.956629]  ? ring_buffer_unlock_commit+0x27/0xe0
[  433.956630]  lock_acquire+0xbd/0x250
[  433.956637]  ? btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956641]  rt_read_lock+0x47/0x60
[  433.956648]  ? btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956654]  btrfs_clear_lock_blocking_rw+0x74/0x130 [btrfs]
[  433.956660]  btrfs_clear_path_blocking+0x99/0xc0 [btrfs]
[  433.956667]  btrfs_next_old_leaf+0x407/0x440 [btrfs]
[  433.956674]  btrfs_next_leaf+0x10/0x20 [btrfs]
[  433.956681]  btrfs_csum_file_blocks+0x31a/0x5f0 [btrfs]
[  433.956682]  ? migrate_enable+0x87/0x160
[  433.956690]  add_pending_csums.isra.46+0x4d/0x70 [btrfs]
[  433.956698]  btrfs_finish_ordered_io+0x30f/0x710 [btrfs]
[  433.956705]  finish_ordered_fn+0x15/0x20 [btrfs]
[  433.956714]  normal_work_helper+0x104/0x620 [btrfs]
[  433.956722]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
[  433.956723]  process_one_work+0x1f0/0x700
[  433.956723]  ? process_one_work+0x171/0x700
[  433.956725]  worker_thread+0x171/0x530
[  433.956726]  kthread+0x10c/0x140
[  433.956727]  ? create_worker+0x1b0/0x1b0
[  433.956728]  ? kthread_park+0x90/0x90
[  433.956729]  ret_from_fork+0x31/0x40
