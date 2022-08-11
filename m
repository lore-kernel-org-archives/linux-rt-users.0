Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971AC19F2A
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Aug 2022 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiHKR5n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKR5k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Aug 2022 13:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5DBBA220C
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660240656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msyZijY6IZN+5cle7R//TDxgyPbbX7VS3xSeb0Hw1ME=;
        b=TDXfV22zOIY5diPZUDLBLye3Lc9+uv2Tq+09TSvtECIiO/tf3FUc0LVoiSFO3pQUogQbbQ
        mXpAJQ26JrW4QfeG0IjMUKptVNDxqF2rpn6c9SjxYfIeryTObxWIdY+/udecvuiRXDBd3A
        GFaHqaiF4od0i1KQn7e7dGROda5GFsU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-KUMgv0xlPw6b4TC2rC4XnQ-1; Thu, 11 Aug 2022 13:57:35 -0400
X-MC-Unique: KUMgv0xlPw6b4TC2rC4XnQ-1
Received: by mail-il1-f197.google.com with SMTP id a19-20020a921a13000000b002df8a28c30dso12370173ila.9
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 10:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=msyZijY6IZN+5cle7R//TDxgyPbbX7VS3xSeb0Hw1ME=;
        b=AC12PDgbEaMhTJsxH+2sGbBe975Vac9Dyjkmb+bx6Er5bpnt+pdU2f68OLJW7sd0n7
         zgz7BaLJyuVqMOUN92nS1BpDSW+vtdFoTLF7bFPFCQH4f1dD80bqDphRupNu3bxHEYNW
         WFcPdFps0AueWByL8NrzVVXUtR/Wkno+g6dm8BtDbUfgY1k3TX6B0SsywBZkkPI/JGX8
         Mv85bkm0DqnYSJgJOsV5o9b7BdJsPlXfAaL42E0YN/XlCDu4sgRNiHiHnjbq5ZopvmUj
         6gsc5aDHeKn9Mdf7ufd7gjVSm0cBQwK5YuLwkXW5771gmVsFGnTPFFnF/Rtc8kTaylNb
         oh5Q==
X-Gm-Message-State: ACgBeo3mlmukJMKPlrOU00Jte7U/D69CUYUEdLlIW7OWuqMRNIQlI/wr
        oJOETvIh9LsCfCTeMz5o7yyBcpoIBB5ozCb8iIymhrSU75Q+IsWBh6BefRZ9hWEV6rFEk328Vc2
        1bxuqzZ7vBpjFdnlvYDsTK8cOp6E=
X-Received: by 2002:a05:6e02:1707:b0:2e0:d676:52f0 with SMTP id u7-20020a056e02170700b002e0d67652f0mr174070ill.78.1660240654860;
        Thu, 11 Aug 2022 10:57:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UTTHL5PXKQr34sXidgvAPF2oIJp6MEj8M/ngsdF8RL7SCu14m+pK0AHUtK46MgBlKLTcDVA==
X-Received: by 2002:a05:6e02:1707:b0:2e0:d676:52f0 with SMTP id u7-20020a056e02170700b002e0d67652f0mr174058ill.78.1660240654600;
        Thu, 11 Aug 2022 10:57:34 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id j189-20020a0263c6000000b00341d7c43ed5sm48273jac.73.2022.08.11.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:57:34 -0700 (PDT)
Date:   Thu, 11 Aug 2022 13:57:07 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     John Stultz <jstultz@google.com>
cc:     linux-rt-users@vger.kernel.org,
        Connor O'Brien <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2] cyclictest: Fix threads being affined even when -a
 isn't set
In-Reply-To: <20220728202236.3998964-1-jstultz@google.com>
Message-ID: <dc8e8275-d242-6766-b799-fb23a952398e@redhat.com>
References: <20220728202236.3998964-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 28 Jul 2022, John Stultz wrote:

