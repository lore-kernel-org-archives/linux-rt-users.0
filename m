Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFBC433E2
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42B920578
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6/+YUVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICQiT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICQiR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 12:38:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195ECC061244
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2020 09:38:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x7so1617053qvi.5
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2020 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/4V23CakI6rWEzBxK9QxO+w0eAlRx45owF4ub/qA2so=;
        b=G6/+YUVqbRkEYxEgDH2BHtizXkShNxyRV9+ciZnDqh3CK1pHj3xAHgiPTHTvz4VhMc
         7smODz2AMhhP0/x5PTdDLEQ9Rdu7acWbrPJ24vQlPin/Xq8f/42WICGit7ME3JVy9/J0
         uGEQrcpSXH1bl12nrX9D6/Rjq6sa0x08YFeDUI6LsufhYGh4q+LwgW4Zi4VBYUpa35dd
         h9BKypT+1RxFgjF2+gHbPRM7Vj4mYvmYLjG7vnM3oaVIuuXXfZfEYX9HxFi0bwYdXeuf
         YHnlqpdwt26Q/L4UO6BNwlo8IeVp2mX1m/slCJYjM5ftzZt+gOfbHuW1PUP7+5I+ztcp
         CgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=/4V23CakI6rWEzBxK9QxO+w0eAlRx45owF4ub/qA2so=;
        b=EdBNveowothzDNpNgycsKtd4ygRoE8t4n0cjPOHJRLr2iP3XOQJBDgHEymbBRRVFJa
         9dVqx+7Nk0e3OFfsQxH4AVxG2V7c0ZqLkDXSnA7E7p/Fy/XgmMc1KPSYcBCqq7QZHyvl
         Mb9kRTTcQ/1YXKynFI4OVcGciLzQ/29Bg5IGrVGn1zi7otYZDLp7aBfLAe8W5pqGJ7+V
         BBQ9ICsG6BKiys1JuNsWie0cD8ztqbnHyOQb7Bt5he4+hO1YDWf+laqMYhExqD1izwa0
         el/Q8q+cSkUnDYvMmBQ37uOyzO/bYTQWAWej5ZrjQo/fxGRHHySXJ16KpHP5tS/iCuv0
         HM3w==
X-Gm-Message-State: AOAM530PdcvAnPOxTqLYUTu6T62eOebOAtfCvvHQEvl10PA/zK09t1mr
        YaUP9GXNwtbjaguzBWzjtqfXgbhdklw=
X-Google-Smtp-Source: ABdhPJyRHU1pSE62Sh3QEHWSozBVmKdx5bnyEKuY+Hb+eLTpPHKd6aTyI/zwInCGtzh7tqN+b8n4CA==
X-Received: by 2002:a05:6214:180d:: with SMTP id o13mr3767599qvw.87.1599151096083;
        Thu, 03 Sep 2020 09:38:16 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id q35sm2381639qtd.75.2020.09.03.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:38:15 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:38:14 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 3/4] rt-utils: Move ARRAY_SIZE to common header
In-Reply-To: <20200901154657.30198-4-dwagner@suse.de>
Message-ID: <alpine.LFD.2.23.451.2009031237410.4001@fionn>
References: <20200901154657.30198-1-dwagner@suse.de> <20200901154657.30198-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 1 Sep 2020, Daniel Wagner wrote:

> Move the ARRAY_SIZE macro to a common header to avoid code
> duplication.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 2 --
>  src/include/rt-utils.h      | 2 ++
>  src/signaltest/signaltest.c | 2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index ae1d64a46b21..b41d42f13f24 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -49,8 +49,6 @@
>  #define SCHED_NORMAL SCHED_OTHER
>  #endif
>  
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -
>  #define sigev_notify_thread_id _sigev_un._tid
>  
>  #ifdef __UCLIBC__
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index f7b98d9605a0..4ed1cbc53ece 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -8,6 +8,8 @@
>  #define STR(x) _STR(x)
>  #define MAX_PATH 256
>  
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
>  int check_privs(void);
>  char *get_debugfileprefix(void);
>  int mount_debugfs(char *);
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 49d42ff20b6f..0bf075456ab6 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -32,8 +32,6 @@
>  #include "error.h"
>  #include "rt-utils.h"
>  
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -
>  /* Must be power of 2 ! */
>  #define VALBUF_SIZE		16384
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
