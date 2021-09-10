Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D4C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AC261167
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhIJQcM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhIJQcL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 12:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631291460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ryhEAPzDbo4xCJZ88xik0XFPrpATvILg9p/2sGdMB20=;
        b=VqOOkSUXeJ5HMtBb87jdROcanOZzzzkPQ327BUedWRH4EqCQhXu93Q3595haQ5icfcLYua
        9BYg6d6THP7jfPOQfl6HUJGkBsJw0llVRxywW/rfkAFJD1rwFcEHog9o7+Zh/mCk/eIxba
        B6ZOfhDNj/ZjMyX/PtFEdO+pxbFkp8k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ZYm3bfSRPwO4mSHyNcXnqQ-1; Fri, 10 Sep 2021 12:30:58 -0400
X-MC-Unique: ZYm3bfSRPwO4mSHyNcXnqQ-1
Received: by mail-qv1-f70.google.com with SMTP id q2-20020ad45ca2000000b00374fa0dbedfso20760596qvh.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Sep 2021 09:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ryhEAPzDbo4xCJZ88xik0XFPrpATvILg9p/2sGdMB20=;
        b=QC51f8hqjj76lSPUtfiKc54oE9vpaiiinvn+6ANkH/tg8RXAHhhRyRxTrfp31HT6RZ
         i6HBJsJXmHHYVUUticf7EImEa3YoDF/0sqQ6FpMz/gN8/+gmaq4z7k12zuSNUZuhWQmk
         1hHoX3M46M5nvSqnEts7Mo87q6SfIScSKbEo4h2VLxCzfUY9TOoIAsbd+JJ6jPpa8nfJ
         eJbcwBPHdJprC2x3fc2CWOxODuWPIjM/9a326uD/1sQsrmw2yjX9GTvPm6Yqc0M6vuYL
         xU8AarYpoCn7I1m5CBbWWo7sdKLxvpOsGeOfF5bzFbX+mL4N6Zf/HLlFshhn5gLhydwz
         DMFQ==
X-Gm-Message-State: AOAM532qO8dbdw/qJGmi+Bfkub4/2AttiqbJLdB5XxAADU1cxSIG4otP
        kjh+V4EvGP8T8ptzflh4v9mO/gwGsvJ0BFIrtNl6rH9BfIOvoDuk4MlvQeNwRUo61T2d4B4uuLp
        N0EMjQNLp6mng9L49wPiJZ1YXk24=
X-Received: by 2002:a37:c97:: with SMTP id 145mr8367961qkm.121.1631291458181;
        Fri, 10 Sep 2021 09:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcatrpCukXl1hhrFUQicbFIIL9QrdCpJrcY/WtbJa9nAEcEatLFUCbRc9T0JwANMMhlzvmhQ==
X-Received: by 2002:a37:c97:: with SMTP id 145mr8367931qkm.121.1631291457942;
        Fri, 10 Sep 2021 09:30:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id m5sm3841187qkn.33.2021.09.10.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:30:57 -0700 (PDT)
Date:   Fri, 10 Sep 2021 12:30:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH 1/2] rteval: osinfo.py: Fix RT kernel detection
In-Reply-To: <20210909080547.1331581-2-punitagrawal@gmail.com>
Message-ID: <65f6c046-67fb-9912-58d2-3210cc3cc193@redhat.com>
References: <20210909080547.1331581-1-punitagrawal@gmail.com> <20210909080547.1331581-2-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 9 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Since the osinfo.py module was developed, RT kernels have moved on
> from identifying as "RT" to "PREEMPT_RT". This change in the kernel
> identifier causes osinfo.py to incorrectly detect RT kernels as
> non-RT.
> 
> Update the check for detecting RT kernel to be able to handle both the
> variants.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/sysinfo/osinfo.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
> index 98e5b4422cad..7b7bfe9ce4ec 100644
> --- a/rteval/sysinfo/osinfo.py
> +++ b/rteval/sysinfo/osinfo.py
> @@ -91,7 +91,7 @@ class OSInfo:
>  
>          (sys, node, release, ver, machine) = os.uname()
>          isrt = 1
> -        if ver.find(' RT ') == -1:
> +        if 'RT ' not in ver:
>              isrt = 0
>  
>          node_n = libxml2.newNode("node")
> -- 
> 2.32.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

