From: Mike Galbraith <bitbucket@online.de>
Subject: 3.[68]-rt: CONFIG_PROVE_LOCKING + CONFIG_DEBUG_FORCE_WEAK_PER_CPU =
 boot time swap_lock deadlock
Date: Sun, 14 Apr 2013 13:07:32 +0200
Message-ID: <1365937652.4717.25.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52598 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3DNLHt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 07:07:49 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

Turn off CONFIG_DEBUG_FORCE_WEAK_PER_CPU, all is well, with it enabled,
I get a boot time deadlock on swap_lock when the box tries to load
initramfs, seemingly because with CONFIG_DEBUG_FORCE_WEAK_PER_CPU,
percpu locallocks are not zeroed, so only initializing the spinlock
isn't enough.  With lockdep enabled, I see warning on owner and nestcnt,
followed by init being permanently stuck.

Do the below, it'll boot and run, but lockdep will eventually gripe
about MAX_LOCKDEP_ENTRIES, MAX_STACK_TRACE_ENTRIES, or adding a
non-static key, and box explodes violently shortly thereafter on
softlock or memory corruption.. so below wasn't exactly a great idea :)

3.4-rt boots and runs just fine with the same config.  Turn off
CONFIG_DEBUG_FORCE_WEAK_PER_CPU, and these kernels boot and run fine
with lockdep, though I do still need to double entries/bits for it to
not shut itself off.  Anyway, seems CONFIG_DEBUG_FORCE_WEAK_PER_CPU
became a very bad idea.  Probably always was, no idea how that ended up
in my config.

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index a5eea5d..7820eec 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -23,7 +23,10 @@ struct local_irq_lock {
 
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
 	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
-		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
+		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock)		\
+		, .owner = NULL						\
+		, .nestcnt = 0						\
+		, .flags = 0 }
 
 #define DECLARE_LOCAL_IRQ_LOCK(lvar)					\
 	DECLARE_PER_CPU(struct local_irq_lock, lvar)
