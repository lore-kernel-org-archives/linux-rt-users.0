Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D68C00144
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jul 2022 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiG2QOz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2QOy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Jul 2022 12:14:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C988CC2
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Jul 2022 09:14:54 -0700 (PDT)
Date:   Fri, 29 Jul 2022 18:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659111292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMQuLoVe/ReXQNSkRYsq1VoKVO3P6mKdrhgUtd4FdkY=;
        b=lQv2Mu/olnupDhHrJrEVRSlAd+fkeX8nv3n7BLOicupyP5d/cQkjdNYZoe2wrropg1gOYh
        11U5lxbemkU+u0GCEdPMh9oZ/ljt8lzfLMbV6v1A/jOaJZhelY3fhRakrVjPsQEL98cfut
        d2UFyqbuesWg+h1iVX3fVb5IxZr4Ij5tlq5L84J3BKjzj0DGGcAJvzbEFHeatsjxSrnmnj
        fFwP3b1p4k+Zf0jI0FIlkhbKyvAgqJquG4TlNUYo9v07Bvmp0OhokY2wg7tRLtlAlCKNOS
        wvVIgW1RkQJ28i0Ks1bBbLAodXnyJyARPs46KlaKhwP+Loj3OKWQXLsUXSdaZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659111292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMQuLoVe/ReXQNSkRYsq1VoKVO3P6mKdrhgUtd4FdkY=;
        b=aPvGzugLKt32xzaRBOdn+eBoqNC4c7gdSY9MEoGKcprd330Avgzh6chM4HwICMfhLY1nQ5
        2JOQ3AMQtkQyptDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     David Oberhollenzer <goliath@infraroot.at>,
        linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
Message-ID: <YuQHe3g3Ydmljx7M@linutronix.de>
References: <20220712112238.18824-1-goliath@infraroot.at>
 <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-07-27 16:35:44 [-0400], Joseph Salisbury wrote:
> Hi David,
Hi,

> Do you know if these patches will be merged into the 5.15 patchset?

I'm going to look at these next week. Has this been tested?

> Thanks,
> 
> Joe

Sebastian
