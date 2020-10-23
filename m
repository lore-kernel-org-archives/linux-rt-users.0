Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C0C4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D377E221F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evOhw8MT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464345AbgJWPzQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464252AbgJWPzQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 11:55:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D15C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 08:55:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z6so1570303qkz.4
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nT9oVroH0AX0+RJ/ZaKI8uXCKKeHnUabfPrj1JSOzv0=;
        b=evOhw8MT86TJJutsiYkKBqFNYjMladFJ3Fsr4YaihJsONFuyYr+d3V5q7leMkzyXSz
         MZe1f50A5RNk7HWER3Ay8jzYDUnXVHXKGcL208R518stWYPPAFwcmSwuqwdxNiYjSqNE
         rh/08XJPZu9l52XQ3c5KFS6YXWemAAX60+Vi7uJAosAR9n9VE4LV4PY996JWGPkyDOqS
         bHaZ3rvGuBp6cvsNQmhn+n5Jl09WTsOeQqw2Ol9WgLDXnmnw6CrCkuDvDq5SHH3+y+w8
         87fOCY+Lf0T0JhoP3CnlZS0B5A3iLYoX1fVTSy5sVU6qVfVoFjxKc2PDk2Gd+02+eo2I
         oVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=nT9oVroH0AX0+RJ/ZaKI8uXCKKeHnUabfPrj1JSOzv0=;
        b=Ul4u/wE72GJglWy9g1Ln0OGtoNmh0LxNk2HNGjnUE5rWtJN3j0Q50hvqzWZLjP/JDz
         nmIP4MVOiqFOGxfiaA2LhyF4UnXx747dcrlBc7Vhk3MsiozJft/OFrcANKR5pVg35/0S
         oqilZju3MHTMVfVLbL4G9BWs4zgWjKvJXGVY5iaubCr7wp8r3d2+ilau44arjYKT+xV0
         5IQ8x8D8JvCEtGbA/N+hyki+/8+7ynpT/8PdDjxEnuqx8iX/iO0G3hd3f7k3Z1anjfPy
         C/3Bb3AFnV2C4Z5GBZ1JHJTYkEpVrV3kD+0llE70fjOhTioUjdZfEmp/kOlvMqvQKHiD
         cNSA==
X-Gm-Message-State: AOAM531O8cPnRLAFCgDyyAzulmOt/YMY0YATeZGrbegwQdgRPmvGXko6
        rcjDDJtD78oyeU6hRWutoGo=
X-Google-Smtp-Source: ABdhPJz6JTeL8AsfYuD9QsM89/41fVYB1gJqQ/pkXLrdq5XhUcxCbxF1N2kR5O4k/kveugPbLt9pvw==
X-Received: by 2002:a37:9747:: with SMTP id z68mr2753972qkd.424.1603468514710;
        Fri, 23 Oct 2020 08:55:14 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id w11sm1153808qtk.37.2020.10.23.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:55:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 11:55:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 02/18] cyclictest: Use numa library helpers in
 get_available_cpus()
In-Reply-To: <20201007085653.11961-3-dwagner@suse.de>
Message-ID: <6f919aa7-78be-4174-3156-3d8864c3a64d@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> The numa library has support for counting the bits in the affinity
> mask and how many CPUs are available and usable by the tasks. Let's
> use those helpers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 02cb92813fb7..d7477c686435 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -915,26 +915,10 @@ static int clocksources[] = {
>   */
>  static int get_available_cpus(void)
>  {
> -	int num_cpus = 0;
> -	int res;
> -	pthread_t thread;
> -	cpu_set_t cpuset;
> -
> -
> -	if (affinity_mask != NULL) {
> -		num_cpus = rt_numa_bitmask_count(affinity_mask);
> -	} else {
> -		CPU_ZERO(&cpuset);
> -		thread = pthread_self();
> -		res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
> -		if (res != 0) {
> -			fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
> -		}
> -		num_cpus = CPU_COUNT(&cpuset);
> -	}
> -
> -	return num_cpus;
> +	if (affinity_mask)
> +		return numa_bitmask_weight(affinity_mask);
>  
> +	return numa_num_task_cpus();
>  }
>  
>  /* cpu_for_thread AFFINITY_SPECIFIED */
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks!
