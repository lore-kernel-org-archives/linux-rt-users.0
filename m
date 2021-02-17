Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC1BC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6B864DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBQDxU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQDxS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:53:18 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902FC061786
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:38 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x3so2924429qti.5
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mnnfEQlcIdWDlVbEtn1dR8ThQTojLIfZDwCY2XNfaUQ=;
        b=bLGW66uwXuzLKgwKlRQMh8r/VF55Al6a45X4LfkXbuSmfiODnwL8r+aYPbzgDPVdR9
         enlHcCkhwmvfhKgBbPZwckdZaoflLSgBjy+Yy7hQMryjjeQvlTFWp/7o+JezH3C8THsP
         VnA3vbqcK2P954gWzDDRctT9SgUHnIQueiSQBzAN3low9S3WY7FzsSXPyKfSJ1gMDl8O
         sU9LT84eZu5nE1gMzsqN5efuCiZtpx2yfCxBkhHyERxQM6Ey5w986VOAG1OxSoVCROy6
         Axncg5YoJcqe3ZNKzLj+LyZkZ6gWuDQu5omXaNSUoFnI5i5sl8xiavmwk6QR/sK4eRzW
         qHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=mnnfEQlcIdWDlVbEtn1dR8ThQTojLIfZDwCY2XNfaUQ=;
        b=l3+S/C4e5zV1hsdk6OQ/P/p/xwDgLOh/i85jvL57avOHNLCm4ek3hiSFktficOixa5
         bnbBBCXIngaA9MQ6/o4HgQj8z9atW922OYvzUpphvr0ideYcgU12ZgRnaK11oMNPj4XD
         jhoDHSsLdXoiBItBxrNHutw17s5T3NyfYG2ylo+7f1fbgkFZZFb8LNzaQXwK/82stlSR
         ChN6/RZDOnCjKEb5o+2mg8J42QhNrNafrAFNOUFLREmoXg7HESLGjw0wFWEzIJWG+voI
         2CSksxNmB/r87KASq/WbADeMZYKkOAVfHHLAqAbsnrKZ97rQICcO1O0F6w/IGIT0LdoO
         leSA==
X-Gm-Message-State: AOAM530+mF0qDdZW5eThDaQ1C/8Thb/hH/DpBfQJidKiZ3ArMugX+wP0
        8UInXe29SSegZ008fTZULfU=
X-Google-Smtp-Source: ABdhPJw/eLJCY/UiMq+mTGeMq26BRR2fYOTO9L8qAlP8NnLzZcu7PhyilqHdrIeBm1+doAqkdnLS0Q==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr22492819qtj.181.1613533957407;
        Tue, 16 Feb 2021 19:52:37 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id d12sm442441qth.11.2021.02.16.19.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:52:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:52:36 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 02/13] signaltest: Move thread data to struct
 thread_param
