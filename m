Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762BC48BD5
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E982133F
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAV2X/cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfFYO2K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:28:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35108 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYO2J (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 10:28:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so3222895qto.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jun 2019 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LPgAAEytgBUY+/ycdy8MfZLh+wNts6WhNe7WAmvr/t8=;
        b=BAV2X/cjCK/62pTNwpc+BUKkrNKIIho57F3/d4SEWF6n/fXa02oU88Ze2LXskeF6BH
         XMQTc/6EiKUl5BtgQNOZLFYyvAHv52wbdhKVBc886cNnh7l4a4M/zUGQdA2Qn19UChdG
         2R3hjul4DADA/NtscGKqGFIcIHkYdIxjtkqNGthMk5jMXOWe/bYaxDQ8LNjMo5rpIOCq
         jezUjfVSm2+Ka7bLDSyy4eUEr6Ed5/jCRjrpj9FLY1Zxyu+aXhcbqCRqDh1f497+82u3
         pIE/dVr1haNCcnmAz4TO2v5WUym6Dh0q+6ix61jseYIR5MxSYg0o3EIRgkJUwUO2erI7
         Jsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=LPgAAEytgBUY+/ycdy8MfZLh+wNts6WhNe7WAmvr/t8=;
        b=nygmfNCQUbx2EMg8UJYQFkS1rK/w6zQ1PDqYpE7mY89BPvAEYqosI2dxce+6xcESiS
         TBdttxMHlTPtpVeZNe7JQsF98ot668HVKCeOt1xDlogFZ7ioq0ozHi0XZcxsEHccAEwN
         VC/59skOaRTtft5b0E4pjN77VSCFTZhVluO2towU2M1WIVTT/9xHh63F0IVduaxU4xlI
         5k9HqgTCLe39e7y7T4GWb9YpygrnRHh1P7D5UL/Wd+x8QMw8/LHKTAYwhMYgqx1/516y
         x1ZzCb0ZamwZqjjiLaxgFxx64Ta6N+o+pkbbu4TD0Pc6UDyNtbJXtsjifhHITjQ/wT0b
         v5nw==
X-Gm-Message-State: APjAAAUMiRVyJk6ECQX27IJDyO7GpiUBRiorTia04ec3KJHbHYCDoZNv
        w0WnmNacoQqBZdS3dOmJtkfU8yBu
X-Google-Smtp-Source: APXvYqxrIN2kjDMkEuYhaz30VWK5Im2lJl/nIJpEwP9lK/e6WISKYv6hTkN5IBnP8UDzszgvdP49nw==
X-Received: by 2002:a0c:b7a8:: with SMTP id l40mr32170445qve.142.1561472888390;
        Tue, 25 Jun 2019 07:28:08 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.181.0])
        by smtp.gmail.com with ESMTPSA id l5sm8085935qte.9.2019.06.25.07.28.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:28:07 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id B3C353C0017; Tue, 25 Jun 2019 11:28:04 -0300 (-03)
Date:   Tue, 25 Jun 2019 11:28:04 -0300
To:     linux-rt-users@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ping Fang <pifang@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH V3 RT] mm/zswap: Do not disable preemption in
 zswap_frontswap_store()
Message-ID: <20190625142804.GH4902@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

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

[26747.628830] 014: BUG: scheduling while atomic: kswapd1/181/0x00000002
[26747.834904] 014: 
[26747.839778] 014: Preemption disabled at:
[26747.845598] 014: [<ffffffff8b2a6cda>] zswap_frontswap_store+0x21a/0x6e1
[26747.856103] 014: 
[26747.864619] 014: Kernel panic - not syncing: scheduling while atomic
[26747.872859] 014: CPU: 14 PID: 181 Comm: kswapd1 Kdump: loaded Not tainted 5.0.14-rt9 #1
[26747.880832] 014: Hardware name: AMD Pence/Pence, BIOS WPN2321X_Weekly_12_03_21 03/19/2012
[26747.888977] 014: Call Trace:
[26747.891847] 014:  dump_stack+0x85/0xc0
[26747.895584] 014:  panic+0x106/0x2a7
[26747.899063] 014:  ? zswap_frontswap_store+0x21a/0x6e1
[26747.904093] 014:  __schedule_bug.cold+0x3f/0x51
[26747.908605] 014:  __schedule+0x5cb/0x6f0
[26747.912513] 014:  schedule+0x43/0xd0
[26747.916073] 014:  rt_spin_lock_slowlock_locked+0x114/0x2b0
[26747.921538] 014:  rt_spin_lock_slowlock+0x51/0x80
[26747.926225] 014:  zbud_alloc+0x1da/0x2d0
[26747.930132] 014:  zswap_frontswap_store+0x31a/0x6e1
[26747.934992] 014:  __frontswap_store+0xab/0x130
[26747.939417] 014:  swap_writepage+0x39/0x70
[26747.943496] 014:  pageout.isra.0+0xe3/0x320
[26747.947666] 014:  shrink_page_list+0xa8e/0xd10
[26747.952092] 014:  shrink_inactive_list+0x251/0x840
[26747.956866] 014:  shrink_node_memcg+0x213/0x770
[26747.961379] 014:  ? preempt_count_sub+0x98/0xe0
[26747.965891] 014:  ? preempt_count_sub+0x98/0xe0
[26747.970402] 014:  shrink_node+0xd9/0x450
[26747.974309] 014:  balance_pgdat+0x2d5/0x510
[26747.978477] 014:  kswapd+0x218/0x470
[26747.982038] 014:  ? finish_wait+0x70/0x70
[26747.986033] 014:  kthread+0xfb/0x130
[26747.989595] 014:  ? balance_pgdat+0x510/0x510
[26747.993934] 014:  ? kthread_park+0x90/0x90
[26747.998012] 014:  ret_from_fork+0x27/0x50

Reported-by: Ping Fang <pifang@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
Tested:   Ran back-to-back repetitions of the reproducer during 10 hours,
          with the V3 patch applied, and no errors were observed. Without
          this patch, every test run ends in a kernel panic, in less than
          5 minutes.

diff --git a/mm/zswap.c b/mm/zswap.c
index a4e4d36ec085..fd5d2d5c9ae9 100644
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
