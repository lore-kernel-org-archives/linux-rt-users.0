Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A5C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E62964ECF
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhBJR3B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhBJR26 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:28:58 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B003C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:28:18 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id h8so2416735qkk.6
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mQlmSDFHtQlIT98kLvhMsi8MZ4cqENsgNzgV6WUAGUY=;
        b=soq+CLEUS2kwHQ/jctGjirPBvmwwqTjI2ovP2qg2Fisdd+xyUJRIsRjnVXJp/ujh9l
         sNy6qBwRRJksG3+ZbZcigQDPhEnfEW6DTgm4Nuj72DJldXOTIiKYfTTc7g1U9VQh2AWD
         q7BrnyEI8vcl/20N/TNu48fNvGo1/k36yoZ5yJesaWcgJhTVWFLOPR9K2iFFP8EbM/gF
         Gmiee16iRe72qQdsWBJJZIVqg9zahKKH5mIvc2kUnalITkyJQibRVmC8evfQfwDC7ex6
         ZgjVCfqnovij5SbbynRtXKTZKOhMZomeboeYtOFdPUNssuRKVM1OyhZFC0kZUB/Hk8fC
         4PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=mQlmSDFHtQlIT98kLvhMsi8MZ4cqENsgNzgV6WUAGUY=;
        b=D7teQzlGCdR8fSx5G2uTe0iHqN8MtM2KZGsdVZVcFokRyfzpqO/3bRYxCr4citjT80
         VkQwvn6v208rU9aY/7e0tpHXGoBkKnkCHLcREqLmDrjucfZwWperfveixGrtQWAo0w/H
         Jt2a+mNMIXjA6Qr/TNYtFJWvU7r4y+0HuOXVL1FVI1epUba+uTk9pZX4QuMn6sw4CD9e
         UKKW+mhV/dzgYt7F3F8X7K1S3EbYhRaOMVGagSmMgfduv14UgpBnMo4fMhILUhDYWrRr
         xImOANIAcdB2mRGhOgaUkB/Qb2FG1p20By+sBFwNCpNoyuacub6OMm0ttzxPZDN6BfKA
         WOcg==
X-Gm-Message-State: AOAM532PcawgA1TkZcocC3fflcy9sx2Ei4Aftb5DQEo/FDCec6lLH1bE
        FhH7teBDcrn7YXKO+CZap4+db2UVvFPYeg==
X-Google-Smtp-Source: ABdhPJwXy4HRJEHtVusyzBzuM6mEJg98p3qBWSS7hEFHBhqaoRzEaXPaR7lh62O6cCZQhx0TKAjfuA==
X-Received: by 2002:a05:620a:16d9:: with SMTP id a25mr4484364qkn.75.1612978097337;
        Wed, 10 Feb 2021 09:28:17 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id z23sm1929119qkb.13.2021.02.10.09.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:28:16 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 10 Feb 2021 12:28:09 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
In-Reply-To: <20210210165407.9770-2-dwagner@suse.de>
Message-ID: <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
References: <20210210165407.9770-1-dwagner@suse.de> <20210210165407.9770-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> During the streamlining of the command line options we missed to hook
> up the command line option '--version' with usage().
> 
> Fixes: e411219d27b1 ("oslat: Streamline usage output and man page")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 5b7e0d5b5d5c..d3f659b218b0 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -655,16 +655,10 @@ static void parse_options(int argc, char *argv[])
>  			 */
>  			g.single_preheat_thread = true;
>  			break;
> -		case 'v':
> -			/*
> -			 * Because we always dump the version even before parsing options,
> -			 * what we need to do is to quit..
> -			 */
> -			exit(0);
> -			break;
>  		case 'z':
>  			g.output_omit_zero_buckets = 1;
>  			break;
> +		case 'v':
>  		case 'h':
>  			usage(0);
>  			break;
> -- 
> 2.30.0
> 
> 

It shouldn't be a fall through, we don't want to print the usage.
