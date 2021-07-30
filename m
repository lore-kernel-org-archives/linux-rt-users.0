Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D00C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2013E60F48
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 20:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhG3U2L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230217AbhG3U2K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 16:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627676885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYwuZFf+XZiZ2fvtFbujnIAgMRmk0IynlSEsHd4iL60=;
        b=KUrpv9YIIz0jKBfgE1oBf71yXogtUtxOZUoLyi3lxXVZyk06eYL8VKncxTo7Wu6o+LpOAR
        KqPSAeRaAfL9kROZUfhfM7ARoarrghANq7AdVvPKqGm8kPS5YwXXjrYdzQJEldMNu+Zlzw
        lLRsRSdVV8zXGWzur86vZvjrdtQikZ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-_eqL7IwrPn-zCL297AOuXg-1; Fri, 30 Jul 2021 16:28:03 -0400
X-MC-Unique: _eqL7IwrPn-zCL297AOuXg-1
Received: by mail-qv1-f70.google.com with SMTP id t18-20020a0cd4120000b02902fbda5d4988so6733198qvh.11
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jul 2021 13:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WYwuZFf+XZiZ2fvtFbujnIAgMRmk0IynlSEsHd4iL60=;
        b=ZW9GOqZzsdXvz9QjCq0BdCtktb+neurAdcRjNjpVZRRVwncL3HnTf5qBZYPJciJ4K+
         FxVLB7XPVkIoTq4bSvOCtQ6ihacnzQ9pQJAYVF3mS3NGjjubkpYKn5RNhlpG7oZvXwKF
         +bLdGEgtMOCnnZMtNARo4yjhSdP7vJe1UhltATpVzYV+mIwDjNnMN62m42G+FLuy3Z68
         p2UZY2apQmCFIr1uI4ijdXLUn23bY32ZRBEgyYHswYa+fhnezEpJ8XUEJ9uVikadsN0i
         sDctnBkrlP3oHXCqgJ+PZYHEWD9PZ8Bv2fjLTcXScLIBIs/vwNNHt8q28X0E0fgReXiU
         0zMQ==
X-Gm-Message-State: AOAM530GTfBSK9nj2UCTy1ztcSle33crFRPJ7P7rsto+sDJhv09O1lIT
        1T2KJLSmgSB60w1+b1DjQ9qzs/cFofw43iiRNugzvOavpMXVVVxGWPkpLWwwlFmgDcn5hQER2bT
        ulpih8jjzxq5rUtqoZ+IuMKzNfvw=
X-Received: by 2002:a37:84c1:: with SMTP id g184mr4080475qkd.102.1627676883289;
        Fri, 30 Jul 2021 13:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwveKo3hqyV5739xUtccdazMaPWLV1eu5xW1bu7bW/hR0CgwPMgJEvItrydMGeQdTsKsJAbIQ==
X-Received: by 2002:a37:84c1:: with SMTP id g184mr4080457qkd.102.1627676883106;
        Fri, 30 Jul 2021 13:28:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id v5sm1455816qkh.39.2021.07.30.13.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 13:28:02 -0700 (PDT)
Date:   Fri, 30 Jul 2021 16:28:01 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2 1/2] rt-utils: Add option to avoid stopping tracing
 in tracemark()
In-Reply-To: <20210714110718.68292-1-nsaenzju@redhat.com>
Message-ID: <6811f6a6-cc33-8b35-f03b-c7c4235d70a7@redhat.com>
References: <20210714110718.68292-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 14 Jul 2021, Nicolas Saenz Julienne wrote:

> Not all users of tracemark() might want to stop tracing after printing a
> mark. For example, if leaving a mark during a test. So add an extra
> argument to tracemark() which avoid the stop.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
> 
> Changes since v1:
>  - Add stdbool.h include in rt-utils.h
> 
>  src/cyclictest/cyclictest.c | 3 ++-
>  src/include/rt-utils.h      | 3 ++-
>  src/lib/rt-utils.c          | 6 ++++--
>  src/oslat/oslat.c           | 2 +-
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a08c91d..1f3c5a2 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <unistd.h>
>  #include <fcntl.h>
>  #include <getopt.h>
> @@ -722,7 +723,7 @@ static void *timerthread(void *param)
>  			pthread_mutex_lock(&break_thread_id_lock);
>  			if (break_thread_id == 0) {
>  				break_thread_id = stat->tid;
> -				tracemark("hit latency threshold (%llu > %d)",
> +				tracemark(true, "hit latency threshold (%llu > %d)",
>  					  (unsigned long long) diff, tracelimit);
>  				break_thread_value = diff;
>  			}
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index f6b3fed..5b3d34d 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -3,6 +3,7 @@
>  #define __RT_UTILS_H
>  
>  #include <stdint.h>
> +#include <stdbool.h>
>  
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
> @@ -31,7 +32,7 @@ int parse_time_string(char *val);
>  int parse_mem_string(char *str, uint64_t *val);
>  
>  void enable_trace_mark(void);
> -void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> +void tracemark(bool stop, char *fmt, ...) __attribute__((format(printf, 2, 3)));
>  void disable_trace_mark(void);
>  
>  #define MSEC_PER_SEC		1000
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 6c0235d..d8d1325 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -23,6 +23,7 @@
>  #include <sys/utsname.h>
>  #include <time.h>
>  #include <sys/time.h>
> +#include <stdbool.h>
>  
>  #include "rt-utils.h"
>  #include "rt-sched.h"
> @@ -458,7 +459,7 @@ static void debugfs_prepare(void)
>  		     "debug fs not mounted");
>  }
>  
> -void tracemark(char *fmt, ...)
> +void tracemark(bool stop, char *fmt, ...)
>  {
>  	va_list ap;
>  	int len;
> @@ -476,7 +477,8 @@ void tracemark(char *fmt, ...)
>  	write(tracemark_fd, tracebuf, len);
>  
>  	/* now stop any trace */
> -	write(trace_fd, "0\n", 2);
> +	if (stop)
> +		write(trace_fd, "0\n", 2);
>  }
>  
>  void enable_trace_mark(void)
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 6ff5ba8..d35be57 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -304,7 +304,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
>  		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
>  		    "Stopping the test.\n";
> -		tracemark(line, g.app_name, g.trace_threshold, us);
> +		tracemark(true, line, g.app_name, g.trace_threshold, us);
>  		err_quit(line, g.app_name, g.trace_threshold, us);
>  	}
>  
> -- 
> 2.31.1
> 
> 

I'm curious as to how you are running this?
What I would do is, something like this
trace-cmd record -p function ./oslat -T100
I have no end to the amount of data it generates.

John

