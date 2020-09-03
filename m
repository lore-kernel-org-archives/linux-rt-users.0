Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71320C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EE92072A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaCzu1wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgICQgu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICQgs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 12:36:48 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486EAC061244
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2020 09:36:46 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x7so1614820qvi.5
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2020 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=V+z2MB5uaQB9eQ/LI4a9lDmnVWJ620KDz9+9ky//TFI=;
        b=EaCzu1wzNo5scRXTam0uMxNuSHA8ngYmuLZLm5rPuree+6mKZlFqqDzUBlSQGQbSNn
         mdgp9j8LI5gNsSA3JwTUvWuZLC57MlQkrWmTA87swvWzMgKiMQGxG5VHz/CWo1dwmpH0
         8h11ASK4Mx075c61yApW8RnsBICu9RXS28eE+77FVBd2Wu1ZTffQUo+WVSMAfSU5iS7H
         m4WfFUwuIkViyH5mH79aUwcRA1JCEvidTfI/TkEO4crDav1ZL0n7XHNZvqkttLo/WXCk
         6GBgfiYgAFHnMz7uVY2apa9kwTo32QOuaEdSRwta0Fzs/7H9WI1HKKmMnt9tSYUQ9YYr
         JSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=V+z2MB5uaQB9eQ/LI4a9lDmnVWJ620KDz9+9ky//TFI=;
        b=dx+imtniLqOe1vkMRz60FBOjTMXdVRjVaW/t5yD1FVe8vNbgpmcnWuwzkoJCCHUC6k
         bCFUhU5orMIV/0LkJOEOHblJ9iWUTeorEYXGIbUT/dEguTDfKgCxPj2Q3OL7miEv7zZU
         CRZvZ7XNkxNNGbslrLknEsW7E71pQJjOUQYHMIGefKdIlXPf+6JYrWTaSvjyhu44frsu
         jorNO9quzATQOzPJvRXxJEKiZzBRibxC1l+50ofr9i5W0P9iiakybDNDSKzJJdZXFdys
         JYrILAC9jnOeQ5ZK1sdbTr9B7nHBtHjhED+RBKnhPRoCjJcZb0CJyoBcvqmy0pRgpVrZ
         I3Tw==
X-Gm-Message-State: AOAM530/Oqp3VPvMXcIUrbVkF9jADToco8vnXy9xEeFJbLQxeyxV57YN
        +tMs5kVVhpLRZBzA3BKCObD3f1Xxt6g=
X-Google-Smtp-Source: ABdhPJzejstkhTCFY8gMy5ANPqg2VGpNt1vD7PIXIpH4T5jNWGQu6Qx0pRDTCTs1X5Md1T9mmduUcQ==
X-Received: by 2002:a05:6214:10c9:: with SMTP id r9mr2803828qvs.0.1599151004840;
        Thu, 03 Sep 2020 09:36:44 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id i7sm2519499qkb.131.2020.09.03.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:36:44 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:36:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 1/4] rt-utils: Move timestamp calc helper to common
 header
In-Reply-To: <20200901154657.30198-2-dwagner@suse.de>
Message-ID: <alpine.LFD.2.23.451.2009031236060.4001@fionn>
References: <20200901154657.30198-1-dwagner@suse.de> <20200901154657.30198-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 1 Sep 2020, Daniel Wagner wrote:

> Several test implement the same helpers. Move it to a
> common header to avoid code duplication.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 40 -------------------------------------
>  src/include/rt-utils.h      | 40 +++++++++++++++++++++++++++++++++++++
>  src/pi_tests/pi_stress.c    |  8 --------
>  src/signaltest/signaltest.c | 15 --------------
>  4 files changed, 40 insertions(+), 63 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index dd418939a0c2..ae1d64a46b21 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -86,9 +86,6 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
>  			   struct timespec *__rem);
>  #endif	/* __UCLIBC__ */
>  
> -#define USEC_PER_SEC		1000000
> -#define NSEC_PER_SEC		1000000000
> -
>  #define HIST_MAX		1000000
>  
>  #define MODE_CYCLIC		0
> @@ -291,43 +288,6 @@ enum {
>  static int trace_fd     = -1;
>  static int tracemark_fd = -1;
>  
> -static inline void tsnorm(struct timespec *ts)
> -{
> -	while (ts->tv_nsec >= NSEC_PER_SEC) {
> -		ts->tv_nsec -= NSEC_PER_SEC;
> -		ts->tv_sec++;
> -	}
> -}
> -
> -static inline int tsgreater(struct timespec *a, struct timespec *b)
> -{
> -	return ((a->tv_sec > b->tv_sec) ||
> -		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
> -}
> -
> -static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
> -{
> -	int64_t diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
> -	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
> -	return diff;
> -}
> -
> -static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
> -{
> -	int64_t diff;
> -	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
> -	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
> -	return diff;
> -}
> -
> -static inline int64_t calctime(struct timespec t)
> -{
> -	int64_t time;
> -	time = USEC_PER_SEC * t.tv_sec;
> -	time += ((int) t.tv_nsec) / 1000;
> -	return time;
> -}
> -
>  /*
>   * Raise the soft priority limit up to prio, if that is less than or equal
>   * to the hard limit
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 51489b408e6c..fdd790600d68 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -30,4 +30,44 @@ int parse_time_string(char *val);
>  void enable_trace_mark(void);
>  void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
>  
> +#define USEC_PER_SEC		1000000
> +#define NSEC_PER_SEC		1000000000
> +
> +static inline void tsnorm(struct timespec *ts)
> +{
> +	while (ts->tv_nsec >= NSEC_PER_SEC) {
> +		ts->tv_nsec -= NSEC_PER_SEC;
> +		ts->tv_sec++;
> +	}
> +}
> +
> +static inline int tsgreater(struct timespec *a, struct timespec *b)
> +{
> +	return ((a->tv_sec > b->tv_sec) ||
> +		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
> +}
> +
> +static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
> +{
> +	int64_t diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
> +	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
> +	return diff;
> +}
> +
> +static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
> +{
> +	int64_t diff;
> +	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
> +	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
> +	return diff;
> +}
> +
> +static inline int64_t calctime(struct timespec t)
> +{
> +	int64_t time;
> +	time = USEC_PER_SEC * t.tv_sec;
> +	time += ((int) t.tv_nsec) / 1000;
> +	return time;
> +}
> +
>  #endif	/* __RT_UTILS.H */
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index eba21d7727bc..93d7044c9f22 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -519,14 +519,6 @@ int pending_interrupt(void)
>  	return interrupted = sigismember(&pending, SIGINT);
>  }
>  
> -static inline void tsnorm(struct timespec *ts)
> -{
> -	while (ts->tv_nsec >= NSEC_PER_SEC) {
> -		ts->tv_nsec -= NSEC_PER_SEC;
> -		ts->tv_sec++;
> -	}
> -}
> -
>  /*
>   * this routine serves two purposes:
>   *   1. report progress
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b5c86c5635cb..42a70facc6b3 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -69,21 +69,6 @@ static int shutdown;
>  static int tracelimit = 0;
>  static int oldtrace = 0;
>  
> -static inline void tsnorm(struct timespec *ts)
> -{
> -	while (ts->tv_nsec >= NSEC_PER_SEC) {
> -		ts->tv_nsec -= NSEC_PER_SEC;
> -		ts->tv_sec++;
> -	}
> -}
> -
> -static inline long calcdiff(struct timespec t1, struct timespec t2)
> -{
> -	long diff;
> -	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
> -	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
> -	return diff;
> -}
>  
>  /*
>   * signal thread
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
