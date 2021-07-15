Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B15C47E48
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Jul 2021 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55654613C7
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Jul 2021 13:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhGONgP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhGONgP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Jul 2021 09:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEF1A613C4;
        Thu, 15 Jul 2021 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626356002;
        bh=9QwJkNJ0EKcP628qDiVl++4c0qoQ5PnIEsAAlvMgoJE=;
        h=Subject:To:Cc:From:Date:From;
        b=O2xa9oEDXAXdtduYUZ6qXCfKldFwhYYUfz4wnaxxHg2sj7hyEuTZGbeTyuG7DA0G9
         dfRCcSpQFPXNxNn1/Ecm9wA650pyeqk6W0SKimq7nc9jsKznXFvCzHXBuUZiLrGeW/
         2CwjWoVSSOBYYESowlBlIYiCi1J5tcxhng2d/pR8=
Subject: FAILED: patch "[PATCH] xfrm: policy: Read seqcount outside of rcu-read side in" failed to apply to 4.19-stable tree
To:     varad.gautam@suse.com, a.darwish@linutronix.de,
        davem@davemloft.net, fw@strlen.de, herbert@gondor.apana.org.au,
        kuba@kernel.org, linux-rt-users@vger.kernel.org,
        steffen.klassert@secunet.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jul 2021 15:33:20 +0200
Message-ID: <16263560005972@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7b0408934c749f546b01f2b33d07421a49b6f3e Mon Sep 17 00:00:00 2001
From: Varad Gautam <varad.gautam@suse.com>
Date: Fri, 28 May 2021 18:04:06 +0200
Subject: [PATCH] xfrm: policy: Read seqcount outside of rcu-read side in
 xfrm_policy_lookup_bytype

xfrm_policy_lookup_bytype loops on seqcount mutex xfrm_policy_hash_generation
within an RCU read side critical section. Although ill advised, this is fine if
the loop is bounded.

xfrm_policy_hash_generation wraps mutex hash_resize_mutex, which is used to
serialize writers (xfrm_hash_resize, xfrm_hash_rebuild). This is fine too.

On PREEMPT_RT=y, the read_seqcount_begin call within xfrm_policy_lookup_bytype
emits a mutex lock/unlock for hash_resize_mutex. Mutex locking is fine, since
RCU read side critical sections are allowed to sleep with PREEMPT_RT.

xfrm_hash_resize can, however, block on synchronize_rcu while holding
hash_resize_mutex.

This leads to the following situation on PREEMPT_RT, where the writer is
blocked on RCU grace period expiry, while the reader is blocked on a lock held
by the writer:

Thead 1 (xfrm_hash_resize)	Thread 2 (xfrm_policy_lookup_bytype)

				rcu_read_lock();
mutex_lock(&hash_resize_mutex);
				read_seqcount_begin(&xfrm_policy_hash_generation);
				mutex_lock(&hash_resize_mutex); // block
xfrm_bydst_resize();
synchronize_rcu(); // block
		<RCU stalls in xfrm_policy_lookup_bytype>

Move the read_seqcount_begin call outside of the RCU read side critical section,
and do an rcu_read_unlock/retry if we got stale data within the critical section.

On non-PREEMPT_RT, this shortens the time spent within RCU read side critical
section in case the seqcount needs a retry, and avoids unbounded looping.

Fixes: 77cc278f7b20 ("xfrm: policy: Use sequence counters with associated lock")
Signed-off-by: Varad Gautam <varad.gautam@suse.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # v4.9
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Acked-by: Ahmed S. Darwish <a.darwish@linutronix.de>

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b74f28cabe24..8c56e3e59c3c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2092,12 +2092,15 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	if (unlikely(!daddr || !saddr))
 		return NULL;
 
-	rcu_read_lock();
  retry:
-	do {
-		sequence = read_seqcount_begin(&xfrm_policy_hash_generation);
-		chain = policy_hash_direct(net, daddr, saddr, family, dir);
-	} while (read_seqcount_retry(&xfrm_policy_hash_generation, sequence));
+	sequence = read_seqcount_begin(&xfrm_policy_hash_generation);
+	rcu_read_lock();
+
+	chain = policy_hash_direct(net, daddr, saddr, family, dir);
+	if (read_seqcount_retry(&xfrm_policy_hash_generation, sequence)) {
+		rcu_read_unlock();
+		goto retry;
+	}
 
 	ret = NULL;
 	hlist_for_each_entry_rcu(pol, chain, bydst) {
@@ -2128,11 +2131,15 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	}
 
 skip_inexact:
-	if (read_seqcount_retry(&xfrm_policy_hash_generation, sequence))
+	if (read_seqcount_retry(&xfrm_policy_hash_generation, sequence)) {
+		rcu_read_unlock();
 		goto retry;
+	}
 
-	if (ret && !xfrm_pol_hold_rcu(ret))
+	if (ret && !xfrm_pol_hold_rcu(ret)) {
+		rcu_read_unlock();
 		goto retry;
+	}
 fail:
 	rcu_read_unlock();
 

