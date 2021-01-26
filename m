Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB3C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31C0206B5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhA0Dx6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbhAZFLg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 00:11:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEEC061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:10:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so11520737qtn.0
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GyY09jMr0+RGJM96uH2CD4RDZ49vBAWSD/1rjRTIZwo=;
        b=H6ej+XluJSbFiJBBTpCcBEnks+eOkVTxgHPL6NjE4H7ZTeUsHCLWao/vQbVVkjoMxY
         Zss9qhd1UUwvPmw9OwD3GFx4IrL0bhpqxDGQFuBPDrk9Wps0DbXk20yQWr9KS3/MiWLp
         vjK+5FwA6+3odChPbq/s0TXS6uD7NLR8BPcBvyTeoy6my1SA50zdVDR98gpkwwTtu6/o
         my2UnN4KV1UaqHwX9xC3KJmrSnBJmqOZr9vbgJnS3Ebc0BeNfqjqrOxKpUiqANCXsDZX
         u/11RC4E30fHMhK13tDYgVYh9Moy0g1CURleYoTZh0+bGqa/B/ZsB+ek+Qwj7ZH/d6IO
         dodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=GyY09jMr0+RGJM96uH2CD4RDZ49vBAWSD/1rjRTIZwo=;
        b=G6x3mg4/919tpXxLOTqEK068kneOiec83rBKtuQ+nCWU5WdMk2kNhB3ApVCY1/+ICg
         0PDb3K5RLouJ3CBDW5Fu1PxG4a521l7EhgrpogNugnKrLz8o35gf7c/A16LTKp6okC56
         vXhLKxGI8Ob7CNYhSYLqhcnRjfLU0EpXqiuN7G6GBi/k6qJTTWlAOXfae0nQBSXVGJNN
         LL4rvK7as3vCxI4GVCEjWOIGy8R+Hv4eAfIOqO3Hhu2D422RQlbXzw6I0P3Zukcj1174
         X8TTC6xDgF8pRxJrqvUnCjc0T5xEntehZljf3N0srMzufJJPKI3+j/Z4KewnONbRDYr/
         Ys6g==
X-Gm-Message-State: AOAM531B96NS5ghim+ZVU1wKvmfLCkovXns65nwXwoTLaIL2ZwkIcMef
        XioM3ilaVkJw6p4ItijJPpo=
X-Google-Smtp-Source: ABdhPJwAUiOLhD9Kqpz+u6WlL70YzKzH7ycSbhmdei3MB0Pa74MKZxGl9YariXIipQof1y/fO9BcxA==
X-Received: by 2002:ac8:480e:: with SMTP id g14mr3874312qtq.377.1611637856221;
        Mon, 25 Jan 2021 21:10:56 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id d9sm5809932qko.84.2021.01.25.21.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:10:55 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 00:10:51 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <20201218161843.1764-2-dwagner@suse.de>
Message-ID: <cf944ef0-a7e1-c0ee-f0ad-f7b98b7a7412@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> libnuma is hard dependency for cyclictest. Thus we can always call
> numa_initialize(). This allows us to remove the global 'numa' variable
> to track if libnuma has been initialized or not.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 63 +++++++++++++++++--------------------
>  src/cyclictest/rt_numa.h    |  2 --
>  2 files changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f38c453f1975..514ed7b20fdb 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1018,9 +1018,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			/* smp sets AFFINITY_USEALL in OPT_SMP */
>  			if (smp)
>  				break;
> -			if (numa_initialize())
> -				fatal("Couldn't initialize libnuma");
> -			numa = 1;
>  			if (optarg) {
>  				parse_cpumask(optarg, max_cpus, &affinity_mask);
>  				setaffinity = AFFINITY_SPECIFIED;
> @@ -1126,8 +1123,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			use_system = MODE_SYS_OFFSET; break;
>  		case 'S':
>  		case OPT_SMP: /* SMP testing */
> -			if (numa)
> -				fatal("numa and smp options are mutually exclusive\n");
>  			smp = 1;
>  			num_threads = -1; /* update after parsing */
>  			setaffinity = AFFINITY_USEALL;
> @@ -1201,16 +1196,17 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  
>  	/* if smp wasn't requested, test for numa automatically */
>  	if (!smp) {
> -		if (numa_initialize())
> -			fatal("Couldn't initialize libnuma");
> -		numa = 1;
>  		if (setaffinity == AFFINITY_UNSPECIFIED)
>  			setaffinity = AFFINITY_USEALL;
>  	}
>  
> -	if (option_affinity) {
> -		if (smp)
> -			warn("-a ignored due to smp mode\n");
> +	if (option_affinity && smp) {
> +		warn("-a ignored due to smp mode\n");
> +		if (affinity_mask) {
> +			numa_bitmask_free(affinity_mask);
> +			affinity_mask = NULL;
> +		}
> +		setaffinity = AFFINITY_USEALL;
>  	}
>  
>  	if (smi) {
> @@ -1744,6 +1740,12 @@ int main(int argc, char **argv)
>  	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	int i, ret = -1;
>  	int status;
> +	void *stack;
> +	void *currstk;
> +	size_t stksize;
> +
> +	if (numa_initialize())
> +		fatal("Couldn't initialize libnuma");
>  
>  	process_options(argc, argv, max_cpus);
>  
> @@ -1926,34 +1928,27 @@ int main(int argc, char **argv)
>  		default: cpu = -1;
>  		}
>  
> -		node = -1;
> -		if (numa) {
> -			void *stack;
> -			void *currstk;
> -			size_t stksize;
> +		/* find the memory node associated with the cpu i */
> +		node = rt_numa_numa_node_of_cpu(cpu);
>  
> -			/* find the memory node associated with the cpu i */
> -			node = rt_numa_numa_node_of_cpu(cpu);
> +		/* get the stack size set for this thread */
> +		if (pthread_attr_getstack(&attr, &currstk, &stksize))
> +			fatal("failed to get stack size for thread %d\n", i);
>  
> -			/* get the stack size set for this thread */
> -			if (pthread_attr_getstack(&attr, &currstk, &stksize))
> -				fatal("failed to get stack size for thread %d\n", i);
> +		/* if the stack size is zero, set a default */
> +		if (stksize == 0)
> +			stksize = PTHREAD_STACK_MIN * 2;
>  
> -			/* if the stack size is zero, set a default */
> -			if (stksize == 0)
> -				stksize = PTHREAD_STACK_MIN * 2;
> +		/*  allocate memory for a stack on appropriate node */
> +		stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
>  
> -			/*  allocate memory for a stack on appropriate node */
> -			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
> +		/* touch the stack pages to pre-fault them in */
> +		memset(stack, 0, stksize);
>  
> -			/* touch the stack pages to pre-fault them in */
> -			memset(stack, 0, stksize);
> -
> -			/* set the thread's stack */
> -			if (pthread_attr_setstack(&attr, stack, stksize))
> -				fatal("failed to set stack addr for thread %d to 0x%x\n",
> -				      i, stack+stksize);
> -		}
> +		/* set the thread's stack */
> +		if (pthread_attr_setstack(&attr, stack, stksize))
> +			fatal("failed to set stack addr for thread %d to 0x%x\n",
> +				i, stack+stksize);
>  
>  		/* allocate the thread's parameter block  */
>  		parameters[i] = par = threadalloc(sizeof(struct thread_param), node);
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index 46690941e0a6..8d02f419ed6d 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -13,8 +13,6 @@
>  #include "rt-utils.h"
>  #include "error.h"
>  
> -static int numa = 0;
> -
>  #include <numa.h>
>  
>  static void *
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
