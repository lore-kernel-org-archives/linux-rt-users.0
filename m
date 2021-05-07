Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F3BC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006F761451
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhEGQSv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhEGQSu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:18:50 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E8C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:17:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id f8so2804868qth.6
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=w3pnbOzOHOzi67BLnu4mx/4n+Q7fZ7nz0cTlspv67Fs=;
        b=PbWJjWWrNKUQSPhUod1Ig4glJ80NRDDeBJ/fBYNjFzzbxjcKuKnuFqVwZFcElheP2E
         IL+h8oENpwKXlpGlwuGUyPttDepeus4vZY811tULn/A0179xRddYE3EbeHuc3Zt3xdVR
         C/eYaCdeOwELnmlMhxh3Ng0Tlc7+MHehKGLaWEJSKAr8dI81TRpic/+ilFF1LiTY6gO8
         vMVCcFfEqHMj5x+SJ3gA4CpHwFMQzYYekUkfPHuDrkT55LrzCM4tDK7+ox+36UAyQM4L
         wFUwMU1G0UqvXRHlzbMpADldUd/7j6NB0X63IkiF43UilICHxMnsk9/SjgOWIaeOg3nn
         dogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=w3pnbOzOHOzi67BLnu4mx/4n+Q7fZ7nz0cTlspv67Fs=;
        b=tQ4NNLv0lttYkbA7URX8tvzsBG5d6QgmlNqnT06Dnfksdqa0g4v9IUkRN1HoVD+EVY
         K/eG9pBx9WuBYj/PIcGIzQiGLVUZKMEKNAuxvlxAhOhXZzn28jDBQyQGye1A8EYeIrBI
         9+ICj7JjfjQtaOsy4kfVBEB2uJEjoGL9go2EYqBreaAxnfTgwau1bU8NR+pCb7uIFgfz
         O/78smyZvi3FL+inArZi78Yx3hwqdUcGglNN491mqcf3zKvUSMKLpTGbVQVkbwul6BAX
         c1C46GBflm1CWWBBxkpi3jtpTUyqWKD707tbpUSROkfUFSPo1exWeTnXg7LiJ1xXmi42
         FiEw==
X-Gm-Message-State: AOAM533HzJJah/XwPCPJC42eyNTH3397kBs36BDSiJqplt9omajAqN/g
        bwporhfIj98FAw+CyHHgV489FrooutW8Dg==
X-Google-Smtp-Source: ABdhPJx4dPuIus6tJqevlGL1LE+cWjcsYvXN04L89ofNCkmENK1XkXzzUreFki4aInt965FHPf/SAw==
X-Received: by 2002:a05:622a:18a:: with SMTP id s10mr9952714qtw.237.1620404268766;
        Fri, 07 May 2021 09:17:48 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id v10sm5011934qtf.39.2021.05.07.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:17:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:17:47 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 01/33] cyclictest: Remove unused include
 header
In-Reply-To: <20210320183829.1318-2-dwagner@suse.de>
Message-ID: <7914c9cc-d91f-76c3-f82b-ab4ec0499d7@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> The header was introduced by 24aaf9619bc2 ("cyclictest: Add JSON
> output feature") for PRIu64 format specifier. As PRIu64 was removed in
> commit f6881fc42baa ("cyclictest: Fix printf format specifier") remove
> the include header again.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index dca961025433..c43dd7cbbd64 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -11,7 +11,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> -#include <inttypes.h>
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

(In fact I pushed this awhile ago)
