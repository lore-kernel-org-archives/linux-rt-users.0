Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1194C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3E9613C9
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGISBl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGISBk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625853536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULQDsGPh3AHD3SOk9O5mssutYSM3JCboakkU2mBEowA=;
        b=Dqs3izX6jbhKTyLYWXf33BVbkaQn0VmcmdXHFk2NXJp/7MszuKoRSsoWDIU5fsjAjGFwmD
        xd9LKbGh2KC0M+1zGoHl2xIMP6MZTzbxKh26k1mYgaf7+OYH0GDDngjuPmET6w3IDSC+jJ
        ItI1+CVaeYgud5wl4KMBeM7HZj6rtWY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-_zhfSi8gMSq6liI4FPlozg-1; Fri, 09 Jul 2021 13:58:55 -0400
X-MC-Unique: _zhfSi8gMSq6liI4FPlozg-1
Received: by mail-qt1-f200.google.com with SMTP id c18-20020a05622a0592b0290251fb198592so6275154qtb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 10:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ULQDsGPh3AHD3SOk9O5mssutYSM3JCboakkU2mBEowA=;
        b=C2gFAWpqQuCJSbLKn89KN1ah7HebH8FLETDjMij0l0/1tk+Ey1pij48ytjUJF7tIU9
         eR64Bmw4oA8YFaAAQJRfXw7fp+nOkTl+L3KQTiNRUZ3mU25o3rsdkcuxQXEvSGIS/864
         sKGDkkKsfy3qoZ5sOqJ9FNqK8LnlRgqzaRIZOblbgOvWnOUw5DpewQE4q0In8u0zmctE
         r8cLF3WvdS9qN5CFkZ8nMBvE5HCceOaXB/vY5bE3j4FzWNVi2aazxw+/mR9c4JZw7THE
         adGdShdtjYgPXJA52G5HD0af77NPyBIHFj4HpTAB6Jrt0kQf6MnRSWKsD2Ta0Oys2QNy
         vpqw==
X-Gm-Message-State: AOAM533fZaKa9Yjh/2nQRKjX8wuHNwvPgf51neSivR0nVatlrvsieKjZ
        2QfHWX2O2daWJoOKJUwucYgQ9++HyLxwdstAtPpb0NIuLN8NCZwQ8iutp4lzb7Bzn58GBiAFAtO
        wBj5VkLsi4GIg4k+eO7QtyH9Odss=
X-Received: by 2002:a37:6314:: with SMTP id x20mr32133068qkb.363.1625853534602;
        Fri, 09 Jul 2021 10:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP3a/LaY5i2GGW1LLPTZC8LjDyE3eq/ZSgzu9FipRTnxgq7Ftvfn6gIHD0+5ZR83eXr1QOxQ==
X-Received: by 2002:a37:6314:: with SMTP id x20mr32133049qkb.363.1625853534340;
        Fri, 09 Jul 2021 10:58:54 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id k125sm2815917qkf.16.2021.07.09.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:58:53 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:58:51 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 1/3] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
In-Reply-To: <20210708151827.21430-2-dwagner@suse.de>
Message-ID: <7e1f5d9-43f3-84ea-4c87-725cea71f15@redhat.com>
References: <20210708151827.21430-1-dwagner@suse.de> <20210708151827.21430-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 8 Jul 2021, Daniel Wagner wrote:

> pthread_getaffinity_np() prevents static builds as glibc does not
> expose it for this configuration. Instead use sched_getaffinity()
> which is always present and has the exact same semantics.
> 
> Fixes: f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified [NUM]")
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/lib/rt-numa.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index babcc634d57e..bb0121a65eca 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -68,15 +68,13 @@ int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
>  int cpu_for_thread_ua(int thread_num, int max_cpus)
>  {
>  	int res, num_cpus, i, m, cpu;
> -	pthread_t thread;
>  	cpu_set_t cpuset;
>  
> -	thread = pthread_self();
>  	CPU_ZERO(&cpuset);
>  
> -	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
> +	res = sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
>  	if (res != 0)
> -		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
> +		fatal("sched_getaffinity failed: %s\n", strerror(res));
>  
>  	num_cpus = CPU_COUNT(&cpuset);
>  	m = thread_num % num_cpus;
> -- 
> 2.32.0
> 
> 

It looks okay on the surface but I would like to know where you tested.

Also, in your message you explain that you can't do a static build
but we never made static builds a requirment for rt-tests. I know from
your cover letter than you are trying to do something with arm, if this
is your motivation you should put it in your message. Even if this is your 
motivation is there a reason we have to have a static build there?

Finally, you put "fixes f240656b056b", it is useful to know where this
was introduced in trying to figure out whether we can really replace a 
pthread call with the sched call, but then phrase it that way, because
as far as I know that commit is not a problem needing fixing, so put
"pthread_getaffinity_np call introduced in f240656b056b"
or something like that.

Thanks

John

