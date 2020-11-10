Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B655C388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8696206F1
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEhAnG0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKJUIU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJUIT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 15:08:19 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93DFC0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:08:19 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so9535262qtj.0
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=998RDw+IBUph31Qg/ZZCdrFA/v0BFmfm0gOYOuvW2MU=;
        b=EEhAnG0zSf8zN1wgB09hlg6MVo5EATbhC0Z8/ttwDeHcnEWu+ZvqYH27LOFNyCkb1O
         tO7SJpOrO4Tk9qRypkQ6yKkQqj316z9EQRzlWScW3KNosB5Y7rFM0+0qabGVtfwlkF3l
         Tv2sRvIafUhCD7FRT6PPjGRwRZQkUlnwInhVGVVievW2vwEqmNI5vsQRkEThpF7SmyfE
         YvX+ROpUd9+nuyBi++CC93G41AeOoG+lZlTJW2t86sh5KuobKKcTzwXi6ZbLgUVF3mGX
         3fb2sQg+yMslve18/cnBIGKTkxu9cYRyjzVqGQ3h8ZcI24kiRvtLorNYo5ABtOib7gCx
         W4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=998RDw+IBUph31Qg/ZZCdrFA/v0BFmfm0gOYOuvW2MU=;
        b=HQLtesg2YMUfAtG7XzhtlH9aQ4XfvjSzT2kR8iYB1Mtew9+D1kgzVbVWPgjwbNOLC0
         rSlzyHIrVmbt3A4Jv3waKn9nf1nAyfsesMwSOf9K41IlBHyOCf+7MLC3v5i3pmNnVAFv
         0FFTQ/Q7oVrgVBGo/HZKjN5ZW299V6JQqGloMotBKZZXYxmGHa+zfb58ux9+/WhCfcEi
         6cs7UqLL0TwaNCKzOrpUcub0Ufu5o4pbIst5M1hqNXNX1BhFbfHf1e03ghKdhtQQvLXr
         oxBFafl4hT92b7c+200VF3BrzpxmGMNnZdLkKRAqDPTGug+j8oGHIUDgUHhAjPjeREcQ
         baPA==
X-Gm-Message-State: AOAM532TjxBjRqX6l77z5MoafUWha4E+B5U2CiBikOCUWA59C4HVvZr7
        1LciQl5wiXVectavNYdMB5c=
X-Google-Smtp-Source: ABdhPJypfIxte+wD0oMaywgOUkGRh7mqMHwt2+hWJ7ZaTtCSukshoZuTkHppKx6AM6p99bHn6oa82g==
X-Received: by 2002:ac8:ecb:: with SMTP id w11mr19550185qti.113.1605038898884;
        Tue, 10 Nov 2020 12:08:18 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id 82sm3864819qke.76.2020.11.10.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:08:18 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 15:08:17 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 4/5] signaltest: Fix break value argument
In-Reply-To: <20201110180036.859080-5-bigeasy@linutronix.de>
Message-ID: <87658dba-5f65-e77-72dc-6b4974cfdf1b@redhat.com>
References: <20201110180036.859080-1-bigeasy@linutronix.de> <20201110180036.859080-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 10 Nov 2020, Sebastian Andrzej Siewior wrote:

> The break value '-b' is not working properly:
> - Every thread may hit the break value. This is expected for thread
>   number > 0 because thread number 0 sleeps every 16 iterations to give
>   the system time to breath. This delay may wrongly trigger as the break
>   value.
> 
> - If a thread hits the break value then it returns signaling "shutdown".
>   The main thread will then SIGTERM to each of the remaining threads.
>   This is a nop because this signal is blocked.
>   Send SIGUSR1 instead which is waited for.
> 
> While doing all of this, report the actual `max' value.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/signaltest/signaltest.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 84eb8827faa5e..dacaa63673c48 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -58,6 +58,7 @@ struct thread_stat {
>  	pthread_t tothread;
>  	int threadstarted;
>  	int tid;
> +	int interrupted;
>  };
>  
>  static int shutdown;
> @@ -123,13 +124,16 @@ void *signalthread(void *param)
>  
>  		diff = calcdiff(after, before);
>  		before = now;
> +
>  		if (diff < stat->min)
>  			stat->min = diff;
>  		if (diff > stat->max)
>  			stat->max = diff;
>  		stat->avg += (double) diff;
>  
> -		if (!stopped && tracelimit && (diff > tracelimit)) {
> +		if (!stopped && tracelimit && !par->id  && (diff > tracelimit)) {
> +			stat->act = diff;
> +			stat->interrupted = 1;
>  			stopped++;
>  			shutdown++;
>  		}
> @@ -376,11 +380,12 @@ int main(int argc, char **argv)
>  		quiet = 2;
>  	for (i = 0; i < num_threads; i++) {
>  		if (stat[i].threadstarted > 0)
> -			pthread_kill(stat[i].thread, SIGTERM);
> +			pthread_kill(stat[i].thread, SIGUSR1);
> +		if (stat[i].interrupted)
> +			printf("Thread %d exceeded trace limit.\n", i);
>  		if (stat[i].threadstarted) {
>  			pthread_join(stat[i].thread, NULL);
> -			if (quiet && (i == 0))
> -				print_stat(&par[i], i, 0);
> +			print_stat(&par[i], i, 0);
>  		}
>  		if (stat[i].values)
>  			free(stat[i].values);
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
