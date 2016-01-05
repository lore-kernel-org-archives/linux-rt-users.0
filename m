From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [4.1.7-rt8][report] Very high cyclictest latency
 during glmark2 on i915 gpu
Date: Tue, 5 Jan 2016 15:41:22 +0100
Message-ID: <20160105144121.GK8076@phenom.ffwll.local>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
 <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
 <CALqGcGobS4WFpMaiZm0PQ1z8cV-aakMs9cbAuO+u3vfmvJWpdA@mail.gmail.com>
 <20151222153726.GF27274@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Mathys <eraserix@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38465 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcAEOlY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 09:41:24 -0500
Received: by mail-wm0-f45.google.com with SMTP id b14so32227016wmb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jan 2016 06:41:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151222153726.GF27274@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Dec 22, 2015 at 04:37:26PM +0100, Sebastian Andrzej Siewior wrote:
> * Christoph Mathys | 2015-12-21 14:19:10 [+0100]:
> 
> >While playing with 4.1.13-rt15 I stumbled across the following thread
> >where Luis reports the same problem with i915 gpu:
> >i915: sleeping function called from invalid context at
> >intel_pipe_update_start/end
> >http://www.spinics.net/lists/linux-rt-users/msg13543.html
> >
> >Sebastian suggested to set i915.use_mmio_flip to -1. I tried this, and
> >this avoids the callstack that I've posted before
> >(intel_mmio_flip_work). The BUG below is now the dominant one:
> perfect.
> 
> |BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
> |in_atomic(): 0, irqs_disabled(): 1, pid: 2109, name: Xorg
> |hardirqs last disabled at (23744596): [<ffffffffa02bca93>] intel_pipe_update_start+0x113/0x640 [i915]
> |Call Trace:
> | [<ffffffff81802c33>] dump_stack+0x4a/0x61
> | [<ffffffff8108713a>] ___might_sleep+0x13a/0x200
> | [<ffffffff8180a5e4>] rt_spin_lock+0x24/0x60
> | [<ffffffff8108b47c>] ? migrate_disable+0x6c/0xe0
> | [<ffffffff810a95fb>] prepare_to_wait+0x2b/0xa0
> | [<ffffffffa02bcb48>] intel_pipe_update_start+0x1c8/0x640 [i915]
> | [<ffffffff810a9ac0>] ? prepare_to_wait_event+0x130/0x130
> | [<ffffffffa02a7fc6>] intel_begin_crtc_commit+0x166/0x1e0 [i915]
> | [<ffffffffa02146f2>] drm_plane_helper_commit+0x112/0x2c0 [drm_kms_helper]
> | [<ffffffffa021493a>] drm_plane_helper_update+0x9a/0xf0
> 
> I have to admit, the i915 tries very hard to avoid running on -RT. Could
> you try the s/local_irq_disable();/local_irq_disable_nort();/ patch
> mentioned in the thread?
> 
> Anyone of the i915 hackers an idea how could get the i915 working
> without disabling interrupts? Is really required?

It's a correctness problem - if we don't disable everything we might miss
the timeframe and your screen will tear. Hence why we essentially need to
run this little section of code with hard-rt semantics. There's other
display chips with proper design which don't need hacks like this one
here.

Now of course you might want to accept a broken screen in exchange for
non-broken hard rt for the things you really care about, but I'm not sure
how to encode this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