In-Reply-To: <20210210175118.19709-3-dwagner@suse.de>
Message-ID: <b62312f5-17fe-a8b9-c46f-9c961d57491a@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-3-dwagner@suse.de>
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
>  src/signaltest/signaltest.c | 44 ++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index c34bc994d886..dd5633d5fc51 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -40,6 +40,10 @@
>  
>  /* Struct to transfer parameters to the thread */
>  struct thread_param {
> +	pthread_t thread;
> +	pthread_t tothread;
> +	int threadstarted;
> +	int tid;
>  	int id;
>  	int prio;
>  	int signal;
> @@ -47,6 +51,7 @@ struct thread_param {
>  	struct thread_stat *stats;
>  	int bufmsk;
>  	int cpu;
> +	int interrupted;
>  };
>  
>  /* Struct for statistics */
> @@ -58,11 +63,6 @@ struct thread_stat {
>  	long act;
>  	double avg;
>  	long *values;
> -	pthread_t thread;
> -	pthread_t tothread;
> -	int threadstarted;
> -	int tid;
> -	int interrupted;
>  };
>  
>  static int shutdown;
> @@ -86,7 +86,7 @@ void *signalthread(void *param)
>  	pthread_t thread;
>  	cpu_set_t mask;
>  
> -	stat->tid = gettid();
> +	par->tid = gettid();
>  
>  	if (par->cpu != -1) {
>  		CPU_ZERO(&mask);
> @@ -105,7 +105,7 @@ void *signalthread(void *param)
>  	schedp.sched_priority = par->prio;
>  	sched_setscheduler(0, policy, &schedp);
>  
> -	stat->threadstarted++;
> +	par->threadstarted++;
>  
>  	clock_gettime(CLOCK_MONOTONIC, &before);
>  
> @@ -128,7 +128,7 @@ void *signalthread(void *param)
>  
>  		/* Get current time */
>  		clock_gettime(CLOCK_MONOTONIC, &now);
> -		pthread_kill(stat->tothread, SIGUSR1);
> +		pthread_kill(par->tothread, SIGUSR1);
>  
>  		/* Skip the first cycle */
>  		if (first) {
> @@ -148,7 +148,7 @@ void *signalthread(void *param)
>  
>  		if (!stopped && tracelimit && !par->id  && (diff > tracelimit)) {
>  			stat->act = diff;
> -			stat->interrupted = 1;
> +			par->interrupted = 1;
>  			stopped++;
>  			shutdown++;
>  		}
> @@ -167,7 +167,7 @@ void *signalthread(void *param)
>  	schedp.sched_priority = 0;
>  	sched_setscheduler(0, SCHED_OTHER, &schedp);
>  
> -	stat->threadstarted = -1;
> +	par->threadstarted = -1;
>  
>  	return NULL;
>  }
> @@ -298,7 +298,7 @@ static void print_stat(struct thread_param *par, int index, int verbose)
>  		if (quiet != 1) {
>  			printf("T:%2d (%5d) P:%2d C:%7lu "
>  			       "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n",
> -			       index, stat->tid, par->prio,
> +			       index, par->tid, par->prio,
>  			       stat->cycles, stat->min, stat->act,
>  			       stat->cycles ?
>  			       (long)(stat->avg/stat->cycles) : 0, stat->max);
> @@ -389,8 +389,8 @@ int main(int argc, char **argv)
>  		stat[i].min = 1000000;
>  		stat[i].max = -1000000;
>  		stat[i].avg = 0.0;
> -		stat[i].threadstarted = 1;
> -		status = pthread_create(&stat[i].thread, NULL, signalthread,
> +		par[i].threadstarted = 1;
> +		status = pthread_create(&par[i].thread, NULL, signalthread,
>  					&par[i]);
>  		if (status)
>  			fatal("failed to create thread %d: %s\n", i,
> @@ -401,18 +401,18 @@ int main(int argc, char **argv)
>  		int allstarted = 1;
>  
>  		for (i = 0; i < num_threads; i++) {
> -			if (stat[i].threadstarted != 2)
> +			if (par[i].threadstarted != 2)
>  				allstarted = 0;
>  		}
>  		if (!allstarted)
>  			continue;
>  
>  		for (i = 0; i < num_threads - 1; i++)
> -			stat[i].tothread = stat[i+1].thread;
> -		stat[i].tothread = stat[0].thread;
> +			par[i].tothread = par[i+1].thread;
> +		par[i].tothread = par[0].thread;
>  		break;
>  	}
> -	pthread_kill(stat[0].thread, signum);
> +	pthread_kill(par[0].thread, signum);
>  
>  	while (!shutdown) {
>  		char lavg[256];
> @@ -443,12 +443,12 @@ int main(int argc, char **argv)
>  	if (quiet)
>  		quiet = 2;
>  	for (i = 0; i < num_threads; i++) {
> -		if (stat[i].threadstarted > 0)
> -			pthread_kill(stat[i].thread, SIGUSR1);
> -		if (stat[i].interrupted)
> +		if (par[i].threadstarted > 0)
> +			pthread_kill(par[i].thread, SIGUSR1);
> +		if (par[i].interrupted)
>  			printf("Thread %d exceeded trace limit.\n", i);
> -		if (stat[i].threadstarted) {
> -			pthread_join(stat[i].thread, NULL);
> +		if (par[i].threadstarted) {
> +			pthread_join(par[i].thread, NULL);
>  			print_stat(&par[i], i, 0);
>  		}
>  		if (stat[i].values)
> -- 
> 2.30.0
> 
> 
No for the same reasons I gave for cyclictest.
Unncessary churn, and it makes backporting fixes harder too.

John
