Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D5C43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 14:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiF2OxW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiF2OxF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 10:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8D21EACD
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656514383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kal7eBa59kutpQYu99xUU24O0MYJGVmtziZ1yFwAuy0=;
        b=ZERVz2SV8jThPs7AwJ6ItiKxU83EIZ8RuDu2qcVn4V/7VqeyhEpVlsVRUOJH2M1xc7IyEg
        qZ3bgtioDbE+ZiBmdPw6iOmS5/4tR8geWDCoYyLh0bhhh2PhnpZ+roB4H7hYFiSkT458H6
        LBew7+XAlIGuMKLYa3yZUG+LOzRBCcI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-wxcyvaCLO-6xIa4vUQRQtA-1; Wed, 29 Jun 2022 10:53:01 -0400
X-MC-Unique: wxcyvaCLO-6xIa4vUQRQtA-1
Received: by mail-qk1-f200.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so16426390qkb.9
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 07:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kal7eBa59kutpQYu99xUU24O0MYJGVmtziZ1yFwAuy0=;
        b=Fvb598nxAn2foikXgtys4MD7mJxVSIoNhl2oWTIRvFvpXE5M3QH4C3qOllBYZ4jDzC
         YKsUYeiu8TY5vAu1iHBDnhxUa7PPd/S35MqTDOqyOcvULw5iqbfNb3rxDjyBfacjlOix
         1pqO3hnYoQmZf/RSeQzTIfWoveJR6SC9oUMM0JxMQa5vL2jJ5kqlc0kIRzU2UyriIM1c
         KgiuVIMfOht/X3AaoU6PIlH+5utjaW9+Nity+gJFxYMLrb2gGQSqtNjTICG/y8wtsvQr
         0/kthLQzvRRow5ClWSKjMMeA/Je+6GKbogtFxL/7Y3b6RYVeZwkkDZARP18Fbw2a9F8i
         WQ2w==
X-Gm-Message-State: AJIora9U7HoKyNJWvpS7GplvX42MOSSm8K+if6fXCKUgsWFpRS2MRssy
        SlXujIXDKOPFRlTp3X1vLtckUk+nW3nKIA9qpz062f2LPiHmdNZcZikj15+myPFBAzIC6cqRH1C
        PrfK5ot+hljQuKY4KC84Nna35Oy0=
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr8070085qvt.94.1656514381294;
        Wed, 29 Jun 2022 07:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCI1Kk/KCqXJOIV338poORuKFCxsCFWivwz075f7oZAzggaH6NnQooObqDTcmiC6f+pTg0Yw==
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr8070064qvt.94.1656514381015;
        Wed, 29 Jun 2022 07:53:01 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id bt5-20020ac86905000000b0031bf68f502esm2088394qtb.59.2022.06.29.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:53:00 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:52:28 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
In-Reply-To: <YqnExv0GkIKTSwoI@linutronix.de>
Message-ID: <161e452-804c-57a8-dde1-4a4f18cd29e0@redhat.com>
References: <YqnExv0GkIKTSwoI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 15 Jun 2022, Sebastian Andrzej Siewior wrote:

> Assuming the current affinity mask of the task is 0x31 (CPUs 0, 4, 5).
> Starting cyclictest with '-S' option will fork the following threads:
> - monitor, mask 0x31
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x10
> - measure thread 3, mask 0x20
> 
> works as expected. Using the options '-S --mainaffinity=0' leads to:
> - monitor, mask 0x01
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x01
> - measure thread 3, mask 0x01
> 
> because the mask of the main thread has been reset early to 0x01 and
> does not allow a CPU mask outside of this mask while setting the
> affinity for the new threads.
> 
> Delay setting the affinity of the main/ monitor thread after the
> measuring threads have been deployed. This leads to the following
> state:
> - monitor, mask 0x01
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x10
> - measure thread 3, mask 0x20
> 
> Signed-off-by: Sebastian Andrzej Savior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index be8285a072b4e..cbf8d00293ec6 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1816,10 +1816,7 @@ int main(int argc, char **argv)
>  		printf("Online CPUs = %d\n", online_cpus);
>  	}
>  
> -	/* Restrict the main pid to the affinity specified by the user */
> -	if (main_affinity_mask != NULL) {
> -		set_main_thread_affinity(main_affinity_mask);
> -	} else if (affinity_mask != NULL) {
> +	if (affinity_mask != NULL) {
>  		set_main_thread_affinity(affinity_mask);
>  		if (verbose)
>  			printf("Using %u cpus.\n",
> @@ -2094,6 +2091,10 @@ int main(int argc, char **argv)
>  			fatal("failed to create thread %d: %s\n", i, strerror(status));
>  
>  	}
> +	/* Restrict the main pid to the affinity specified by the user */
> +	if (main_affinity_mask != NULL)
> +		set_main_thread_affinity(main_affinity_mask);
> +
>  	if (use_fifo) {
>  		status = pthread_create(&fifo_threadid, NULL, fifothread, NULL);
>  		if (status)
> -- 
> 2.36.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

