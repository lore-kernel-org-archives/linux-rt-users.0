Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AEEC388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C43206F1
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uO2/S9Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKJUHu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJUHt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 15:07:49 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B887BC0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:07:49 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so9152780qtq.12
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CATGpEi92EGwLF4estfNWTIwINg0f9HF5SBiIOQzqGk=;
        b=uO2/S9UgCteWYzQR+zcpNf2UEP0hkHjqMgu/dJktMJrrhn2f3NxlIGWoHNDu6VEyl+
         M146YyJCx9c2SaBOxTfwaGmXLrDP8tgk6oVlzrhleGCuH8oW/eTA5V9Iy7epVmNbSk7i
         snDBPkWPTFzJ8JzhcUrP/z/xDDrAjizf7c3omoaJhfEnD0FfaKBsheHtrTJYMjqd5EM/
         zN2xw78QfFpLZccpfZwB/MlwXcvnsR7ZY9p9NzcvFXx+6XwKzW0CnNlwPvuP9k5eEUcZ
         eGWBlBKdt1oEIQb9cKF50V/ZX2zikTPoVx2i+J4VeFw6E80gLIUmwGAdKU+ocAmOah/u
         VZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=CATGpEi92EGwLF4estfNWTIwINg0f9HF5SBiIOQzqGk=;
        b=I+dvsV7g+UOELqlK7EFftMm3gsEDigkfmk35crpyALH9Q0gv5Ff4Pi04fSDELqzIwM
         TmYTv5uKsEht00dqojEeGvCFaprLbPPvCNQH//6Gyt8g4f7LHKFeiwxJr/9QwtbGsu5d
         7QsA/ltZZCqPcf3u9OXa7F4qKgKuqLzU5mCftWqsg4eSLvgMMeXO76ekfnRYeh8EKCZI
         p98gy+5Zvtl0ZZiDgfaDdlkPSo61rULWpBVAUOhBl/uQX4C4U1jZhLzTrZpH75rscY4w
         nSpmz4lwBT/jYFfXwGIBdy2ubmVVRFxZunwfCvLjDKLtfznH5XIJPh2Nv0/hLQHlwBqT
         nLgw==
X-Gm-Message-State: AOAM5329VDL11qJZb/EfBp2m+Z97QfcuUd7WaBHVbcqwGgoiuH2rtAZM
        mGidKgoUEBAgKlxBv9Px8fU=
X-Google-Smtp-Source: ABdhPJzX5btUhflO8+97nNpFpUoGgqwfShCsPv8rlP0HIB31Ys7qUt/owN004yekGuOniLdnRCavYg==
X-Received: by 2002:aed:3147:: with SMTP id 65mr20386735qtg.295.1605038869063;
        Tue, 10 Nov 2020 12:07:49 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id p127sm9456041qkc.37.2020.11.10.12.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:07:48 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 15:07:47 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 3/5] signaltest: Don't expect trace interface at /proc
In-Reply-To: <20201110180036.859080-4-bigeasy@linutronix.de>
Message-ID: <cef4d798-6496-a640-13d-c57a5f428f3@redhat.com>
References: <20201110180036.859080-1-bigeasy@linutronix.de> <20201110180036.859080-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 10 Nov 2020, Sebastian Andrzej Siewior wrote:

> This was never merged.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/signaltest/signaltest.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index aceb714d3e9d3..84eb8827faa5e 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -79,19 +79,6 @@ void *signalthread(void *param)
>  	int stopped = 0;
>  	int first = 1;
>  
> -	if (tracelimit) {
> -		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
> -		system("echo 1 > /proc/sys/kernel/trace_enabled");
> -		system("echo 1 > /proc/sys/kernel/trace_freerunning");
> -		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
> -		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
> -		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
> -		system("echo 0 > /proc/sys/kernel/trace_verbose");
> -		system("echo 0 > /proc/sys/kernel/preempt_thresh");
> -		system("echo 0 > /proc/sys/kernel/wakeup_timing");
> -		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
> -	}
> -
>  	stat->tid = gettid();
>  
>  	sigemptyset(&sigset);
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
