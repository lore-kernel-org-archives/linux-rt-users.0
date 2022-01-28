Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B457C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 21:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbiA1VL4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 16:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbiA1VLz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 16:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643404315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wfz6DBHf/CTisqt45CxKTHSnvePlyyMjmhxggu/e+UM=;
        b=gnTU5rIiRfuEcE1O11v1V5oNoZ6OT4IQEnxAJsGgr60yctcBPtMgEM0LLPFf1EOvApXSYc
        4wLwH1MKpDSVUADUR81MFUMqksOZk70m/c2lp23XML+jesBRn6tBsVRMh44wkETtfAUryi
        Tn0DvNvLln0DV5jIhbKmCVqDYaBxRiY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-qbo0-bDON5aR4r6AvrAIUw-1; Fri, 28 Jan 2022 16:11:53 -0500
X-MC-Unique: qbo0-bDON5aR4r6AvrAIUw-1
Received: by mail-qt1-f199.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso5516762qtm.8
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2022 13:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Wfz6DBHf/CTisqt45CxKTHSnvePlyyMjmhxggu/e+UM=;
        b=EXPQl42piiBq08Hfk0Xl6KnJBwCUt1BKXFCPkUgKC8PiI/7IHtYndAFmfPxa6bxfhs
         uW6BkOfV11XBgk5Y2nzxZ3qu+knRs0LfVD7RAl/O/3xUGrrxjaaLhKIdamDtWnMETPGV
         DAuf/o9cm1qiL38TUdBWbYSzH9XI13LqeT4IkVGwg1mMMFVGvftfmf6WnqQCWTwgBOR5
         qkWqi8j8FFW1EeYDlzWO9cd0BjMdjORRqstUG0AC3Px0gwszEs4igQpblKD2BiizKV2t
         XR1RqDytc2eSdmL+/BL035eoO554lRwdHOR7CqSmz/+CsoJ+VegzRa8I9REIX3s4xQC2
         IwUg==
X-Gm-Message-State: AOAM532eYw6nYe3TxB3gLXEC/UMsAhb5DQNrtIo4fz9L8lnd2op0RyMc
        /s6qjxbeI/xk+xy8aSVHIMSIvLSVY3SNHPJbcXOYCRUYOWZKQtcF1m6ZApoVMRJ69gRnbbVcs09
        Cv15IJ7mPUpAzyyaNpEtg41dqRlo=
X-Received: by 2002:a37:ad15:: with SMTP id f21mr7002945qkm.117.1643404313243;
        Fri, 28 Jan 2022 13:11:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3NWKyF3xJnN+bfC6FcqT59SYJBzBhmJMUxydgEi6Jnm52ShWrNj8G2wSALyZ7j2al+ASsDQ==
X-Received: by 2002:a37:ad15:: with SMTP id f21mr7002938qkm.117.1643404313062;
        Fri, 28 Jan 2022 13:11:53 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id m4sm3625678qka.111.2022.01.28.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 13:11:52 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:11:51 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] rt-numa: ignore runtime cpumask if -a CPULIST is
 specified
In-Reply-To: <YfQ4f1CWDubRMlmA@fuller.cnet>
Message-ID: <18abab1-c454-bd62-ebab-6b5451ac3de@redhat.com>
References: <YerAW90QwEg9yXAb@fuller.cnet> <YfBEDR4E2dNK8XzK@fuller.cnet> <YfBFaNrP/1LCgWoN@fuller.cnet> <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com> <YfQ4f1CWDubRMlmA@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 28 Jan 2022, Marcelo Tosatti wrote:

> 
> When using isolcpus kernel command line option, the CPUs
> specified at isolcpus= are not part of the run time environment
> cpumask.
> 
> This causes "cyclictest -a isolatedcpus" to fail with:
> 
> WARN: Couldn't setaffinity in main thread: Invalid argument
> FATAL: No allowable cpus to run on
> # /dev/cpu_dma_latency set to 0us
> 
> To fix this, ignore the runtime cpumask if neither "+", "!"
> are specified in the cpu list string.
> 
> Suggested by Sebastian Andrzej Siewior.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> v3: simplified version (John Kacur)
> v2: fix changelog typo
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index ee5ab99..3eead80 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -131,7 +131,8 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
>  		return 0;
>  	}
>  
> -	use_current_cpuset(max_cpus, mask);
> +	if (strchr(str, '!') != NULL || strchr(str, '+') != NULL)
> +		use_current_cpuset(max_cpus, mask);
>  	*cpumask = mask;
>  
>  	return 0;
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

