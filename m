Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EACC64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB82087D
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saYCVkYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgLAHLz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAHLz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:11:55 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97AC0613D2
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:11:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z5so577522iob.11
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Zv5ZAQmJaOShYZ9yVFt88mooIi0ZykfmlhniBi0h14k=;
        b=saYCVkYOYvDpV7buxVyB+zQpnalWrO+EmAR9A7bGh2eKDGF4RVev1qfsKgRw7fupIG
         YuGrwOkI0RvDJbB2C+WdmH5q7HkxNxW7HKWk2Nb0SNAlggmMtxEmY+LljRMn1NHIO3m0
         nClPqBM3dNUJo0W3ORhszlU8NDWXOWVVdsjDibnUIHW7xktjBv2eYNLTwec4G8mSacAn
         45Kmctu9WT7r1M3bc494YrjBJ6kny0OjJKgCwVH/Rq+PZa0C8LbzdzU6Vkcsi/jRqwLv
         DCAZa4PfW0W0Gq8vUpLEpJ6EfjSflroU6fDWaeLzvrWZNqXyUukmtj3se8FL9ynUmVk4
         RREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Zv5ZAQmJaOShYZ9yVFt88mooIi0ZykfmlhniBi0h14k=;
        b=dGJgPUQczOQYlZTYLwlPdsg5DuCNl9EcPYFQ+iHmb7SN0s9E+ms3LYZ5nfwYkeJ279
         eFPIoF0ZfX86PfBgBwPSZZ5kwUbE7NRdI8MRnSD+SR2mQkIQ3UIwgB0D5NNTbANIWydh
         i0S70YQaEmyA9qHkIyvJEuL+nLUt4WkKjfrryLc9lM5ynq4+QVTyCMe4Nez9PwppP8xq
         kzcVcUnULBXXFTnkEcwnpUBaX2zX5eSSvXFbF0GdW4YfJ7ETqV+xOol5yQprzKH/c+rO
         x7mitDP/iqBn7SKjT995+AcuaUuzpTNBIs23MRTtV6AUHHIWnVsGUvTnene674i6B75D
         yOcA==
X-Gm-Message-State: AOAM5320R18th4DpFZNXvZxyE1arw3AIu5LTXpRt0TZPCD/RTeMBl+4N
        q6IJFZdCZQoyjN/JOmnfjcM=
X-Google-Smtp-Source: ABdhPJw7WxBDsngGtGc3oFHvnPfXtp1gSBXzNKDJ/FjOpwtedzxh5A0z3HB7BTxud8O1hLx+Upl/VQ==
X-Received: by 2002:a02:9f8b:: with SMTP id a11mr1498388jam.108.1606806674369;
        Mon, 30 Nov 2020 23:11:14 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id a13sm649049ilh.0.2020.11.30.23.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:11:13 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:11:09 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 08/12] svsematest: Move statictic output into
 print_stat()
