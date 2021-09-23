Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A6C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E2E610D1
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 19:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbhIWTcm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242796AbhIWTcl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 15:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632425469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f349V6ryxmLk5wWM8MYArstMA5Vu3uG9DpQoZGm70UM=;
        b=U+Gf+kpCeju+xWPPsqYukswUwhwjYdRJHSRDhFROUc8ta4Rn3BoNNZDGpDzqayeo8GLeqJ
        RoopXxGeWKngQq6/mFkR5rkKjBmaq1Vt2ToKF3PWHUDDLjbeh3Gbo4fzq4+YbWnaD+i6lN
        FZ7+n0p7WJhGa6IW34OrKiWR5m1PvJs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-NTtMla-XNpGcANkla53H0w-1; Thu, 23 Sep 2021 15:31:08 -0400
X-MC-Unique: NTtMla-XNpGcANkla53H0w-1
Received: by mail-qv1-f71.google.com with SMTP id cf6-20020a05621403e600b0037a70d2f960so22451941qvb.13
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 12:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=f349V6ryxmLk5wWM8MYArstMA5Vu3uG9DpQoZGm70UM=;
        b=YfnzIeHHlKBhcKAFpEgliw8cbAm5Ia6qslm93R4SOEW74yHsO7conwYwgCqsEIgh7T
         2ROGhjYc7SG7B/2svLyNORSygSMk7/JM1xXdYQVZLkNF/80YAhBLB6LkZyGq8LYDtunQ
         iqr2YK7XCmQPb5TPk5JzyrvR51Jn6/+5y2CrIkt7ofEaxpBFp5p16tfMo032T8LnwLM5
         I+4FZBUZBxbEEb5xhZ0XLpBwzMy7CR6nSbCi5DjSXWDImH/zysKXDn5ntWBO17elnCSG
         /UnaQW3BPHZRgxYMQyYVLnjmBJmD+F3Gzb/qqJgUgu5oy5Cauv3qo+smWNNBWuF8jBXt
         hqmQ==
X-Gm-Message-State: AOAM532wC1ZEzLU10+r8Dv6Jq4meWmkRiYub9L5Gu+rjZ6diM4gduKLs
        +kKKs/8nUYqxXC1LJviMxYKiG1xN1LLT8bq5u8BT3IB91Q128c8K0oFj8iNx4IYtxurCXgZdfCh
        6iW83ezlZbUaBd2JelvMCy5WhtEY=
X-Received: by 2002:a37:94c4:: with SMTP id w187mr6815346qkd.136.1632425467757;
        Thu, 23 Sep 2021 12:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9XpVm4oHibk2PBTpUMwCXhast8qJ1Wfenr8NK+XjNojeFlQD/n/XkKdyK1YtS3qbPZEEbxA==
X-Received: by 2002:a37:94c4:: with SMTP id w187mr6815337qkd.136.1632425467596;
        Thu, 23 Sep 2021 12:31:07 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-75.dsl.bell.ca. [184.147.140.75])
        by smtp.gmail.com with ESMTPSA id 134sm4897628qkn.108.2021.09.23.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:31:07 -0700 (PDT)
Date:   Thu, 23 Sep 2021 15:31:06 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     venkata pyla <venkata.pyla@toshiba-tsip.com>
cc:     punit1.agrawal@toshiba.co.jp, daniel.sangorrin@toshiba.co.jp,
        dinesh.kumar@toshiba-tsip.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: kcompile.py: Relax the requirement for kernel
 tarball filename
In-Reply-To: <20210922171740.8939-1-venkata.pyla@toshiba-tsip.com>
Message-ID: <f735b9b-3a71-7ccf-fbaa-e6aab76748ff@redhat.com>
References: <20210922171740.8939-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 22 Sep 2021, venkata.pyla@toshiba-tsip.com wrote:

> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The kcompile module includes kernel version when looking for tarballs
> or source folders. This necessitates periodically bumping the
> kernel_prefix but also requires the user to provide particular version
> of the kernel sources when using this workload. As the intent is to
> generate a compile workload the source version used shouldn't matter.
> 
> To make life easier both for users and developers, relax the
> requirement for specific version of kernel sources when using
> kcompile.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  rteval/modules/loads/kcompile.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 8d08a3d..be40a62 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -35,7 +35,7 @@ from rteval.Log import Log
>  from rteval.misc import expand_cpulist, compress_cpulist
>  from rteval.systopology import SysTopology
>  
> -kernel_prefix = "linux-5.13"
> +kernel_prefix = "linux"
>  
>  class KBuildJob:
>      '''Class to manage a build job bound to a particular node'''
> -- 
> 2.20.1
> 
> 
> 

It shouldn't be onerous for a developer to grab the right version of the 
kernel from kernel.org and save it in loadsource

As for users, they are probably getting rteval from a distribution.
In Fedora and rhel we split it out into two packages.
rteval and rteval-loads. rteval-loads has the correct kernel version.

The idea behind this is that rteval changes more often than the version of 
the kernel we compile, so the user doesn't have to download a new kernel 
everytime they download a new version of rteval.

You make a good point though that the purpose is to provide a load.
We have had some discussions in the past about whether making sure 
everyone is using the same load so that we have apples to apples 
comparisons is necessary or not. I might revisit this in the future with 
some innovations to kcompile, but for now this is a NAK.

Thank You

John

