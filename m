Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF71C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E9D64E2F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBSQzA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSQy7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:54:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B97C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:54:19 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v206so6145214qkb.3
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+8meYH2i9E9gUhYyGCMLHd2VFee0uT+URz4nk6QIU5E=;
        b=ZHfO1JMGkfArfWmX5TKgTZJEhRJJYTxmxkUuOXemnV7xlhXMIEKrTtaMLasf8kU+kI
         mlOokxseDkjGsxjENjr8Ixmm7gcB3Hrh5wibQI8aLAZLncUQwxCgfqn6RTDCic4kOMSC
         7hwxg3aLA4qUhtgB87K8PsT26H4usJqi87FJULaqCrIYMtITBxlL8jb/PU4JFZhAJIdu
         /YG0U5KBKxmiDbaIWijwCGCsfjHE5T6FuG02TzcYbetJ/FlQI2xOVc1hKEPSepDG7eCK
         UGDFFouA8oj7L6JoWwZjXQs7lL+5XsKmonOtUaZOr4dAc8ff7FPz+A/TNQj6NgP96K7k
         PwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=+8meYH2i9E9gUhYyGCMLHd2VFee0uT+URz4nk6QIU5E=;
        b=ufURDCdNb9CY0NIk296LhCXma5w/n9myBM9ZiwayyoVQQgA0hP3OGyp7PVGe9RXJnR
         kqQcsmVzwFM1szM0DpV9Ci9/hoUsNLML/ljTZtH7SJyVAlOFlWl3j+NZ5l1F0nY1RsKV
         1fliGyIatQd2juBMFxu5DE9iBUkpb43qFgZ0JSrpZ0uvkkOCSsa/JRQfemt5tXMO3DdG
         gedDMMwyPLnRTtTvcWvpcsikrK7xktPM7yKsx6muGMvKeHmJPbxVnKEZha2EkFTV/StK
         ICRmxpBXLrv+eeSdPrm2vTHTZmFeOxCoPA0HfmTQQRfa4lcbbuYr7+t/wLiEvOZ2ukMZ
         pP4A==
X-Gm-Message-State: AOAM532Hs6dYa+HSqCgZWN/wUZmU+6iUn1sNx6POwFi7Z/OHxMrWTtMY
        ohEUtMxcIzTyi/fQP4jQlB4=
X-Google-Smtp-Source: ABdhPJysFnqyTyDZA5zSq425gI3RzHgZ1uIu51c6LzK9a+/r+XL2wTkEuMgX4/6rPZhGrqtznYQKMA==
X-Received: by 2002:a37:c20a:: with SMTP id i10mr10585341qkm.142.1613753658283;
        Fri, 19 Feb 2021 08:54:18 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r17sm5813482qta.78.2021.02.19.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:54:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:54:16 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
In-Reply-To: <20210218192729.116427-1-peterx@redhat.com>
Message-ID: <16577614-5c1e-c74c-6cdc-9811a96e36d8@redhat.com>
References: <20210218192729.116427-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 18 Feb 2021, Peter Xu wrote:

> parse_cpumask() is too strict for oslat, in that use_current_cpuset() will
> filter out all the cores that are not allowed for current process to run.  This
> seems to be unnecessary at least for oslat.  For example, the bash process that
> runs the oslat program may have a sched affinity of 0-2, however it's still
> legal to have it start a oslat thread running on the cores outside 0-2 as long
> as the follow up sched_setaffinity() will succeed.
> 
> numa_parse_cpustring_all() suites exactly for this case, which should already
> have considered sysconf(_SC_NPROCESSORS_ONLN) limit.  Use that instead.
> 
> Since at it, also remove initialization of cpu_set variable otherwise it's
> leaked in previous parse_cpumask too: numa_parse_cpustring_all() will return a
> newly allocated buffer already.  Quotting from manual:
> 
>     numa_parse_nodestring() parses a character string list of nodes into a bit
>     mask.  The bit mask is allocated by numa_allocate_nodemask().
> 
>     numa_parse_nodestring_all() is similar to numa_parse_nodestring, but can
>     parse all possible nodes, not only current nodeset.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Clark Williams <williams@redhat.com>
> Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>
> Reported-by: Mike Stowell <mstowell@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  src/oslat/oslat.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index b2c5373..465a694 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -785,7 +785,6 @@ int main(int argc, char *argv[])
>  	struct thread *threads;
>  	int i, n_cores;
>  	struct bitmask *cpu_set = NULL;
> -	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  
>  #ifdef FRC_MISSING
>  	printf("This architecture is not yet supported. "
> @@ -797,10 +796,6 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	cpu_set = numa_allocate_cpumask();
> -	if (!cpu_set)
> -		fatal("oslat: Could not allocate cpumask\n");
> -
>  	g.app_name = argv[0];
>  	g.rtprio = 0;
>  	g.bucket_size = BUCKET_SIZE;
> @@ -817,7 +812,8 @@ int main(int argc, char *argv[])
>  	if (!g.cpu_list)
>  		g.cpu_list = strdup("all");
>  
> -	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set) != 0)
> +	cpu_set = numa_parse_cpustring_all(g.cpu_list);
> +	if (!cpu_set)
>  		fatal("oslat: parse_cpumask failed.\n");
>  	n_cores = numa_bitmask_weight(cpu_set);
>  
> -- 
> 2.26.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
