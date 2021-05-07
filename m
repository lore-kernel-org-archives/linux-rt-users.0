Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1ABC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994A66144F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbhEGQaP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhEGQaN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:30:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C926C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:29:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k127so9020546qkc.6
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3wKXzBPDQ9Q6u5QB6fHZyRuvfoSMLB9aBR8pZNkxfac=;
        b=k7A1eNOeTmVGCgds+Ceeqc4uPtanV9ugVmG+cpEnMUv8cDDEWGsL4GvwedLQ7elkqi
         O06W66kFpCxK8dUF59Tt5n718bQgJcJ0pCKZjD/xCyhbRcOwVaNBuQiMAAVGJlMzHoJz
         eZcQnqPITSwAf36Tn6nb62rhNOs8fZya19FIEtcV4fuBaJ6+p7ICpckNcEIxHkbJ3JEO
         kqDtDmfYLgCYbrOJ58gqdopRJ2jW/dKDeY2gzZvXVwsap6apPTE1ZLEgzu2kt/v+nWRy
         /WUpSyPjcdQlvGSTS+xHnM0tnKuOoHlOCwz6PLYl4NGedtD30hm5Ufk6TEMYm+RSW2KK
         kjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=3wKXzBPDQ9Q6u5QB6fHZyRuvfoSMLB9aBR8pZNkxfac=;
        b=kpD/P/8tnOWw2rtcewUpsVqtoT87SBtOKuBQTQqCv/na6Of6UIS9A9G+PaJHHBz9hc
         V3w/W9nbH47qOv0ylIT9qMtEud07ZEM1TAbahuPoEZ3XCUHmDwDaOboJhD5p9OSNMT9s
         1LpLpHpWv7fqTG4SJl7lCAu3b/sbKj5FUWjNHFHXYxRYCML0YQhl0bj1UIJgLFa0vfWC
         0lRnnWyBr4O9y9hf6QuH8A1bZC6eUTAZfSQrQMW8lde4K9gW6EE9cSm2wL3Ao+pYrnxH
         QjyGTgdH99fQP753tZDdwW64YEHjS0G+tn7yPzm4nsUxjDGzyefTbQ6C61Qzz9OJG0MA
         tg/Q==
X-Gm-Message-State: AOAM5321mFqtis8DJMgAEIeFmjzxaWSgTFS9FWy4jl1OzccczGn0HhTT
        fPlSe4IS0WMzKUDgcuotgDw=
X-Google-Smtp-Source: ABdhPJxSjdigGyqX5ecKt9D6rM3Ya+ECuAFv1CXXe5aqSM3sCpxaOYkHqRf3YRPJhZFz1qomst+GvQ==
X-Received: by 2002:a37:7246:: with SMTP id n67mr9874029qkc.71.1620404952736;
        Fri, 07 May 2021 09:29:12 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id o135sm4912330qke.124.2021.05.07.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:29:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:29:11 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 06/33] oslat: Initialize rt-util
In-Reply-To: <20210320183829.1318-7-dwagner@suse.de>
Message-ID: <44646c3c-1653-e7e0-7b3f-c8df14f5f4fb@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Allow rt-util make a copy of the command line.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 465a694cdd1d..da7b25d48384 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -796,6 +796,8 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> +	rt_init(argc, argv);
> +
>  	g.app_name = argv[0];
>  	g.rtprio = 0;
>  	g.bucket_size = BUCKET_SIZE;
> -- 
> 2.30.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
