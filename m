Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9AC433ED
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Apr 2021 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C647C61059
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Apr 2021 16:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhDZQnT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234333AbhDZQnR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Apr 2021 12:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619455354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJxzv5jKNQktybLPgY590umZq9XnypXNfHP7076nH64=;
        b=aTmlduUdgTCpfiM+b1W4zGk5cLXWf2u1JbZeXuwMkDGDUqsve2bLWVcmpQtBB4jqipPp+U
        jld455ZequpVXj7RVRcjjh3doeRcSm5URI4lMCgYWxok09mv6ozWm/f1ahikN1LMNkXCxO
        eJUhALmLlNXErhCI5JwCZ90z9bCUAB8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-oo8onfYuP-iwrpP4LjcDeQ-1; Mon, 26 Apr 2021 12:42:32 -0400
X-MC-Unique: oo8onfYuP-iwrpP4LjcDeQ-1
Received: by mail-il1-f197.google.com with SMTP id g7-20020a056e021a27b02901663a2bc830so28375945ile.1
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Apr 2021 09:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJxzv5jKNQktybLPgY590umZq9XnypXNfHP7076nH64=;
        b=eq9ZFGVnxLdL4k7IUPGnkzyv2zF0SUofURjIeiqcFeFTNSghpmugQuIAOza62iRzxL
         LUnYTswwdUpUMsUt/Hn61jjO83jf+B4e8oeCfj2XD3oeifnQCNV/qhjRFGZpBTpWF1Ce
         R9pnjoy2HsPxtSouoBTk5WDbjNkCjRDDjm8oZZKnrQl5TWP65R8xNKMEcH4X9gsWnxNP
         x70KvIySfRe+r/0jWihy7C+mf/l53t9/+wp02FQqvc7oraAhTNckN8je0xCmsTK5b2cR
         5mrP0i6KYfSPUWV8EDGQVhNRrPVJEqcRlYqzSs9JKXwHgUuuRIiUJj2ZoTFt96qnLef9
         Zjlw==
X-Gm-Message-State: AOAM533QTduSgQm6QTa69EEykNqoJX5RhkxFdVP1hR5Q5XctzyNov7Mx
        bV7yg2GwcgqoXR4ORo6n1BgLsf1uQ7YUvCv6jjZq+kMlwpom7dHpztW83/RTl32jqUIkIfmtgF+
        O0K3GaapN4fY/gWL3KqCb5JAGTu0=
X-Received: by 2002:a92:bf11:: with SMTP id z17mr15070655ilh.146.1619455351946;
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD8S2SaijrAd62taudrpY7FzMTTsRwm3xCUxNYbDsm3mc+yVBtLie0n3zLxCerfxoxSBh27Q==
X-Received: by 2002:a92:bf11:: with SMTP id z17mr15070638ilh.146.1619455351776;
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v8sm181953ilq.0.2021.04.26.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:42:29 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
Message-ID: <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop>
References: <20210406221952.50399-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406221952.50399-1-ahalaney@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 06, 2021 at 05:19:52PM -0500, Andrew Halaney wrote:
> There's no chance of sleeping here, the reader is giving up the
> lock and possibly waking up the writer who is waiting on it.
> 
> Reported-by: Chunyu Hu <chuhu@redhat.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Hello,
> 
> I ran into a warning caused by this, and I think the warning is
> incorrect. Please let me know if I'm wrong!
> I'm working off of linux-5.12.y-rt, but this applies cleanly to older
> stable branches as well.
> 
> Thanks,
> Andrew
> 
>  kernel/locking/rwsem-rt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
> index 274172d5bb3a..b61edc4dcb73 100644
> --- a/kernel/locking/rwsem-rt.c
> +++ b/kernel/locking/rwsem-rt.c
> @@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
>  	if (!atomic_dec_and_test(&sem->readers))
>  		return;
>  
> -	might_sleep();
>  	raw_spin_lock_irq(&m->wait_lock);
>  	/*
>  	 * Wake the writer, i.e. the rtmutex owner. It might release the
> -- 
> 2.30.2
> 

Just a gentle follow up, any feedback?

Thanks,
Andrew

