Return-Path: <SRS0=5BY9=B4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B783C433E3
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A7C2076E
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHRQeH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:34:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgHRQd4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Aug 2020 12:33:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA248AC46;
        Tue, 18 Aug 2020 16:34:20 +0000 (UTC)
Date:   Tue, 18 Aug 2020 09:20:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -RT 4.x] net: xfrm: fix compress vs decompress serialization
Message-ID: <20200818162053.3zu6toupxooygbz7@linux-p48b>
References: <20200814173700.1532-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200814173700.1532-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A crash was seen in xfrm when running ltp's 'tcp4_ipsec06' stresser on v4.x
based RT kernels.

ipcomp_compress() will serialize access to the ipcomp_scratches percpu buffer by
disabling BH and preventing a softirq from coming in and running ipcom_decompress(),
which is never called from process context. This of course won't work on RT and
the buffer can get corrupted; there have been similar issues with in the past with
such assumptions, ie: ebf255ed6c44 (net: add back the missing serialization in
ip_send_unicast_reply()).

Similarly, this patch addresses the issue with locallocks allowing RT to have a
percpu spinlock and do the correct serialization.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
This applies on top of all v4.x based kernels -rt.

 net/xfrm/xfrm_ipcomp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index ccfdc7115a83..f13871de6e0d 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/locallock.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -36,6 +37,7 @@ struct ipcomp_tfms {
 
 static DEFINE_MUTEX(ipcomp_resource_mutex);
 static void * __percpu *ipcomp_scratches;
+static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
 static int ipcomp_scratch_users;
 static LIST_HEAD(ipcomp_tfms_list);
 
@@ -45,12 +47,15 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
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
+
+	local_lock(ipcomp_scratches_lock);
 
+	scratch = *this_cpu_ptr(ipcomp_scratches);
+	tfm = *this_cpu_ptr(ipcd->tfms);
+	err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
 	if (err)
 		goto out;
 
@@ -103,7 +108,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	err = 0;
 
 out:
-	put_cpu();
+	local_unlock(ipcomp_scratches_lock);
 	return err;
 }
 
@@ -146,6 +151,8 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
+	local_lock(ipcomp_scratches_lock);
+
 	scratch = *this_cpu_ptr(ipcomp_scratches);
 	tfm = *this_cpu_ptr(ipcd->tfms);
 	err = crypto_comp_compress(tfm, start, plen, scratch, &dlen);
@@ -158,12 +165,14 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
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
2.26.2

