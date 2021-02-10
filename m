Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA2C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58EC64E15
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhBJRCD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232159AbhBJRB7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612976432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8EqlFL3cZN8qCt2/9m+0oLdtQJOwB2lLM7rfMywV7g=;
        b=OJwzIGu/PUoRkp7I6KlRgrp+KLmNwPTCphhVZaXGdTOVqjyRDkxHjfmaaU4tgJ0O7qD0Qx
        cCTU0N/HmzGkaJpxUc2guzUHscGYYsF4YdfplPnT84TbUyzbZ1dPxhlBO665WzzW16YznN
        V/1AsQmyzniHLn0YT1Egw1sKzLMJ5rw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-9v56LQzuO_ymcD9I3_Rfrw-1; Wed, 10 Feb 2021 12:00:30 -0500
X-MC-Unique: 9v56LQzuO_ymcD9I3_Rfrw-1
Received: by mail-qk1-f198.google.com with SMTP id h185so2074216qkd.4
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8EqlFL3cZN8qCt2/9m+0oLdtQJOwB2lLM7rfMywV7g=;
        b=gabHYSsw2bgmcTUVhA7sieXTHz3FDAtmt6d++C7E1m/pRrVkLE3+tz+WkI6XQ4Re7I
         v5NR/FJaMz3vAaaqWxywHkxCwHoPw/3b73ABUiDWXjDecO8oc1JN9hGARP8R0AdrwYnX
         XxhRBAk6mvO72XjoooQlx1xTzQdG5n5OK8t18S44l0xGtWd6Ad63EpddMDl4ZJJ1KBVF
         Unj0rtkuiX016PXTX8O9hU4ChaBBpJVcr+fJBHhqVJK9amARplGyEPGpeTIUXipsu19i
         NKWaDf4ofVxhawMvJRnTqvz0mBL6o1XK37J7ohwIbS3KF5/70S3XG4X2pxKbJuCNWxsw
         omnA==
X-Gm-Message-State: AOAM532PW0TR0Ft6nqgHpjKuT3P36fh5bDVJyKk6dBNwBXJP4aIRWGiz
        qi49P3Cd1U/n+bED1UrYbeyCFYlQSqGr8yqX5Ex9eQKomX7twy4qh9TzpobEQAdi0izQb+q8TwM
        h7mT1kw/Z/ziHAGL3Xk/aF62Qyj8=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr3494880qtr.28.1612976429328;
        Wed, 10 Feb 2021 09:00:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP+8Vk6Mgmb5c4vThaZ2VnVG8sVih4zXQM4//xcHH1tQN+ZmdcQsr48WhdzmDGA6JUcxc9hQ==
X-Received: by 2002:ac8:47da:: with SMTP id d26mr3494850qtr.28.1612976429001;
        Wed, 10 Feb 2021 09:00:29 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id y135sm1935429qkb.14.2021.02.10.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:00:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:00:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210170015.GL103365@xz-x1>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
 <20210210160847.GI103365@xz-x1>
 <20210210162559.GJ103365@xz-x1>
 <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
 <20210210163537.t2tt3nyuqgkfzbl3@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210163537.t2tt3nyuqgkfzbl3@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 05:35:37PM +0100, Daniel Wagner wrote:
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -655,16 +655,10 @@ static void parse_options(int argc, char *argv[])
>                          */
>                         g.single_preheat_thread = true;
>                         break;
> -               case 'v':
> -                       /*
> -                        * Because we always dump the version even before parsing options,
> -                        * what we need to do is to quit..
> -                        */
> -                       exit(0);
> -                       break;
>                 case 'z':
>                         g.output_omit_zero_buckets = 1;
>                         break;
> +               case 'v':
>                 case 'h':
>                         usage(0);
>                         break;
> 
> 
> 
> $ ./oslat -v
> oslat V 1.10
> Usage:
> oslat <options>
> 
> This is an OS latency detector by running busy loops on specified cores.
> Please run this tool using root.
> 
> Available options:
> 
> -b, --bucket-size      Specify the number of the buckets (4-1024)
> -B, --bias             Add a bias to all the buckets using the estimated mininum
> -c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'
> -C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.
> -D, --duration         Specify test duration, e.g., 60, 20m, 2H
>                        (m/M: minutes, h/H: hours, d/D: days)
> -f, --rtprio           Using SCHED_FIFO priority (1-99)
> -m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).
>                        Total memory usage will be this value multiplies 2*N,
>                        because there will be src/dst buffers for each thread, and
>                        N is the number of processors for testing.
> -s, --single-preheat   Use a single thread when measuring latency at preheat stage
>                        NOTE: please make sure the CPU frequency on all testing cores
>                        are locked before using this parmater.  If you don't know how
>                        to lock the freq then please don't use this parameter.
> -T, --trace-threshold  Stop the test when threshold triggered (in us),
>                        print a marker in ftrace and stop ftrace too.
> -v, --version          Display the version of the software.
> -w, --workload         Specify a kind of workload, default is no workload
>                        (options: no, memmove)
> -z, --zero-omit        Don't display buckets in the output histogram if all zeros.
> 
> 
> 
> The other tests print also the usage text which included the version if
> you provided '--version'. So this would make it behave in the same way.
> Good enough?

It makes sense to make all binaries in rt-tests behave similarly, so regarding
"oslat -v" even if it's not my preference, it's fine to me.

Again - Would you consider also dump the version in the output as before even
for a normal run?

-- 
Peter Xu

