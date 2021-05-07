Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECBC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AE6145D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhEGQol (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGQok (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:44:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61400C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:43:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 5so1155188qvk.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8EkjdKUend/lqElQ20qp1eKOOGEvKhwFQnT/DyoLooo=;
        b=ennvk+t5nPmO/j4eZvwTi6s1koG2t+bxeFSdGyCG1QlpyVwKSlwY37Y0/bxgDWqII9
         8eHl70j4MiUYPImhf7Z504c5Gn+4eBLKbhayQts8OlAunEDMJlUMvDDLPe35kzCn3+rJ
         hjE0/tqcZY+FpnIhpoLpUkiqRhgmuMLC9x8j5BU8WBfJj979cvG7klT/XGdLspDlQGEQ
         KQ1TI4ByqRw3Ai9kvTO76deqiFnkKoD6ECrwrFISWg8miD0ZPoU+frOe/RwvNIhNwaNX
         jIwmdaIGcH4Uc53jaedOmCdBCC2d9wgmkC2kGv2hL5OK0eZTCb/Xf4RTVNj4C7aK5KLb
         ETMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8EkjdKUend/lqElQ20qp1eKOOGEvKhwFQnT/DyoLooo=;
        b=pKUaUippcXVglRnq7/ply7xz4gtoX6oDAvuBGUQYSyYWOl9Q3GC5M99XABFmMWnU/r
         Ozkfuo95jznm6AgEUwMSIfSAxkys23JdWMtwCZiZ8Ue3bvsHzOXqReD91vJ37IDcvRCt
         KYJWDWt2ufApQqJshZsf/kFO/H6u6BFx4UgLMvuLwHP37fJETUwgqz5K9t0eED1ZVjrV
         3cOyQn5CyeWNs+pbr2yoFZ/fM5XenM7KpjDmjkiBs2Sl8oXkW0Lw2fWNy8IJL+esQH9o
         VoDRqukUBkDnU4/ObZhbPjqUCIJw9mPwIzISmgy3tlN1rVg0yK5FpMwUXMiQGw5u03vJ
         y3cg==
X-Gm-Message-State: AOAM532nHqnVRuUQpEyZm4K9a852RL5HqXkfcMnEw7fp0H1dLA4ufobS
        rzSYiFbiyVsYeKaotptIy9M=
X-Google-Smtp-Source: ABdhPJwSelaGIPkShXiGedQZe8yIm6ikTvtP2K2VQLrHoBHuLjsGsDhC9dJBQZxVA/KAZVSF+Wn/NQ==
X-Received: by 2002:a05:6214:daa:: with SMTP id h10mr10784074qvh.42.1620405819736;
        Fri, 07 May 2021 09:43:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id g6sm5309815qkm.120.2021.05.07.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:43:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:43:38 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 19/33] ptesematest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-20-dwagner@suse.de>
Message-ID: <cf9ec3ca-fcc-845-6af-876ad7df55a7@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-20-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ptsematest/ptsematest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index a32bfc1698f0..471f1b307c14 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -468,6 +468,7 @@ int main(int argc, char *argv[])
>  	maindelay.tv_sec = 0;
>  	maindelay.tv_nsec = 50000000; /* 50 ms */
>  
> +	rt_test_start();
>  	while (!shutdown) {
>  		for (i = 0; i < num_threads; i++)
>  			shutdown |= receiver[i].shutdown | sender[i].shutdown;
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
