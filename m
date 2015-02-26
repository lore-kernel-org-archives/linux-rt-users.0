From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: 3.18.7-rt: BUG: sleeping function called from invalid context
 (snd_pcm_stream_lock+0x29/0x70)
Date: Thu, 26 Feb 2015 17:08:15 -0300
Message-ID: <20150226200815.GM4111@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:34352 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbBZUIT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 15:08:19 -0500
Received: by mail-qa0-f51.google.com with SMTP id i13so9561136qae.10
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2015 12:08:18 -0800 (PST)
Received: from lclaudio.dyndns.org ([177.157.5.90])
        by mx.google.com with ESMTPSA id g6sm1178901qaq.26.2015.02.26.12.08.18
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 12:08:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

Right after boot I start seeing these messages to:

[   44.046458] BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/kernel-rt/kernel/locking/rtmutex.c:915
[   44.046459] in_atomic(): 0, irqs_disabled(): 1, pid: 2515, name: pulseaudio
[   44.046460] 1 lock held by pulseaudio/2515:
[   44.046469]  #0:  (snd_pcm_link_rwlock){......}, at: [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   44.046471] CPU: 3 PID: 2515 Comm: pulseaudio Tainted: G        W      3.18.7-rt2+ #2
[   44.046472] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[   44.046474]  0000000000000000 00000000989763cd ffff880189d43cb8 ffffffff8175a165
[   44.046475]  00000000989763cd 0000000000000000 ffff880189d43cd8 ffffffff810a3be9
[   44.046476]  0000000000000011 ffffffffa03359c0 ffff880189d43cf8 ffffffff81760a94
[   44.046477] Call Trace:
[   44.046481]  [<ffffffff8175a165>] dump_stack+0x4f/0x7c
[   44.046484]  [<ffffffff810a3be9>] __might_sleep+0xf9/0x170
[   44.046486]  [<ffffffff81760a94>] __rt_spin_lock+0x24/0x40
[   44.046489]  [<ffffffff817612f7>] rt_read_lock+0x57/0x70
[   44.046494]  [<ffffffffa0323c69>] ? snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   44.046497]  [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   44.046501]  [<ffffffffa0324b06>] snd_pcm_hw_params+0x46/0x3f0 [snd_pcm]
[   44.046504]  [<ffffffff811a700b>] ? memdup_user+0x4b/0x90
[   44.046508]  [<ffffffffa0327327>] snd_pcm_common_ioctl1+0x457/0xe20 [snd_pcm]
[   44.046511]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   44.046513]  [<ffffffff810ca7ba>] ? lock_release_holdtime.part.24+0x9a/0x160
[   44.046517]  [<ffffffffa03281db>] snd_pcm_capture_ioctl1+0x1bb/0x2f0 [snd_pcm]
[   44.046518]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   44.046522]  [<ffffffffa03283d4>] snd_pcm_capture_ioctl+0x34/0x40 [snd_pcm]
[   44.046524]  [<ffffffff81217a10>] do_vfs_ioctl+0x2f0/0x520
[   44.046526]  [<ffffffff81217cc1>] SyS_ioctl+0x81/0xa0
[   44.046529]  [<ffffffff81761952>] system_call_fastpath+0x12/0x17
[   45.081114] BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/kernel-rt/kernel/locking/rtmutex.c:915
[   45.081115] in_atomic(): 0, irqs_disabled(): 1, pid: 2515, name: pulseaudio
[   45.081117] 3 locks held by pulseaudio/2515:
[   45.081136]  #0:  (&card->power_lock){......}, at: [<ffffffffa032759d>] snd_pcm_common_ioctl1+0x6cd/0xe20 [snd_pcm]
[   45.081142]  #1:  (snd_pcm_link_rwsem){......}, at: [<ffffffff810d2160>] rt_down_read+0x10/0x20
[   45.081150]  #2:  (snd_pcm_link_rwlock){......}, at: [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   45.081153] CPU: 3 PID: 2515 Comm: pulseaudio Tainted: G        W      3.18.7-rt2+ #2
[   45.081154] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[   45.081157]  0000000000000000 00000000989763cd ffff880189d43bf8 ffffffff8175a165
[   45.081159]  00000000989763cd 0000000000000000 ffff880189d43c18 ffffffff810a3be9
[   45.081161]  ffff8800bad2aa00 ffffffffa03359c0 ffff880189d43c38 ffffffff81760a94
[   45.081162] Call Trace:
[   45.081167]  [<ffffffff8175a165>] dump_stack+0x4f/0x7c
[   45.081170]  [<ffffffff810a3be9>] __might_sleep+0xf9/0x170
[   45.081174]  [<ffffffff81760a94>] __rt_spin_lock+0x24/0x40
[   45.081179]  [<ffffffff817612f7>] rt_read_lock+0x57/0x70
[   45.081185]  [<ffffffffa0323c69>] ? snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   45.081190]  [<ffffffffa0482a7b>] ? azx_pcm_prepare+0x2db/0x530 [snd_hda_controller]
[   45.081196]  [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   45.081202]  [<ffffffffa0323cf4>] _snd_pcm_stream_lock_irqsave+0x24/0x30 [snd_pcm]
[   45.081209]  [<ffffffffa032d33c>] snd_pcm_lib_ioctl+0x10c/0x270 [snd_pcm]
[   45.081214]  [<ffffffffa0322393>] snd_pcm_do_reset+0x23/0x70 [snd_pcm]
[   45.081220]  [<ffffffffa0323c39>] snd_pcm_do_prepare+0x29/0x30 [snd_pcm]
[   45.081226]  [<ffffffffa03237df>] snd_pcm_action_single+0x2f/0x70 [snd_pcm]
[   45.081229]  [<ffffffff810d2160>] ? rt_down_read+0x10/0x20
[   45.081236]  [<ffffffffa0323a16>] snd_pcm_action_nonatomic+0x76/0x80 [snd_pcm]
[   45.081242]  [<ffffffffa03275c3>] snd_pcm_common_ioctl1+0x6f3/0xe20 [snd_pcm]
[   45.081245]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   45.081247]  [<ffffffff810ca7ba>] ? lock_release_holdtime.part.24+0x9a/0x160
[   45.081253]  [<ffffffffa0327eb3>] snd_pcm_playback_ioctl1+0x1c3/0x2f0 [snd_pcm]
[   45.081255]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   45.081262]  [<ffffffffa0328014>] snd_pcm_playback_ioctl+0x34/0x40 [snd_pcm]
[   45.081265]  [<ffffffff81217a10>] do_vfs_ioctl+0x2f0/0x520
[   45.081268]  [<ffffffff81217cc1>] SyS_ioctl+0x81/0xa0
[   46.193615] BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/kernel-rt/kernel/locking/rtmutex.c:915
[   46.193616] in_atomic(): 0, irqs_disabled(): 1, pid: 2523, name: alsa-sink-92HD7
[   46.193617] 1 lock held by alsa-sink-92HD7/2523:
[   46.193631]  #0:  (snd_pcm_link_rwlock){......}, at: [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   46.193633] CPU: 1 PID: 2523 Comm: alsa-sink-92HD7 Tainted: G        W      3.18.7-rt2+ #2
[   46.193633] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[   46.193635]  0000000000000000 00000000ec9c958e ffff88018a723a08 ffffffff8175a165
[   46.193636]  00000000ec9c958e 0000000000000000 ffff88018a723a28 ffffffff810a3be9
[   46.193637]  ffff88018a723b5c ffffffffa03359c0 ffff88018a723a48 ffffffff81760a94
[   46.193637] Call Trace:
[   46.193642]  [<ffffffff8175a165>] dump_stack+0x4f/0x7c
[   46.193644]  [<ffffffff810a3be9>] __might_sleep+0xf9/0x170
[   46.193647]  [<ffffffff81760a94>] __rt_spin_lock+0x24/0x40
[   46.193651]  [<ffffffff817612f7>] rt_read_lock+0x57/0x70
[   46.193655]  [<ffffffffa0323c69>] ? snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   46.193657]  [<ffffffff81223568>] ? __fget+0xb8/0x100
[   46.193659]  [<ffffffff812234b5>] ? __fget+0x5/0x100
[   46.193662]  [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[   46.193666]  [<ffffffffa032484d>] snd_pcm_playback_poll+0x5d/0x120 [snd_pcm]
[   46.193668]  [<ffffffff81219d42>] do_sys_poll+0x352/0x5d0
[   46.193670]  [<ffffffff810a9d21>] ? get_parent_ip+0x11/0x50
[   46.193675]  [<ffffffffa032cf59>] ? snd_pcm_update_hw_ptr0+0x7c9/0x9a0 [snd_pcm]
[   46.193677]  [<ffffffff813a9e87>] ? debug_smp_processor_id+0x17/0x20
[   46.193678]  [<ffffffff810ca297>] ? get_lock_stats+0x27/0x60
[   46.193679]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   46.193681]  [<ffffffff810b0155>] ? local_clock+0x25/0x30
[   46.193682]  [<ffffffff810cc6a3>] ? __lock_acquire.isra.32+0x2e3/0xdc0
[   46.193684]  [<ffffffff810cc6a3>] ? __lock_acquire.isra.32+0x2e3/0xdc0
[   46.193685]  [<ffffffff8175e580>] ? __rt_spin_lock_slowunlock+0x60/0x70
[   46.193687]  [<ffffffff81218790>] ? poll_select_copy_remaining+0x160/0x160
[   46.193688]  [<ffffffff81218790>] ? poll_select_copy_remaining+0x160/0x160
[   46.193690]  [<ffffffff81218790>] ? poll_select_copy_remaining+0x160/0x160
[   46.193691]  [<ffffffff81218790>] ? poll_select_copy_remaining+0x160/0x160
[   46.193693]  [<ffffffff810b0155>] ? local_clock+0x25/0x30
[   46.193694]  [<ffffffff810cc6a3>] ? __lock_acquire.isra.32+0x2e3/0xdc0
[   46.193695]  [<ffffffff810cc6a3>] ? __lock_acquire.isra.32+0x2e3/0xdc0
[   46.193696]  [<ffffffff810a9d21>] ? get_parent_ip+0x11/0x50
[   46.193697]  [<ffffffff81218a53>] ? poll_select_set_timeout+0x53/0x80
[   46.193698]  [<ffffffff813a9e87>] ? debug_smp_processor_id+0x17/0x20
[   46.193699]  [<ffffffff810ca297>] ? get_lock_stats+0x27/0x60
[   46.193700]  [<ffffffff810ca49e>] ? put_lock_stats.isra.23+0xe/0x30
[   46.193701]  [<ffffffff810ca7ba>] ? lock_release_holdtime.part.24+0x9a/0x160
[   46.193704]  [<ffffffff810fca8b>] ? ktime_get_ts64+0x8b/0x150
[   46.193705]  [<ffffffff81218a53>] ? poll_select_set_timeout+0x53/0x80
[   46.193707]  [<ffffffff8121a317>] SyS_ppoll+0x1a7/0x1d0
[   46.193709]  [<ffffffff81761952>] system_call_fastpath+0x12/0x17


>From sound/core/pcm_native.c:

static DEFINE_RWLOCK(snd_pcm_link_rwlock);

                read_lock(&snd_pcm_link_rwlock);


Cheers
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

