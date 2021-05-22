Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB50C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A372613D8
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEVDjc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhEVDjc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K6aweiWGHlZCr579czVKnn00mkcmqztLgcpFI4RKhDg=;
        b=hvuGcb3eoGhahCuOV6f9sQYh/gp79CmzvlXZkB1revQHslTkv14RvXTAEBKtCCvgiYearE
        H0tdm/7TrKM3Jo8mXGUuG1X6mc2Qi1pHdMVrEmQuaiUHlTgSmrRGgi43Ko9osIuyp8Fh0E
        tBKKkgfKWi64ZzphDbsFCeODeFsuOzk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-ImQfP7L2NpCIGaSJRhorow-1; Fri, 21 May 2021 23:38:06 -0400
X-MC-Unique: ImQfP7L2NpCIGaSJRhorow-1
Received: by mail-qk1-f197.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso12295231qkm.12
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=K6aweiWGHlZCr579czVKnn00mkcmqztLgcpFI4RKhDg=;
        b=NQnntfwb3Mtn9C73r2wQln4qNRpWKFm9ZhiGSHPAwtNuUFnySlNKl6hyHcEpaTr+4L
         2BYtr6z5YdP8/a4DfcLVhdoRnKarXBDaBX+CRqxDF4hSrt7hpFNgmo0Ps3r5LvCWxM49
         rp4nnFhx+6+Pq4MzeDebT8agCuOLVzO0HJwAVe8zFk/Xk1YqxpNZgQBC73JU1xUzeREW
         EdYZDZ3RAty5VjxvWoRrO1R/hwk1jtJ6rE6wyyHsqDi/v2tCEAMoQsb8BA9YD9tZHYgI
         8ApUiSCY4ISVDvWZYnmqMq0FsfiBIXTVGMYA7zFilDhBJonMYS/i/1sUtmbiqRd24OSq
         1OXw==
X-Gm-Message-State: AOAM531L4/DAowjR+ZCwySCFgZpNxUD779flprd9SFJR2Zhp0YZdG1hm
        MnlPYEs4XYvo0VbbEBdw6EPW8WnpUhX2OXqHmG6h9pVMBcvUihFRy3tba51li/kOgh/JL9I3qHR
        OFgMTGzEMzGShfvSQVK3dJHNeL8g=
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr15538647qks.425.1621654685983;
        Fri, 21 May 2021 20:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpliT9dIup4H4Y+HNGZcOm7mnXXWHUYKNMkCQGtv/AXpgvQOGpXJLfxaLLVLTRtFACszECWw==
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr15538639qks.425.1621654685830;
        Fri, 21 May 2021 20:38:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id f1sm6136542qkl.93.2021.05.21.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:38:05 -0700 (PDT)
Date:   Fri, 21 May 2021 23:38:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 13/23] cyclictest: Add --json to man page
In-Reply-To: <20210519170945.21941-14-dwagner@suse.de>
Message-ID: <f127ea5c-b0dd-3c6-35d4-64d6dea3c03@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-14-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> Add the newly introduced --json command line to the man page.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.8 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 44b5d0dbcc4a..4fe42e502535 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -17,8 +17,8 @@ cyclictest \- High resolution test program
>  .SH SYNOPSIS
>  .SY cyclictest
>  .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
> -[\-h " histogram " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] \
> -[\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
> +[\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
> +[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
>  
>  .\" .SH DESCRIPTION
>  .\" This manual page documents briefly the
> @@ -85,6 +85,9 @@ Dump the latency histogram to <path> instead of stdout.
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

