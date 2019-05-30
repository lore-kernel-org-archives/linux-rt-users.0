Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9892C28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 02:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2C224436
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 02:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgDVGuh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE3CxD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 May 2019 22:53:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43070 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfE3CxC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 May 2019 22:53:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so5204544qtj.10
        for <linux-rt-users@vger.kernel.org>; Wed, 29 May 2019 19:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fU71rqvNXSjVzJ1kg940Zgx2CXM/eU2PTw3RotNO+h8=;
        b=JgDVGuh3CsJpqeo3QxkPK5Kcp+HYFqonbfVK0oEBLRHJXgZdmxQJHlyGV1JHW9C3gm
         CIFwztcX0ml8whxIrHWhPmsNdJkc1rKCL18j6wPiPANZy4yyAwO8U+IWdkhWWeQma/ZM
         udv5jp11UPfH9yvqCsVJprpv9hKZ2H4T7aECRoLPvtXkVHNsn6zvihUTVE8S5pGBLwbv
         OgZEZjRILtDgRoka+UrTx/8iYjDIk574W/Tp71E1C77aWoNVKwacJFk2koSHoLi6Bj77
         BIcY2FV2qQ5HDxMyYkgvsfqYWU53Y+26Hs/3NYCdy7DbDqYbF3WWKk/fmdV2SqvLvKrj
         pPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=fU71rqvNXSjVzJ1kg940Zgx2CXM/eU2PTw3RotNO+h8=;
        b=B0J2GIT6v8trQLDJlH11XoRLhpTQM9WVw2oGQBUfFRp2Yl2Y425YYVQmUBdmlsfboV
         fvelVKU6HXoIEUkJgtUIyeihEmp3UFzxfcfW3k4YTJIq5saDGpjPNDPEMmJufbSUIl73
         LR7hvzLyKFqil3hwsGDUO5+t/klk/RcX+Bf0msPCvlwNXr7DRG8B9ttfHY6EVUguJKnz
         PZQIOFN+e3NN0/GARfcUn/IJCKaZTsD4fUO2iD3CLdvEa3gs5jiaIa92IKcwpgyJLmEM
         A+uG481z6DENIkn0VrPXQaNZWINHd3Y4GtzLpmLP5AFIbVggdr2Zw1X5goTSMrGsbn1l
         r/DA==
X-Gm-Message-State: APjAAAXXfLPrwsO51KKLxNqRbrM2qE0YeLyMRPFDGn6Qd6EYUP9l8wjG
        /k31s7aLUdh5XpaDce6Z5FT/dzcr
X-Google-Smtp-Source: APXvYqzYSn77cpGFHnCP0xTzy2nK6V2pClgKqX/xi2zU9D9L2A2IsrAwTFaAY+DxVeBBYuar+nC4dA==
X-Received: by 2002:ac8:30a7:: with SMTP id v36mr1225578qta.119.1559184780553;
        Wed, 29 May 2019 19:53:00 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.181.235])
        by smtp.gmail.com with ESMTPSA id x1sm572581qkf.61.2019.05.29.19.52.58
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 19:52:58 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A3A1D3C16B6; Wed, 29 May 2019 23:52:54 -0300 (-03)
Date:   Wed, 29 May 2019 23:52:54 -0300
To:     linux-rt-users@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ping Fang <pifang@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT] mm/zswap: Do not disable preemption in
 zswap_frontswap_store()
Message-ID: <20190530025254.GE23690@uudg.org>
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
Tested:   Ran 70 consecutive repetitions of the reproducer listed above
          without any warning. Without this patch, every test run ends in
          a kernel panic, in less than 6 minutes.

diff --git a/mm/zswap.c b/mm/zswap.c
index a4e4d36..787f226 100644
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
+DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1066,7 +1069,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_cpu_var(zswap_dstmem);
+	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	tfm = *get_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
@@ -1094,7 +1097,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1122,7 +1125,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);

