Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D4C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFE60C40
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBKE3B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKE27 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 23:28:59 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51DC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:28:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id b24so3295358qtp.13
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BJWs1VsmmFF++D6drfKpbH90sufr6aj0uc7zrll3fhc=;
        b=T7ovj+2tZ+WimKxHvwMQNVHN8855Ak3EOWgHV8Fh2AaWQ0gFgeT+795fyRFwIqk5ti
         YWsBGaXbiRnEd88Lu0K78sCZkKylfUaz5N9M6XQL9irbkc9taQ8avs18wtWJQg2GkasH
         WzZR5EQnxGclwRs57JHjUrFFlGSmRYPvZ0NA1JSMl/3NfIICsUZ/NH/E8H1e+FI0Ra4z
         hSRfczpQfwxYh71VjNwvavdDQ0j1pqIWnDxKdxbBsbi0kP4YIw+GYcqCOEqXjcRt+jZp
         UzbHA6BJWy9Fml/V3OaUvW9nt6sRad8o11eLpq76eDB/RnZo+goZh6l7i5spkDdzN6lH
         9vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=BJWs1VsmmFF++D6drfKpbH90sufr6aj0uc7zrll3fhc=;
        b=qG57+gjP/fLszyk+P762+PPAZsDEldAaMS5n4F6KHHGor55eqoZXEz7AaCdpHTejwm
         WEstiz6lHAuCjm2NWMiZJd/3QmtKHadeHqA2feLPaYnnddyJt0OrYa1FVk8YnJnoyev1
         ZwKK2i4fis4smsA7RbNNH3lSJy4kPInpYX7mkkAXyAkGj79Z3M1HLRK9/T8Fr1A34v+O
         mlM+jfUYEBMh6OBz0pdYygiyxN7g/TKt7CxV+YNQLKXx8QfFC/8TOcIf2qXCPzD+TAlF
         Hp6X+ODaVf2LmHuMwjR//pmlfaiMFfvsf3w2mtARAuh4ZRUorxA9WJm7+2Y6BuJMmOuC
         zuig==
X-Gm-Message-State: AOAM531+QWGfvalMe/5lM7pRD2fp0WdVwzOtF+/QixQXk6cQ4wKEippP
        1i2Ox0ziPvSmGRhZeVdxmryU5UQCPDOoIQ==
X-Google-Smtp-Source: ABdhPJyYULleMWDDdKqa0kysITLhncTIG/h1PdoT/RpjrpVTRgvIXFtdCzYIGGtkbKdgvWWCLrmcsw==
X-Received: by 2002:ac8:60c9:: with SMTP id i9mr6108808qtm.88.1613017697549;
        Wed, 10 Feb 2021 20:28:17 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id m21sm2759142qtq.52.2021.02.10.20.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:28:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 10 Feb 2021 23:28:16 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 2/2] oslat: Use cpuset size as upper bound
In-Reply-To: <20210210165407.9770-3-dwagner@suse.de>
Message-ID: <fe39aaf5-57f5-c36a-70ea-af212318ea@redhat.com>
References: <20210210165407.9770-1-dwagner@suse.de> <20210210165407.9770-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> To assign the threads to the correct CPU we need to use the cpuset
> size as upper bound for the loop and not the number of threads.
> 
> Fixes: 85b0763dacd9 ("oslat: Use parse_cpumask() from rt-numa.h")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index d3f659b218b0..62b82098419a 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -742,9 +742,12 @@ int main(int argc, char *argv[])
>  	n_cores = numa_bitmask_weight(cpu_set);
>  
>  	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
> -	for (i = 0; i < n_cores; ++i)
> -		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0)
> +	for (i = 0; n_cores && i < cpu_set->size; i++) {
> +		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0) {
>  			threads[g.n_threads_total++].core_i = i;
> +			n_cores--;
> +		}
> +	}
>  
>  	if (numa_bitmask_isbitset(cpu_set, 0) && g.rtprio)
>  		printf("WARNING: Running SCHED_FIFO workload on CPU 0 may hang the thread\n");
> -- 
> 2.30.0
> 
> 

This looks okay, but we are waiting for Pradipta's testing to confirm 
before I push it.

Thanks

John
