Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16708C04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D0C613EE
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhEUVbr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhEUVbn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621632620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaGHfLJF+C6XYztZI9wKxiydXVMdr6otMdf1NfO/n+o=;
        b=BUpgiTkrD1Ro4+0sn+Pkdq6Nmo/fsjDNkP9XHb8l8jWy3hxTJp+bYdv2ZaNlWEz9Gko9Vz
        2XyFdi3bUA1IbserginmtVxFqwKKHTt1oIsFuvCsu02N8fFzIjq392cA5PQfMHAJJrG+BW
        bd5wZAo0C6kPsK8ykujayZt0r6E7JsY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-vJi9MHVgOQmj61P_BnuYig-1; Fri, 21 May 2021 17:30:16 -0400
X-MC-Unique: vJi9MHVgOQmj61P_BnuYig-1
Received: by mail-qt1-f199.google.com with SMTP id z14-20020ac8710e0000b029020e9ce69225so5942847qto.7
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=IaGHfLJF+C6XYztZI9wKxiydXVMdr6otMdf1NfO/n+o=;
        b=MEzqGswvuIx/YVmrLxgMGtFZOFIDqGUu7OjT9Neik23txiQRnoCg5rZEb8zMEk4Mk2
         9m7JSCmEkqlv9rgO7mQHVaqXEXfLrjJ9n1lRZsXdn9RtTa1gOrzYts7F3s1d3JL43gtA
         veUCFNt6q/Kwg9AmPQfk1ocAwye4vx9XSqkjNQ7kN++T9xjt8B7x+yWhIsL5xS8jZE1t
         c9gANSKIhaMvb0NhTPe4gAUiCzzPiu4p48aSa9u29INtRSazQUnKGEQSF9L0RuodarO1
         WResO+6zNP9bGQzoo3h4uakii90rjCBv68rPB6ieL0lsyVpnbvOWTqqLFSHGGd9RiQ2V
         5y9A==
X-Gm-Message-State: AOAM533nHq0tHxx1+IEbvRd0UADwsYtO5VSoW8m7jiyOx5ao60J8s5qW
        Fzx49HCp7mT/mxjaLVitxyghvjRv+ZFRLNyC7Q51xXbJAwkhs3Z2pxQzQGR9jtwZejTYhUIPnun
        OZFEL5VIznLLBM+U+zkbWIp8TwD8=
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr13981985qtw.258.1621632615853;
        Fri, 21 May 2021 14:30:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKqS0fYu/o8ZGM6Y6+PfGQ/GHN59vKFAFZtVuJeirz6OdwW1zAiUW/SyfhDk0nqTezVXIHQw==
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr13981968qtw.258.1621632615674;
        Fri, 21 May 2021 14:30:15 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x11sm746105qkh.129.2021.05.21.14.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:30:15 -0700 (PDT)
Date:   Fri, 21 May 2021 17:30:14 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 01/23] cyclicdeadline: Fix JSON output
 format
In-Reply-To: <20210519170945.21941-2-dwagner@suse.de>
Message-ID: <aaf373-194d-b5dc-484-baa84f4a18c8@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> Add missing comma after the max entry.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 8d801b4c154a..b81fb3a2091d 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -977,7 +977,7 @@ static void write_stats(FILE *f, void *data)
>  		fprintf(f, "    \"%u\": {\n", i);
>  		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
>  		fprintf(f, "	 \"min\": %ld,\n", s->min);
> -		fprintf(f, "	 \"max\": %ld\n", s->max);
> +		fprintf(f, "	 \"max\": %ld,\n", s->max);
>  		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
>  		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
>  	}
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

