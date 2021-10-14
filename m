Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3CC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980B561037
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhJNSbK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhJNSbJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 14:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMZrMT2D7C7lTlQ0AuLDFZf7pACUKSJygDBGOgykqzs=;
        b=bT1xDts8UDj4siwr8J5nHDWZebQMMHpTBjrkY+oEkQk8qypg0imJ36h0R5d2od72hZFIfW
        1AFmBGgZw3M0cwNRUXhsb3el4yGm/k4V8qFoE0DbUWau8CN5pLaHR0Gj3aljAiwbFTuEtB
        6iI13w3FY6oD02CCwYszRJQezgAvdew=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-YW_UNNtNOSaLIdfhGQsASQ-1; Thu, 14 Oct 2021 14:29:02 -0400
X-MC-Unique: YW_UNNtNOSaLIdfhGQsASQ-1
Received: by mail-qk1-f197.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so5094857qki.11
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 11:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=TMZrMT2D7C7lTlQ0AuLDFZf7pACUKSJygDBGOgykqzs=;
        b=hci64HsYkN0r0uVP55mpC0KKxrW0cHFSkAhOgib+6EkdrpKhfHux9gOfcagVcBue5G
         z/RQ8Gy7e7ocde91PfqWaLq1FDmxb2aWXiFK8Hdr9DI8YXjWu7bNy+w6AEvHl23XvCZJ
         OIzZildw1fb3babCMpRTa29at9kENzg+E/saeKUItAKSjHNeIvMKsTenDDDFO66oZris
         tCOSu70pxpcbdJGFwpmVAGMgh1VIB+ElXDE8u2Huyax7Tk148Apf6nai2Rh+bxGvPcZp
         VMMLUtuwGOoQDF1A/eoJXkoE18NLPuQMK3Km2TkCg+1hJ/c2AtEq0CCld0KKWivqy3WB
         qiPQ==
X-Gm-Message-State: AOAM530KXju/iLBmL7NB6dk7pyi6lWV8Le4e4ufTtGsJCKNt5LCG/5R1
        PFtCS1c+OipE3d5oukJcFiiczub/a30wc9fBOfbpWJwYgQBi/xNU40yDYh4XPBv4SOR6MeTvckh
        waP75NEq2mYIOxNxRZZr9OJO3C1E=
X-Received: by 2002:ad4:5486:: with SMTP id q6mr7059194qvy.1.1634236142436;
        Thu, 14 Oct 2021 11:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuqSHpM7c0veQYY3BDPKmcyBwcOuDsyHoDZ5xFqAvvTArqPuUCCwAjzhUoCVhiSYXz2vJsvg==
X-Received: by 2002:ad4:5486:: with SMTP id q6mr7059179qvy.1.1634236142286;
        Thu, 14 Oct 2021 11:29:02 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id x16sm1689593qtp.56.2021.10.14.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:29:01 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:29:00 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 2/7] rt-tests: cyclictest: Simplify duplicate initialization
 of "stop"
In-Reply-To: <20211014071247.4165329-3-punitagrawal@gmail.com>
Message-ID: <e5d249a3-4ac9-d665-6faa-19e19aee589@redhat.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com> <20211014071247.4165329-3-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 14 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> The timespec structure "stop" is initialised whether it is used or not
> as the compiler is not smart enough to figure out that it's use is
> always guarded by the "duration" variable. As a result, "stop" needs
> to be initialised whether it's used or not to avoid a compiler
> warning.
> 
> Replace the duplicate memset statements by initializing "stop" using
> structure initialiser.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  src/cyclictest/cyclictest.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0c1e6617e0e1..d06ed01c58f4 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -507,7 +507,7 @@ static void *timerthread(void *param)
>  	struct sigevent sigev;
>  	sigset_t sigset;
>  	timer_t timer;
> -	struct timespec now, next, interval, stop;
> +	struct timespec now, next, interval, stop = { 0 };
>  	struct itimerval itimer;
>  	struct itimerspec tspec;
>  	struct thread_stat *stat = par->stats;
> @@ -516,8 +516,6 @@ static void *timerthread(void *param)
>  	pthread_t thread;
>  	unsigned long smi_now, smi_old = 0;
>  
> -	memset(&stop, 0, sizeof(stop));
> -
>  	/* if we're running in numa mode, set our memory node */
>  	if (par->node != -1)
>  		rt_numa_set_numa_run_on_node(par->node, par->cpu);
> @@ -598,7 +596,6 @@ static void *timerthread(void *param)
>  	tsnorm(&next);
>  
>  	if (duration) {
> -		memset(&stop, 0, sizeof(stop)); /* grrr */
>  		stop = now;
>  		stop.tv_sec += duration;
>  	}
> -- 
> 2.32.0
> 
> 

Looks good, I'll sign off on that, just remove the RFC

