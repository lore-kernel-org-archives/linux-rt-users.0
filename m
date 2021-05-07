Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD5C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FB6144F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhEGQU3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhEGQUZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:20:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89575C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:19:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o27so8977453qkj.9
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=XUSmZATSPBjAy7ASD/JsIyY0ftU8wGCxFWz1PB9xzwc=;
        b=fR56f9MmZkE1QmMUdpXT5R5BssYa3lqmceFQU2h43faC4aITut3v4tvu57YTGT9urX
         Y7xy4UkLEViFwX9b5X26PkMfaGPNn5kS4TCXDjjpAlCU7nE8lbW2I/UIS0ktjOOBouXV
         pdZRIAvfBn8ugbJBGWiWCck/lDpMChxEUxDkfVEJmtlKezE0JjzEXGdxAO9xNMu8dLRP
         8fXmR3ioZroJSVnG2qaAWCeNr0jitoDkT1Z+LitW04kZsPrpkajjNihj3mVXccKha1lf
         370O/zmolvmPqN+x1zMaNahR3u9dx2PDCLKTanQrTgf+Kd/xhCQt3oTFF1QK7QXgjohE
         dsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=XUSmZATSPBjAy7ASD/JsIyY0ftU8wGCxFWz1PB9xzwc=;
        b=mm+vx/19zWMjYZ8eGdbeKi7ktz6Jztrglsi1Mo8LpI6k5yO4ooxlevuL1ffUOWBtKL
         JW5tZVZCbyw8Cm7YlVU9ZTFuw+9c/KWsaf1rc9965yqT7B5DxBzGA4bLkeeLtT5ee+Yk
         D2O9WMSA62uy5vv09NEyuNQC3v5EiEdOk3mQaid+ux8D3u2jRZPPtijY0JCOGC5q1wNq
         vvSud9Sq7NiyAWjvDGFXAFiGQ4RIZQF3kDVONAc+76CmgQ417n+iHBHuBFdOXQHKpug4
         l/6J6o63tuPoiF1xTS3UMaT3M9ZaZZ+wvjZeTzdE8bhHaKrRcEa+guG6U1Btr70n+4EX
         tKqA==
X-Gm-Message-State: AOAM531DMfzsVzItdlUR9tXGL389VDwyzWOvF3zs8IBSx+AwEeFrJr5L
        ovRq7npF3vzG79cQ3FeqrBRmd6LATgIjcg==
X-Google-Smtp-Source: ABdhPJx1pZqriAkuRirKizzMa7ZeMjr4jke2w+ZpbtQEHHQcmC25o4DtMCT8V/dtIfKdLSpNd8snNg==
X-Received: by 2002:a37:b702:: with SMTP id h2mr10283136qkf.88.1620404362889;
        Fri, 07 May 2021 09:19:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id r65sm5361897qkd.81.2021.05.07.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:19:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:19:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 02/33] cyclicdeadline: Remove unused include
 header
In-Reply-To: <20210320183829.1318-3-dwagner@suse.de>
Message-ID: <aab01f72-30b7-e33e-30f8-7fdd1267395@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> The header was introduced by 68621f3c3322 ("cyclicdeadline: Add JSON
> output feature")for PRIu64 format specifier. As PRIu64 was removed in
> commit 51255cc14051 ("cyclicdeadline.c: Fix printf format specifier")
> remove the include header again.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index a02f4e519630..d7aa9bb5d269 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -18,7 +18,6 @@
>  #include <errno.h>
>  #include <signal.h>
>  #include <getopt.h>
> -#include <inttypes.h>
>  
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
