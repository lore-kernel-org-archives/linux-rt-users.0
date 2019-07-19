Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B7C76197
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E26218C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbfGSVuM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388796AbfGSVuA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:50:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C3D218B6;
        Fri, 19 Jul 2019 21:49:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalK-000866-HC; Fri, 19 Jul 2019 17:49:58 -0400
Message-Id: <20190719214958.420525053@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com,
        stable-rt@vger.kernel.org, Ping Fang <pifang@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH RT 15/16] mm/zswap: Do not disable preemption in zswap_frontswap_store()
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>

[ Upstream commit 4e4cf4be79635e67144632d9135286381acbc95a ]

Zswap causes "BUG: scheduling while atomic" by blocking on a rt_spin_lock() with
preemption disabled. The preemption is disabled by get_cpu_var() in
zswap_frontswap_store() to protect the access of the zswap_dstmem percpu variable.

Use get_locked_var() to protect the percpu zswap_dstmem variable, making the
code preemptive.

As get_cpu_ptr() also disables preemption, replace it by this_cpu_ptr() and
remove the counterpart put_cpu_ptr().

Steps to Reproduce:

    1. # grubby --args "zswap.enabled=1" --update-kernel DEFAULT
    2. # reboot
    3. Calculate the amount o memory to be used by the test:
       ---> grep MemAvailable /proc/meminfo
       ---> Add 25% ~ 50% to that value
    4. # stress --vm 1 --vm-bytes ${MemAvailable+25%} --timeout 240s

Usually, in less than 5 minutes the backtrace listed below appears, followed
by a kernel panic:

| BUG: scheduling while atomic: kswapd1/181/0x00000002
|
| Preemption disabled at:
| [<ffffffff8b2a6cda>] zswap_frontswap_store+0x21a/0x6e1
|
| Kernel panic - not syncing: scheduling while atomic
| CPU: 14 PID: 181 Comm: kswapd1 Kdump: loaded Not tainted 5.0.14-rt9 #1
| Hardware name: AMD Pence/Pence, BIOS WPN2321X_Weekly_12_03_21 03/19/2012
| Call Trace:
|  panic+0x106/0x2a7
|  __schedule_bug.cold+0x3f/0x51
|  __schedule+0x5cb/0x6f0
|  schedule+0x43/0xd0
|  rt_spin_lock_slowlock_locked+0x114/0x2b0
|  rt_spin_lock_slowlock+0x51/0x80
|  zbud_alloc+0x1da/0x2d0
|  zswap_frontswap_store+0x31a/0x6e1
|  __frontswap_store+0xab/0x130
|  swap_writepage+0x39/0x70
|  pageout.isra.0+0xe3/0x320
|  shrink_page_list+0xa8e/0xd10
|  shrink_inactive_list+0x251/0x840
|  shrink_node_memcg+0x213/0x770
|  shrink_node+0xd9/0x450
|  balance_pgdat+0x2d5/0x510
|  kswapd+0x218/0x470
|  kthread+0xfb/0x130
|  ret_from_fork+0x27/0x50

Cc: stable-rt@vger.kernel.org
Reported-by: Ping Fang <pifang@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/zswap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cd91fd9d96b8..420225d3ff0b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/locallock.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/frontswap.h>
@@ -990,6 +991,8 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+/* protect zswap_dstmem from concurrency */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1066,12 +1069,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_cpu_var(zswap_dstmem);
-	tfm = *get_cpu_ptr(entry->pool->tfm);
+	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
 	kunmap_atomic(src);
-	put_cpu_ptr(entry->pool->tfm);
 	if (ret) {
 		ret = -EINVAL;
 		goto put_dstmem;
@@ -1094,7 +1096,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1122,7 +1124,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
-- 
2.20.1


