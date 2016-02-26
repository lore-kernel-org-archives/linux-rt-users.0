From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/10] net/core/cpuhotplug: Drain input_pkt_queue lockless
Date: Fri, 26 Feb 2016 16:35:58 -0500
Message-ID: <20160226213709.366991188@goodmis.org>
References: <20160226213551.557375746@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0007-net-core-cpuhotplug-Drain-input_pkt_queue-lockless.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

I can constantly see below error report with 4.1 RT-kernel on TI ARM dra7-evm
if I'm trying to unplug cpu1:

[   57.737589] CPU1: shutdown
[   57.767537] BUG: spinlock bad magic on CPU#0, sh/137
[   57.767546]  lock: 0xee994730, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[   57.767552] CPU: 0 PID: 137 Comm: sh Not tainted 4.1.10-rt8-01700-g2c38702-dirty #55
[   57.767555] Hardware name: Generic DRA74X (Flattened Device Tree)
[   57.767568] [<c001acd0>] (unwind_backtrace) from [<c001534c>] (show_stack+0x20/0x24)
[   57.767579] [<c001534c>] (show_stack) from [<c075560c>] (dump_stack+0x84/0xa0)
[   57.767593] [<c075560c>] (dump_stack) from [<c00aca48>] (spin_dump+0x84/0xac)
[   57.767603] [<c00aca48>] (spin_dump) from [<c00acaa4>] (spin_bug+0x34/0x38)
[   57.767614] [<c00acaa4>] (spin_bug) from [<c00acc10>] (do_raw_spin_lock+0x168/0x1c0)
[   57.767624] [<c00acc10>] (do_raw_spin_lock) from [<c075b4cc>] (_raw_spin_lock+0x4c/0x54)
[   57.767631] [<c075b4cc>] (_raw_spin_lock) from [<c07599fc>] (rt_spin_lock_slowlock+0x5c/0x374)
[   57.767638] [<c07599fc>] (rt_spin_lock_slowlock) from [<c075bcf4>] (rt_spin_lock+0x38/0x70)
[   57.767649] [<c075bcf4>] (rt_spin_lock) from [<c06333c0>] (skb_dequeue+0x28/0x7c)
[   57.767662] [<c06333c0>] (skb_dequeue) from [<c06476ec>] (dev_cpu_callback+0x1b8/0x240)
[   57.767673] [<c06476ec>] (dev_cpu_callback) from [<c007566c>] (notifier_call_chain+0x3c/0xb4)

The reason is that skb_dequeue is taking skb->lock, but RT changed the
core code to use a raw spinlock. The non-raw lock is not initialized
on purpose to catch exactly this kind of problem.

Fixes: 91df05da13a6 'net: Use skbufhead with raw lock'
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddb8578b2f34..055dc9c98b10 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6890,7 +6890,7 @@ static int dev_cpu_callback(struct notifier_block *nfb,
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
-- 
2.7.0
