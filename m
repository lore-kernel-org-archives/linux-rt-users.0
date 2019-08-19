Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EFC3A5A0
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FB820851
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 12:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHSM20 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfHSM20 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 08:28:26 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E579C0740CD
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2019 12:28:25 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a17so5178792wrr.10
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2019 05:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tSDNac3IpC0XQfaKU1b+CVQPA8G8Z+zM6tWLA7ESmuw=;
        b=oW/bojSzO+gdkt0rcxBbyVr7euY7Tv+ypCsQ14jQ4IAFaDg69RfRDagEo4/t78JVjo
         yzwu2jYlCPGbafe5pqVdSaeCyBPmYhH+sFutZg25fIiXvV4AvkBlo80iR7vmnXWl509o
         cOPUpvpMoCGxEJQYBudqOzcjwxriblQzv2EU4RGM+GgxNh1dNEjfRQ3QdAkNCgPXLooJ
         OIqWwIZ/0fJSqJjiXNrO1Uxjy2vhVw3ornVl9aGpTvvWWVOGethmOg5bIQCPFKF6EGIB
         vMk7LMGYJeRXdzLztxebmhou5H8v5SIYJY2C8eGmGTpRVReXtVrAmKrhA/rGHuMkhk0t
         EunQ==
X-Gm-Message-State: APjAAAWGJO6TJez2tC0hC1k9Q4VFUpvisz89Er4Ad4AHGi+HvOwrptbk
        vd1EZWF+bE8/aWv3xxuqNO6AIif7Bugg8SmTIanrhFS2SlvGE/+UUpUmXUouWMJyk6F7nzjfcuh
        IkIVxKg1Zqmz0y1AWgTNO2zesGNw=
X-Received: by 2002:adf:e50b:: with SMTP id j11mr27033322wrm.65.1566217703715;
        Mon, 19 Aug 2019 05:28:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbJc9Pv12kuOIGbz/OiAksBhRVlbykjC6o6V6asCfOI5oBSHZNvEVhEHAcN97DlgvE5s8zKw==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr27033285wrm.65.1566217703342;
        Mon, 19 Aug 2019 05:28:23 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id a6sm11074431wmj.15.2019.08.19.05.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 05:28:22 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with local_lock
Date:   Mon, 19 Aug 2019 14:27:31 +0200
Message-Id: <20190819122731.6600-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The following BUG has been reported while running ipsec tests.

 BUG: scheduling while atomic: irq/78-eno3-rx-/12023/0x00000002
 Modules linked in: ipcomp xfrm_ipcomp ...
 Preemption disabled at:
 [<ffffffffc0b29730>] ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
 CPU: 1 PID: 12023 Comm: irq/78-eno3-rx- Kdump: loaded Not tainted [...] #1
 Hardware name: [...]
 Call Trace:
  dump_stack+0x5c/0x80
  ? ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
  __schedule_bug.cold.81+0x44/0x51
  __schedule+0x5bf/0x6a0
  schedule+0x39/0xd0
  rt_spin_lock_slowlock_locked+0x10e/0x2b0
  rt_spin_lock_slowlock+0x50/0x80
  get_page_from_freelist+0x609/0x1560
  ? zlib_updatewindow+0x5a/0xd0
  __alloc_pages_nodemask+0xd9/0x280
  ipcomp_input+0x299/0x9a0 [xfrm_ipcomp]
  xfrm_input+0x5e3/0x960
  xfrm4_ipcomp_rcv+0x34/0x50
  ip_local_deliver_finish+0x22d/0x250
  ip_local_deliver+0x6d/0x110
  ? ip_rcv_finish+0xac/0x480
  ip_rcv+0x28e/0x3f9
  ? packet_rcv+0x43/0x4c0
  __netif_receive_skb_core+0xb7c/0xd10
  ? inet_gro_receive+0x8e/0x2f0
  netif_receive_skb_internal+0x4a/0x160
  napi_gro_receive+0xee/0x110
  tg3_rx+0x2a8/0x810 [tg3]
  tg3_poll_work+0x3b3/0x830 [tg3]
  tg3_poll_msix+0x3b/0x170 [tg3]
  net_rx_action+0x1ff/0x470
  ? __switch_to_asm+0x41/0x70
  do_current_softirqs+0x223/0x3e0
  ? irq_thread_check_affinity+0x20/0x20
  __local_bh_enable+0x51/0x60
  irq_forced_thread_fn+0x5e/0x80
  ? irq_finalize_oneshot.part.45+0xf0/0xf0
  irq_thread+0x13d/0x1a0
  ? wake_threads_waitq+0x30/0x30
  kthread+0x112/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x35/0x40

The problem resides in the fact that get_cpu(), called from
ipcomp_input() disables preemption, and that triggers the scheduling
while atomic BUG further down the callpath chain of
get_page_from_freelist(), i.e.,

  ipcomp_input
    ipcomp_decompress
      <-- get_cpu()
      alloc_page(GFP_ATOMIC)
        alloc_pages(GFP_ATOMIC, 0)
          alloc_pages_current
            __alloc_pages_nodemask
              get_page_from_freelist
                (try_this_zone:) rmqueue
                  rmqueue_pcplist
                    __rmqueue_pcplist
                      rmqueue_bulk
                        <-- spin_lock(&zone->lock) - BUG

Fix this by replacing get_cpu() with a local lock to protect
ipcomp_scratches buffers used by ipcomp_(de)compress().

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

--
This v2 applies to v4.19.59-rt24.

v1 -> v2: Use a local lock instead of {get,put}_cpu_light(), as the
latter doesn't protect against multiple CPUs invoking (de)compress
function at the same time, thus concurently working on the same scratch
buffer.
---
 net/xfrm/xfrm_ipcomp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a00ec715aa46..3b4a38febf0a 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -18,6 +18,7 @@
 #include <linux/crypto.h>
 #include <linux/err.h>
 #include <linux/list.h>
+#include <linux/locallock.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
@@ -35,6 +36,7 @@ struct ipcomp_tfms {
 };
 
 static DEFINE_MUTEX(ipcomp_resource_mutex);
+static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
 static void * __percpu *ipcomp_scratches;
 static int ipcomp_scratch_users;
 static LIST_HEAD(ipcomp_tfms_list);
@@ -45,12 +47,14 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	const int plen = skb->len;
 	int dlen = IPCOMP_SCRATCH_SIZE;
 	const u8 *start = skb->data;
-	const int cpu = get_cpu();
-	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);
-	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
-	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
-	int len;
+	u8 *scratch;
+	struct crypto_comp *tfm;
+	int err, len;
 
+	local_lock(ipcomp_scratches_lock);
+	scratch = *this_cpu_ptr(ipcomp_scratches);
+	tfm = *this_cpu_ptr(ipcd->tfms);
+	err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
 	if (err)
 		goto out;
 
@@ -103,7 +107,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	err = 0;
 
 out:
-	put_cpu();
+	local_unlock(ipcomp_scratches_lock);
 	return err;
 }
 
@@ -146,6 +150,7 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
+	local_lock(ipcomp_scratches_lock);
 	scratch = *this_cpu_ptr(ipcomp_scratches);
 	tfm = *this_cpu_ptr(ipcd->tfms);
 	err = crypto_comp_compress(tfm, start, plen, scratch, &dlen);
@@ -158,12 +163,14 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 
 	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
 	return 0;
 
 out:
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 	return err;
 }
-- 
2.17.2

