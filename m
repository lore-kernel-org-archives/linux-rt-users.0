From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [4.1.7-rt8][report] Very high cyclictest latency
 during glmark2 on i915 gpu
Date: Tue, 5 Jan 2016 15:38:51 +0100
Message-ID: <20160105143851.GJ8076@phenom.ffwll.local>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
 <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
 <CALqGcGobS4WFpMaiZm0PQ1z8cV-aakMs9cbAuO+u3vfmvJWpdA@mail.gmail.com>
 <20151222153726.GF27274@linutronix.de>
 <CALqGcGq35+-NGe+h5WtJhRnzSf1Qq0g3oZLjgQ1dtmGcNXx9Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Vetter <daniel.vetter@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38385 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbcAEOiz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 09:38:55 -0500
Received: by mail-wm0-f41.google.com with SMTP id b14so32112473wmb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jan 2016 06:38:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALqGcGq35+-NGe+h5WtJhRnzSf1Qq0g3oZLjgQ1dtmGcNXx9Kw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Dec 23, 2015 at 01:40:06PM +0100, Christoph Mathys wrote:
> On Tue, Dec 22, 2015 at 4:37 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > I have to admit, the i915 tries very hard to avoid running on -RT. Could
> > you try the s/local_irq_disable();/local_irq_disable_nort();/ patch
> > mentioned in the thread?
> 
> It did not crash so far, I did some usual work and executed glmark2
> several times. The BUG has not surfaced again. BUT, the latency is
> still far from ideal, it takes only seconds for the maximum latency to
> spike into the range of milliseconds. By the way, this is now
> 4.1.15-rt17 with the changes from here:
> http://www.spinics.net/lists/linux-rt-users/msg13543.html
> 
> During some tests with cyclictests --breaktrace I've seen more BUG
> messages, but they might relate to the kernel tracing. Unfortunately,
> I could not make much of the --breaktrace.

Waking the GT takes a while, and for a bunch of reasons we need to be able
to do this from irq context, hence spin_lock_irq. Doesn't RT convert that
to a mutex?

Otherwise not sure what would prevent interrupts in your backtrace ...
-Daniel

