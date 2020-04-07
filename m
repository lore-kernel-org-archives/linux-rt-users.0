Return-Path: <SRS0=ghNa=5X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99C7C2BB55
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A877D2076E
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP9l+rmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgDGOyj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:54:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38226 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOyi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Apr 2020 10:54:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so1899993qke.5
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2020 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qLXjpTFC3hR7177L880TMC0sQ/REQpLwIH4t+fEvCqk=;
        b=pP9l+rmiznHo3ypJK2pzs0JF4ELjIBwH8ufPkRtSEZuVNQOuaf3oxivlVRPYeoNldJ
         oi6OVxoUYfsF6vuqFUg7uiBzS5hS3JkTnQ5GhRpfHJDjWe4GV6MARSDQ/C5EBlxoZOSk
         Eav20TipArCEWtiviVffGuFwkgerRoUFKt+B6iMz4UlNt7/vlBvR3zPyARjvNGSQH/1a
         /NR4y5AsyYswDWVd4acVxb50I01v9xNKgqznSzU5TxASuIB++Jla64fl67RE9rymBQ+L
         QiLPJXy+0W7tbTAj99SWP+/DC2UYYO0ZLsz/iMtFVopkM6w6u/sIdDvxNhH8JQblH83s
         qdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=qLXjpTFC3hR7177L880TMC0sQ/REQpLwIH4t+fEvCqk=;
        b=dNtebg2wOIe/zriJYZrEgclmpxdFMx0Oh7BcsIRDNdvwdzWLnPdeNEVYpEI0JKW4LG
         QLvUfN0k9DpIY7qV4Fid5MbKWIJcnFrwPR7MTtTUKKu9gtjm1oLbYFg7c2LjBvUlXZtj
         9t6Xymhkbh1Gmvur5zJKuJ1pKgt8OAeqBfqD0p6ZEoGJcwPAV4SDwy50oxQIR5nABH0H
         55CqoFNydEGNTodQ/DA9yYzLsHY40XI1yjLjk5X5p2GGhZirOXMzvBKELcxRdTYoIX9i
         jtlVvPWqjhchgGFwymCSXQMWn2o4OziTaTGpFkN0bKypgsjZbXSCfKLBQYAhQSNomDkF
         mg6w==
X-Gm-Message-State: AGi0PuZ9uJjzfT+bqq3Xp1nIDaMHP8JDxWp6cyigFLJCWTqAPiVVLBh8
        DAodjj43ujSGAz7UnsTyoEs=
X-Google-Smtp-Source: APiQypIhxPJ7upCeL4TOTXYtDzUmWCDO3afWSLa2UIYBDU/GhlGroNPx8D3R7pMDnXUGFmDCwKb/YQ==
X-Received: by 2002:a05:620a:1014:: with SMTP id z20mr2530684qkj.56.1586271277521;
        Tue, 07 Apr 2020 07:54:37 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id l18sm17107728qke.132.2020.04.07.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:54:37 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:54:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Scott Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RTEVAL PATCH 2/3] Makefile: Use parentheses around print args
In-Reply-To: <20200406221405.3043-2-swood@redhat.com>
Message-ID: <alpine.LFD.2.21.2004071054050.6907@planxty>
References: <20200406221405.3043-1-swood@redhat.com> <20200406221405.3043-2-swood@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 6 Apr 2020, Scott Wood wrote:

> Otherwise, this fails on python3.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index f91e6e06a9a4..479bda8d8674 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -5,7 +5,7 @@ else
>  	PYTHON = python2
>  endif
>  PACKAGE :=	rteval
> -VERSION :=      $(shell $(PYTHON) -c "from rteval import RTEVAL_VERSION; print RTEVAL_VERSION")
> +VERSION :=      $(shell $(PYTHON) -c "from rteval import RTEVAL_VERSION; print(RTEVAL_VERSION)")
>  D	:=	10
>  
>  # XML-RPC related files
> -- 
> 2.18.2
> 
> 

Tested by running the default target (runit)

Thanks for fixing

Signed-off-by: John Kacur <jkacur@redhat.com>
