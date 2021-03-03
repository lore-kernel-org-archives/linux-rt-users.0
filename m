Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6C9C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1719364DDA
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355263AbhCDAVv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhCDAAr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 19:00:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D12C0613DF
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 15:29:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b130so14356225qkc.10
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2021 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5EFncusB7kSv25FYRl/ukrH1GO+toldQ+cNrcH7tCO8=;
        b=CBicoQTSgG+KJ8gTSYy8OkiU1IKyUIE4WUq2f1ulU7DabWYF+plu3AQfXRo2zc0cOP
         gJoljDoJi44/fkWWjZTbthhTQfScd0+SZsrnCUnlCwrpVgWXKJHYfZ5Z20J/7y6JlFOx
         TB3Cf5fX0+9ENWT7vsO9x9eIzUHzcjkRQ+5lJcmmsclK7hxE9HfNUB0nuE9YlB+qzHmg
         Pcx7GRqvhheUB22rtW8haSyGHtxqn4H4Tl22URCQQ2hAkF+D/8TzFiRGNjs8oxDLsho8
         qbCbTPeGhUA9gal0ROLmuoE860iWy5y5mTxserz26L01MEpscHqAHu8d07BL3H+7XPov
         hHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=5EFncusB7kSv25FYRl/ukrH1GO+toldQ+cNrcH7tCO8=;
        b=CIURWU0IVtH42aQqYtPhhIkR1ISDwIRJ+H1q76hqbKyqePJJi3i7KA6JB5tTNkwagu
         qPJDGHmwTBoJE9m7oIfZYE2d2LL1BUSsiKp0J8FRfEhsOLl3iB+srZmI9aMPzQITjRcX
         OAOVSKn26m37+I7/3N48Cg/5YHvznFMcdyBZ+ZsdJc48+hzI5KZXxF3AfDe1RWfRrsdW
         5ypSXBReC0unj9tRrz7MZCtz8TSG12DYyL/mqnuCY4nzzL5yTIr3nV6y9p11hKpMJ9Zl
         IUsNOY4KfTeaprPD83+79/Lluo5YXGV7uwbW9foC5ng/3UfJ8wx5vlvJQSjwqmd+30Po
         aV0A==
X-Gm-Message-State: AOAM530h5s8aTzcbXKHsJ/zPd60DjwXa3t9071h/4UwSESdAnlmlzfSS
        Mf7wgp0wG1CZrVuNtaNjaKIMpVsJACUW3eZz
X-Google-Smtp-Source: ABdhPJyNgmGpxE1ChiRvygaq5nY+aag/TMLwYhZcywRvm0yWODSYLvCzL5wJY//2Cjt921EfAhQsIw==
X-Received: by 2002:a05:620a:4050:: with SMTP id i16mr1531306qko.473.1614814198480;
        Wed, 03 Mar 2021 15:29:58 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id f8sm16080295qth.6.2021.03.03.15.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:29:58 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 3 Mar 2021 18:29:57 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 2/2] cyclicdeadline.c: Fix printf format
 specifier
In-Reply-To: <20210219163340.6290-3-dwagner@suse.de>
Message-ID: <69c89f85-2aae-d14c-62b-1ad0a6a44913@redhat.com>
References: <20210219163340.6290-1-dwagner@suse.de> <20210219163340.6290-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Daniel Wagner wrote:

> The fields are not uint64 just longs, update the printf format
> specifiers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index ed3c960d9916..bb8ffc3642bc 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -978,9 +978,9 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < nr_threads; i++) {
>  		s = &sd[i].stat;
>  		fprintf(f, "    \"%u\": {\n", i);
> -		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
> +		fprintf(f, "	 \"min\": %ld,\n", s->min);
> +		fprintf(f, "	 \"max\": %ld\n", s->max);
>  		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
>  		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
>  	}
> -- 
> 2.30.0
> 
> 

    Also Reported-by: Signed-off-by: Christian Eggers <ceggers@arri.de>
    Signed-off-by: John Kacur <jkacur@redhat.com>

