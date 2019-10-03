Return-Path: <SRS0=VHVG=X4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDBC32792
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Oct 2019 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7A7215EA
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Oct 2019 11:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On1xLbSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfJCLzr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:55:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCLzq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Oct 2019 07:55:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so2397392ljj.5;
        Thu, 03 Oct 2019 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Paj185Z1oMKKyLaMGojqAMgFwG1hAhXKeOj1AF/nCI=;
        b=On1xLbSvqMHI0gYtjwASGqRJzgHTIvS7/BHXBEjUUgS9zNLVY8TJAJiqal1Ib1ZFAk
         eSCPLTjFLQJ6Mjt+mLrvB0GY8osuGj8H+FOCXfEIsnvOxWvC4e54kk5q6nGj7+nQl9sL
         CvZBQRWNmhCqXni0J31rsmLl7w26YaLU4Bz7n8OgM5NcjcNWDjxjW6tMcYkVTbWYAeqL
         i/Z1qPtjwFqKBMuB7gwyW01oUxHeMrYDlvkQNOmttECn5HqvvLLbnGXybhvCrXQHSidY
         wQmDdQ/7ro2zyth6kCpTXhwt56Kbnnlul8vFyAri1VCOCbBbXQwszKPanxdxjJ5rtKuV
         iseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Paj185Z1oMKKyLaMGojqAMgFwG1hAhXKeOj1AF/nCI=;
        b=bNvE995gAf2LyUgVI5PpuOg+v2xLyTReePge1nr860l5V6jIaXBscvEHg1hKQpAjdD
         iKGZiEP3SWw5wrErcvbHz8SJrShYTBK4cR5AUt5lw54Vh79jTbjwB1hidMjklVv8Vjny
         dAK3OHPQNVWtR598Sv80fty/X4cYs9UBFf3f4EG56NTKypMIKyuRGiLWleC1yo5B+smH
         5OenroEIiekHh0uHpaRIxmk8N765GhDaVUYX7xTU5BjVy5/JJgeUfuUbP6l8ZausEQZ7
         jZ9hp9CL/ShwL8Cs1tWToSLmJVvbi3f2wdGQxkOlOfRRncYesK1dDhNPHzcFwJxT23gb
         tDwQ==
X-Gm-Message-State: APjAAAV2I5ZvvVIk/k4h26+93Rwgwd240yIuE7vn1DFm5GYKGDNsccLo
        RYE+OiOxgaoYtrSqaPf5cFI=
X-Google-Smtp-Source: APXvYqxaeMa1FebqGpGSRyqlv0/0e3gSpyZbRoQVACXNZ9D8AG7XBbriRxQYi19pY2hmp8GIiix6RA==
X-Received: by 2002:a2e:730a:: with SMTP id o10mr6021928ljc.214.1570103744494;
        Thu, 03 Oct 2019 04:55:44 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n25sm475996ljc.107.2019.10.03.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:55:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 3 Oct 2019 13:55:36 +0200
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191003115536.GA15745@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090906.1261-1-dwagner@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Oct 03, 2019 at 11:09:06AM +0200, Daniel Wagner wrote:
> Replace preempt_enable() and preempt_disable() with the vmap_area_lock
> spin_lock instead. Calling spin_lock() with preempt disabled is
> illegal for -rt. Furthermore, enabling preemption inside the
> spin_lock() doesn't really make sense.
> 
> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for
> split purpose")
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  mm/vmalloc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 08c134aa7ff3..0d1175673583 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1091,11 +1091,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * Even if it fails we do not really care about that. Just proceed
>  	 * as it is. "overflow" path will refill the cache we allocate from.
>  	 */
> -	preempt_disable();
> +	spin_lock(&vmap_area_lock);
>  	if (!__this_cpu_read(ne_fit_preload_node)) {
> -		preempt_enable();
> +		spin_unlock(&vmap_area_lock);
>  		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> -		preempt_disable();
> +		spin_lock(&vmap_area_lock);
>  
>  		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
>  			if (pva)
> @@ -1103,9 +1103,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		}
>  	}
>  
> -	spin_lock(&vmap_area_lock);
> -	preempt_enable();
> -
>  	/*
>  	 * If an allocation fails, the "vend" address is
>  	 * returned. Therefore trigger the overflow path.
> -- 
> 2.16.4
> 
Some background. The idea was to avoid of touching several times
vmap_area_lock, therefore there are preempt_disable()/preempt_enable()
instead, in order to stay on the same CPU.

When it comes to PREEMPT_RT it is a problem, so

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