In-Reply-To: <20201118190642.16006-9-dwagner@suse.de>
Message-ID: <59477fbe-1fad-3e15-d2ed-26a1cb1c83ad@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-9-dwagner@suse.de>
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
>  src/svsematest/svsematest.c | 101 ++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 56 deletions(-)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 98efd930e63f..7de20dc65445 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -65,7 +65,6 @@ struct params {
>  	struct timeval unblocked, received, diff;
>  	pthread_t threadid;
>  	struct params *neighbor;
> -	char error[MAX_PATH * 2];
>  };
>  
>  static int mustfork;
> @@ -95,9 +94,8 @@ void *semathread(void *param)
>  		CPU_ZERO(&mask);
>  		CPU_SET(par->cpu, &mask);
>  		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
> -			snprintf(par->error, sizeof(par->error),
> -			    "WARNING: Could not set CPU affinity "
> -			    "to CPU #%d\n", par->cpu);
> +			fatal("Could not set CPU affinity "
> +			      "to CPU #%d\n", par->cpu);
>  	} else {
>  		int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
> @@ -178,9 +176,8 @@ void *semathread(void *param)
>  					write(tracing_enabled, "0", 1);
>  					close(tracing_enabled);
>  				} else
> -					snprintf(par->error, sizeof(par->error),
> -					    "Could not access %s\n",
> -					    tracing_enabled_file);
> +					fatal("Could not access %s\n",
> +					      tracing_enabled_file);
>  				par->shutdown = 1;
>  				neighbor->shutdown = 1;
>  			}
> @@ -379,6 +376,42 @@ static void sighand(int sig)
>  	mustshutdown = 1;
>  }
>  
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_threads; i++) {
> +		int receiver_pid, sender_pid;
> +
> +		if (mustfork) {
> +			receiver_pid = receiver[i].pid;
> +			sender_pid = sender[i].pid;
> +		} else {
> +			receiver_pid = receiver[i].tid;
> +			sender_pid = sender[i].tid;
> +		}
> +		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
> +			i*2, receiver_pid, receiver[i].priority,
> +			receiver[i].cpu, receiver[i].delay.tv_nsec /
> +			1000, i*2+1, sender_pid, sender[i].priority,
> +			sender[i].cpu, sender[i].samples);
> +	}
> +
> +	for (i = 0; i < num_threads; i++) {
> +		if (receiver[i].mindiff == -1)
> +			printf("#%d -> #%d (not yet ready)\n",
> +				i*2+1, i*2);
> +		else
> +			printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> +				i*2+1, i*2, receiver[i].mindiff,
> +				(int) receiver[i].diff.tv_usec,
> +				(int) ((receiver[i].sumdiff /
> +						receiver[i].samples) + 0.5),
> +				receiver[i].maxdiff);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	char *myfile;
> @@ -608,57 +641,14 @@ int main(int argc, char *argv[])
>  	}
>  
>  	while (!mustshutdown) {
> -		int printed;
> -		int errorlines = 0;
> -
>  		for (i = 0; i < num_threads; i++)
>  			mustshutdown |= receiver[i].shutdown |
>  			    sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || mustshutdown) {
> -			for (i = 0; i < num_threads; i++) {
> -				int receiver_pid, sender_pid;
> -
> -				if (mustfork) {
> -					receiver_pid = receiver[i].pid;
> -					sender_pid = sender[i].pid;
> -				} else {
> -					receiver_pid = receiver[i].tid;
> -					sender_pid = sender[i].tid;
> -				}
> -				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: "
> -				    "ID%d, P%d, CPU%d, Cycles %d\n",
> -				    i*2, receiver_pid, receiver[i].priority,
> -				    receiver[i].cpu, receiver[i].delay.tv_nsec /
> -				    1000, i*2+1, sender_pid, sender[i].priority,
> -				    sender[i].cpu, sender[i].samples);
> -			}
> -			for (i = 0; i < num_threads; i++) {
> -				if (receiver[i].mindiff == -1)
> -					printf("#%d -> #%d (not yet ready)\n",
> -					    i*2+1, i*2);
> -				else
> -					printf("#%d -> #%d, Min %4d, Cur %4d, "
> -					    "Avg %4d, Max %4d\n",
> -					    i*2+1, i*2, receiver[i].mindiff,
> -					    (int) receiver[i].diff.tv_usec,
> -					    (int) ((receiver[i].sumdiff /
> -					    receiver[i].samples) + 0.5),
> -					    receiver[i].maxdiff);
> -				if (receiver[i].error[0] != '\0') {
> -					printf("%s", receiver[i].error);
> -					receiver[i].error[0] = '\0';
> -					errorlines++;
> -				}
> -				if (sender[i].error[0] != '\0') {
> -					printf("%s", sender[i].error);
> -					sender[i].error[0] = '\0';
> -					errorlines++;
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
> @@ -670,11 +660,10 @@ int main(int argc, char *argv[])
>  
>  		sigemptyset(&sigset);
>  		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
> -
> -		if (printed && !mustshutdown)
> -			printf("\033[%dA", num_threads*2 + errorlines);
>  	}
>  
> +	printf("\033[%dB", num_threads*2 + 2);
> +
>  	for (i = 0; i < num_threads; i++) {
>  		receiver[i].shutdown = 1;
>  		sender[i].shutdown = 1;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
