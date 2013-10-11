From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: sleeping function called from invalid context on
 3.10.10-rt7
Date: Fri, 11 Oct 2013 16:19:31 +0200
Message-ID: <20131011141931.GI6983@linutronix.de>
References: <20130911102809.GA31663@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33818 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab3JKOTd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 10:19:33 -0400
Content-Disposition: inline
In-Reply-To: <20130911102809.GA31663@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2013-09-11 07:28:09 [-0300]:

>Hello,
Hi Luis,

>after Xorg started. I silenced that with a hackish patch, just for fun, and
>found a second problem, this time on tty_ldisc_reinit().
>
>[   25.423675] BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/mrg-rt-v2-devel/kernel/rtmutex.c:659
>[   25.423676] in_atomic(): 1, irqs_disabled(): 1, pid: 188, name: plymouthd
>[   25.423676] 3 locks held by plymouthd/188:
>[   25.423682]  #0:  (&tty->legacy_mutex){......}, at: [<ffffffff816528d0>] tty_lock_nested+0x40/0x90
>[   25.423686]  #1:  (&tty->ldisc_mutex){......}, at: [<ffffffff8139b482>] tty_ldisc_hangup+0x152/0x300
>[   25.423688]  #2:  (tty_ldisc_lock){......}, at: [<ffffffff8139a9c2>] tty_ldisc_reinit+0x72/0x130
>[   25.423689] Preemption disabled at:[<ffffffff8139a9c2>] tty_ldisc_reinit+0x72/0x130
>[   25.423691] CPU: 2 PID: 188 Comm: plymouthd Not tainted 3.10.10-rt7+ #6
>[   25.423692] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
>[   25.423694]  005ff00000000000 ffff8801788ada68 ffffffff8164b790 ffff8801788ada80
>[   25.423695]  ffffffff8107e62f ffff8801991ce1a0 ffff8801788adaa0 ffffffff81651ac4
>[   25.423696]  0000000000000000 ffffea0005e26680 ffff8801788adaf8 ffffffff81130984
>[   25.423696] Call Trace:
>[   25.423700]  [<ffffffff8164b790>] dump_stack+0x19/0x1b
>[   25.423702]  [<ffffffff8107e62f>] __might_sleep+0xff/0x170
>[   25.423704]  [<ffffffff81651ac4>] rt_spin_lock+0x24/0x60
>[   25.423707]  [<ffffffff81130984>] free_hot_cold_page+0xb4/0x3c0
>[   25.423710]  [<ffffffff81178209>] ?unfreeze_partials.isra.42+0x229/0x2b0
>[   25.423711]  [<ffffffff81130dc7>] __free_pages+0x47/0x70
>[   25.423713]  [<ffffffff81130fb2>] __free_memcg_kmem_pages+0x22/0x50
>[   25.423714]  [<ffffffff81177528>] __free_slab+0xe8/0x1e0
>[   25.423716]  [<ffffffff81177654>] free_delayed+0x34/0x50
>[   25.423717]  [<ffffffff81649633>] __slab_free+0x273/0x36b
>[   25.423719]  [<ffffffff810acde9>] ? get_lock_stats+0x19/0x60
>[   25.423721]  [<ffffffff810ad49e>] ? put_lock_stats.isra.23+0xe/0x40
>[   25.423722]  [<ffffffff81178794>] kfree+0x1c4/0x210
>[   25.423724]  [<ffffffff8139a9f5>] ? tty_ldisc_reinit+0xa5/0x130
>[   25.423725]  [<ffffffff8139a9f5>] tty_ldisc_reinit+0xa5/0x130
>[   25.423726]  [<ffffffff8139b49f>] tty_ldisc_hangup+0x16f/0x300
>[   25.423728]  [<ffffffff81082e1d>] ? get_parent_ip+0xd/0x50
>[   25.423731]  [<ffffffff8104d736>] ? unpin_current_cpu+0x16/0x70
>[   25.423732]  [<ffffffff81392136>] __tty_hangup+0x346/0x460
>[   25.423733]  [<ffffffff81392260>] tty_vhangup+0x10/0x20
>[   25.423735]  [<ffffffff8139d6e1>] pty_close+0x131/0x180
>[   25.423736]  [<ffffffff813936ad>] tty_release+0x11d/0x5f0
>[   25.423737]  [<ffffffff810acde9>] ? get_lock_stats+0x19/0x60
>[   25.423747]  [<ffffffff81009d84>] ? native_sched_clock+0x24/0x80
>[   25.423749]  [<ffffffff81087025>] ? sched_clock_cpu+0xb5/0x100
>[   25.423750]  [<ffffffff810acde9>] ? get_lock_stats+0x19/0x60
>[   25.423752]  [<ffffffff8118eb45>] __fput+0xf5/0x250
>[   25.423762]  [<ffffffff8118ed6e>] ____fput+0xe/0x10
>[   25.423764]  [<ffffffff8106f1cc>] task_work_run+0xac/0xe0
>[   25.423765]  [<ffffffff81002a11>] do_notify_resume+0x91/0xf0
>[   25.423767]  [<ffffffff8165a41c>] int_signal+0x12/0x17

So the thread continues as a i915 bug thread. Now that I looked at it
again I noticed the tty problem which we probably have since v3.8. The
following patch should fix it.

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 1afe192..bc4ffe4 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -197,9 +197,10 @@ static inline void tty_ldisc_put(struct tty_ldisc *ld)
 	WARN_ON(!atomic_dec_and_test(&ld->users));
 
 	ld->ops->refcount--;
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+
 	module_put(ld->ops->owner);
 	kfree(ld);
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 }
 
 static void *tty_ldiscs_seq_start(struct seq_file *m, loff_t *pos)
-- 
1.8.4.rc3

Sebastian
