Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B266BC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D2361268
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhKKUfq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231754AbhKKUfp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636662775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4Cy84Jgi6TXOulUTxC+8PYefojlH7XNQS8/+khicY0=;
        b=d8+id7yHQtWZYOlHayIernXctzDYupRS3mO1udwEyslYZDE/f7huYY8D4t4Hn9lon+afBZ
        wI3evT0wkMnfrA2L5jtyE0scZR13okAjV8bLstz833tc+FEzfQLj3GHV1Yl9SG5doAmhe1
        csqY8Cd8Jq/+za31IMYT5hgcB9h2NTU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-vRec0WseOKuWPI4Ql_kwpQ-1; Thu, 11 Nov 2021 15:32:54 -0500
X-MC-Unique: vRec0WseOKuWPI4Ql_kwpQ-1
Received: by mail-qk1-f200.google.com with SMTP id p18-20020a05620a057200b00467bc32b45aso4953772qkp.12
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=o4Cy84Jgi6TXOulUTxC+8PYefojlH7XNQS8/+khicY0=;
        b=nmMdFhNxYPFrUJRgy2hZpRwlQEnZdlWsqPdGRqcEPH+zID2bpP4Ir3cAOj6mr/iklI
         hu0rzNDVpYZlxl4flPkeLu5vxXqSeMdnsrA2XBhf9J92HMEkqkHpWsSPcpCcyB0WvJ8G
         LPkOq8r7ChsacbNu3jkhbCGm9CqSECm5uHzX+YKMEz9nJWDqV78dIYk8HiDERgdNz2DU
         5PVd3JID7/eyuQo12uraztt3ATYzNkJSf6z76fsD+TYLEJBHS3ebHvTu+LPtodzOlTGy
         mBx5n92CvQXzfCGbfvduYONqKdzE5A0xpnmrzSqfnGz8wQN9JP50KONcJctKQUnOlp3u
         5eXQ==
X-Gm-Message-State: AOAM530kPg4D2SrT0i/wp9JwAn1DO3P+Rv9LiBvKNW8Z74IFUb1ol/7i
        YWmA8qGXu8sgWfugx29Py4f6YYKa5L7mHunufr1M1B/AnKL1Kj8y7xQbrBkT//sSi6qRHwlQOMq
        shB4vtmRyjLdXpYq6Eas8+2ADAVs=
X-Received: by 2002:a05:622a:116:: with SMTP id u22mr10686384qtw.193.1636662772638;
        Thu, 11 Nov 2021 12:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMuwqdqXKZCrMY9eD+ma8k4AEDmIEEt5lJT7hvCLQBRn+SKXstytE+k6HA2Kqdhz1hcRM5tg==
X-Received: by 2002:a05:622a:116:: with SMTP id u22mr10686367qtw.193.1636662772489;
        Thu, 11 Nov 2021 12:32:52 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id p16sm2102522qtx.92.2021.11.11.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:32:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:32:50 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 2/7] rt-tests: cyclictest: Simplify duplicate initialization
 of "stop"
In-Reply-To: <20211014071247.4165329-3-punitagrawal@gmail.com>
Message-ID: <53fdf3ec-6b94-bb0-3eef-8643c518cece@redhat.com>
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
Signed-off-by: John Kacur <jkacur@redhat.com>

