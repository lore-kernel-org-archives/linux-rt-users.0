Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED99C46CA1
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Sep 2023 15:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjIRPRj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIRPRi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Sep 2023 11:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C946DDB
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Sep 2023 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695050205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEA6VDQPJOXu5AXx1LQuhsOW5LNyWyh2/a6/SrXAAHY=;
        b=KY6CTCb3ehc38la0GYMDp0xGRoYZvWLdVbV8/p1Ne9Ycx6nzxTkY5ZU6Dkw/ZJHZxyg8rm
        1LenRiTEGDAe0nA5hMPZ2KzEuMx3PlCIQWoXWp0K+QD/GrMBTLZJ/tPDDq7eGkKmLKO9HU
        g1gL1pF0HzRHQjkGvTUqU+10aZAJZzk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-hzDBk8sePtaUmvA9_MgzWA-1; Mon, 18 Sep 2023 11:15:40 -0400
X-MC-Unique: hzDBk8sePtaUmvA9_MgzWA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65825867403so7434006d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Sep 2023 08:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050140; x=1695654940;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEA6VDQPJOXu5AXx1LQuhsOW5LNyWyh2/a6/SrXAAHY=;
        b=LS7K8IRkdbsvPLDGxlPQanJ8BqHeqvis99gFA8SeVssf0LlqDro5aL9pvq8Colxze9
         sP+18L3t+Qcx0ZjwzGM9j0y2RHj/+xulwlLGHuvt062QJq7mEa/HGe6ASm42YXrhbVsn
         IBM3Y2VI1RpNWGRTCz6ivACGf8zAvnkHyL4r5e39bR5cALjzKrPF3mHc1ZkvYpffEIdu
         k2gRkYyYVSn0ij7vwg0oo7JzYS9/pcE1DHPCHH9tkpyYc98U7JEh1EuUwjyPurIUvWak
         Q5H3kQlpPGOeKIQcLMvx1DIExvXgYbtgvc5SlVTB9qzwqE4EhLIjPOgMGs9cEkLm6QB/
         DNEA==
X-Gm-Message-State: AOJu0YwWOcLbxT/MmdcfTvgfkuzj3Q7GewVVKl1nSTQRLiFib1UOVydg
        MoVbaC8yOnTGbWL36GCdczs0QoeDjKBQ0KbeyOR9Uxg+7nd3Q8gqeNeJJqhMK6CNLveXR8XVVKw
        nPt6ae4+TXrV56ro0rkEuSXeLrK8=
X-Received: by 2002:a0c:f509:0:b0:658:3d4e:a0c8 with SMTP id j9-20020a0cf509000000b006583d4ea0c8mr729848qvm.9.1695050139872;
        Mon, 18 Sep 2023 08:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7LHlWGAtDrgC+YxUkWDTqe5EeR+36z8ClbI8BS+l4693zIwW9hZbgyKUsLhTydyMZh6+DiA==
X-Received: by 2002:a0c:f509:0:b0:658:3d4e:a0c8 with SMTP id j9-20020a0cf509000000b006583d4ea0c8mr729833qvm.9.1695050139598;
        Mon, 18 Sep 2023 08:15:39 -0700 (PDT)
Received: from fionn ([174.88.88.130])
        by smtp.gmail.com with ESMTPSA id j17-20020a0cf311000000b0065635a05e64sm2659035qvl.20.2023.09.18.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:15:39 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:12:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Eder Zulian <ezulian@redhat.com>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2] rt-tests: cyclictest: Remove warnings due different
 signedness in comparison
In-Reply-To: <20230811154247.481194-1-ezulian@redhat.com>
Message-ID: <e4f72415-a77-11dd-c2fc-14bb45e6c7c6@redhat.com>
References: <20230811154247.481194-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 11 Aug 2023, Eder Zulian wrote:

> Type casting used to remove compiler warnings due to comparison of
> integer expressions of different signedness.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
> v2: Cleaned up coding style and addressed review comments
> 
>  src/cyclictest/cyclictest.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4a7108e..179ae8b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -317,8 +317,10 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
>  		return err;
>  	}
>  
> -	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
> -	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
> +	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned int)policy_max
> +						    : rlim.rlim_cur;
> +	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned int)policy_max
> +						    : rlim.rlim_max;
>  
>  	if (prio > soft_max && prio <= hard_max) {
>  		rlim.rlim_cur = prio;
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

