Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB03C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5B64DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBQDxK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDxH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:53:07 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB0C0613D6
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:27 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f17so11650695qkl.5
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=gueuF2A7h80TkDJu+MkJq54PQZQjYmHRwTbOIrs+aJw=;
        b=feeMsp8C/ryAyItXWOI+9MvskQWLa5a5C9aEy3q+lY5gCHRzfY+3dndULCM3P3k5OA
         evkqf6e4JHJHttKQt6v5dK4V6d+0bsnXWsgCl/HAsY6bFfj2Qrp9tA4TlLkKF8E+8bBO
         RzUchUmcG+YM9NC/xKAffjhMSqn1pnFQjhFAY1gESuobTlakIA/VnunzxKQay1mtn740
         Y4yHtOsC65/8TVxEwz03Xfz7B2uytrDKAC7i9gQiRB3P0ZcmfoDXhuL6K5hT7YWkp5VT
         fgze831mkQbpP7E/QD5aXUhzfvNHv4sUFP/+etHjhuEccf+hAtm57x2OcdJ71mUiqqcM
         VGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=gueuF2A7h80TkDJu+MkJq54PQZQjYmHRwTbOIrs+aJw=;
        b=FZg7iJWiRkkGZmwYL0ZQJz3bNqEu/iX/H9YJ0EXor3Nk3Cl2MZt0JEfFu/GLKEk1VU
         LlYnB6iyFiyfVENls6brlw0oDysRaSEmuzpXteFhmywWAMCTJX0DH8trVBtg2e+Gfs5q
         HOP61/O36YOX2Oj6ib7w/BcHkx9Ij5k95MRHhYZJouS6VJA6KtveAHRhEL9fGf2XnUMW
         03IJp26SBaRmH6Tq2AtVZXYe76ixmnJ9Kizql5w0pyt8DFa9ZyY4uWUp1IzjvznueQnn
         k2HwTh8uQFiJNUYdfQtGxwZ9gTe2AI3FK9bUIA1olmkMw/ZMbQjcdgaZeZxOt6Ayt6tz
         /Brg==
X-Gm-Message-State: AOAM533Rkyrf56H1FO2h8cfPrB781/i3oUoQoJyGfYzPWCv0eQtZhjDq
        J087m7OJO6iu+Hud/e3Jq14=
X-Google-Smtp-Source: ABdhPJwOcOG2Wu2POtWSmVEBpH9jmZ4oftmNZ5bI2Fho8jT/SVxQR7KTQtt+jENzN293p4Urq0Yntg==
X-Received: by 2002:a37:78c4:: with SMTP id t187mr22910826qkc.139.1613533947065;
        Tue, 16 Feb 2021 19:52:27 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r7sm785019qkd.89.2021.02.16.19.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:52:26 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:52:26 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 01/13] cyclictest: Move thread data to struct
 thread_param
