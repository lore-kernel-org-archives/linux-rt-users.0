Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF7C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Sep 2021 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55D760F44
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Sep 2021 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhIZPM2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhIZPMY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C712C061575
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Sep 2021 08:10:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632669045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnplyvWyxnR6F++laozuRCz3CoQ3kHJFgDmxVAQUv+s=;
        b=jeXE+aNLl3dc9EsQAqNJ3C309fSiERMnlPRqr4CKuE09tCojfmZQ3rEf2eZ3GjQNT6tLfE
        vC7Sd8/2MbWyaWxTuh62UPmV9ieSSyb6PbFvynY68x74xjKi6D/CinmhcM0QAb2VI/JeAR
        FFXLg1RYV0pP0O7PeUJy4OSGD9iO/3ICrDAeptKiRlWCFf1xEP4as3J1vz9VJ//fSAE8l/
        7Sz+AkcvldBezbOBoDcsD2ml1P7Ji1W6ntknQ1cMG5jCvjB13S5cu6rJMa6RBFyMBex/1O
        xc1pZN0zHR70ZUdWoLYBEsxMfNPJKT9hJAxval9xM/lG2wgHWd8NSSEPWw/2kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632669045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnplyvWyxnR6F++laozuRCz3CoQ3kHJFgDmxVAQUv+s=;
        b=uKo8a3DtKQHOfzL5SKdS50Tm9w1Md6wdCikPLiWUMpUPN4NIKSOKlayqbXhk0eiIor2AHl
        dCEjYO5cPufyQwCw==
To:     Mike Galbraith <efault@gmx.de>, RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] Re: v5.15-rc2-rt3:  WARNING: CPU: 0 PID: 12 at
 ./include/linux/seqlock.h:271
In-Reply-To: <a105fecc71d4b721d4e025e2caf2b13336b5d0fc.camel@gmx.de>
References: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
 <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
 <a105fecc71d4b721d4e025e2caf2b13336b5d0fc.camel@gmx.de>
Date:   Sun, 26 Sep 2021 17:10:45 +0200
Message-ID: <87zgrzbcei.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Sep 26 2021 at 06:05, Mike Galbraith wrote:
> On Fri, 2021-09-24 at 07:22 +0200, Mike Galbraith wrote:
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1679,10 +1679,14 @@ static void br_multicast_update_querier(
>  {
>  	lockdep_assert_held_once(&brmctx->br->multicast_lock);
>
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();

That sequence count is protected by brmctx->br->multicast_lock, but
seqcount_init() does not associate the lock.

Untested below should cure it properly.

Thanks,

        tglx
---
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1677,8 +1677,6 @@ static void br_multicast_update_querier(
 					int ifindex,
 					struct br_ip *saddr)
 {
-	lockdep_assert_held_once(&brmctx->br->multicast_lock);
-
 	write_seqcount_begin(&querier->seq);
 	querier->port_ifidx = ifindex;
 	memcpy(&querier->addr, saddr, sizeof(*saddr));
@@ -3867,13 +3865,13 @@ void br_multicast_ctx_init(struct net_br
 
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
