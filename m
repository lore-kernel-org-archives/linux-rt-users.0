Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B1C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47F06145E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhEGQ4E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbhEGQ4D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:56:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447CC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:55:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id dl3so5128833qvb.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Hw4QkP8AoSgLDU+GCMA90KPY6q0hFM8UynESaHcBQ8s=;
        b=I4hlr1CaL1r0yTsVvKXv2USqKFGc64Y2OycodNDWPldsIjlwBe+RcxESM8inWthZa7
         97z2iTTBqtzJMp+bfZ8I3Q3m27QjLRdjS251ERM2rPJzUI5gbaBbcUZ8cWjxmzGatlll
         wgsRAgpX/Jq4szt6nZG4d7cuYHmp5808kwlu90yfx9W+FwTesiMqDNfznPXITbAzCuyW
         q3APXQo4nEGPSJ8zvRzamlhMkMd7/m5iVakhPaYEDQXWbnPhrwnLcf7jtHnZMur4aJye
         z5rDha8AuEBGUThTw+Rd+SMZP0fncEiF/D6BK6tnVj2ixMkUkzeQpzucoNE8zardyvV2
         Kv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Hw4QkP8AoSgLDU+GCMA90KPY6q0hFM8UynESaHcBQ8s=;
        b=n4LN48fGb4s5LnIRE8iFrAh913RB/vE9+w6Snm4btOhKEjvUx/lEn0WshsAeqB05PC
         XWm1gWAMfz/yw+5srFwZAbKdm1lsyhYMTXbzyi/p9xVI904boWtOEvH6Off97xKS2Mqu
         6SPcBuwtE4secWuMqbpVkeixfyiN29P+qixvR/Ecd+is0r6y7VheBdMRYoBajbeIxjqj
         5ePeh+6nqozikLWU6Ot+8ngKdw4R75wlBFAhltq9iOO80H1qw0WkXi+FJ5QsGNTmJ8JH
         a1YCGyyCmEb7BdUdGYDNC3za3q09ZG3mBuwJqmXk7/ceQwnDgYGs7Wm5gxs4jJjBOy3l
         qZIw==
X-Gm-Message-State: AOAM533qrXW2P12xfxsQTus2y0OHmK7VwDTWBLf/UD/tY2EWAjZ+jpd5
        guwqleTwUhTmnTh6BMDkjPI=
X-Google-Smtp-Source: ABdhPJwuMRZdWG4a99br/87lr50FjeAWjGBA34EjqgN0fjvf8uRkCF0MmRaFVsRNtLP39EMNuToDdw==
X-Received: by 2002:a0c:ee23:: with SMTP id l3mr11045119qvs.55.1620406501908;
        Fri, 07 May 2021 09:55:01 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id l8sm5140257qtv.18.2021.05.07.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:55:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:55:00 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 26/33] pip_stress: Move test result output
 to main
In-Reply-To: <20210320183829.1318-27-dwagner@suse.de>
Message-ID: <7281701c-2e78-73b9-85a-59e7ef15263c@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-27-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Instead printing the result high() close directly move it to main()
> function to simplify the return code if the test fails.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pip_stress.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 8b91578f9ab8..2c3288984202 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -146,6 +146,7 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	} else if (pid1 != 0) {		/* parent code */
>  		low(pid1);
> +		exit(0);
>  	} else {			/* child code */
>  		pid2 = fork();		/* parent code */
>  		if (pid2 == -1) {
> @@ -155,9 +156,15 @@ int main(int argc, char *argv[])
>  			high(pid2);
>  		} else {			/* child code */
>  			medium();
> +			exit(0);
>  		}
>  	}
>  
> +	if (statep->inversion)
> +		printf("Successfully used priority inheritance to handle an inversion\n");
> +	else
> +		printf("No inversion incurred\n");
> +
>  	exit(0);
>  }
>  
> @@ -222,14 +229,6 @@ void high(pid_t pid)
>  	Pthread_mutex_unlock(resource);
>  	kill(pid, SIGKILL);	/* kill the medium thread */
>  	waitpid(pid, &status, 0);
> -
> -	Pthread_mutex_lock(statep->mutex);
> -
> -	if (statep->inversion)
> -		printf("Successfully used priority inheritance to handle an inversion\n");
> -	else
> -		printf("No inversion incurred\n");
> -	Pthread_mutex_unlock(statep->mutex);
>  }
>  
>  /* mmap a page of anonymous shared memory */
> -- 
> 2.30.2
> 
> 
NAK, see comments in the next patch
