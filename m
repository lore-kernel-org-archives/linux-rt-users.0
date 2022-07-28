Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4929C04A68
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jul 2022 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiG1OsG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiG1OsG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jul 2022 10:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD30222A2
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659019684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkD1Br86yA/fua+TJqxDZgBBscqkMJ6MzDuPL/V9Skk=;
        b=icRbvBJrOUDveYZPvfGliuNbncaDfdwXp8r3WJDCRUdM1oVEFaJEUK0wJ+6wSk/2xPYfvP
        LOEOJRGyPP76idCIe8sQwXIYAKtdnK1VxS9LqvrXlUX5cuaErS7Q02X9kfLReaobYMDMPI
        GxDGn1ugkN12o9heKgiJccNYxOKD67Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-h4anMedFONqo-RHCUmoooA-1; Thu, 28 Jul 2022 10:48:02 -0400
X-MC-Unique: h4anMedFONqo-RHCUmoooA-1
Received: by mail-qv1-f70.google.com with SMTP id k7-20020a056214102700b004740a13b3bcso1456312qvr.4
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 07:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=qkD1Br86yA/fua+TJqxDZgBBscqkMJ6MzDuPL/V9Skk=;
        b=J6+sKgRP0lAiWNZhV7Bw/W0Zo6QrAhx44wV8TM4CtzdNSk1JddMWoMLhZFpL7eWfuv
         rtuHMc7Z4L5DSwsJvhXorCpbNIiEk/e7JSSnEIc1KvvOpI/GZisdHw/TO/3osMtgW0aP
         dKadI49zYap3up4NKp9/Q0aGlU1vNAZ36TJIZUamTcPH6xh3YhhyJIftNWkSXhcCfr/x
         IDSvo2eiBZfI4l1M9Vxh8jNPcNBh9p+l2qCRcR/2QxN1pvQttVcvCYxgxgUF7DtXJJ/w
         F5A+z5PIhPL3W/rPsHF3UF0Cn4H7WX68Jy+uKlZ+G+hHNWw43FaCJJc9DxX9/83O3xDq
         6Veg==
X-Gm-Message-State: AJIora/JZKGtyTDB75KhlVlrP6G+07WaVDGtxLYYK26vTcrWSF8Sm/Xb
        2WhUFvP+CR1njuguV7G46ULuKBx9sSDasFeht5gGXwX4ENCgrnHR6R3tNj8qdKojzzqywDYvQK5
        yQQswkeStnbZzPTYrHm8y+53eDBA=
X-Received: by 2002:a05:620a:19a9:b0:6b6:4f9c:fc24 with SMTP id bm41-20020a05620a19a900b006b64f9cfc24mr16888018qkb.252.1659019681414;
        Thu, 28 Jul 2022 07:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veNJ7HvaoTfAvRF184uPTD1tH7XjT1fl2CVrrEYos7q3QiCGCO8A2IIAOmkMlIFP9N67qB0w==
X-Received: by 2002:a05:620a:19a9:b0:6b6:4f9c:fc24 with SMTP id bm41-20020a05620a19a900b006b64f9cfc24mr16888004qkb.252.1659019681127;
        Thu, 28 Jul 2022 07:48:01 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id s8-20020ac85cc8000000b0031ebb1f8918sm572278qta.76.2022.07.28.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:48:00 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:47:44 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     John Stultz <jstultz@google.com>
cc:     linux-rt-users@vger.kernel.org,
        Connor O'Brien <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] cyclictest: Fix threads being affined even when -a isn't
 set
In-Reply-To: <20220726180502.2932619-1-jstultz@google.com>
Message-ID: <da2be617-4f3e-9733-2ae3-42d1c271107a@redhat.com>
References: <20220726180502.2932619-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jul 2022, John Stultz wrote:

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
> AFFINITY_USEALL by default.
> 
> With this patch, we no longer call pthread_setaffinity_np() in the
> "./cyclictest -t -q -D1"  case.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  src/cyclictest/cyclictest.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index decea78..02f32f6 100644
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
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
> 

Okay, I see what's happening. We removed the numa flag to automate if 
the user doesn't specify smi, then we use numa if we detect that it is 
available and in that case we assume AFFINITY_USEALL. Part of this was an 
attempt to reduce the alphabet soup that the cyclictest commandline was 
becoming. However, I see your point, if a person doesn't ask for affinity, 
then, it shouldn't be assumed.

Your patch of course doesn't work as it is, because we'll end-up passing a 
cpu=-1 value to rt_numa_numa_node_of_cpu(int cpu) resulting in
FATAL: invalid cpu passed to numa_node_of_cpu(-1)
but it illustrated your point.

I'm off for a few days, but I'll tackle this when I come back on.

Thanks

John

