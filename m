From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Tue, 22 Dec 2015 16:37:26 +0100
Message-ID: <20151222153726.GF27274@linutronix.de>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
 <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
 <CALqGcGobS4WFpMaiZm0PQ1z8cV-aakMs9cbAuO+u3vfmvJWpdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54405 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbbLVPhb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 10:37:31 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGobS4WFpMaiZm0PQ1z8cV-aakMs9cbAuO+u3vfmvJWpdA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-21 14:19:10 [+0100]:

>While playing with 4.1.13-rt15 I stumbled across the following thread
>where Luis reports the same problem with i915 gpu:
>i915: sleeping function called from invalid context at
>intel_pipe_update_start/end
>http://www.spinics.net/lists/linux-rt-users/msg13543.html
>
>Sebastian suggested to set i915.use_mmio_flip to -1. I tried this, and
>this avoids the callstack that I've posted before
>(intel_mmio_flip_work). The BUG below is now the dominant one:
perfect.

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
|in_atomic(): 0, irqs_disabled(): 1, pid: 2109, name: Xorg
|hardirqs last disabled at (23744596): [<ffffffffa02bca93>] intel_pipe_update_start+0x113/0x640 [i915]
|Call Trace:
| [<ffffffff81802c33>] dump_stack+0x4a/0x61
| [<ffffffff8108713a>] ___might_sleep+0x13a/0x200
| [<ffffffff8180a5e4>] rt_spin_lock+0x24/0x60
| [<ffffffff8108b47c>] ? migrate_disable+0x6c/0xe0
| [<ffffffff810a95fb>] prepare_to_wait+0x2b/0xa0
| [<ffffffffa02bcb48>] intel_pipe_update_start+0x1c8/0x640 [i915]
| [<ffffffff810a9ac0>] ? prepare_to_wait_event+0x130/0x130
| [<ffffffffa02a7fc6>] intel_begin_crtc_commit+0x166/0x1e0 [i915]
| [<ffffffffa02146f2>] drm_plane_helper_commit+0x112/0x2c0 [drm_kms_helper]
| [<ffffffffa021493a>] drm_plane_helper_update+0x9a/0xf0

I have to admit, the i915 tries very hard to avoid running on -RT. Could
you try the s/local_irq_disable();/local_irq_disable_nort();/ patch
mentioned in the thread?

Anyone of the i915 hackers an idea how could get the i915 working
without disabling interrupts? Is really required?

Sebastian
