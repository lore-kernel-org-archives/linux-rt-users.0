From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch-3.18.7-rt1]sunrpc: make svc_xprt_do_enqueue() use
 get_cpu_light()
Date: Wed, 18 Feb 2015 16:05:28 +0100
Message-ID: <1424271928.6903.3.camel@gmail.com>
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

[   37.667792] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   37.720307] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:915
[   37.720307] in_atomic(): 1, irqs_disabled(): 0, pid: 3194, name: rpc.nfsd
[   37.720318] Preemption disabled at:[<ffffffffa06bf0bb>] svc_xprt_received+0x4b/0xc0 [sunrpc]

[   37.720320] CPU: 6 PID: 3194 Comm: rpc.nfsd Not tainted 3.18.7-rt1 #9
[   37.720320] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.404 11/06/2014
[   37.720321]  ffff880409630000 ffff8800d9a33c78 ffffffff815bdeb5 0000000000000002
[   37.720322]  0000000000000000 ffff8800d9a33c98 ffffffff81073c86 ffff880408dd6008
[   37.720322]  ffff880408dd6000 ffff8800d9a33cb8 ffffffff815c3d84 ffff88040b3ac000
[   37.720323] Call Trace:
[   37.720326]  [<ffffffff815bdeb5>] dump_stack+0x4f/0x9e
[   37.720328]  [<ffffffff81073c86>] __might_sleep+0xe6/0x150
[   37.720329]  [<ffffffff815c3d84>] rt_spin_lock+0x24/0x50
[   37.720335]  [<ffffffffa06beec0>] svc_xprt_do_enqueue+0x80/0x230 [sunrpc]
[   37.720340]  [<ffffffffa06bf0bb>] svc_xprt_received+0x4b/0xc0 [sunrpc]
[   37.720345]  [<ffffffffa06c03ed>] svc_add_new_perm_xprt+0x6d/0x80 [sunrpc]
[   37.720349]  [<ffffffffa06b2693>] svc_addsock+0x143/0x200 [sunrpc]
[   37.720351]  [<ffffffff810b6f47>] ? __getnstimeofday64+0x37/0xd0
[   37.720352]  [<ffffffff810b6fee>] ? getnstimeofday64+0xe/0x30
[   37.720353]  [<ffffffff810b702a>] ? do_gettimeofday+0x1a/0x50
[   37.720356]  [<ffffffffa072e69c>] write_ports+0x28c/0x340 [nfsd]
[   37.720358]  [<ffffffff812bcfe7>] ? debug_smp_processor_id+0x17/0x20
[   37.720361]  [<ffffffff811512c7>] ? might_fault+0x47/0x50
[   37.720363]  [<ffffffffa072e410>] ? write_versions+0x320/0x320 [nfsd]
[   37.720365]  [<ffffffffa072d2ac>] nfsctl_transaction_write+0x4c/0x80 [nfsd]
[   37.720366]  [<ffffffff8117ee83>] vfs_write+0xb3/0x1d0
[   37.720368]  [<ffffffff814c5082>] ? release_sock+0x152/0x1a0
[   37.720369]  [<ffffffff8117f889>] SyS_write+0x49/0xb0
[   37.720371]  [<ffffffff815c4556>] system_call_fastpath+0x16/0x1b

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 net/sunrpc/svc_xprt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -357,7 +357,7 @@ static void svc_xprt_do_enqueue(struct s
 		return;
 	}
 
-	cpu = get_cpu();
+	cpu = get_cpu_light();
 	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
 	spin_lock_bh(&pool->sp_lock);
 
@@ -390,7 +390,7 @@ static void svc_xprt_do_enqueue(struct s
 	}
 
 	spin_unlock_bh(&pool->sp_lock);
-	put_cpu();
+	put_cpu_light();
 }
 
 /*
