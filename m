Return-Path: <SRS0=WLQy=6I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55880C54FD0
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226C920661
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Apr 2020 21:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOKaYZc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDXVAJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDXVAJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Apr 2020 17:00:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32DC09B048
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Apr 2020 14:00:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o19so11703998qkk.5
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Apr 2020 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/xmRxv81/5nAuw4gojUMd1MrZ7ZErbeCitc9LcWL2+Y=;
        b=IOKaYZc/qZAMIYAruOwRjXmBKrWvv0jldxbZO01fXzkulgIUldDQwVnkjc4eev/WQW
         oXuo3KFbGamKkKN8dnFJ6pLr4smz+dHt58D/b8VWdbWa08gwIor8eWVutYhhMuqmdrTi
         LdwDcMm/mu8KNgqwLC09X0bZxbXL1LJHG+SU6wi+8sGsySbFKkWFlOJOdQgTBMZwISWz
         FedNg8UxsmM7S/TAx7Oq+3b/ieaO+TsXG/3nYIr8huOAYpZnw261UHvdkDQj1UY3BSD9
         KNwiBgd+AKfKLWnGbczEQ7tr5VTz3SkluQQ0w8SuayXLp+T1+kNDFGTnmlaLRTRnLt0k
         uQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=/xmRxv81/5nAuw4gojUMd1MrZ7ZErbeCitc9LcWL2+Y=;
        b=n8szPeXqh2VfQWm0JRCV+M60sG1qojkAq1VQqoq0y3epediIhKYrm4UbfSJmk4HS/D
         PGfRIxYhdFZuc4w/xiL7nRljWT6mCO/+Rgfk+2FH6QcnYWblJ0yEL2upHfkrvpeI4j9c
         FCqbZK9aV7twLeTK4+1/4d6RpQgG5Gv34UDuCaWeva848i3AXv0bjQBWuaLg9DLsMbeI
         U/vwlSWo/6HPdKLAgGQ+bj8dk93FuiR2yaX89NCw/NhMYAuEmkkmQ0SlwqFJN5NoSZVW
         2AoQEODoqyww6aLgs8OSnsoUKZY4VTvpJRJyPMng5LZiR/ZFka+d5yD/a7EDWqZrD1dj
         P8Eg==
X-Gm-Message-State: AGi0PuZVWvxw5sJyddNkM2XJfxBCbOxDuAjbjP8bGQpLmXdD5HyqMZcc
        POCEu2V8hkqLHW2ROrPF458=
X-Google-Smtp-Source: APiQypJp3In9sHD4Cz6XQxwMZ4ZRdpClFvX38V2eTe3s3BVA1zsd9k8DVFrPulzBazIP6sctS+P8nw==
X-Received: by 2002:a37:49d5:: with SMTP id w204mr10699262qka.335.1587762008624;
        Fri, 24 Apr 2020 14:00:08 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id d17sm4969950qtb.74.2020.04.24.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 14:00:07 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:59:59 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        hushiyuan@huawei.com, hewenliang4@huawei.com
Subject: Re: [PATCH] rt-tests: cyclictest: Fix -a option fail when max_cpus
 is more
In-Reply-To: <a56715d8-efbc-3104-11d3-47014fa1c5f9@huawei.com>
Message-ID: <alpine.LFD.2.21.2004241659290.9383@planxty>
References: <a56715d8-efbc-3104-11d3-47014fa1c5f9@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 22 Apr 2020, Yunfeng Ye wrote:

> An Error occurs when run: ./cyclictest -v -t 5 -p 80 -i 1000 -a 3
> 
>   parse_cpumask: Using 0 cpus.
>   Max CPUs = 96
>   WARN: Couldn't setaffinity in main thread: Invalid argument
>   # /dev/cpu_dma_latency set to 0us
>   FATAL: No allowable cpus to run on
> 
> We find that numa_bitmask_alloc() is used incorrectly in
> use_current_cpuset(), it should pass the number of cpus as parameters,
> not the sizeof(struct bitmask), which is only 8 bytes.
> 
> The syscall sched_getaffinity will check the parameters, if using
> sizeof(struct bitmask), it will fail when cpus is more:
> 
>   SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
>                 unsigned long __user *, user_mask_ptr)
>   {
>         int ret;
>         cpumask_var_t mask;
> 
>         if ((len * BITS_PER_BYTE) < nr_cpu_ids)
>                 return -EINVAL;
> 
> Fix it by passing max_cpus as parameters to numa_bitmask_alloc().
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c5f1fd46567a..989113fb3483 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1135,7 +1135,7 @@ static void use_current_cpuset(const int max_cpus)
> 
>  	pid = getpid();
> 
> -	curmask = numa_bitmask_alloc(sizeof(struct bitmask));
> +	curmask = numa_bitmask_alloc(max_cpus);
>  	numa_sched_getaffinity(pid, curmask);
> 
>  	/* Clear bits that are not set in both the cpuset from the environment,
> -- 
> 1.8.3.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks!
