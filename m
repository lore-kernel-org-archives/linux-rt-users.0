Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E19C433F5
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Dec 2021 16:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhLYQnf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 25 Dec 2021 11:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhLYQnf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 25 Dec 2021 11:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640450614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6NYY2weqTzkSUUZ75LTx2KnP9AbjdyMc7FdB/R8Cjc=;
        b=Gy+9brm56lrP1KJACpoJk63TSk/jonH2HKSb9bQE9e1YvBzW2O2bm+si/4bG1vifKmnWPY
        iSWKPXWQIcpkhooVGncHWmnSlhmG0tP2fGYKjszyN2XnbFHFPbOzry2nt+wRyl5SrjVieS
        Si1aBCY1uQhfmGINY9QSC1EezfVpTDc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-xeqrJ-5yOkqn3wLychxCdA-1; Sat, 25 Dec 2021 11:43:33 -0500
X-MC-Unique: xeqrJ-5yOkqn3wLychxCdA-1
Received: by mail-qt1-f198.google.com with SMTP id m15-20020aed27cf000000b002c3def3eefdso8080740qtg.21
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Dec 2021 08:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=W6NYY2weqTzkSUUZ75LTx2KnP9AbjdyMc7FdB/R8Cjc=;
        b=UJsfpLja/Y/9QNILEhFuYpVNlwAf3xFKbX3Vu0TwMAu5WhUq1hrSFN277v8GxItbhW
         uaz4eo9MScL/CKDdj1Gi2mjuixjs+6ySyRtbD6DbTas4lUqiP1EYeKcegMbx48Ib/mMN
         YnO1c4V6uEOi7jSDHMdiUaJy+MaAAAJinwXm3GgV8ZgGBunaumxibq59dsbHf5pyyPfT
         8OtAFxSv5KQpAiYQWg8QlSUqHItu2ugsvTpQypzvq6Ao1/JAUYi35RKKDSwIl1SCBf18
         nLjPoFkOia/dEj8t+DhKpBNjRFpH/Jg6820vFoI7X9dgkHZTGvMJ8og1ucjGA7u4Xi3u
         L+5Q==
X-Gm-Message-State: AOAM530yuvc28WNlx6SIsxyLRzld3Pmw5MANEPMZlQb8A1/YhKOHclDf
        gHxmUZ8tzpCbf0EaiwE6FBnVFci0EV8/AONBDKBsHWVA3QPrdhu7LGHC7pdgDcAlkJb8N55uxBB
        bE5dATnLkIY+dAzTQfaI/FfFq4as=
X-Received: by 2002:a0c:c710:: with SMTP id w16mr9357960qvi.114.1640450612732;
        Sat, 25 Dec 2021 08:43:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoKe+awDBfN6PvQz2ZrlWqZT/IoTrUJxFC8inANs4p3SMz/SIWovwCVhDhd0tqxq5MuYVIiQ==
X-Received: by 2002:a0c:c710:: with SMTP id w16mr9357949qvi.114.1640450612540;
        Sat, 25 Dec 2021 08:43:32 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-130.dsl.bell.ca. [174.88.120.130])
        by smtp.gmail.com with ESMTPSA id u11sm9692206qtw.29.2021.12.25.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 08:43:32 -0800 (PST)
Date:   Sat, 25 Dec 2021 11:43:31 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Correct the comment of numa_initialize()
In-Reply-To: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <ae5e7361-59b-37ca-6d63-2b9870d1ad7d@redhat.com>
References: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 23 Dec 2021, Oscar Shiang wrote:

> numa_initialize() returns 0 only when numa_available() returns -1,
> which means that libnuma is unavailable.
> 
> The return values in the comment should be corrected to 1 if all
> functions are available and 0 when the functions are unavailable.
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  src/lib/rt-numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index bb0121a..ee5ab99 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * numa_available() must be called before any other calls to the numa library
> - * returns 0 if numa is available, or 1 if numa is not available
> + * returns 1 if numa is available, or 0 if numa is not available
>   */
>  int numa_initialize(void)
>  {
> -- 
> 2.25.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

