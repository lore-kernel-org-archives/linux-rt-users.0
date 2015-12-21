From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Mon, 21 Dec 2015 14:19:10 +0100
Message-ID: <CALqGcGobS4WFpMaiZm0PQ1z8cV-aakMs9cbAuO+u3vfmvJWpdA@mail.gmail.com>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
	<CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36069 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbLUNTM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 08:19:12 -0500
Received: by mail-lf0-f46.google.com with SMTP id z124so105945515lfa.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2015 05:19:11 -0800 (PST)
In-Reply-To: <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

While playing with 4.1.13-rt15 I stumbled across the following thread
where Luis reports the same problem with i915 gpu:
i915: sleeping function called from invalid context at
intel_pipe_update_start/end
http://www.spinics.net/lists/linux-rt-users/msg13543.html

Sebastian suggested to set i915.use_mmio_flip to -1. I tried this, and
this avoids the callstack that I've posted before
(intel_mmio_flip_work). The BUG below is now the dominant one:

[ 1513.969093] BUG: sleeping function called from invalid context at
kernel/locking/rtmutex.c:917
[ 1513.969094] in_atomic(): 0, irqs_disabled(): 1, pid: 2109, name: Xorg
[ 1513.969095] 2 locks held by Xorg/2109:
[ 1513.969110]  #0:  (crtc_ww_class_acquire){+.+.+.}, at:
[<ffffffffa01d8a6c>] drm_modeset_lock_crtc+0x4c/0x100 [drm]
[ 1513.969118]  #1:  (crtc_ww_class_mutex){+.+.+.}, at:
[<ffffffffa01d8871>] drm_modeset_lock+0x41/0x130 [drm]
[ 1513.969119] irq event stamp: 23744596
[ 1513.969121] hardirqs last  enabled at (23744595):
[<ffffffff810ed47f>] ktime_get+0x6f/0x120
[ 1513.969137] hardirqs last disabled at (23744596):
[<ffffffffa02bca93>] intel_pipe_update_start+0x113/0x640 [i915]
[ 1513.969139] softirqs last  enabled at (0): [<ffffffff810565f1>]
copy_process.part.33+0x5e1/0x1d50
[ 1513.969140] softirqs last disabled at (0): [<          (null)>]
      (null)
[ 1513.969141] CPU: 2 PID: 2109 Comm: Xorg Tainted: G            E
4.1.13-realtime-1-rt15 #3
[ 1513.969142] Hardware name: Komax AG, Dierikon Komax-PC/KMX-B75,
BIOS DD3-1-1D 08/21/2013
[ 1513.969144]  ffffffff81c8606d ffff8803ec1bb958 ffffffff81802c33
0000000000000002
[ 1513.969145]  ffff8803fdfb0000 ffff8803ec1bb988 ffffffff8108713a
ffff8803ec1bb988
[ 1513.969146]  ffff8803fa99a188 ffff8803fa99a188 0000000000000002
ffff8803ec1bb9b8
[ 1513.969146] Call Trace:
[ 1513.969149]  [<ffffffff81802c33>] dump_stack+0x4a/0x61
[ 1513.969151]  [<ffffffff8108713a>] ___might_sleep+0x13a/0x200
[ 1513.969153]  [<ffffffff8180a5e4>] rt_spin_lock+0x24/0x60
[ 1513.969155]  [<ffffffff8108b47c>] ? migrate_disable+0x6c/0xe0
[ 1513.969156]  [<ffffffff810a95fb>] prepare_to_wait+0x2b/0xa0
[ 1513.969167]  [<ffffffffa02bcb48>] intel_pipe_update_start+0x1c8/0x640 [i915]
[ 1513.969168]  [<ffffffff810a9ac0>] ? prepare_to_wait_event+0x130/0x130
[ 1513.969178]  [<ffffffffa02a7fc6>] intel_begin_crtc_commit+0x166/0x1e0 [i915]
[ 1513.969183]  [<ffffffffa02146f2>]
drm_plane_helper_commit+0x112/0x2c0 [drm_kms_helper]
[ 1513.969186]  [<ffffffffa021493a>] drm_plane_helper_update+0x9a/0xf0
[drm_kms_helper]
[ 1513.969193]  [<ffffffffa01c8bc8>] __setplane_internal+0x248/0x350 [drm]
[ 1513.969199]  [<ffffffffa01c8df5>] drm_mode_cursor_universal+0x125/0x210 [drm]
[ 1513.969205]  [<ffffffffa01c8f5f>] drm_mode_cursor_common+0x7f/0x1b0 [drm]
[ 1513.969212]  [<ffffffffa01cd411>] drm_mode_cursor_ioctl+0x41/0x50 [drm]
[ 1513.969216]  [<ffffffffa01bd0a9>] drm_ioctl+0x349/0x690 [drm]
[ 1513.969222]  [<ffffffffa01cd3d0>] ? drm_mode_setcrtc+0x630/0x630 [drm]
[ 1513.969224]  [<ffffffff81095585>] ? local_clock+0x25/0x30
[ 1513.969225]  [<ffffffff810b2443>] ? lock_release_holdtime.part.31+0xd3/0x1a0
[ 1513.969227]  [<ffffffff81203088>] do_vfs_ioctl+0x328/0x5e0
[ 1513.969228]  [<ffffffff8120f2a5>] ? __fget+0x5/0x210
[ 1513.969229]  [<ffffffff8120f51a>] ? __fget_light+0x2a/0xa0
[ 1513.969230]  [<ffffffff812033c1>] SyS_ioctl+0x81/0xa0
[ 1513.969232]  [<ffffffff8180afdb>] system_call_fastpath+0x16/0x73

Christoph
