Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D2C4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509C821852
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtz4hzcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDEOgW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:36:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOgW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 10:36:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so8247613wrw.13
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vMgrJYRcEfhzL9F6IqndWy4u7Oms++GikKQANrSVurQ=;
        b=Xtz4hzcTp5UIihWcdS/JCyOZRMjf8QJqU33LmHyemS6Eu+jNIu8QpGciwYnngS1J6m
         ctFNLzdAJUgtuyFqnaHm0F06B6nPolJ0oaSDAXlQCq5HwFSkyFXEftQbCS181veQDk6d
         8uK4zP5lIkohUKPgH9JnyWHwVvqq7rjtgyP4XH6WU1zeum/hHahh8k4gOQoZzaUqJouS
         pdqRJR7pg/n6CMKHI3oijdedhf7WZ6byAPogqZb5UB2cg/HKm3QU03crShD53Np2f6NT
         hezb9JaCDBJL8PZ6xrh+1UmYbpeLjcCKYoIyZv7Qkj/bwOa7BDCA4NBxLcw/CQfmgfIs
         kdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=vMgrJYRcEfhzL9F6IqndWy4u7Oms++GikKQANrSVurQ=;
        b=TIYDVqNmYRDhV482psHy+KiGLcBOyOcX+tt3YQwnNM4liQDdawvfuIo8N0Un+qu2gf
         Pt5L7uxmDFUOAYy83YVKgWfykrvaNKAvSRDWaD3y6NEUHsbTjFc6OhN2a6uee+jHJJ9C
         AuB+wt3EmlK11XL+lFtuoHK5UwCgo/GRYs+lZX5bKBsx0B2g/fdEJBGRQ+XM6ajc1xl7
         RTwK13Y04428HXiIv7QbjJjWgdLo0d49rLCqRBOUwc6TF9IBcD3F2sykd9Qmuww8Cs5+
         50lGiK4MSio0JsSc6+uzPkphheCGw6S4p2DS9lXWl9NcEybnuIofMg0ORJn4tcC9thd6
         zmlg==
X-Gm-Message-State: APjAAAX0IFqwDYkd0Ofg2GPKhCafaeV6yHbzZ4NCLZfLvnJC2BwBS0GM
        odTlsyui1P5UdeR7y+iWO/k=
X-Google-Smtp-Source: APXvYqyxa9o6Xp1mNeqeOpp7Kb2vlYi02MlwLvY8CRq4rfD5SVnAi1hQRbCyquzA/8jJj/KwqNGG0w==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr8618102wrr.269.1554474980700;
        Fri, 05 Apr 2019 07:36:20 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id k4sm28707427wro.33.2019.04.05.07.36.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 07:36:20 -0700 (PDT)
Date:   Fri, 5 Apr 2019 16:36:12 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] rt-tests: deadline_test: add missing frees
In-Reply-To: <20190404134814.13376-5-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904051635560.8480@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-5-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> The threads and thread data structures are allocated using calloc(). But never
> free'd. So, free them.
> 
> While here, remove the if statement for setcpu_buf. Free() is NULL safe.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/deadline_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index 4826557d0624..69e6fd18b73b 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -2092,8 +2092,9 @@ int main (int argc, char **argv)
>  		printf("\n");
>  	}
>  
> -	if (!setcpu_buf)
> -		free(setcpu_buf);
> +	free(thread);
> +	free(sched_data);
> +	free(setcpu_buf);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