> 
> [ 4629.753864] BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:917
> [ 4629.753865] in_atomic(): 1, irqs_disabled(): 0, pid: 1913, name: Xorg
> [ 4629.753866] 2 locks held by Xorg/1913:
> [ 4629.753879]  #0:  (crtc_ww_class_acquire){+.+.+.}, at:
> [<ffffffffa0211a6c>] drm_modeset_lock_crtc+0x4c/0x100 [drm]
> [ 4629.753887]  #1:  (crtc_ww_class_mutex){+.+.+.}, at:
> [<ffffffffa0211871>] drm_modeset_lock+0x41/0x130 [drm]
> [ 4629.753888] CPU: 4 PID: 1913 Comm: Xorg Tainted: G            E
> 4.1.15-i915-patch-realtime-1-rt17+ #4
> [ 4629.753889] Hardware name: Komax AG, Dierikon Komax-PC/KMX-B75,
> BIOS DD3-1-1D 08/21/2013
> [ 4629.753891]  ffffffff81c862ce ffff8803e92538b8 ffffffff81805313
> 0000000000005b10
> [ 4629.753892]  ffff8803e8baa660 ffff8803e92538e8 ffffffff8108813a
> ffff8803e92538d8
> [ 4629.753893]  ffff8803fe6d0070 ffff8803fe6d0070 ffff8803fe6d0068
> ffff8803e9253918
> [ 4629.753893] Call Trace:
> [ 4629.753897]  [<ffffffff81805313>] dump_stack+0x4a/0x61
> [ 4629.753899]  [<ffffffff8108813a>] ___might_sleep+0x13a/0x200
> [ 4629.753901]  [<ffffffff8180ccc4>] rt_spin_lock+0x24/0x60
> [ 4629.753916]  [<ffffffffa02f61d6>] gen6_read32+0x46/0x380 [i915]
> [ 4629.753925]  [<ffffffffa02d4b42>] gm45_get_vblank_counter+0x32/0x40 [i915]
> [ 4629.753934]  [<ffffffffa02e11b5>]
> ftrace_raw_event_i915_pipe_update_start+0x65/0xb0 [i915]
> [ 4629.753944]  [<ffffffffa0324c23>] intel_pipe_update_start+0x2a3/0x640 [i915]
> [ 4629.753946]  [<ffffffff810aaac0>] ? prepare_to_wait_event+0x130/0x130
> [ 4629.753956]  [<ffffffffa030ffc6>] intel_begin_crtc_commit+0x166/0x1e0 [i915]
> [ 4629.753961]  [<ffffffffa026e6f2>]
> drm_plane_helper_commit+0x112/0x2c0 [drm_kms_helper]
> [ 4629.753963]  [<ffffffffa026e93a>] drm_plane_helper_update+0x9a/0xf0
> [drm_kms_helper]
> [ 4629.753970]  [<ffffffffa0201bc8>] __setplane_internal+0x248/0x350 [drm]
> [ 4629.753975]  [<ffffffffa0201df5>] drm_mode_cursor_universal+0x125/0x210 [drm]
> [ 4629.753981]  [<ffffffffa0201f5f>] drm_mode_cursor_common+0x7f/0x1b0 [drm]
> [ 4629.753987]  [<ffffffffa0206411>] drm_mode_cursor_ioctl+0x41/0x50 [drm]
> [ 4629.753992]  [<ffffffffa01f60a9>] drm_ioctl+0x349/0x690 [drm]
> [ 4629.753998]  [<ffffffffa02063d0>] ? drm_mode_setcrtc+0x630/0x630 [drm]
> [ 4629.753999]  [<ffffffff81096585>] ? local_clock+0x25/0x30
> [ 4629.754001]  [<ffffffff810b3443>] ? lock_release_holdtime.part.31+0xd3/0x1a0
> [ 4629.754002]  [<ffffffff81204088>] do_vfs_ioctl+0x328/0x5e0
> [ 4629.754004]  [<ffffffff812102a5>] ? __fget+0x5/0x210
> [ 4629.754004]  [<ffffffff8121051a>] ? __fget_light+0x2a/0xa0
> [ 4629.754005]  [<ffffffff812043c1>] SyS_ioctl+0x81/0xa0
> [ 4629.754007]  [<ffffffff8180d804>] tracesys_phase2+0x88/0x8d
> 
> [  361.526236] BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:917
> [  361.526237] in_atomic(): 1, irqs_disabled(): 0, pid: 667, name: irq/51-i915
> [  361.526237] no locks held by irq/51-i915/667.
> [  361.526239] CPU: 4 PID: 667 Comm: irq/51-i915 Tainted: G
> E   4.1.15-i915-patch-realtime-1-rt17+ #4
> [  361.526240] Hardware name: Komax AG, Dierikon Komax-PC/KMX-B75,
> BIOS DD3-1-1D 08/21/2013
> [  361.526242]  ffffffff81c862ce ffff8803fe6e7b58 ffffffff81805313
> 0000000000000000
> [  361.526243]  ffff8803ff3d4cc0 ffff8803fe6e7b88 ffffffff8108813a
> 0000000000000296
> [  361.526244]  ffff8803fe6d0070 ffff8803fe6d0070 ffff8803fe6d0068
> ffff8803fe6e7bb8
> [  361.526244] Call Trace:
> [  361.526249]  [<ffffffff81805313>] dump_stack+0x4a/0x61
> [  361.526251]  [<ffffffff8108813a>] ___might_sleep+0x13a/0x200
> [  361.526253]  [<ffffffff8180ccc4>] rt_spin_lock+0x24/0x60
> [  361.526281]  [<ffffffffa02f61d6>] gen6_read32+0x46/0x380 [i915]
> [  361.526283]  [<ffffffff81142270>] ? trace_event_buffer_lock_reserve+0x40/0x80
> [  361.526293]  [<ffffffffa02e782f>] gen6_ring_get_seqno+0x2f/0x40 [i915]
> [  361.526301]  [<ffffffffa02e0eef>]
> ftrace_raw_event_i915_gem_request_notify+0x5f/0x90 [i915]
> [  361.526309]  [<ffffffffa02d843d>] notify_ring.isra.12+0xcd/0x240 [i915]
> [  361.526316]  [<ffffffffa02d8a0c>] snb_gt_irq_handler+0x12c/0x180 [i915]
> [  361.526323]  [<ffffffffa02dab97>] ironlake_irq_handler+0x1c7/0xfe0 [i915]
> [  361.526324]  [<ffffffff81087f0d>] ? finish_task_switch+0x4d/0x140
> [  361.526325]  [<ffffffff810cf7e7>] irq_forced_thread_fn+0x27/0x70
> [  361.526326]  [<ffffffff810cfd99>] irq_thread+0x149/0x1f0
> [  361.526327]  [<ffffffff810cf7c0>] ? irq_thread_fn+0x40/0x40
> [  361.526328]  [<ffffffff810cf860>] ? wake_threads_waitq+0x30/0x30
> [  361.526329]  [<ffffffff810cfc50>] ? irq_thread_check_affinity+0x70/0x70
> [  361.526330]  [<ffffffff81081854>] kthread+0xe4/0x100
> [  361.526332]  [<ffffffff810b649d>] ? trace_hardirqs_on+0xd/0x10
> [  361.526333]  [<ffffffff81081770>] ? kthread_create_on_node+0x240/0x240
> [  361.526334]  [<ffffffff8180db22>] ret_from_fork+0x42/0x70
> [  361.526335]  [<ffffffff81081770>] ? kthread_create_on_node+0x240/0x240
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
