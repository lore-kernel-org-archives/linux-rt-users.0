From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] drivers,connector: Protect send_msg() with a local lock for
 RT
Date: Sun, 16 Oct 2016 05:11:54 +0200
Message-ID: <1476587514.1538.5.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


[ 6496.323071] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
[ 6496.323072] in_atomic(): 1, irqs_disabled(): 0, pid: 31807, name: sleep
[ 6496.323077] Preemption disabled at:[<ffffffff8148019b>] proc_exit_connector+0xbb/0x140
[ 6496.323077]
[ 6496.323080] CPU: 4 PID: 31807 Comm: sleep Tainted: G        W   E   4.8.0-rt11-rt #106
[ 6496.323081] Hardware name: IBM System x3550 M3 -[7944K3G]-/69Y5698     , BIOS -[D6E150AUS-1.10]- 12/15/2010
[ 6496.323084]  0000000000000000 ffff8801051d3d08 ffffffff813436cd 0000000000000000
[ 6496.323086]  ffff880167ccab80 ffff8801051d3d28 ffffffff8109c425 ffffffff81ce91c0
[ 6496.323088]  0000000000000000 ffff8801051d3d40 ffffffff816406b0 ffffffff81ce91c0
[ 6496.323089] Call Trace:
[ 6496.323092]  [<ffffffff813436cd>] dump_stack+0x65/0x88
[ 6496.323094]  [<ffffffff8109c425>] ___might_sleep+0xf5/0x180
[ 6496.323097]  [<ffffffff816406b0>] __rt_spin_lock+0x20/0x50
[ 6496.323100]  [<ffffffff81640978>] rt_read_lock+0x28/0x30
[ 6496.323103]  [<ffffffff8156e209>] netlink_broadcast_filtered+0x49/0x3f0
[ 6496.323106]  [<ffffffff81522621>] ? __kmalloc_reserve.isra.33+0x31/0x90
[ 6496.323109]  [<ffffffff8156e5cd>] netlink_broadcast+0x1d/0x20
[ 6496.323111]  [<ffffffff8147f57a>] cn_netlink_send_mult+0x19a/0x1f0
[ 6496.323114]  [<ffffffff8147f5eb>] cn_netlink_send+0x1b/0x20
[ 6496.323116]  [<ffffffff814801d8>] proc_exit_connector+0xf8/0x140
[ 6496.323119]  [<ffffffff81077f71>] do_exit+0x5d1/0xba0
[ 6496.323122]  [<ffffffff810785cc>] do_group_exit+0x4c/0xc0
[ 6496.323125]  [<ffffffff81078654>] SyS_exit_group+0x14/0x20
[ 6496.323127]  [<ffffffff81640a72>] entry_SYSCALL_64_fastpath+0x1a/0xa4

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 drivers/connector/cn_proc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -32,6 +32,7 @@
 #include <linux/pid_namespace.h>
 
 #include <linux/cn_proc.h>
+#include <linux/locallock.h>
 
 /*
  * Size of a cn_msg followed by a proc_event structure.  Since the
@@ -54,10 +55,12 @@ static struct cb_id cn_proc_event_id = {
 
 /* proc_event_counts is used as the sequence number of the netlink message */
 static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
+static DEFINE_LOCAL_IRQ_LOCK(send_msg_lock);
 
 static inline void send_msg(struct cn_msg *msg)
 {
-	preempt_disable();
+	/* RT ordering protection, maps to preempt_disable() for !RT */
+	local_lock(send_msg_lock);
 
 	msg->seq = __this_cpu_inc_return(proc_event_counts) - 1;
 	((struct proc_event *)msg->data)->cpu = smp_processor_id();
@@ -70,7 +73,7 @@ static inline void send_msg(struct cn_ms
 	 */
 	cn_netlink_send(msg, 0, CN_IDX_PROC, GFP_NOWAIT);
 
-	preempt_enable();
+	local_unlock(send_msg_lock);
 }
 
 void proc_fork_connector(struct task_struct *task)
