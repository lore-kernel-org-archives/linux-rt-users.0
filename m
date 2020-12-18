Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C7EC3526D
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 23:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6423BA8
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 23:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLRXUU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 18:20:20 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:60420 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgLRXUR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 18:20:17 -0500
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DC4258E9A53;
        Sat, 19 Dec 2020 00:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1608333575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAV0Fn6ArK/ifbmD3DpCR6NZTO8ZE/t/wY+YI/Y7IGU=;
        b=nE1fiiu53rcxLe3WGM4ptprNIJzSIkkGtmxk9cELSi9OSCY7SQrvKY2ew5E/FYGQ/nh0yn
        ian+log1Fxpa7QfLL49ozILNJ+nvjc83KM0mY1S2ayzmP4JPjWS7a1V/6mJb2LDJjRmwxR
        iYmUCpoi6MfRU7q6lmj3r4vX1RXdcSY=
Date:   Sat, 19 Dec 2020 00:19:34 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-mm@kvack.org, lkml@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, akpm@linux-foundation.org
Subject: Re: [PATCH 0/3] z3fold: stability / rt fixes
Message-ID: <20201218231934.nwdj6zok2fndgexk@spock.localdomain>
References: <20201209145151.18994-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209145151.18994-1-vitaly.wool@konsulko.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 09, 2020 at 04:51:48PM +0200, Vitaly Wool wrote:
> This patchset addresses z3fold stability issues under stress load,
> primarily in the reclaim and free aspects. Besides, it fixes the
> locking problems that were only seen in real-time kernel
> configuration.
> 
> Vitaly Wool (2):
>   z3fold: simplify freeing slots
>   z3fold: stricter locking and more careful reclaim
> 
> Mike Galbraith (1):
>   z3fold: Remove preempt disabled sections for RT
> 
>  mm/z3fold.c | 191 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 96 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 

Thanks for addressing this!

(I'd appreciate Cc'ing me on this though since I was the one who
reported it initially...)

-- 
  Oleksandr Natalenko (post-factum)
