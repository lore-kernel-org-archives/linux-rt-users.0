Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B26C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C692184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294034;
	bh=0javQJG2N3SRtmKFfgxuYv2z4xXZJpn03rwbSlHoIYI=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=d9wurqXu3CkF8QBnwJ+qyzKb1bLSIBEDtyYsVNzgXPBacawkQIIEbL7cNDvBqmDLe
	 tTGTyV6LKselY5w+Bp89jtdUP/4gmi0pG4UsFyZgGFTe12yQM/CcFKKvutSbPDcBIN
	 QO/dgbr/22I5lyeNxQeA+GLCnpfxdsBqfUWGQz60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfHHTxv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404578AbfHHTx2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:28 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6886C218F0;
        Thu,  8 Aug 2019 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294007;
        bh=0javQJG2N3SRtmKFfgxuYv2z4xXZJpn03rwbSlHoIYI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AETXDqgdWcwPV8/00USmsuErKGQPUdHnHjBPGE4JmYeGqPXXyLZnKa4buFff9cpNA
         eElUd6YYElCI90r+2EdKJmMmUvju+X0mGuHp8sTVs3q5vvxGG8NTs9g24yfbEhZz1u
         wp7usgwid3Md1e8x/bwouZPJlTRl5HtK7Y0l4mBw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 18/19] mm/zswap: Do not disable preemption in zswap_frontswap_store()
Date:   Thu,  8 Aug 2019 14:52:46 -0500
Message-Id: <15236d55deeb510c997d4057a4585eb6a755be80.1565293935.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
        mm/zswap.c
---
 mm/zswap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ebb0bc88c5f7..a2b4e14f851c 100644
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
@@ -953,6 +954,8 @@ static int zswap_shrink(void)
 	return ret;
 }
 
+/* protect zswap_dstmem from concurrency */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1016,12 +1019,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1045,7 +1047,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	buf = (u8 *)(zhdr + 1);
 	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1072,7 +1074,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
-- 
2.14.1

