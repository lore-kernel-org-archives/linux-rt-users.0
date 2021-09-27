Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7FEC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DC66054F
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhI0IPD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:15:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55430 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhI0IPC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Sep 2021 04:15:02 -0400
Date:   Mon, 27 Sep 2021 10:13:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632730404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olmXqcwnilyf8UMNRXRvaYAkzzv4WVQHmukJHfOI2ME=;
        b=1tDZOEsSjMrB9xZZSO0Gxk5kvfSfKEjBLpBXT+jfXfqJnBRQbZ7Qi5piGbOtlFDiDoxvyy
        tXF2vbMC7mbQ65RX8PqZUPbAPqgSDgPUU3K7bZEffGbL20g58tgGcgoq4LYcYv77i4u351
        ngTERdbJAj+g9EFSauZF9gPDCrbyPU3aU1I8i0W6qu5EnAuXiJgbRDsxWZHjsBXvjwGnP0
        zz8ohn0dzStaaxf7kk0sWM3heSvXZ5cWHz8Hi2np4Oo28ecOkRDS3XuEJmbGacY+l4WHA+
        b/onmopXON+yndwm+NQrj2b5q//guP6aJ/yaaXvcgQC4oRjgcG2ahUfZcbfYvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632730404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olmXqcwnilyf8UMNRXRvaYAkzzv4WVQHmukJHfOI2ME=;
        b=+qttR1BUTXm0VeY/XgRvvmCDo27l2BlvJftvr92MRdqaJggz71DtKI+Gj1FzSRXSzR6MbH
        0uePTSU6qnw9UDDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: [PATCH] net: bridge: mcast: Associate the seqcount with its
 protecting lock.
Message-ID: <20210927081323.kkgflgmsitijf6tb@linutronix.de>
References: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
 <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
 <a105fecc71d4b721d4e025e2caf2b13336b5d0fc.camel@gmx.de>
 <87zgrzbcei.ffs@tglx>
 <27fee469d80baea697dd672808108cc8fd7ec96c.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27fee469d80baea697dd672808108cc8fd7ec96c.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 26 Sep 2021 17:10:45 +0200

The sequence count bridge_mcast_querier::seq is protected by
net_bridge::multicast_lock but seqcount_init() does not associate the
seqcount with the lock. This leads to a warning on PREEMPT_RT because
preemption is still enabled.

Let seqcount_init() associate the seqcount with lock that protects the
write section. Remove lockdep_assert_held_once() because lockdep checks
for the associated lock.

Fixes: 67b746f94ff39 ("net: bridge: mcast: make sure querier port/address updates are consistent")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Mike Galbraith <efault@gmx.de>
---

I would post this official unless there are objections.

 net/bridge/br_multicast.c | 6 ++----
 net/bridge/br_private.h   | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3523c8c7068fd..f3d751105343c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1677,8 +1677,6 @@ static void br_multicast_update_querier(struct net_bridge_mcast *brmctx,
 					int ifindex,
 					struct br_ip *saddr)
 {
-	lockdep_assert_held_once(&brmctx->br->multicast_lock);
-
 	write_seqcount_begin(&querier->seq);
 	querier->port_ifidx = ifindex;
 	memcpy(&querier->addr, saddr, sizeof(*saddr));
@@ -3867,13 +3865,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 
 	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
-	seqcount_init(&brmctx->ip4_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
-	seqcount_init(&brmctx->ip6_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
 	timer_setup(&brmctx->ip4_mc_router_timer,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b4cef3a97f12b..e8136db44462c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -82,7 +82,7 @@ struct bridge_mcast_other_query {
 struct bridge_mcast_querier {
 	struct br_ip addr;
 	int port_ifidx;
-	seqcount_t seq;
+	seqcount_spinlock_t seq;
 };
 
 /* IGMP/MLD statistics */
-- 
2.33.0

