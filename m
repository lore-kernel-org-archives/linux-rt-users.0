Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835EC64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA7A2087D
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJHYJHxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLAHHk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgLAHHk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:07:40 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4BC0613D2
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:06:54 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z5so568430iob.11
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=TZwdyiGrxbD3jv5jddZ6t4My/WKhy8Pru8jzmNkRn1A=;
        b=tJHYJHxV6Cv6I2ivuXkvC15IzyW2wBS/32u5l3yiA2lj7CIm9utGW+HFo6XKgbVO38
         DEwJIUR4ZAQqnqk2hxGFBWuWcLwtfeKFSNJyUwKcJRvJeZOkI2ZCrUiWoWrfSfnrrafD
         bU9pUo6pirLN8m/kgQHr/5rPKcbOlSbsc9SAJGv7bhh/96mo/QgtUttZNVlSK+jT69JM
         S6Xwm5CNEyX3OdE3/JdUlXY5UwiQjXs3v7aw2kuaerSLuMbGSx4UsVcbOuuwDtBOy8vY
         VS/iheXsSF8J9oufZDPJCIG7A2V/y9FKHxIJlbIEvL30doIT5Awe6S45NExk/VH01orX
         E4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=TZwdyiGrxbD3jv5jddZ6t4My/WKhy8Pru8jzmNkRn1A=;
        b=uRwPspAKTbsihs4JHyp9xVIfOE41DiSFXXoHUiHI4kCy47WS5yfM4GE6PdGbgoIX7C
         c+UnZFTVqjK+4cgYnyF4u4qS5mWmjyfuTdwbYRTAofy4Vlg6LqTy/eJwU1Ixffx2RCrq
         +mmoVcFZI3rqsupH8rOyAJ8xRRHVulFo3ZqqQBPU6kZ8jjMRdJEwXo0PvPszfvOJ6sFN
         uJvsM199bAbc6RaGYFLjBIM6BrSw6H1OT5ZJ/YTozn9Nfq4arrGj13aK59FOyfwy9EEk
         TjD7YxIh7ycenb0M8N9w/XiArrHn3Ths4NdPPkmyA8Jdu+F4HODevAwnD23E5D/Y5AcN
         /m5A==
X-Gm-Message-State: AOAM533HGKiMulWQt8btJNSq1oGsgd+zdOD/i2eWYf/QiR5uTFx6xm76
        B5FLHQXFwBeZA36bN+Qye84=
X-Google-Smtp-Source: ABdhPJy6mb4RRsIyfE4ezkWyt+V8/xtca2vIVcDOOzNjotaC+KUFhCBvpjFsT5ttGRyfEvA0YhUtZg==
X-Received: by 2002:a02:9002:: with SMTP id w2mr1507371jaf.111.1606806411804;
        Mon, 30 Nov 2020 23:06:51 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id j8sm590961ilk.50.2020.11.30.23.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:06:51 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:06:47 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 06/12] ptsematest: Move statictic output into
 print_stat()
In-Reply-To: <20201118190642.16006-7-dwagner@suse.de>
Message-ID: <4f4a3b77-a1c2-6a65-c691-87c99ae1fea@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 18 Nov 2020, Daniel Wagner wrote:

> Prepare the code to introduce the quiet command line option by moving
> the statistic output code into print_stat(). We follow here the
> pattern from cyclictest.
> 
> While at it replace the rather sophisticated error printing code with
> a fatal(). Just fail if something is not working.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ptsematest/ptsematest.c | 65 ++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 37 deletions(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 9cd5f34509a8..69b4e1221361 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -52,7 +52,6 @@ struct params {
>  	struct timeval unblocked, received, diff;
>  	pthread_t threadid;
>  	struct params *neighbor;
> -	char error[MAX_PATH * 2];
>  };
>  
>  void *semathread(void *param)
> @@ -121,9 +120,8 @@ void *semathread(void *param)
>  					write(tracing_enabled, "0", 1);
>  					close(tracing_enabled);
>  				} else
> -					snprintf(par->error, sizeof(par->error),
> -					    "Could not access %s\n",
> -					    tracing_enabled_file);
> +					fatal("Could not access %s\n",
> +					      tracing_enabled_file);
>  				par->shutdown = 1;
>  				par->neighbor->shutdown = 1;
>  			}
> @@ -290,6 +288,28 @@ static void sighand(int sig)
>  	shutdown = 1;
>  }
>  
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_threads; i++) {
> +		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
> +			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> +			receiver[i].delay.tv_nsec / 1000,
> +			i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
> +			sender[i].samples);
> +	}
> +	for (i = 0; i < num_threads; i++) {
> +		printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> +			i*2+1, i*2,
> +			receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
> +			(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
> +			receiver[i].maxdiff);
> +	}
> +}
> +
> +
>  int main(int argc, char *argv[])
>  {
>  	int i;
> @@ -367,40 +387,13 @@ int main(int argc, char *argv[])
>  	maindelay.tv_nsec = 50000000; /* 50 ms */
>  
>  	while (!shutdown) {
> -		int printed;
> -		int errorlines = 0;
> -
>  		for (i = 0; i < num_threads; i++)
>  			shutdown |= receiver[i].shutdown | sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || shutdown) {
> -			for (i = 0; i < num_threads; i++) {
> -				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
> -				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> -				    receiver[i].delay.tv_nsec / 1000,
> -				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
> -				    sender[i].samples);
> -			}
> -			for (i = 0; i < num_threads; i++) {
> -				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> -					i*2+1, i*2,
> -					receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
> -					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
> -					receiver[i].maxdiff);
> -				if (receiver[i].error[0] != '\0') {
> -					printf("%s", receiver[i].error);
> -					errorlines++;
> -					receiver[i].error[0] = '\0';
> -				}
> -				if (sender[i].error[0] != '\0') {
> -					printf("%s", sender[i].error);
> -					errorlines++;
> -					receiver[i].error[0] = '\0';
> -				}
> -			}
> -			printed = 1;
> -		} else
> -			printed = 0;
> +			print_stat(stdout, receiver, sender, 0, 0);
> +			printf("\033[%dA", num_threads*2);
> +		}
>  
>  		sigemptyset(&sigset);
>  		sigaddset(&sigset, SIGTERM);
> @@ -411,10 +404,8 @@ int main(int argc, char *argv[])
>  
>  		sigemptyset(&sigset);
>  		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
> -
> -		if (printed && !shutdown)
> -			printf("\033[%dA", num_threads*2 + errorlines);
>  	}
> +	printf("\033[%dB", num_threads*2 + 2);
>  
>  	for (i = 0; i < num_threads; i++) {
>  		receiver[i].shutdown = 1;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