In-Reply-To: <20210210175118.19709-2-dwagner@suse.de>
Message-ID: <d2adbbb3-fd73-425-ee82-bd29c81fcb27@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> Group thread realated data such as thread ID to struct thread_param.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c4b2369bee6b..7c45732c1553 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -113,6 +113,9 @@ static char *policyname(int policy);
>  
>  /* Struct to transfer parameters to the thread */
>  struct thread_param {
> +	pthread_t thread;
> +	int threadstarted;
> +	int tid;
>  	int prio;
>  	int policy;
>  	int mode;
> @@ -141,9 +144,6 @@ struct thread_stat {
>  	long *smis;
>  	long *hist_array;
>  	long *outliers;
> -	pthread_t thread;
> -	int threadstarted;
> -	int tid;
>  	long reduce;
>  	long redmax;
>  	long cycleofmax;
> @@ -530,7 +530,7 @@ static void *timerthread(void *param)
>  	interval.tv_sec = par->interval / USEC_PER_SEC;
>  	interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;
>  
> -	stat->tid = gettid();
> +	par->tid = gettid();
>  
>  	sigemptyset(&sigset);
>  	sigaddset(&sigset, par->signal);
> @@ -539,7 +539,7 @@ static void *timerthread(void *param)
>  	if (par->mode == MODE_CYCLIC) {
>  		sigev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
>  		sigev.sigev_signo = par->signal;
> -		sigev.sigev_notify_thread_id = stat->tid;
> +		sigev.sigev_notify_thread_id = par->tid;
>  		timer_create(par->clock, &sigev, &timer);
>  		tspec.it_interval = interval;
>  	}
> @@ -613,7 +613,7 @@ static void *timerthread(void *param)
>  		setitimer(ITIMER_REAL, &itimer, NULL);
>  	}
>  
> -	stat->threadstarted++;
> +	par->threadstarted++;
>  
>  	while (!shutdown) {
>  
> @@ -719,7 +719,7 @@ static void *timerthread(void *param)
>  			shutdown++;
>  			pthread_mutex_lock(&break_thread_id_lock);
>  			if (break_thread_id == 0) {
> -				break_thread_id = stat->tid;
> +				break_thread_id = par->tid;
>  				tracemark("hit latency threshold (%llu > %d)",
>  					  (unsigned long long) diff, tracelimit);
>  				break_thread_value = diff;
> @@ -795,7 +795,7 @@ static void *timerthread(void *param)
>  	/* switch to normal */
>  	schedp.sched_priority = 0;
>  	sched_setscheduler(0, SCHED_OTHER, &schedp);
> -	stat->threadstarted = -1;
> +	par->threadstarted = -1;
>  
>  	return NULL;
>  }
> @@ -1293,7 +1293,7 @@ static void print_tids(struct thread_param *par[], int nthreads)
>  
>  	printf("# Thread Ids:");
>  	for (i = 0; i < nthreads; i++)
> -		printf(" %05d", par[i]->stats->tid);
> +		printf(" %05d", par[i]->tid);
>  	printf("\n");
>  }
>  
> @@ -1407,7 +1407,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
>  				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
>  				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
>  
> -			fprintf(fp, fmt, index, stat->tid, par->prio,
> +			fprintf(fp, fmt, index, par->tid, par->prio,
>  				par->interval, stat->cycles, stat->min,
>  				stat->act, stat->cycles ?
>  				(long)(stat->avg/stat->cycles) : 0, stat->max);
> @@ -1463,7 +1463,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
>  				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
>  				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
>  
> -			dprintf(fd, fmt, index, stat->tid, par->prio,
> +			dprintf(fd, fmt, index, par->tid, par->prio,
>  				par->interval, stat->cycles, stat->min,
>  				stat->act, stat->cycles ?
>  				(long)(stat->avg/stat->cycles) : 0, stat->max);
> @@ -1966,9 +1966,9 @@ int main(int argc, char **argv)
>  		stat->min = 1000000;
>  		stat->max = 0;
>  		stat->avg = 0.0;
> -		stat->threadstarted = 1;
>  		stat->smi_count = 0;
> -		status = pthread_create(&stat->thread, &attr, timerthread, par);
> +		par->threadstarted = 1;
> +		status = pthread_create(&par->thread, &attr, timerthread, par);
>  		if (status)
>  			fatal("failed to create thread %d: %s\n", i, strerror(status));
>  
> @@ -2038,10 +2038,10 @@ int main(int argc, char **argv)
>  	if (quiet)
>  		quiet = 2;
>  	for (i = 0; i < num_threads; i++) {
> -		if (statistics[i]->threadstarted > 0)
> -			pthread_kill(statistics[i]->thread, SIGTERM);
> -		if (statistics[i]->threadstarted) {
> -			pthread_join(statistics[i]->thread, NULL);
> +		if (parameters[i]->threadstarted > 0)
> +			pthread_kill(parameters[i]->thread, SIGTERM);
> +		if (parameters[i]->threadstarted) {
> +			pthread_join(parameters[i]->thread, NULL);
>  			if (quiet && !histogram)
>  				print_stat(stdout, parameters[i], i, 0, 0);
>  		}
> -- 
> 2.30.0
> 
> 

Why? I don't see any advantage to this, and according to the comments at 
the top of the struct, thread_param is to transfer params to a thread
and thread_stat is for statistics. This is unnecessary churn, unless
you can convince me otherwise. I was worried that your JSON changes
would rely on this being changed, but as far as I can see, they do not!
