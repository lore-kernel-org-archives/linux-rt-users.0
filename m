Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CEB6108B
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhIMSki (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235873AbhIMSkg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 14:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qkukz/WQEFi8bUQwB8wpSrXC0dQKOXS+pNB/cTjwMgA=;
        b=FMldl34DXfG86gzELNmauyXm1D0QCKeIBZ0p03Ia/j2ympcFeZFfGPbGf41kjq9qvbZOFS
        tkBJM+njBn/S6w5oBPUNXYU3DzsY/l9Pz9+aIhaT+vsU3ffAvq7fvLRIQX8dEnjUiDncs3
        1ah3c3gTmCWzixnBmH0TGp/xUDgCr/A=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-4secJOIkO3udsY8s4-f4_Q-1; Mon, 13 Sep 2021 14:39:17 -0400
X-MC-Unique: 4secJOIkO3udsY8s4-f4_Q-1
Received: by mail-io1-f72.google.com with SMTP id g2-20020a6b7602000000b005be59530196so14529368iom.0
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 11:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Qkukz/WQEFi8bUQwB8wpSrXC0dQKOXS+pNB/cTjwMgA=;
        b=MZSHh1KupzfepPKjVe0N79yRZpL1XUSp+DEoQfZRh6JF/kVNbjbB4D6vJXCHaLKoxd
         wkc/6ky5cBhDh7SRa2+QHmcBumgupoSqpWlPheX04McFHs7FhaF+su1pk0qZF4QA54Kg
         nX/bVeNFmzy916FJQIGw+2ISex9uqzNTI2cXQ13EfwKfEDt8tIlrEGURPoWtzdFx5GZN
         p7ryrUUvyalqV5/LDxzUp1pENxFthP2NqT33sTm6+ZCby2rmgzpKv3MpWQ4qfoWA+Y5C
         faW2N4GF5kjzWonDOTwJILlnENWFEMGQXC6QKwakZQgeOTx8ulhTykggBDjWf4/l1MRp
         1R0A==
X-Gm-Message-State: AOAM532JGVXNZkcje5wbOSQrwE5a8SKFSdAALsCM4ZYFGk6DsBidMnUW
        VMxieigMiJnyMLdaWBf/3US0HnWxwKeme25gdX7D1ZGvqT2SvMmbaSpsyfCLjsfTanOCJNftQwx
        S3uYgvAdYVK3jrozFOXLcIlP2Ces=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr8896447ilq.121.1631558356712;
        Mon, 13 Sep 2021 11:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVFvBkstHw1nqoZMfQBt4IGDBG6ca9Fg/xqGmHY2mEcSBmNPr9OOjsTCbSnHh5abR1l4dnGA==
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr8896434ilq.121.1631558356553;
        Mon, 13 Sep 2021 11:39:16 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id h9sm5015718ioz.30.2021.09.13.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:39:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 14:39:15 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2 3/3] oslat: Allow for arch specific counter frequency
 measurements
In-Reply-To: <20210913083908.48408-3-nsaenzju@redhat.com>
Message-ID: <502acee-636e-1a93-f0d8-f191a24282@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com> <20210913083908.48408-3-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Nicolas Saenz Julienne wrote:

> Some architectures have special purpose registers to query the system
> counter's frequency. Let's use that when available.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> --
> 
> Changes since v1:
>  - Use cleaner method to have generic and arch functions to measure
>    couter's freq
> 
>  src/oslat/oslat.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index c90ec1a..5fce223 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -74,6 +74,16 @@ static inline void frc(uint64_t *pval)
>  # elif defined(__aarch64__)
>  #  define relax()          __asm__ __volatile("yield" : : : "memory")
>  
> +#define arch_measure_counter_mhz
> +static unsigned int measure_counter_mhz(void)
> +{
> +	unsigned int val;
> +
> +	__asm__ __volatile__("mrs %0, cntfrq_el0" : "=r" (val));
> +
> +	return val / 1e6;
> +}
> +
>  static inline void frc(uint64_t *pval)
>  {
>  	/*
> @@ -241,6 +251,7 @@ static int move_to_core(int core_i)
>  	return sched_setaffinity(0, sizeof(cpus), &cpus);
>  }
>  
> +#ifndef arch_measure_counter_mhz
>  static cycles_t __measure_counter_hz(void)
>  {
>  	struct timeval tvs, tve;
> @@ -273,6 +284,7 @@ static unsigned int measure_counter_mhz(void)
>  
>  	return (unsigned int) (m / 1000000);
>  }
> +#endif
>  
>  static void thread_init(struct thread *t)
>  {
> -- 
> 2.31.1
> 
> 
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>

