Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4DC54EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Jan 2023 18:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjAPSbc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjAPSa4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Jan 2023 13:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081912CC4A
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673892944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usHgO9ujyy37+TNikcLJl76DQcGcgvjdFdn+jyCQpCY=;
        b=DRSo6qiAWhL6COvcoVmp6nP7V66xVCKeez1+nj9RB88xexRGbtHmwXTg8Fh6g3PO+mxn/2
        VV/lJHREJl297BFFQWPhuo6n/D+5WgIW8R9/FJOjkm1o+/7Mrp+tpjYEsJ9H9ruPWsq67C
        v/RTXxWfn29p7naPYtsc4BadiG9ZvrU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-lrto_fPGO1WrZTY_OWBeXA-1; Mon, 16 Jan 2023 13:15:42 -0500
X-MC-Unique: lrto_fPGO1WrZTY_OWBeXA-1
Received: by mail-qt1-f199.google.com with SMTP id a13-20020ac8610d000000b003a8151cadebso13161436qtm.10
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 10:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usHgO9ujyy37+TNikcLJl76DQcGcgvjdFdn+jyCQpCY=;
        b=Bg2+lZGuKimzpQ1lT5PE8q+TBSZPhr2chPjBzOmC3YAwCjLyIcCTbIkqqTZxco3kK6
         95YLXvd8Vzf6weOwEMfvdLb2wSc2wSMNYs181ROEvi/16JfGY3wA3rloWtLp7/ZMVJia
         2ZM2u96HvQqk0UIprP8Ltwday88EfSPr750It55K27P7IGjuV+IFoWKQPWOuQTw7Q5PV
         j1fZEN7qYlEWhdBekNPthtjD1E7D9LWprl9iSTow8U2vRMcTS+iGhcDLpZZxI2XPxN07
         i9zvRcsy9fwSby81aC+efr7g8QPICeP6rkIMW8qEvVdbU/dp2XXyrjlt0YbiHf+BlHE+
         c4bQ==
X-Gm-Message-State: AFqh2koTgWNaWpBeA3KAbaHGRJ1zx9cyRv9sVvv3RtxvINxJq5EMHSB/
        If7m37BkOir9Y7YJZhikFg+O10brk0FV4UE6fN45kwdNTN05V7MI++3sFSibjYvuphy8MkJZstb
        tPj63QXg6kbIjNA5gaJWkkZLLoj4=
X-Received: by 2002:a05:622a:591b:b0:3ab:6a9a:aa8b with SMTP id ga27-20020a05622a591b00b003ab6a9aaa8bmr136747596qtb.60.1673892942058;
        Mon, 16 Jan 2023 10:15:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+W8l9Pd78M01bn6FSqE1MbMGyLxI+hpZqb0R4NA82iJGmf+7qwo4YtIHwuB8BWrQWzYr5KA==
X-Received: by 2002:a05:622a:591b:b0:3ab:6a9a:aa8b with SMTP id ga27-20020a05622a591b00b003ab6a9aaa8bmr136747570qtb.60.1673892941769;
        Mon, 16 Jan 2023 10:15:41 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id r20-20020ac867d4000000b003b635a5d56csm1007517qtp.30.2023.01.16.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:15:41 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:15:30 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Use a reasonable default max CPU value.
In-Reply-To: <Y7/aS/dW0H0CK8Oe@linutronix.de>
Message-ID: <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com>
References: <Y7/aS/dW0H0CK8Oe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 12 Jan 2023, Sebastian Andrzej Siewior wrote:

> numa_num_task_cpus() returns here > 100 CPUs while the system has only
> 32 populated. The BIOS assumes that I can probably use larger CPUs (with
> more cores) on the socket so the number of "configured CPUs" is rather
> high.
> For default configuration, only with the -S option, it makes sense to
> use the current affinity instead looking at the number of possible CPUs
> which could be brought online. It still depends on the affinity of the
> created threads if the additional CPUs can be used. In a container setup
> this may not be the case.
> 
> Use sched_getaffinity() to figure out the number of possible CPUs.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/lib/rt-numa.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index 3eead80c3b2b3..1b09cff8d9485 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -35,10 +35,19 @@ int numa_initialize(void)
>  
>  int get_available_cpus(struct bitmask *cpumask)
>  {
> +	cpu_set_t cpuset;
> +	int ret;
> +
>  	if (cpumask)
>  		return numa_bitmask_weight(cpumask);
>  
> -	return numa_num_task_cpus();
> +	CPU_ZERO(&cpuset);
> +
> +	ret = sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
> +	if (ret < 0)
> +		fatal("sched_getaffinity failed: %m\n");
> +
> +	return CPU_COUNT(&cpuset);
>  }
>  
>  int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
> -- 
> 2.39.0
> 

In cyclictest we have

	if (num_threads == -1)
		num_threads = get_available_cpus(affinity_mask);


But the num_threads can be set to -1 in OPT_THREADS too,
not just for OPT_SMP

John Kacur

