Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD7C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3522072A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ9egl1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgICQh3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICQhZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 12:37:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08819C061244
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2020 09:37:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o64so3614636qkb.10
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2020 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=qmCwmoKpF5sVfM/zRiHoTaBVfD96YnZ3qB0mLs473xM=;
        b=PJ9egl1gqVOW+/fuG24usw3QWouwKkqh3+ZWMH8vZ7l/Beu42y6UE0r6SLSFhpk1zz
         2kQ5IMM7TNFbq0T7Gq4BScIzPHDS6k/piqsy5QicBh42WpO1n3pLO0lFDZLmd1IMSKBq
         jBV4padZKrpWLnTGWXovHeUp1pyntt54pciQydk3dcopQKTswNBa49ltXpl9qY7u4G+Z
         70JtzzY+lwQlkohVwVA6D0phUcxW5AqVNU6QcwFKvqik9ewKeBU68h40uht7P57pzjQa
         qbUdKtMwDLtER2hTXI2S499gmGxl+fqWYsmtr5b7v4b+8liw7sL8nPfd/PqwC9gixk8k
         k6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=qmCwmoKpF5sVfM/zRiHoTaBVfD96YnZ3qB0mLs473xM=;
        b=if4i7kyRZzlzYLLoVdhuc8/hpT9BYiVBFdWyvTrw+/TB4LoBuNTyDUcI8XQ3+7t8Er
         AYF5+t1vzveZpbKFSO6V0YKZB2mbDhBgdN3M10DlZqX4TupxRiDfA/vDvwOedAhCCyc6
         SXgwlvD9ovCVjrCrBUcDxZ3MhcgLvu4fjG/QPepE+U9mcQCbtxcRybSH5F2rxihY2LC3
         UkmjrYzWYagFWGSQrEd2c7E/l5a2VandeXYBup3ULtiBuH+uTa6CG55rOA/GUJhtxIoi
         w+bYrmgph+H1MwpSkoVEsYwwS1rzv7YNy4axWBu+LXUinWpcu5trFhUQ38WIBtQEvbMK
         C4Qw==
X-Gm-Message-State: AOAM531tHFQoxYdp/vSCHmEwrtVf6urTf9Ydo8XVV0NL9u6P68jUjP94
        WAgZWzXzhiCKpjlB3nzva14=
X-Google-Smtp-Source: ABdhPJxiLfjMaYdBVboK0z1xfyS0C10VN1My2P8Us8kv0VeCd5WN8Eq1tVuR0COHV6G/LQtfHjtmww==
X-Received: by 2002:a05:620a:200b:: with SMTP id c11mr3825320qka.92.1599151043797;
        Thu, 03 Sep 2020 09:37:23 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id d10sm2437790qkk.1.2020.09.03.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:37:23 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:37:22 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 2/4] rt-utils: Move time defininitions to common
 header
In-Reply-To: <20200901154657.30198-3-dwagner@suse.de>
Message-ID: <alpine.LFD.2.23.451.2009031236550.4001@fionn>
References: <20200901154657.30198-1-dwagner@suse.de> <20200901154657.30198-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 1 Sep 2020, Daniel Wagner wrote:

