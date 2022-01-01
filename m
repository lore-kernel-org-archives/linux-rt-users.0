Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2DC433F5
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 Jan 2022 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiAAVSo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 1 Jan 2022 16:18:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbiAAVSo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Jan 2022 16:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641071923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfinJrBVuVKxezw2axzeYyy3h3zEaU7q681zxGonGgs=;
        b=BGFzg3cAlGsdKX0h+zc/QdOAeCX8iABvd9ghB9MwDRC5mDcD5RlUL3jkJ9hsWOuHtzjIYx
        YAvu2c47TS9ozgBfaXNIPDw3in01GOmI552woPgbgz7HjUuu90pDc5jttIb3c0Z/eK5jLS
        iozk5WPzwwC97B00LzQbqL9UP1GNXhE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-QuencM62NeqFImzMgrekAQ-1; Sat, 01 Jan 2022 16:18:42 -0500
X-MC-Unique: QuencM62NeqFImzMgrekAQ-1
Received: by mail-qt1-f198.google.com with SMTP id h13-20020ac87d4d000000b002af9c496444so22249636qtb.22
        for <linux-rt-users@vger.kernel.org>; Sat, 01 Jan 2022 13:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VfinJrBVuVKxezw2axzeYyy3h3zEaU7q681zxGonGgs=;
        b=eO1ng+kGklc5X3Oybyl4rq1woJNZPkqO9oaD2j+IYW0i7OWm1vWH1K9EThxlPueo5s
         aqzD0LeGwg2mmva4WkbI5DN5F3ia0BCHyMTUVb04o1XPipgYGKo5l/4DtiNIjLaWhWM9
         BMwMEBkbqb2H0XgVBctpSyqOlq2Sn3zk6d2+0DNenCMM5iQyrjMyxuFEcdP0xKk39CPB
         5v9SRFYtv3JK7fLgOj/tx8kG/CM52Y/XnDW2rpQWgNRJpvkUXkDw9ksIpGxZPCnCpG7G
         CvHoVyF1HIBA0O+dODrvSo+XHeFErxc/60CrLAXpZ95eOrvsjygU5pohTVC70CRLs+7n
         QVWQ==
X-Gm-Message-State: AOAM530HGH3M82rlHh/Aek4MqvFNawnzU6x9A7GxLbURZcMLe4sgKavO
        msCmC2pP6+WzIUWKxVVtx4BGLlP7XikopgrHt0d+3c8V8QBLBI0X4y4MZ1DlxXJZmqwnot2b4MI
        4kIW57p0FLjLRQf5sUTEb/hsThpo=
X-Received: by 2002:a05:6214:2346:: with SMTP id hu6mr13895643qvb.31.1641071922219;
        Sat, 01 Jan 2022 13:18:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzk6Xq8ZCCh9EOeHKqgP1uGwqHBtvWGqpj+gmjMDIKexDgVlBFYgQbjoWQoqos9NOzr+F5LCQ==
X-Received: by 2002:a05:6214:2346:: with SMTP id hu6mr13895634qvb.31.1641071922064;
        Sat, 01 Jan 2022 13:18:42 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-130.dsl.bell.ca. [174.88.120.130])
        by smtp.gmail.com with ESMTPSA id s4sm24797516qko.47.2022.01.01.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 13:18:41 -0800 (PST)
Date:   Sat, 1 Jan 2022 16:18:40 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
cc:     williams@redhat.com, peterx@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: oslat.8: Remove the argument of --bias
In-Reply-To: <TYCP286MB19139F2712AF29EB517F70FBA1459@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <dcdb4ae0-d44c-4a3a-1342-8c832749d8fc@redhat.com>
References: <TYCP286MB19139F2712AF29EB517F70FBA1459@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 30 Dec 2021, Oscar Shiang wrote:

> The option --bias does not require an argument and the bias should
> be estimated later.
> 
> There is no need to provide USEC to --bias option.
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  src/oslat/oslat.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
> index 4b28abd..39b36df 100644
> --- a/src/oslat/oslat.8
> +++ b/src/oslat/oslat.8
> @@ -18,7 +18,7 @@ TSC information and measuring the time frequently during the process.
>  .B \-b, \-\-bucket-size=N
>  Specify the number of the buckets (4-1024).
>  .TP
> -.B \-B, \-\-bias=USEC
> +.B \-B, \-\-bias
>  Add a bias to all the buckets using the estimated mininum.
>  .TP
>  .B \-c, \-\-cpu-list=CPULIST
> -- 
> 2.25.1
> 
> 
Signed-off-by: John Kacur <jkacur@gmail.com>

