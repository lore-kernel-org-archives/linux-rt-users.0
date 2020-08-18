Return-Path: <SRS0=5BY9=B4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B6C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E6207D3
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Amcp0iQg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krfp/bs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRQDT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgHRQDF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Aug 2020 12:03:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9BC061389
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2020 09:03:04 -0700 (PDT)
Date:   Tue, 18 Aug 2020 18:03:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597766582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+9BMMFN5Z8RWdd1tXDQqy7gCeeSJRwgol3Sm3eUVvE=;
        b=Amcp0iQgY2FouPLKgAxU9+R5BPxABb77F/Q5eyIJAfvPmcEF56yWTJaEhpdDoc9+HT+rzK
        c2Y/roOCXeiD+1Eh50Y0o/I1V9ROFx6hpZ2fAHYrE4Dt8GHP72q9tU+4d5s9IAbkohuTWD
        KkSgzSWM5VtDRnML4PC7Z7YwaOaf7vc/3En5My0S/YWbOxbQT2ys49ufABI4cxYNfZPWaz
        hjyLZpawtBb5YoaaYZkhW5rh6volJ+Xjz3v5opXQmurqJ1Dnjdsm3CtLyNveACnjKtMVOb
        uzGme3wb5eK4uB3uUGM2QyOpHMaE+F/DhmPKlKwv0IZR/u3RCPrY6burvjfEAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597766582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+9BMMFN5Z8RWdd1tXDQqy7gCeeSJRwgol3Sm3eUVvE=;
        b=krfp/bs0hXdm9nqvSVtOy8pE5Pq6ljHlWW8x+VnMQl1dUguY70GYz6+BzJAgEsznkH3kNB
        EPQX1vTwrqLSjeAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-rt-users@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH -RT] net: xfrm: fix compress vs decompress serialization
Message-ID: <20200818160300.lgrect6qy2qdfave@linutronix.de>
References: <20200814173700.1532-1-dave@stgolabs.net>
 <20200817144754.5lyhn3xtenigvfbd@linutronix.de>
 <20200818154250.evbjaxzdyzh7oz7b@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818154250.evbjaxzdyzh7oz7b@linux-p48b>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-18 08:42:50 [-0700], Davidlohr Bueso wrote:
> On Mon, 17 Aug 2020, Sebastian Andrzej Siewior wrote:
> > So what you are saying that this patch isn't needed v5.0.19-rt10+
> > because local_bh_disable() acts there as a lock. Repost is then with Tom
> > in Cc because he will be the first one to apply to the v4.19 tree. And
> > please shrink the patch description to a sane amount of information.
> 
> Sure, but which Tom are you refering to?

Tom Zanussi (Cc:). The v4.19 kernel is top most kernel which requires
the change [0]. So it should start with Tom and drop down.

[0] as per https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

> Thanks,
> Davidlohr

Sebastian
