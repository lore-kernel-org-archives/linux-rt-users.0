Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB19C433E3
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D35420789
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7WNfn0w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nW4lVn/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgHQOr6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgHQOr6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 10:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C979EC061389
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2020 07:47:57 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:47:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597675675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UvOQe0GW43AKOQ/7HR55jUwUt4nh2eVzRqmR8mUpBo=;
        b=T7WNfn0w07Tdb2hMa0ZSzhcqb76na5OAOT6QjHrRqCidrMhx+RTFQirwPUr8mVRWkrXlLo
        Hoqm3rau5rOi4BigdPhngKSHbY3KtXZgp23vuXmGzuI0W4SMPj6wFgzKy7TmT1hYsEWgXn
        0GAsX8v3yeHZA46QuU5V1ljDxajof+iTPGo3vS0AVNiu5cV9vwZ8+PFOaGJ5WIjH/jg3uL
        NlPHlDhqGLhKo3mB7JwJS2fwOjduynP3vnwwWUDHCn5HOKrBxwzms//tE9PLX2gpxVRj8J
        Y51kbbsTHLOnW08hpKqyyuC3T8Dow32oAo1yeApDNijzYsBZQe4+Xm41KZaBTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597675675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UvOQe0GW43AKOQ/7HR55jUwUt4nh2eVzRqmR8mUpBo=;
        b=nW4lVn/PVLEoSFAb6YzkP/r/L+JqYdmG40FiqVs28+o7yXyRdyZAzZKOwMPpKZPNr9y2Ji
        poct/v2aSNaGqSDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-rt-users@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -RT] net: xfrm: fix compress vs decompress serialization
Message-ID: <20200817144754.5lyhn3xtenigvfbd@linutronix.de>
References: <20200814173700.1532-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814173700.1532-1-dave@stgolabs.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-14 10:37:00 [-0700], Davidlohr Bueso wrote:
> ipcomp_compress() will serialize access to the ipcomp_scratches percpu buffer by
> disabling BH and preventing a softirq from coming in and running ipcom_decompress(),
> which is never called from process context. This of course won't work on RT and
> the buffer can get corrupted; there have been similar issues with in the past with
> such assumptions, ie: ebf255ed6c44 (net: add back the missing serialization in
> ip_send_unicast_reply()).
> 
> Similarly, this patch addresses the issue with locallocks allowing RT to have a
> percpu spinlock and do the correct serialization.
> 
> Addressing such races on an individual basis seemed like a game of whack a mole,
> until afaict local_bh_enable() was reworked to use locallocks in 96fac673174
> (softirq: Add preemptible softirq) which is why the BUG is not seen in newer kernels.

So what you are saying that this patch isn't needed v5.0.19-rt10+
because local_bh_disable() acts there as a lock. Repost is then with Tom
in Cc because he will be the first one to apply to the v4.19 tree. And
please shrink the patch description to a sane amount of information.

For upstream, could you please get rid of get_cpu() in
ipcomp_decompress()? If that function is always called with BH disabled
then something like this_cpu_ptr() would be enough. Also I highly
discourage code where half of the stuff is done in the part of the
function where you define local variables.
Removing get_cpu() would be nice because some implementation of
crypto_comp_decompress() acquire sleeping locks. That would be:
- nx842_crypto_decompress()
- zip_comp_decompress()
- nx842_crypto_decompress()

> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> 
> This applies on top of all v4.x based kernels -rt.

Sebastian
