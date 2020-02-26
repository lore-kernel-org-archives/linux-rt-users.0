Return-Path: <SRS0=ak3V=4O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A131DC4BA13
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Feb 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7826E206E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Feb 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+NKy6Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgBZRSi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:18:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39683 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBZRSi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Feb 2020 12:18:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id p34so19438qtb.6
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2020 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4D3H4Il/dymdhYlZYtrvLqQdPjYaUUGsjOxlnMFC4+M=;
        b=c+NKy6FuNyRtJvKrsU7N3crECz6HJ50tqgB3dcG+L4vJ7C9/rMHB10xQjLTmeDUf+S
         TTV1BZEd/94gWp2MpuZk6VL99ElPr9Yj1tsdwxDG9e9pFkDJy6E9AYBbUEG+T30TCoAK
         RX3PimZbQbrDe0uqUvMEMwpICt5lFP4MbE5KP4+gD6Wx2GjcRoiFfHF65X91zZCJRrKV
         S1rg27EtT3y/G7JMpg3Z4YpAINyWzkWEOHMC9GOHhitnFezmCfgriV+lVoB45zTVSYVI
         1S4ZlwIvNSy0jBcGE5hwxBUxrnoPQGL5XpAp1K7IRWYB6iKKcM5JSEaRdBozrv8EGX1H
         Gu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=4D3H4Il/dymdhYlZYtrvLqQdPjYaUUGsjOxlnMFC4+M=;
        b=Iq7uNjWAMaY9PipMIOXoF0o1e9o9wcoJSlo10dgfvsZdBrLnOXbeWxSOSTmi7dZjvi
         tL58QqaX+My6iY3t5K/R061/2bqGjmd/icigcyHwxuGtUJz0WX9FYwgkDgsUbr9VWBOH
         qKpGUKMPrgZsCbmKCTRrBN8BDl+H/KySkFuVr2u5JfWaelvMQY73KZbAx4VdwII0MxLM
         dy8pf+9AzCdLle2slHE8sBX7JaY7ZM5Tn5HgSCAtXli7QJkBpkaJUHd0yk1TVuACIhdQ
         Ge1Q+b+K7CdH+GEAsRvin4TrtxMeSvmXFhtVYZLKGAct9eh1Ulo8EJadAj7etnxXhc0i
         xiHg==
X-Gm-Message-State: APjAAAXkbKxWrgMPrGLOHe4b8c0YHHAKwXjHJGbFv7Yel5qUwAjtShnm
        N095fkP7EPH/bFAO4qc03E/HEaGsLlc=
X-Google-Smtp-Source: APXvYqwXOdD8XWWs3RZJ2K7YM9xNBnB4Uni8Xe1lJoVtrbQOP8dG6Aa77dXEdwPeBQNcwpoNpm+LBw==
X-Received: by 2002:aed:20f1:: with SMTP id 104mr5921912qtb.121.1582737517031;
        Wed, 26 Feb 2020 09:18:37 -0800 (PST)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id h123sm1459520qkd.125.2020.02.26.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:18:36 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:18:29 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     "Jeremy A. Puhlman" <jpuhlman@mvista.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests][PATCH] rt-tests: make manpages builds reproducible
In-Reply-To: <20200225234230.17232-1-jpuhlman@mvista.com>
Message-ID: <alpine.LFD.2.21.2002261217460.9967@planxty>
References: <20200225234230.17232-1-jpuhlman@mvista.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 25 Feb 2020, Jeremy A. Puhlman wrote:

> From: Jeremy Puhlman <jpuhlman@mvista.com>
> 
> Add -n to gzip call to make the build output
> of the manpages reproducible.
> 
> Signed-off-by: Jeremy A. Puhlman <jpuhlman@mvista.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8747971..1b37ba7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -181,7 +181,7 @@ ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  %.8.gz: %.8
> -	gzip -c $< > $@
> +	gzip -nc $< > $@
>  
>  %.8.bz2: %.8
>  	bzip2 -c $< > $@
> -- 
> 2.20.1
> 
> 

Could you explain to me how this makes the build output of manpages more 
reproducible?

Thanks

John
