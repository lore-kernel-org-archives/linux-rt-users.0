Return-Path: <SRS0=gFqs=B7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CDC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC76A20FC3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039238;
	bh=9s0dxQfEM7trRmPp4oaJKHOhthvJmZ+52qF9JNKKRZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=0sYzo+odw4mRKPaByvTszxVbqV6XCESwqZDcX8a0rytN/5awzB1jfDXXI3XGIVLMc
	 ILtd7LCYPEtpFVg6AKuZHYWnI/5/NbozfHT6JajtrMEmMkaI5Zxl4cBAdNoM5vZhnF
	 +q+4C9o+LCFu9HzM21hIKQ3qgbK49cA695PdgHSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUTrQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHUTrM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:12 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA24207DA;
        Fri, 21 Aug 2020 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039231;
        bh=9s0dxQfEM7trRmPp4oaJKHOhthvJmZ+52qF9JNKKRZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DMX4ZNLNASS/cpxY1+eFI5iYXYwgYMEkpbb5a0/DzOORLQgaeEe/tHKcOmzXNAdZ5
         cqUgWIG95DZwAXOV24Y3LLe6eJ2To7Ww+OLl+jedOdLgFNyuST8EFdoF3BItjt4gRj
         u/IPTZkgUYuRf4y+QoSL00F/6AexLfCMOvQEyDtU=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH RT 4/5] net: xfrm: fix compress vs decompress serialization
Date:   Fri, 21 Aug 2020 14:47:03 -0500
Message-Id: <962434cf5eb6c4c469df413b2312b8ae80e3906d.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

v4.19.135-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 net/xfrm/xfrm_ipcomp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a00ec715aa46..a97997385423 100644
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
2.17.1

