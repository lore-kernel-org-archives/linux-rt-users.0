Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A5C432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 17:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FAB60FD9
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhH0RKf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhH0RKe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 13:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630084185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1pbzcLs6faBznHOBMo25uTz+8vncAYswfG8cvpNeOU=;
        b=CfDOtQsUDf4+NMD/CHuNVnjEhz6SosR4Toh4c3lC0a6cHRML8IoKOy4Vsv5jH8aYLm7I/t
        eSxCYLJJgd0oeDfhFgeMT0oxLGdbpZCIvrroc1EWA87vdSKteizaDhluSqw8oNWM3hL3O+
        jAYO8JUkzO3SnOGxgqs+vj+6Vs7gKdg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-zHskMNMGOk-sC5bJytnNPA-1; Fri, 27 Aug 2021 13:09:43 -0400
X-MC-Unique: zHskMNMGOk-sC5bJytnNPA-1
Received: by mail-qv1-f72.google.com with SMTP id e14-20020a056214162e00b00375ec21dd99so3700811qvw.23
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=P1pbzcLs6faBznHOBMo25uTz+8vncAYswfG8cvpNeOU=;
        b=q/VLnX2jGqcPUwd9CugZudg86EC3DbIymKfpIq9+b9aMwZTNYUZKwE84UYoVWObZGM
         OY94aPzjPq0Rfu5MzNgX6DmTLCyToIoU/KL+jiey2oc4f0WPEDupP7dfuQXBLBWHGDaT
         j9aqVmPS7xEoKnRaMiIZ/wkWdw0NvQEm14zztuDxrNY8ralVxahJvzdK2MWHxV2UEPrG
         WVCqRcW8Mq1LV9LKzTq0ujCt99M1VDn0vnHYjdKTmlMJISi0kLqGn3vkUnKFAoNR1/Am
         5JhBMEnD+/jtDMiJ4JRm6C8fS/Q2GkXDvJjxxi6tj4L8JO43BZaZ02waIQ4ZXpRZlH77
         dkDA==
X-Gm-Message-State: AOAM531yHdpJyYcicAsEMaIzS6w+ga042kUFxdEAgGtP0WyczNr0H0B4
        VylfGm0BZ8Ih7tGFWouDUStNvJtKbk4Tkkdapono7ogTlqnSemSr1K2Bs4Vs2YxU94JMt7+3Gku
        lPwbZ9E1TrSEhH59Zh4aWHZ69Ods=
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr10156146qkg.352.1630084183447;
        Fri, 27 Aug 2021 10:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywSD7/uLqx5j1RpHSV8/JeKmQdU7uqJRG6PDNd7oE41PmhcWz7I0vm8y67OELFPedTGfnGMg==
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr10156130qkg.352.1630084183223;
        Fri, 27 Aug 2021 10:09:43 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id a8sm3681766qtx.39.2021.08.27.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:09:42 -0700 (PDT)
Date:   Fri, 27 Aug 2021 13:09:41 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
In-Reply-To: <20210719081505.520-2-dwagner@suse.de>
Message-ID: <c85f2cf8-4c30-3171-223-b6a95853637a@redhat.com>
References: <20210719081505.520-1-dwagner@suse.de> <20210719081505.520-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 19 Jul 2021, Daniel Wagner wrote:

> pthread_getaffinity_np() prevents static builds as glibc does not
> expose it for this configuration. Instead use sched_getaffinity()
> directly as pthread_getaffinity_np() is just a fancy glibc wrapper
> around sched_getaffinity().
> 
> Static builds helps in in situation where the rootfs is minimal
> and does for example not ship libnuma.
> 
> The pthread_getaffinity_np call was introduced by commit
> f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified
> [NUM]")
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

-Some minor fixes to the description
Signed-off-by: John Kacur <jkacur@redhat.com>

