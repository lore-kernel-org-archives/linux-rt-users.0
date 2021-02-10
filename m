Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC48C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B780064DEE
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBJRO7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232459AbhBJROS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612977173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HKJYxtuPaIvWKeA05yE6QSsyYfC4k+gld5IyVie82A=;
        b=SD5QLvA+tRvnO7sykmSXBgn5HbDXpd6EGF7tpbG3y3EDemLp2ooSMLcbPBeToxLYTjA1GM
        fPQab7n2k13wRrVI7QT9RuvdkOa1QgnBvVxrJ++FE36pq9RD6FjuQBaibRyRr+xQLycqKW
        7fZbat0/G5+iwq+xjiUph9xQKPjUZyY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-pD9y3x_SN7q05DFb3E6XfA-1; Wed, 10 Feb 2021 12:12:51 -0500
X-MC-Unique: pD9y3x_SN7q05DFb3E6XfA-1
Received: by mail-qv1-f71.google.com with SMTP id v1so1894365qvb.2
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HKJYxtuPaIvWKeA05yE6QSsyYfC4k+gld5IyVie82A=;
        b=alrNmFc7p612vtXyhU0cD1zNbuJD/6W2BPTrHr5eLtMq/sdi/f0jICog9BiElapZQa
         +Cal7t4059Ne8cMHrDkRwdA08pVOiDfYcykh5q8n0oCIHhONF5aQ3fEdHIe6tBgOjRUf
         hEV3iqUo7UXdBL48bb/5sU8u4xvzSVJwqKCeVOCACSeAOjxxCO35od1t4N+C0eekc8wq
         pt3Ag2NF4GxwUx5rtxCi28NxBXgO0OCaip8ObOlFzo+XAWGzYFT+H4e8p01R/rj0Uw2X
         L9/uXEMdIJV8tj2+YvLLycVakCx6pFbzSHW5sP0kINVoblTZS8gLf4nvaYCFQl3tP7y/
         Ftfw==
X-Gm-Message-State: AOAM532ADlX1EXQpEOd2dTrAniRLYZBhK2AcJ6SF9AFVe6qBkP/9WcNT
        MEs+dTx9a0Bv92hhJoOQk3d0MMBUvbHxmcUncdTOWg7QaNFBlsITZbJJZtzJZy7ddPzQZfEpvyW
        mIoxMT7t74RpdDWBg3FGaJBiYkeA=
X-Received: by 2002:ae9:dc87:: with SMTP id q129mr4411937qkf.297.1612977170654;
        Wed, 10 Feb 2021 09:12:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjIJ/CyhmmNS+BLSg3z/r//3+OMo7ZA4ZLySGXGgGnQuIicqwWM71D1oafsVffir+NIeTF5A==
X-Received: by 2002:ae9:dc87:: with SMTP id q129mr4411923qkf.297.1612977170464;
        Wed, 10 Feb 2021 09:12:50 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id d12sm1658922qth.11.2021.02.10.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:12:50 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:12:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210171248.GM103365@xz-x1>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210165407.9770-2-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, Daniel,

On Wed, Feb 10, 2021 at 05:54:06PM +0100, Daniel Wagner wrote:
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

Thanks for your quick response.  I've commented here:

https://lore.kernel.org/linux-rt-users/20210210170015.GL103365@xz-x1/

-- 
Peter Xu