> Several tests define the same time values. Move them all to
> common header to avoid code duplication.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/backfire/sendme.c         | 3 ---
>  src/include/rt-utils.h        | 6 ++++++
>  src/pi_tests/pi_stress.c      | 9 ---------
>  src/pmqtest/pmqtest.c         | 4 ----
>  src/ptsematest/ptsematest.c   | 2 --
>  src/queuelat/queuelat.c       | 2 +-
>  src/signaltest/signaltest.c   | 3 ---
>  src/sigwaittest/sigwaittest.c | 2 --
>  src/svsematest/svsematest.c   | 2 --
>  9 files changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
> index c1854d9660cb..d963723b1c93 100644
> --- a/src/backfire/sendme.c
> +++ b/src/backfire/sendme.c
> @@ -38,9 +38,6 @@
>  #include <sys/time.h>
>  #include <sys/mman.h>
>  
> -#define USEC_PER_SEC		1000000
> -#define NSEC_PER_SEC		1000000000
> -
>  #define SIGTEST SIGHUP
>  
>  enum {
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index fdd790600d68..f7b98d9605a0 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -30,8 +30,14 @@ int parse_time_string(char *val);
>  void enable_trace_mark(void);
>  void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
>  
> +#define MSEC_PER_SEC		1000
>  #define USEC_PER_SEC		1000000
>  #define NSEC_PER_SEC		1000000000
> +#define USEC_TO_NSEC(u)		((u) * 1000)
> +#define USEC_TO_SEC(u)		(u) / USEC_PER_SEC)
> +#define NSEC_TO_USEC(n)		((n) / 1000)
> +#define SEC_TO_NSEC(s)		((s) * NSEC_PER_SEC)
> +#define SEC_TO_USEC(s)		((s) * USEC_PER_SEC)
>  
>  static inline void tsnorm(struct timespec *ts)
>  {
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 93d7044c9f22..e03cca25b933 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -50,15 +50,6 @@
>  
>  #include "error.h"
>  
> -/* conversions */
> -#define USEC_PER_SEC 	1000000
> -#define NSEC_PER_SEC 	1000000000
> -#define USEC_TO_NSEC(u) ((u) * 1000)
> -#define USEC_TO_SEC(u) 	((u) / USEC_PER_SEC)
> -#define NSEC_TO_USEC(n) ((n) / 1000)
> -#define SEC_TO_NSEC(s) 	((s) * NSEC_PER_SEC)
> -#define SEC_TO_USEC(s) 	((s) * USEC_PER_SEC)
> -
>  /* test timeout */
>  #define TIMEOUT 2
>  
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 3ce29252b9a2..5db8d348cdf8 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -27,13 +27,9 @@
>  
>  #include <pthread.h>
>  
> -#define USEC_PER_SEC 1000000
> -
>  #define SYNCMQ_NAME "/syncmsg%d"
>  #define TESTMQ_NAME "/testmsg%d"
>  #define MSG_SIZE 8
> -#define MSEC_PER_SEC 1000
> -#define NSEC_PER_SEC 1000000000
>  
>  char *syncmsg = "Syncing";
>  char *testmsg = "Testing";
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 485c991ec173..de8ea2fe1b0c 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -25,8 +25,6 @@
>  
>  #include <pthread.h>
>  
> -#define USEC_PER_SEC 1000000
> -
>  enum {
>  	AFFINITY_UNSPECIFIED,
>  	AFFINITY_SPECIFIED,
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index 22b68a84d6ae..2b9118d8a8a5 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -17,7 +17,7 @@
>  #include <signal.h>
>  #include <time.h>
>  
> -#define NSEC_PER_SEC 1000000000
> +#include "rt-utils.h"
>  
>  /* Program parameters:
>   * max_queue_len: maximum latency allowed, in nanoseconds (int).
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 42a70facc6b3..49d42ff20b6f 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -34,9 +34,6 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
> -#define USEC_PER_SEC		1000000
> -#define NSEC_PER_SEC		1000000000
> -
>  /* Must be power of 2 ! */
>  #define VALBUF_SIZE		16384
>  
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 4678b68675b2..e7393f791519 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -43,8 +43,6 @@
>  
>  #include <pthread.h>
>  
> -#define USEC_PER_SEC 1000000
> -
>  enum {
>  	AFFINITY_UNSPECIFIED,
>  	AFFINITY_SPECIFIED,
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 023a303fd7df..607b397bf39e 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -32,8 +32,6 @@
>  #include "rt-get_cpu.h"
>  #include "error.h"
>  
> -#define USEC_PER_SEC 1000000
> -
>  #define SEM_WAIT_FOR_RECEIVER 0
>  #define SEM_WAIT_FOR_SENDER 1
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