> Using cyclictest without specifying affinity via -a, I was
> noticing a strange issue where the rt threads where not
> migrating when being blocked.
> 
> After lots of debugging in the kernel, I found its actually an
> issue with cyclictest.
> 
> When using -t there is no behavioral difference between specifying
> -a or not specifying -a.
> 
> This can be confirmed by adding printf messages around the
> pthread_setaffinity_np() call in the threadtest function.
> 
> Currently:
> 
> root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
> Affining thread 0 to cpu: 0
> Affining thread 1 to cpu: 1
> Affining thread 2 to cpu: 2
> Affining thread 3 to cpu: 3
> Affining thread 4 to cpu: 4
> Affining thread 5 to cpu: 5
> Affining thread 7 to cpu: 7
> Affining thread 6 to cpu: 6
> T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
> ...
> 
> root@localhost:~/rt-tests# ./cyclictest -t -q -D1
> Affining thread 0 to cpu: 0
> Affining thread 1 to cpu: 1
> Affining thread 2 to cpu: 2
> Affining thread 3 to cpu: 3
> Affining thread 4 to cpu: 4
> Affining thread 5 to cpu: 5
> Affining thread 6 to cpu: 6
> Affining thread 7 to cpu: 7
> T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
> ..
> 
> This issue seems to come from the logic in process_options():
> 	/* if smp wasn't requested, test for numa automatically */
> 	if (!smp) {
> 		numa = numa_initialize();
> 		if (setaffinity == AFFINITY_UNSPECIFIED)
> 			setaffinity = AFFINITY_USEALL;
>         }
> 
> Here, by setting setaffinity = AFFINITY_USEALL, we effectively
> pin each thread to its respective cpu, same as the "-a" option.
> 
> This was most recently introduced in commit bdb8350f1b0b
> ("Revert "cyclictest: Use affinity_mask for steering
> thread placement"").
> 
> This seems erronious to me, so I wanted to share this patch
> which removes the overriding AFFINITY_UNSPECIFIED with
> AFFINITY_USEALL by default. Also, some additional tweaks to
> preserve the existing numa allocation affinity.
> 
> With this patch, we no longer call pthread_setaffinity_np() in the
> "./cyclictest -t -q -D1"  case.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2: Fixes error passing cpu = -1 to rt_numa_numa_node_of_cpu()
> ---
>  src/cyclictest/cyclictest.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index decea78..82759d1 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  	/* if smp wasn't requested, test for numa automatically */
>  	if (!smp) {
>  		numa = numa_initialize();
> -		if (setaffinity == AFFINITY_UNSPECIFIED)
> -			setaffinity = AFFINITY_USEALL;
>  	}
>  
>  	if (option_affinity) {
> @@ -2043,9 +2041,13 @@ int main(int argc, char **argv)
>  			void *stack;
>  			void *currstk;
>  			size_t stksize;
> +			int node_cpu = cpu;
> +
> +			if (node_cpu == -1)
> +				node_cpu = cpu_for_thread_ua(i, max_cpus);
>  
>  			/* find the memory node associated with the cpu i */
> -			node = rt_numa_numa_node_of_cpu(cpu);
> +			node = rt_numa_numa_node_of_cpu(node_cpu);
>  
>  			/* get the stack size set for this thread */
>  			if (pthread_attr_getstack(&attr, &currstk, &stksize))
> @@ -2056,7 +2058,7 @@ int main(int argc, char **argv)
>  				stksize = PTHREAD_STACK_MIN * 2;
>  
>  			/*  allocate memory for a stack on appropriate node */
> -			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
> +			stack = rt_numa_numa_alloc_onnode(stksize, node, node_cpu);
>  
>  			/* touch the stack pages to pre-fault them in */
>  			memset(stack, 0, stksize);
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
> 

Still thinking about this, I guess if we go with the above change it will 
mean that to get meaningful numa behaviour you'll need to specify -a

This is what happened, inorder to reduce the alphabet soup of cyclictest 
options, we decided that if you don't specify --smp, we would test if 
numa was available and go with that and both implied -a, so we are missing
a third option.

Another possibility I guess would be to put back --numa, since it's 
starting to appear that the cure was worse than the disease. At least
that's more explicit than using -a to get numa behaviour.

Or if -a is unused we could have a --no--affinity

Not sure yet.

John

