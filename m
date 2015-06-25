From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [4.0.5-rt4] i915: sleeping function called from invalid context at
 intel_pipe_update_start/end
Date: Thu, 25 Jun 2015 12:09:47 -0300
Message-ID: <20150625150947.GA10320@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34826 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbbFYPJx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Jun 2015 11:09:53 -0400
Received: by qkbp125 with SMTP id p125so40060647qkb.2
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jun 2015 08:09:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

I have been seeing the annoying message below non-stop: 

i915: sleeping function called from invalid context at intel_pipe_update_start/end

[drm] Initialized i915 1.6.0 20150130 for 0000:00:02.0 on minor 0
fbcon: inteldrmfb (fb0) is primary device
BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/mrg-rt-v2-devel/kernel/locking/rtmutex.c:917
in_atomic(): 0, irqs_disabled(): 1, pid: 111, name: kworker/u8:5
9 locks held by kworker/u8:5/111:
 #0:  ("events_unbound"){......}, at: [<ffffffff8109a06d>] process_one_work+0x17d/0x640
 #1:  ((&entry->work)){......}, at: [<ffffffff8109a06d>] process_one_work+0x17d/0x640
 #2:  (registration_lock){......}, at: [<ffffffff81416314>] register_framebuffer+0x34/0x3a0
 #3:  (console_lock){......}, at: [<ffffffff81416534>] register_framebuffer+0x254/0x3a0
 #4:  (&fb_info->lock){......}, at: [<ffffffff814145db>] lock_fb_info+0x1b/0x40
 #5:  ((fb_notifier_list).rwsem){......}, at: [<ffffffff810d7d60>] rt_down_read+0x10/0x20
 #6:  (&dev->mode_config.mutex){......}, at: [<ffffffffa007476e>] __drm_modeset_lock_all+0x8e/0x120 [drm]
 #7:  (crtc_ww_class_acquire){......}, at: [<ffffffffa0074778>] __drm_modeset_lock_all+0x98/0x120 [drm]
 #8:  (crtc_ww_class_mutex){......}, at: [<ffffffffa007432d>] drm_modeset_lock+0x3d/0x110 [drm]
CPU: 0 PID: 111 Comm: kworker/u8:5 Not tainted 4.0.5-rt4+ #4
Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 000000002b54f949 ffff88003de17658 ffffffff81783f82
 000000002b54f949 0000000000000000 ffff88003de17678 ffffffff810a6578
 ffff88018aef5808 ffff88018aef5808 ffff88003de176a8 ffffffff8178abe4
