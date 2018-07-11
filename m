Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:52471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbeGKPTo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Jul 2018 11:19:44 -0400
Message-ID: <1531322087.12761.33.camel@gmx.de>
Subject: [4.16-rt patch] crypto: scompress - serialize RT percpu scratch
 buffer access with a local lock
From: Mike Galbraith <efault@gmx.de>
Date: Wed, 11 Jul 2018 17:14:47 +0200
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>


[   26.767879] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[   26.767881] in_atomic(): 1, irqs_disabled(): 0, pid: 1401, name: cryptomgr_test
[   26.767883] Preemption disabled at:
[   26.767895] [<ffff00000849941c>] scomp_acomp_comp_decomp+0x34/0x1a0
[   26.767902] CPU: 21 PID: 1401 Comm: cryptomgr_test Tainted: G        W        4.16.18-rt9-rt #1
[   26.767903] Hardware name: www.cavium.com crb-1s/crb-1s, BIOS 0.3 Apr 25 2017
[   26.767905] Call trace:
[   26.767908]  dump_backtrace+0x0/0x1c8
[   26.767910]  show_stack+0x24/0x30
[   26.767916]  dump_stack+0xac/0xe8
[   26.767923]  ___might_sleep+0x124/0x188
[   26.767927]  rt_spin_lock+0x40/0x88
[   26.767939]  zip_load_instr+0x44/0x170 [thunderx_zip]
[   26.767950]  zip_deflate+0x184/0x378 [thunderx_zip]
[   26.767956]  zip_compress+0xb0/0x130 [thunderx_zip]
[   26.767968]  zip_scomp_compress+0x48/0x60 [thunderx_zip]
[   26.767974]  scomp_acomp_comp_decomp+0xd8/0x1a0
[   26.767976]  scomp_acomp_compress+0x24/0x30
[   26.767978]  test_acomp+0x15c/0x558
[   26.767981]  alg_test_comp+0xc0/0x128
[   26.767988]  alg_test.part.6+0x120/0x2c0
[   26.767990]  alg_test+0x6c/0xa0
[   26.767992]  cryptomgr_test+0x50/0x58
[   26.767995]  kthread+0x134/0x138
[   26.767998]  ret_from_fork+0x10/0x18

Mainline disables preemption to serialize percpu scratch buffer access,
causing the splat above.  Serialize with a local lock for RT instead.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 crypto/scompress.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -24,6 +24,7 @@
 #include <linux/cryptouser.h>
 #include <net/netlink.h>
 #include <linux/scatterlist.h>
+#include <linux/locallock.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/acompress.h>
 #include <crypto/internal/scompress.h>
@@ -34,6 +35,7 @@ static void * __percpu *scomp_src_scratc
 static void * __percpu *scomp_dst_scratches;
 static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
+static DEFINE_LOCAL_IRQ_LOCK(scomp_scratches_lock);
 
 #ifdef CONFIG_NET
 static int crypto_scomp_report(struct sk_buff *skb, struct crypto_alg *alg)
@@ -146,7 +148,7 @@ static int scomp_acomp_comp_decomp(struc
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	const int cpu = get_cpu();
+	const int cpu = local_lock_cpu(scomp_scratches_lock);
 	u8 *scratch_src = *per_cpu_ptr(scomp_src_scratches, cpu);
 	u8 *scratch_dst = *per_cpu_ptr(scomp_dst_scratches, cpu);
 	int ret;
@@ -181,7 +183,7 @@ static int scomp_acomp_comp_decomp(struc
 					 1);
 	}
 out:
-	put_cpu();
+	local_unlock_cpu(scomp_scratches_lock);
 	return ret;
 }
 
