From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch-3.18.7-rt1] snd/pcm: fix snd_pcm_stream_lock*()
 irqs_disabled() splats
Date: Wed, 18 Feb 2015 15:09:23 +0100
Message-ID: <1424268563.7035.5.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216111822.GA21649@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Locking functions previously using read_lock_irq()/read_lock_irqsave() were
changed to local_irq_disable/save(), leading to gripes.  Use nort variants.

[ 2423.966857] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:915
[ 2423.966858] in_atomic(): 0, irqs_disabled(): 1, pid: 5947, name: alsa-sink-ALC88
[ 2423.966860] CPU: 5 PID: 5947 Comm: alsa-sink-ALC88 Not tainted 3.18.7-rt1 #9
[ 2423.966860] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.404 11/06/2014
[ 2423.966862]  ffff880409316240 ffff88040866fa38 ffffffff815bdeb5 0000000000000002
[ 2423.966863]  0000000000000000 ffff88040866fa58 ffffffff81073c86 ffffffffa03b2640
[ 2423.966864]  ffff88040239ec00 ffff88040866fa78 ffffffff815c3d34 ffffffffa03b2640
[ 2423.966864] Call Trace:
[ 2423.966868]  [<ffffffff815bdeb5>] dump_stack+0x4f/0x9e
[ 2423.966870]  [<ffffffff81073c86>] __might_sleep+0xe6/0x150
[ 2423.966880]  [<ffffffff815c3d34>] __rt_spin_lock+0x24/0x50
[ 2423.966883]  [<ffffffff815c4044>] rt_read_lock+0x34/0x40
[ 2423.966887]  [<ffffffffa03a2979>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]
[ 2423.966890]  [<ffffffffa03a355d>] snd_pcm_playback_poll+0x5d/0x120 [snd_pcm]
[ 2423.966892]  [<ffffffff811937a2>] do_sys_poll+0x322/0x5b0
[ 2423.966895]  [<ffffffff812bcfe7>] ? debug_smp_processor_id+0x17/0x20
[ 2423.966897]  [<ffffffffa03fa023>] ? azx_cc_read+0x23/0x30 [snd_hda_controller]
[ 2423.966899]  [<ffffffff810b9029>] ? timecounter_read+0x19/0x50
[ 2423.966901]  [<ffffffffa03fb187>] ? azx_get_wallclock_tstamp+0x97/0xc0 [snd_hda_controller]
[ 2423.966904]  [<ffffffffa03aaed1>] ? snd_pcm_update_hw_ptr0+0x1b1/0x470 [snd_pcm]
[ 2423.966906]  [<ffffffff812bcfe7>] ? debug_smp_processor_id+0x17/0x20
[ 2423.966907]  [<ffffffff81051d2a>] ? unpin_current_cpu+0x1a/0x70
[ 2423.966910]  [<ffffffff81079ec0>] ? migrate_enable+0xe0/0x1e0
[ 2423.966912]  [<ffffffff811923c0>] ? poll_select_copy_remaining+0x130/0x130
[ 2423.966914]  [<ffffffff811923c0>] ? poll_select_copy_remaining+0x130/0x130
[ 2423.966915]  [<ffffffff811923c0>] ? poll_select_copy_remaining+0x130/0x130
[ 2423.966916]  [<ffffffff811923c0>] ? poll_select_copy_remaining+0x130/0x130
[ 2423.966919]  [<ffffffffa03a5ba2>] ? snd_pcm_common_ioctl1+0x1c2/0xda0 [snd_pcm]
[ 2423.966920]  [<ffffffff812bcfe7>] ? debug_smp_processor_id+0x17/0x20
[ 2423.966923]  [<ffffffffa03a690b>] ? snd_pcm_playback_ioctl1+0x18b/0x2d0 [snd_pcm]
[ 2423.966924]  [<ffffffff811c6fa9>] ? eventfd_ctx_read+0x179/0x1e0
[ 2423.966926]  [<ffffffffa03a6a84>] ? snd_pcm_playback_ioctl+0x34/0x40 [snd_pcm]
[ 2423.966927]  [<ffffffff810b661e>] ? ktime_get_ts64+0x4e/0xf0
[ 2423.966928]  [<ffffffff81193d48>] SyS_ppoll+0x1a8/0x1c0
[ 2423.966930]  [<ffffffff815c4556>] system_call_fastpath+0x16/0x1b

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 sound/core/pcm_native.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock)
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
 	if (!substream->pcm->nonatomic)
-		local_irq_disable();
+		local_irq_disable_nort();
 	snd_pcm_stream_lock(substream);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
@@ -113,7 +113,7 @@ void snd_pcm_stream_unlock_irq(struct sn
 {
 	snd_pcm_stream_unlock(substream);
 	if (!substream->pcm->nonatomic)
-		local_irq_enable();
+		local_irq_enable_nort();
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
 
@@ -121,7 +121,7 @@ unsigned long _snd_pcm_stream_lock_irqsa
 {
 	unsigned long flags = 0;
 	if (!substream->pcm->nonatomic)
-		local_irq_save(flags);
+		local_irq_save_nort(flags);
 	snd_pcm_stream_lock(substream);
 	return flags;
 }
@@ -132,7 +132,7 @@ void snd_pcm_stream_unlock_irqrestore(st
 {
 	snd_pcm_stream_unlock(substream);
 	if (!substream->pcm->nonatomic)
-		local_irq_restore(flags);
+		local_irq_restore_nort(flags);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
 