Call Trace:
 [<ffffffff81783f82>] dump_stack+0x4f/0x90
 [<ffffffff810a6578>] ___might_sleep+0xf8/0x170
 [<ffffffff8178abe4>] rt_spin_lock+0x24/0x60
 [<ffffffff810acff5>] ? migrate_disable+0x85/0xf0
 [<ffffffff810c7a0b>] prepare_to_wait+0x2b/0x90
 [<ffffffffa005ab3f>] ? drm_vblank_get+0x6f/0xc0 [drm]
 [<ffffffffa0161ace>] intel_pipe_update_start+0x1be/0x390 [i915]
 [<ffffffff810c7e00>] ? wait_woken+0xa0/0xa0
 [<ffffffffa014a6f9>] intel_begin_crtc_commit+0x159/0x1c0 [i915]
 [<ffffffffa00cc464>] drm_atomic_helper_commit_planes+0x64/0x1b0 [drm_kms_helper]
 [<ffffffffa00c9f0c>] ? drm_atomic_helper_prepare_planes+0x5c/0xe0 [drm_kms_helper]
 [<ffffffffa016822e>] intel_atomic_commit+0xbe/0x110 [i915]
 [<ffffffffa0075397>] drm_atomic_commit+0x37/0x60 [drm]
 [<ffffffffa00cb48d>] drm_atomic_helper_plane_set_property+0x8d/0xd0 [drm_kms_helper]
 [<ffffffffa006313d>] drm_mode_plane_set_obj_prop+0x2d/0x90 [drm]
 [<ffffffffa00cd2fb>] restore_fbdev_mode+0x6b/0xf0 [drm_kms_helper]
 [<ffffffffa00cf3b9>] drm_fb_helper_restore_fbdev_mode_unlocked+0x29/0x80 [drm_kms_helper]
 [<ffffffffa00cf432>] drm_fb_helper_set_par+0x22/0x50 [drm_kms_helper]
 [<ffffffffa0163c4a>] intel_fbdev_set_par+0x1a/0x60 [i915]
 [<ffffffff8140d3f8>] fbcon_init+0x588/0x610
 [<ffffffff81481c4c>] visual_init+0xbc/0x120
 [<ffffffff8148449e>] do_bind_con_driver+0x17e/0x3c0
 [<ffffffff81484c44>] do_take_over_console+0xb4/0x1b0
 [<ffffffff814081f3>] do_fbcon_takeover+0x63/0xd0
 [<ffffffff8140df4d>] fbcon_event_notify+0x6dd/0x7e0
 [<ffffffff810a11bf>] notifier_call_chain+0x4f/0x80
 [<ffffffff810d7d60>] ? rt_down_read+0x10/0x20
 [<ffffffff810a14b1>] __blocking_notifier_call_chain+0x51/0x70
 [<ffffffff810a14e6>] blocking_notifier_call_chain+0x16/0x20
 [<ffffffff8141401b>] fb_notifier_call_chain+0x1b/0x20
 [<ffffffff81416557>] register_framebuffer+0x277/0x3a0
 [<ffffffffa00cf6c4>] drm_fb_helper_initial_config+0x264/0x3c0 [drm_kms_helper]
 [<ffffffffa0164f5b>] intel_fbdev_initial_config+0x1b/0x20 [i915]
 [<ffffffff810a2f4c>] async_run_entry_fn+0x4c/0x160
 [<ffffffff8109a108>] process_one_work+0x218/0x640
 [<ffffffff8109a06d>] ? process_one_work+0x17d/0x640
 [<ffffffff8109a58b>] worker_thread+0x5b/0x500
 [<ffffffff8109a530>] ? process_one_work+0x640/0x640
 [<ffffffff8109fd56>] kthread+0xf6/0x110
 [<ffffffff810cfb5e>] ? put_lock_stats.isra.24+0xe/0x40
 [<ffffffff8109fc60>] ? kthread_create_on_node+0x260/0x260
 [<ffffffff8178b688>] ret_from_fork+0x58/0x90
 [<ffffffff8109fc60>] ? kthread_create_on_node+0x260/0x260
[drm:intel_set_pch_fifo_underrun_reporting [i915]] *ERROR* uncleared pch fifo underrun on pch transcoder A
[drm:intel_pch_fifo_underrun_irq_handler [i915]] *ERROR* PCH transcoder A FIFO underrun
Console: switching to colour frame buffer device 240x67
i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
i915 0000:00:02.0: registered panic notifier

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 9c5451c..2b9e648 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -101,7 +101,7 @@ bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl_count)
 	if (WARN_ON(drm_vblank_get(dev, pipe)))
 		return false;
 
-	local_irq_disable();
+	local_irq_disable_nort();
 
 	trace_i915_pipe_update_start(crtc, min, max);
 
@@ -123,11 +123,11 @@ bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl_count)
 			break;
 		}
 
-		local_irq_enable();
+		local_irq_enable_nort();
 
 		timeout = schedule_timeout(timeout);
 
-		local_irq_disable();
+		local_irq_disable_nort();
 	}
 
 	finish_wait(wq, &wait);
@@ -158,7 +158,7 @@ void intel_pipe_update_end(struct intel_crtc *crtc, u32 start_vbl_count)
 
 	trace_i915_pipe_update_end(crtc, end_vbl_count);
 
-	local_irq_enable();
+	local_irq_enable_nort();
 
 	if (start_vbl_count != end_vbl_count)
 		DRM_ERROR("Atomic update failure on pipe %c (start=%u end=%u)\n",