@@ -31,8 +34,12 @@ struct local_irq_lock {
 #define local_irq_lock_init(lvar)					\
 	do {								\
 		int __cpu;						\
-		for_each_possible_cpu(__cpu)				\
+		for_each_possible_cpu(__cpu) {				\
 			spin_lock_init(&per_cpu(lvar, __cpu).lock);	\
+			per_cpu(lvar, __cpu).owner = NULL;		\
+			per_cpu(lvar, __cpu).nestcnt = 0;		\
+			per_cpu(lvar, __cpu).flags = 0;			\
+		}							\
 	} while (0)
 
 static inline void __local_lock(struct local_irq_lock *lv)

Virgin 3.6-rt source warnings etc.  Oops, almost virgin, virgin except
for build bug fix stolen from 3.8-rt.

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: gpu/i915: don't open code these things

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_gem.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -90,7 +90,6 @@ i915_gem_wait_for_error(struct drm_devic
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	struct completion *x = &dev_priv->error_completion;
-	unsigned long flags;
 	int ret;
 
 	if (!atomic_read(&dev_priv->mm.wedged))
@@ -115,9 +114,7 @@ i915_gem_wait_for_error(struct drm_devic
 		 * end up waiting upon a subsequent completion event that
 		 * will never happen.
 		 */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		x->done++;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		complete(x);
 	}
 	return 0;
 }
@@ -1884,12 +1881,9 @@ i915_gem_check_wedge(struct drm_i915_pri
 	if (atomic_read(&dev_priv->mm.wedged)) {
 		struct completion *x = &dev_priv->error_completion;
 		bool recovery_complete;
-		unsigned long flags;
 
 		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		recovery_complete = x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		recovery_complete = completion_done(x);
 
 		/* Non-interruptible callers can't handle -EAGAIN, hence return
 		 * -EIO unconditionally for these. */

Now boot gripage:


[    2.297315] Unpacking initramfs...
[    2.301645] ------------[ cut here ]------------
[    2.306264] WARNING: at include/linux/locallock.h:42 __lru_cache_add+0x1e2/0x210()
[    2.313824] Hardware name: MS-7502
[    2.317223] Modules linked in:
[    2.320291] Pid: 1, comm: swapper/0 Not tainted 3.6.11.1-rt32-smp #33
[    2.326724] Call Trace:
[    2.329171]  [<ffffffff8103bc6f>] warn_slowpath_common+0x7f/0xc0
[    2.329174]  [<ffffffff8103bcca>] warn_slowpath_null+0x1a/0x20
[    2.329177]  [<ffffffff81112622>] __lru_cache_add+0x1e2/0x210
[    2.329179]  [<ffffffff81104895>] add_to_page_cache_lru+0x35/0x50
[    2.329181]  [<ffffffff81104ac5>] grab_cache_page_write_begin+0x95/0xf0
[    2.329185]  [<ffffffff81182018>] simple_write_begin+0x38/0x100
[    2.329187]  [<ffffffff81104376>] generic_perform_write+0xc6/0x200
[    2.329189]  [<ffffffff8110450d>] generic_file_buffered_write+0x5d/0x90
[    2.329191]  [<ffffffff81105f31>] __generic_file_aio_write+0x1c1/0x3c0
[    2.329194]  [<ffffffff811061af>] generic_file_aio_write+0x7f/0x100
[    2.329197]  [<ffffffff81159f03>] do_sync_write+0xa3/0xe0
[    2.329200]  [<ffffffff8115a782>] vfs_write+0xb2/0x160
[    2.329201]  [<ffffffff8115aa6d>] sys_write+0x4d/0x90
[    2.329205]  [<ffffffff818e7cae>] ? do_name.part.5+0xc9/0x229
[    2.329208]  [<ffffffff819062cd>] ? bunzip2+0x192/0x192
[    2.329210]  [<ffffffff818e7b82>] do_copy+0x73/0x8e
[    2.329212]  [<ffffffff818e734f>] flush_buffer+0x82/0xb2
[    2.329213]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.329215]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.329217]  [<ffffffff81906554>] gunzip+0x27e/0x326
[    2.329219]  [<ffffffff818e761e>] unpack_to_rootfs+0x160/0x293
[    2.329221]  [<ffffffff818e729a>] ? initrd_load+0x3f/0x3f
[    2.329223]  [<ffffffff818e7fb7>] ? do_header+0x6c/0x6c
[    2.329225]  [<ffffffff818e8009>] populate_rootfs+0x52/0x71
[    2.329228]  [<ffffffff810001bf>] do_one_initcall+0x3f/0x170
[    2.329230]  [<ffffffff818e6c30>] do_basic_setup+0x91/0xaf
[    2.329232]  [<ffffffff818e6674>] ? do_early_param+0x87/0x87
[    2.329234]  [<ffffffff818e6ccf>] kernel_init+0x81/0xf2
[    2.329237]  [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[    2.329241]  [<ffffffff81071953>] ? finish_task_switch+0x83/0x100
[    2.329243]  [<ffffffff814403d9>] ? sub_preempt_count+0x29/0x60
[    2.329245]  [<ffffffff8143cc5d>] ? retint_restore_args+0xe/0xe
[    2.329247]  [<ffffffff818e6c4e>] ? do_basic_setup+0xaf/0xaf
[    2.329249]  [<ffffffff81445420>] ? gs_change+0xb/0xb
[    2.329250] ---[ end trace 0000000000000001 ]---
[    2.525143] ------------[ cut here ]------------
[    2.529756] WARNING: at include/linux/locallock.h:43 __lru_cache_add+0x1f8/0x210()
[    2.537316] Hardware name: MS-7502
[    2.540713] Modules linked in:
[    2.543783] Pid: 1, comm: swapper/0 Tainted: G        W    3.6.11.1-rt32-smp #33
[    2.551168] Call Trace:
[    2.553616]  [<ffffffff8103bc6f>] warn_slowpath_common+0x7f/0xc0
[    2.553619]  [<ffffffff8103bcca>] warn_slowpath_null+0x1a/0x20
[    2.553621]  [<ffffffff81112638>] __lru_cache_add+0x1f8/0x210
[    2.553623]  [<ffffffff81104895>] add_to_page_cache_lru+0x35/0x50
[    2.553625]  [<ffffffff81104ac5>] grab_cache_page_write_begin+0x95/0xf0
[    2.553628]  [<ffffffff81182018>] simple_write_begin+0x38/0x100
[    2.553629]  [<ffffffff81104376>] generic_perform_write+0xc6/0x200
[    2.553632]  [<ffffffff8110450d>] generic_file_buffered_write+0x5d/0x90
[    2.553634]  [<ffffffff81105f31>] __generic_file_aio_write+0x1c1/0x3c0
[    2.553637]  [<ffffffff811061af>] generic_file_aio_write+0x7f/0x100
[    2.553639]  [<ffffffff81159f03>] do_sync_write+0xa3/0xe0
[    2.553642]  [<ffffffff8115a782>] vfs_write+0xb2/0x160
[    2.553644]  [<ffffffff8115aa6d>] sys_write+0x4d/0x90
[    2.553646]  [<ffffffff818e7cae>] ? do_name.part.5+0xc9/0x229
[    2.553648]  [<ffffffff819062cd>] ? bunzip2+0x192/0x192
[    2.553650]  [<ffffffff818e7b82>] do_copy+0x73/0x8e
[    2.553652]  [<ffffffff818e734f>] flush_buffer+0x82/0xb2
[    2.553653]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.553655]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.553657]  [<ffffffff81906554>] gunzip+0x27e/0x326
[    2.553659]  [<ffffffff818e761e>] unpack_to_rootfs+0x160/0x293
[    2.553661]  [<ffffffff818e729a>] ? initrd_load+0x3f/0x3f
[    2.553663]  [<ffffffff818e7fb7>] ? do_header+0x6c/0x6c
[    2.553665]  [<ffffffff818e8009>] populate_rootfs+0x52/0x71
[    2.553667]  [<ffffffff810001bf>] do_one_initcall+0x3f/0x170
[    2.553669]  [<ffffffff818e6c30>] do_basic_setup+0x91/0xaf
[    2.553671]  [<ffffffff818e6674>] ? do_early_param+0x87/0x87
[    2.553673]  [<ffffffff818e6ccf>] kernel_init+0x81/0xf2
[    2.553675]  [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[    2.553677]  [<ffffffff81071953>] ? finish_task_switch+0x83/0x100
[    2.553679]  [<ffffffff814403d9>] ? sub_preempt_count+0x29/0x60
[    2.553681]  [<ffffffff8143cc5d>] ? retint_restore_args+0xe/0xe
[    2.553683]  [<ffffffff818e6c4e>] ? do_basic_setup+0xaf/0xaf
[    2.553685]  [<ffffffff81445420>] ? gs_change+0xb/0xb
[  [    2.749961] 
[    2.749961] ======================================================
[    2.749962] [ INFO: possible circular locking dependency detected ]
[    2.749963] 3.6.11.1-rt32-smp #33 Tainted: G        W   
[    2.749964] -------------------------------------------------------
[    2.749965] swapper/0/1 is trying to acquire lock:
[    2.749970]  (sb_writers#2){.+.+.+}, at: [<ffffffff81106193>] generic_file_aio_write+0x63/0x100
[    2.749970] 
[    2.749970] but task is already holding lock:
[    2.749974]  (&per_cpu(swap_lock, __cpu).lock){+.+.+.}, at: [<ffffffff811124a8>] __lru_cache_add+0x68/0x210
[    2.749975] 
[    2.749975] which lock already depends on the new lock.
[    2.749975] 
[    2.749975] 
[    2.749975] the existing dependency chain (in reverse order) is:
[    2.749978] 
[    2.749978] -> #1 (&per_cpu(swap_lock, __cpu).lock){+.+.+.}:
[    2.749981]        [<ffffffff8109a95a>] check_prevs_add+0xda/0x140
[    2.749983]        [<ffffffff8109af40>] validate_chain.isra.37+0x580/0x700
[    2.749985]        [<ffffffff8109b8b8>] __lock_acquire+0x378/0x9a0
[    2.749988]        [<ffffffff8109c02a>] lock_release_non_nested+0x14a/0x310
[    2.749989]        [<ffffffff8109c21a>] lock_release_nested+0x2a/0xa0
[    2.749991]        [<ffffffff8109c33d>] __lock_release+0xad/0xd0
[    2.749993]        [<ffffffff8109c3ba>] lock_release+0x5a/0x120
[    2.749996]        [<ffffffff8143bfb3>] _mutex_unlock+0x23/0x40
[    2.749998]        [<ffffffff811061ba>] generic_file_aio_write+0x8a/0x100
[    2.750000]        [<ffffffff81159f03>] do_sync_write+0xa3/0xe0
[    2.750002]        [<ffffffff8115a782>] vfs_write+0xb2/0x160
[    2.750004]        [<ffffffff8115aa6d>] sys_write+0x4d/0x90
[    2.750005]        [<ffffffff818e7b82>] do_copy+0x73/0x8e
[    2.750005]        [<ffffffff818e734f>] flush_buffer+0x82/0xb2
[    2.750005]        [<ffffffff81906554>] gunzip+0x27e/0x326
[    2.750005]        [<ffffffff818e761e>] unpack_to_rootfs+0x160/0x293
[    2.750005]        [<ffffffff818e8009>] populate_rootfs+0x52/0x71
[    2.750005]        [<ffffffff810001bf>] do_one_initcall+0x3f/0x170
[    2.750005]        [<ffffffff818e6c30>] do_basic_setup+0x91/0xaf
[    2.750005]        [<ffffffff818e6ccf>] kernel_init+0x81/0xf2
[    2.750005]        [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[    2.750005] 
[    2.750005] -> #0 (sb_writers#2){.+.+.+}:
[    2.750005]        [<ffffffff8109a878>] check_prev_add+0x6b8/0x6c0
[    2.750005]        [<ffffffff8109a95a>] check_prevs_add+0xda/0x140
[    2.750005]        [<ffffffff8109af40>] validate_chain.isra.37+0x580/0x700
[    2.750005]        [<ffffffff8109b8b8>] __lock_acquire+0x378/0x9a0
[    2.750005]        [<ffffffff8109c505>] lock_acquire+0x85/0x150
[    2.750005]        [<ffffffff8115c61c>] __sb_start_write+0xbc/0x1a0
[    2.750005]        [<ffffffff81106193>] generic_file_aio_write+0x63/0x100
[    2.750005]        [<ffffffff81159f03>] do_sync_write+0xa3/0xe0
[    2.750005]        [<ffffffff8115a782>] vfs_write+0xb2/0x160
[    2.750005]        [<ffffffff8115aa6d>] sys_write+0x4d/0x90
[    2.750005]        [<ffffffff818e7b82>] do_copy+0x73/0x8e
[    2.750005]        [<ffffffff818e734f>] flush_buffer+0x82/0xb2
[    2.750005]        [<ffffffff81906554>] gunzip+0x27e/0x326
[    2.750005]        [<ffffffff818e761e>] unpack_to_rootfs+0x160/0x293
[    2.750005]        [<ffffffff818e8009>] populate_rootfs+0x52/0x71
[    2.750005]        [<ffffffff810001bf>] do_one_initcall+0x3f/0x170
[    2.750005]        [<ffffffff818e6c30>] do_basic_setup+0x91/0xaf
[    2.750005]        [<ffffffff818e6ccf>] kernel_init+0x81/0xf2
[    2.750005]        [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[    2.750005] 
[    2.750005] other info that might help us debug this:
[    2.750005] 
[    2.750005]  Possible unsafe locking scenario:
[    2.750005] 
[    2.750005]        CPU0                    CPU1
[    2.750005]        ----                    ----
[    2.750005]   lock(&per_cpu(swap_lock, __cpu).lock);
[    2.750005]                                lock(sb_writers#2);
[    2.750005]                                lock(&per_cpu(swap_lock, __cpu).lock);
[    2.750005]   lock(sb_writers#2);
[    2.750005] 
[    2.750005]  *** DEADLOCK ***
[    2.750005] 
[    2.750005] 1 lock held by swapper/0/1:
[    2.750005]  #0:  (&per_cpu(swap_lock, __cpu).lock){+.+.+.}, at: [<ffffffff811124a8>] __lru_cache_add+0x68/0x210
[    2.750005] 
[    2.750005] stack backtrace:
[    2.750005] Pid: 1, comm: swapper/0 Tainted: G        W    3.6.11.1-rt32-smp #33
[    2.750005] Call Trace:
[    2.750005]  [<ffffffff8142d1b0>] print_circular_bug+0xd3/0xe4
[    2.750005]  [<ffffffff8109a878>] check_prev_add+0x6b8/0x6c0
[    2.750005]  [<ffffffff8109a95a>] check_prevs_add+0xda/0x140
[    2.750005]  [<ffffffff8109af40>] validate_chain.isra.37+0x580/0x700
[    2.750005]  [<ffffffff8109b8b8>] __lock_acquire+0x378/0x9a0
[    2.750005]  [<ffffffff8109b8b8>] ? __lock_acquire+0x378/0x9a0
[    2.750005]  [<ffffffff811124a8>] ? __lru_cache_add+0x68/0x210
[    2.750005]  [<ffffffff81106193>] ? generic_file_aio_write+0x63/0x100
[    2.750005]  [<ffffffff8109c505>] lock_acquire+0x85/0x150
[    2.750005]  [<ffffffff81106193>] ? generic_file_aio_write+0x63/0x100
[    2.750005]  [<ffffffff8115c61c>] __sb_start_write+0xbc/0x1a0
[    2.750005]  [<ffffffff81106193>] ? generic_file_aio_write+0x63/0x100
[    2.750005]  [<ffffffff8109b8b8>] ? __lock_acquire+0x378/0x9a0
[    2.750005]  [<ffffffff81106193>] ? generic_file_aio_write+0x63/0x100
[    2.750005]  [<ffffffff81106193>] generic_file_aio_write+0x63/0x100
[    2.750005]  [<ffffffff8119ce8a>] ? fsnotify+0x8a/0x300
[    2.750005]  [<ffffffff81159f03>] do_sync_write+0xa3/0xe0
[    2.750005]  [<ffffffff8115a782>] vfs_write+0xb2/0x160
[    2.750005]  [<ffffffff8115aa6d>] sys_write+0x4d/0x90
[    2.750005]  [<ffffffff818e7cae>] ? do_name.part.5+0xc9/0x229
[    2.750005]  [<ffffffff819062cd>] ? bunzip2+0x192/0x192
[    2.750005]  [<ffffffff818e7b82>] do_copy+0x73/0x8e
[    2.750005]  [<ffffffff818e734f>] flush_buffer+0x82/0xb2
[    2.750005]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.750005]  [<ffffffff818e72cd>] ? eat+0x1c/0x1c
[    2.750005]  [<ffffffff81906554>] gunzip+0x27e/0x326
[    2.750005]  [<ffffffff818e761e>] unpack_to_rootfs+0x160/0x293
[    2.750005]  [<ffffffff818e729a>] ? initrd_load+0x3f/0x3f
[    2.750005]  [<ffffffff818e7fb7>] ? do_header+0x6c/0x6c
[    2.750005]  [<ffffffff818e8009>] populate_rootfs+0x52/0x71
[    2.750005]  [<ffffffff810001bf>] do_one_initcall+0x3f/0x170
[    2.750005]  [<ffffffff818e6c30>] do_basic_setup+0x91/0xaf
[    2.750005]  [<ffffffff818e6674>] ? do_early_param+0x87/0x87
[    2.750005]  [<ffffffff818e6ccf>] kernel_init+0x81/0xf2
[    2.750005]  [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[    2.750005]  [<ffffffff81071953>] ? finish_task_switch+0x83/0x100
[    2.750005]  [<ffffffff814403d9>] ? sub_preempt_count+0x29/0x60
[    2.750005]  [<ffffffff8143cc5d>] ? retint_restore_args+0xe/0xe
[    2.750005]  [<ffffffff818e6c4e>] ? do_basic_setup+0xaf/0xaf
[    2.750005]  [<ffffffff81445420>] ? gs_change+0xb/0xb
[    3.187860] Freeing initrd memory: 20672k freed
[    3.832126] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.838573] software IO TLB [mem 0xcbe8a000-0xcfe89fff] (64MB) mapped at [ffff8800cbe8a000-ffff8800cfe89fff]
[    3.850672] audit: initializing netlink socket (disabled)
[    3.856093] type=2000 audit(1365836763.854:1): initialized
[    3.875797] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.883162] msgmni has been set to 15468
[    3.888154] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    3.895545] io scheduler noop registered
[    3.899467] io scheduler deadline registered
[    3.903784] io scheduler cfq registered (default)
[    3.908485] start plist test
[    3.912423] end plist test
[    3.915585] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    3.921292] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[    3.927463] vesafb: scrolling: redraw
[    3.931121] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    3.938528] vesafb: framebuffer at 0xf9000000, mapped to 0xffffc90012200000, using 5120k, total 14336k
[    3.968296] Console: switching to colour frame buffer device 160x64
[    3.993748] fb0: VESA VGA frame buffer device
[    3.998296] vga16fb: initializing
[    4.001684] vga16fb: mapped to 0xffff8800000a0000
[    4.006491] checking generic (f9000000 e00000) vs hw (a0000 10000)
[    4.012969] fb1: VGA16 VGA frame buffer device
[    4.017532] intel_idle: does not run on family 6 model 15
[    4.023130] GHES: HEST is not enabled!
[    4.088162] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.115368] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.142280] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    4.170142] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.197109] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    4.203581] Non-volatile memory driver v1.3
[    4.207938] Linux agpgart interface v0.103
[    4.213504] tun: Universal TUN/TAP device driver, 1.6
[    4.218666] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.225204] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.232136] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    4.243340] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.248738] mousedev: PS/2 mouse device common for all mice
[    4.254697] cpuidle: using governor ladder
[    4.258884] cpuidle: using governor menu
[    4.263048] NET: Registered protocol family 26
[    4.267642] IPv4 over IPv4 tunneling driver
[    4.272302] TCP: cubic registered
[    4.275690] NET: Registered protocol family 17
[    4.279162] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    4.289180] Key type dns_resolver registered
[    4.294549] registered taskstats version 1
[    4.299488] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    4.307975] Freeing unused kernel memory: 796k freed
[    4.313422] Write protecting the kernel read-only data: 8192k
[    4.325427] Freeing unused kernel memory: 1752k freed
[    4.331480] Freeing unused kernel memory: 4k freed
[    4.850075] tsc: Refined TSC clocksource calibration: 2392.503 MHz
[    4.862184] Switching to clocksource tsc
[  243.874055] INFO: task init:58 blocked for more than 120 seconds.
[  243.886115] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.899886] init            D ffff88022130c000     0    58      1 0x00000000
[  243.912892]  ffff88022130fb58 0000000000000046 0000000000000000 ffff88022130ffd8
[  243.912894]  ffff8801b1006400 ffff88022130ffd8 ffff88022130ffd8 ffff88022130ffd8
[  243.912896]  ffffffff8181b420 ffff88022130c000 0000000000000246 ffff8801b1006400
[  243.952822] Call Trace:
[  243.961074]  [<ffffffff8143a759>] schedule+0x29/0x70
[  243.961076]  [<ffffffff8143b3a5>] rt_spin_lock_slowlock+0xf5/0x340
[  243.961079]  [<ffffffff8143b41c>] ? rt_spin_lock_slowlock+0x16c/0x340
[  243.961082]  [<ffffffff8143be16>] rt_spin_lock+0x16/0x40
[  243.961084]  [<ffffffff810761e3>] ? migrate_disable+0xc3/0x130
[  243.961088]  [<ffffffff811124a8>] __lru_cache_add+0x68/0x210
[  243.961090]  [<ffffffff81112f04>] lru_cache_add_lru+0x24/0x50
[  243.961092]  [<ffffffff8113720d>] page_add_new_anon_rmap+0x7d/0x90
[  243.961095]  [<ffffffff8112c2ac>] do_wp_page+0x21c/0x6b0
[  243.961097]  [<ffffffff8112e17b>] handle_pte_fault+0x19b/0x1d0
[  243.961099]  [<ffffffff81440369>] ? sub_preempt_count.part.79+0x69/0xb0
[  243.961101]  [<ffffffff8112e434>] handle_mm_fault+0x124/0x1d0
[  243.961104]  [<ffffffff810a3999>] ? rt_down_read_trylock+0x69/0x90
[  243.961105]  [<ffffffff8143fdec>] ? do_page_fault+0x1dc/0x580
[  243.961107]  [<ffffffff8143fe3e>] do_page_fault+0x22e/0x580
[  243.961110]  [<ffffffff8143b668>] ? rt_mutex_unlock+0x78/0x90
[  243.961112]  [<ffffffff8143d0a3>] ? error_sti+0x5/0x6
[  243.961114]  [<ffffffff81097db8>] ? trace_hardirqs_off_caller+0x28/0xc0
[  243.961117]  [<ffffffff81222065>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  243.961119]  [<ffffffff8143ceaf>] page_fault+0x1f/0x30
[  243.961120] INFO: lockdep is turned off.
[  244.200572] sending NMI to all CPUs:
[  244.170620] NMI backtrace for cpu 2
[  244.170620] CPU 2 
[  244.170620] Pid: 0, comm: swapper/2 Tainted: G        W    3.6.11.1-rt32-smp #33 MEDIONPC MS-7502/MS-7502
[  244.170620] RIP: 0010:[<ffffffff8100b76e>]  [<ffffffff8100b76e>] mwait_idle.part.9+0x2fe/0x340
[  244.170620] RSP: 0000:ffff880226d7dec8  EFLAGS: 00000246
[  244.170620] RAX: 0000000000000000 RBX: ffff880226d7dfd8 RCX: 0000000000000000
[  244.170620] RDX: 0000000000000000 RSI: ffffffff8100b765 RDI: ffffffff8109d0dd
[  244.170620] RBP: ffff880226d7dee8 R08: 0000000000000000 R09: 0000000000000001
[  244.170620] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff818b7570
[  244.170620] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
[  244.170620] FS:  0000000000000000(0000) GS:ffff88022f900000(0000) knlGS:0000000000000000
[  244.170620] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  244.170620] CR2: 0000000000000000 CR3: 0000000001813000 CR4: 00000000000007e0
[  244.170620] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  244.170620] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  244.170620] Process swapper/2 (pid: 0, threadinfo ffff880226d7c000, task ffff880226d7a000)
[  244.170620] Stack:
[  244.170620]  ffff880226d7dfd8 ffffffff818b7570 ffff880226d7dfd8 0000000000000000
[  244.170620]  ffff880226d7def8 ffffffff8100b7f1 ffff880226d7df28 ffffffff8100c116
[  244.170620]  0000000000000000 000000000000b000 0000000000000000 0000000000000000
[  244.170620] Call Trace:
[  244.170620]  [<ffffffff8100b7f1>] mwait_idle+0x41/0x50
[  244.170620]  [<ffffffff8100c116>] cpu_idle+0x106/0x130
[  244.170620]  [<ffffffff81423339>] start_secondary+0x78/0x7d
[  244.170620] Code: 75 45 e8 86 c2 0b 00 e9 a9 fd ff ff 90 48 8b 86 38 e0 ff ff f6 c4 02 0f 85 85 fd ff ff e8 6b 19 09 00 31 c0 48 89 c1 fb 0f 01 c9 <e9> 78 fd ff ff e8 28 ef 42 00 e9 15 fe ff ff 0f 1f 00 e8 1b ef 
[  244.209566] NMI backtrace for cpu 3
[  244.209569] CPU 3 
[  244.209569] Pid: 39, comm: khungtaskd Tainted: G        W    3.6.11.1-rt32-smp #33 MEDIONPC MS-7502/MS-7502
[  244.209572] RIP: 0010:[<ffffffff81440476>]  [<ffffffff81440476>] add_preempt_count.part.80+0x66/0xb0
[  244.209573] RSP: 0018:ffff8802216efd60  EFLAGS: 00000286
[  244.209574] RAX: ffffffff81220b83 RBX: 0000000000000001 RCX: 0000000000000000
[  244.209575] RDX: ffff8802216ec000 RSI: ffffffff8102a150 RDI: ffffffff81220b83
[  244.209576] RBP: ffff8802216efd70 R08: 0000000000000000 R09: 0000000000000000
[  244.209577] R10: 00000000000002c6 R11: 0000000000000000 R12: ffff88022130c000
[  244.209578] R13: 00000000002481ba R14: 00000000000003ce R15: ffff88022130c218
[  244.209579] FS:  0000000000000000(0000) GS:ffff88022f980000(0000) knlGS:0000000000000000
[  244.209581] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  244.209582] CR2: 0000000000000000 CR3: 0000000001813000 CR4: 00000000000007e0
[  244.209583] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  244.209584] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  244.209585] Process khungtaskd (pid: 39, threadinfo ffff8802216ee000, task ffff8802216ec000)
[  244.209585] Stack:
[  244.209587]  00000000000003ce 0000000000002710 ffff8802216efd80 ffffffff814404ef
[  244.209589]  ffff8802216efdc0 ffffffff81220b83 ffff8802216efda0 0000000000002710
[  244.209591]  ffff88022130c000 00000000003fffcf 00000000000003ce ffff88022130c218
[  244.209592] Call Trace:
[  244.209594]  [<ffffffff814404ef>] add_preempt_count+0x2f/0x60
[  244.209597]  [<ffffffff81220b83>] delay_tsc+0x23/0x100
[  244.209599]  [<ffffffff81220af8>] __const_udelay+0x28/0x30
[  244.209602]  [<ffffffff810261ca>] arch_trigger_all_cpu_backtrace+0x6a/0x90
[  244.209604]  [<ffffffff810be1b1>] check_hung_task+0xb1/0xc0
[  244.209606]  [<ffffffff810be390>] check_hung_uninterruptible_tasks+0x1d0/0x210
[  244.209608]  [<ffffffff810be210>] ? check_hung_uninterruptible_tasks+0x50/0x210
[  244.209610]  [<ffffffff810be3d0>] ? check_hung_uninterruptible_tasks+0x210/0x210
[  244.209612]  [<ffffffff810be41f>] watchdog+0x4f/0x60
[  244.209614]  [<ffffffff8106403c>] kthread+0x8c/0xa0
[  244.209617]  [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[  244.209620]  [<ffffffff81071953>] ? finish_task_switch+0x83/0x100
[  244.209622]  [<ffffffff814403d9>] ? sub_preempt_count+0x29/0x60
[  244.209623]  [<ffffffff8143cc5d>] ? retint_restore_args+0xe/0xe
[  244.209625]  [<ffffffff81063fb0>] ? __init_kthread_worker+0xa0/0xa0
[  244.209627]  [<ffffffff81445420>] ? gs_change+0xb/0xb
[  244.209646] Code: 3b 98 44 e0 ff ff 74 0d 48 83 c4 08 5b 5d c3 66 0f 1f 44 00 00 48 8b 45 00 48 8b 78 08 e8 63 4e c3 ff 65 48 8b 14 25 40 9b 00 00 <48> 89 82 e8 1f 00 00 48 89 c6 48 8b 7d 08 e8 67 34 ca ff 48 83 
[  244.143474] NMI backtrace for cpu 1
[  244.143474] CPU 1 
[  244.143474] Pid: 0, comm: swapper/1 Tainted: G        W    3.6.11.1-rt32-smp #33 MEDIONPC MS-7502/MS-7502
[  244.143474] RIP: 0010:[<ffffffff8100b76e>]  [<ffffffff8100b76e>] mwait_idle.part.9+0x2fe/0x340
[  244.143474] RSP: 0000:ffff880226d77ec8  EFLAGS: 00000246
[  244.143474] RAX: 0000000000000000 RBX: ffff880226d77fd8 RCX: 0000000000000000
[  244.143474] RDX: 0000000000000000 RSI: ffffffff8100b765 RDI: ffffffff8109d0dd
[  244.143474] RBP: ffff880226d77ee8 R08: 0000000000000000 R09: 0000000000000001
[  244.143474] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff818b7570
[  244.143474] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[  244.143474] FS:  0000000000000000(0000) GS:ffff88022f880000(0000) knlGS:0000000000000000
[  244.143474] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  244.143474] CR2: 0000000000000000 CR3: 0000000001813000 CR4: 00000000000007e0
[  244.143474] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  244.143474] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  244.143474] Process swapper/1 (pid: 0, threadinfo ffff880226d76000, task ffff880226d74000)
[  244.143474] Stack:
[  244.143474]  ffff880226d77fd8 ffffffff818b7570 ffff880226d77fd8 0000000000000000
[  244.143474]  ffff880226d77ef8 ffffffff8100b7f1 ffff880226d77f28 ffffffff8100c116
[  244.143474]  0000000000000000 000000000000b000 0000000000000000 0000000000000000
[  244.143474] Call Trace:
[  244.143474]  [<ffffffff8100b7f1>] mwait_idle+0x41/0x50
[  244.143474]  [<ffffffff8100c116>] cpu_idle+0x106/0x130
[  244.143474]  [<ffffffff81423339>] start_secondary+0x78/0x7d
[  244.143474] Code: 75 45 e8 86 c2 0b 00 e9 a9 fd ff ff 90 48 8b 86 38 e0 ff ff f6 c4 02 0f 85 85 fd ff ff e8 6b 19 09 00 31 c0 48 89 c1 fb 0f 01 c9 <e9> 78 fd ff ff e8 28 ef 42 00 e9 15 fe ff ff 0f 1f 00 e8 1b ef 
[  244.207384] NMI backtrace for cpu 0
[  244.207384] CPU 0 
[  244.207384] Pid: 0, comm: swapper/0 Tainted: G        W    3.6.11.1-rt32-smp #33 MEDIONPC MS-7502/MS-7502
[  244.207384] RIP: 0010:[<ffffffff8100b76e>]  [<ffffffff8100b76e>] mwait_idle.part.9+0x2fe/0x340
[  244.207384] RSP: 0000:ffffffff81801eb8  EFLAGS: 00000246
[  244.207384] RAX: 0000000000000000 RBX: ffffffff81801fd8 RCX: 0000000000000000
[  244.207384] RDX: 0000000000000000 RSI: ffffffff8100b765 RDI: ffffffff8109d0dd
[  244.207384] RBP: ffffffff81801ed8 R08: 0000000000000000 R09: 0000000000000001
[  244.207384] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff818b7570
[  244.207384] R13: 0000000000000000 R14: ffff88022fde8480 R15: 0000000000000000
[  244.207384] FS:  0000000000000000(0000) GS:ffff88022f800000(0000) knlGS:0000000000000000
[  244.207384] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  244.207384] CR2: 00007f9a75b23a00 CR3: 0000000221310000 CR4: 00000000000007f0
[  244.207384] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  244.207384] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  244.207384] Process swapper/0 (pid: 0, threadinfo ffffffff81800000, task ffffffff8181b420)
[  244.207384] Stack:
[  244.207384]  ffffffff81801fd8 ffffffff818b7570 ffffffff81801fd8 ffff88022fde8480
[  244.207384]  ffffffff81801ee8 ffffffff8100b7f1 ffffffff81801f18 ffffffff8100c116
[  244.207384]  ffffffff8143ac32 0000000000000002 6db6db6db6db6db7 ffffffff81924ae0
[  244.207384] Call Trace:
[  244.207384]  [<ffffffff8100b7f1>] mwait_idle+0x41/0x50
[  244.207384]  [<ffffffff8100c116>] cpu_idle+0x106/0x130
[  244.207384]  [<ffffffff8143ac32>] ? schedule_preempt_disabled+0x22/0x30
[  244.207384]  [<ffffffff81412bbd>] rest_init+0xc1/0xd4
[  244.207384]  [<ffffffff81412afc>] ? csum_partial_copy_generic+0x16c/0x16c
[  244.207384]  [<ffffffff818e6b92>] start_kernel+0x356/0x363
[  244.207384]  [<ffffffff818e66ce>] ? repair_env_string+0x5a/0x5a
[  244.207384]  [<ffffffff818e632d>] x86_64_start_reservations+0x131/0x135
[  244.207384]  [<ffffffff818e6421>] x86_64_start_kernel+0xf0/0xf7
[  244.207384] Code: 75 45 e8 86 c2 0b 00 e9 a9 fd ff ff 90 48 8b 86 38 e0 ff ff f6 c4 02 0f 85 85 fd ff ff e8 6b 19 09 00 31 c0 48 89 c1 fb 0f 01 c9 <e9> 78 fd ff ff e8 28 ef 42 00 e9 15 fe ff ff 0f 1f 00 e8 1b ef 
[  244.210648] Kernel panic - not syncing: hung_task: blocked tasks
[  244.210650] Pid: 39, comm: khungtaskd Tainted: G        W    3.6.11.1-rt32-smp #33
[  244.210651] Call Trace:
[  244.210654]  [<ffffffff8142b4a1>] panic+0xcd/0x1e2
[  244.210656]  [<ffffffff81220bf7>] ? delay_tsc+0x97/0x100
[  244.210658]  [<ffffffff810be1bf>] check_hung_task+0xbf/0xc0
[  244.210660]  [<ffffffff810be390>] check_hung_uninterruptible_tasks+0x1d0/0x210
[  244.210662]  [<ffffffff810be210>] ? check_hung_uninterruptible_tasks+0x50/0x210
[  244.210664]  [<ffffffff810be3d0>] ? check_hung_uninterruptible_tasks+0x210/0x210
[  244.210666]  [<ffffffff810be41f>] watchdog+0x4f/0x60
[  244.210668]  [<ffffffff8106403c>] kthread+0x8c/0xa0
[  244.210670]  [<ffffffff81445424>] kernel_thread_helper+0x4/0x10
[  244.210672]  [<ffffffff81071953>] ? finish_task_switch+0x83/0x100
[  244.210674]  [<ffffffff814403d9>] ? sub_preempt_count+0x29/0x60
[  244.210675]  [<ffffffff8143cc5d>] ? retint_restore_args+0xe/0xe
[  244.210677]  [<ffffffff81063fb0>] ? __init_kthread_worker+0xa0/0xa0
[  244.210679]  [<ffffffff81445420>] ? gs_change+0xb/0xb  2.553686] ---[ end trace 0000000000000002 ]---


