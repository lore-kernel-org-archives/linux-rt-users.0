Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F5FC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F322A85
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbhAZRTQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAZGNf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:13:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44450C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:12:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v126so14949445qkd.11
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8MZv0IYRrIAWDG0HyDb5Eex5svbWSft9q1besiAVHss=;
        b=qVGVsKFgBk+px+enJ2M5Ktn7bQ8lwbvMn9pF3V5ZXUqhqRZGDNXpQ+8MEaFegUYM89
         6ir8fLCKbroqbSWQHhW5zDku8/dPLmTAUVCrVKygn1YWw52bfFpy7MHpJgNZjOqe0lJz
         A3IZYvSzTMyIOFOPOZ4nAY9kwCqVg0IYIyViFqGmZKynGCsVnTnRkBvxI5b4QUYb4Yrv
         9NKWWJi61vfM0FHQaJ28moRDs+uI9nTRRaCkP5ypQO90iAhF47uldSExf4vtwSROLyWO
         mOVbwnkzM64HdXy4+C3Dr8lyXlEbWUvLDy5r1dZWAV4IlvN2qLK+NeatQ/hisp7ezuz3
         RfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8MZv0IYRrIAWDG0HyDb5Eex5svbWSft9q1besiAVHss=;
        b=gvd2adpQSJE58HJBiBhQl7Vq3SDM3jc0GwvEeOg9LB0vAKC9iQXKYtbAnqWmre393h
         G+5thvwFh3069wcRoyxwcYc9legcPy9JovJHtCD8Qdc5eRx2qabfguq4/aq4fzkIHxKU
         5+nCnPdNMzHX46WrLKngIhU6EoSG14ZySZbdLH9emoESQCDLOIIURkR3qTHawagG5Gkb
         HlUp1wBbtzZM1B2elEMvAEmKQZiQWbEDGvyxXAi4pbOXE8VxZ2nDqQEDEmGqOgTv2LRl
         8m63X8rDVT3UTxHLrGv+p+ANuS3afPxMOvQtqZw6J+KIkEocVbxuIugaarheFwWwUZ1D
         HO+w==
X-Gm-Message-State: AOAM530CpAOJwJa/4KZ67AC1f9nRe0yXY7HmwC7Iy8+NryZtVYW5C4Fu
        0mnSpvh4rutPhta948BuW98=
X-Google-Smtp-Source: ABdhPJw4dP/L4ea1NO1bsA6Lzyty16u8UDGnyvyi/NTZgMG4H2FRwYtuIfHJq6+M7zkBGtFuqB0g6Q==
X-Received: by 2002:a37:7104:: with SMTP id m4mr4401817qkc.5.1611641571559;
        Mon, 25 Jan 2021 22:12:51 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id x15sm8421507qtr.72.2021.01.25.22.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:12:51 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:12:50 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 03/19] rt-tests: Rename error.h to rt-error.h
In-Reply-To: <20210115190936.26148-4-dwagner@suse.de>
Message-ID: <bff1f2e6-7437-8bd2-ff30-801fcbb42a4e@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> Avoid confusion with the system header called error.h.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c         | 2 +-
>  src/include/pip_stress.h            | 5 +++--
>  src/include/{error.h => rt-error.h} | 0
>  src/lib/error.c                     | 2 +-
>  src/lib/rt-numa.c                   | 2 +-
>  src/lib/rt-utils.c                  | 3 ++-
>  src/oslat/oslat.c                   | 2 +-
>  src/pi_tests/pi_stress.c            | 3 +--
>  src/pmqtest/pmqtest.c               | 6 +++---
>  src/ptsematest/ptsematest.c         | 6 +++---
>  src/sched_deadline/cyclicdeadline.c | 6 +++---
>  src/signaltest/signaltest.c         | 2 +-
>  src/sigwaittest/sigwaittest.c       | 2 +-
>  src/svsematest/svsematest.c         | 3 ++-
>  14 files changed, 23 insertions(+), 21 deletions(-)
>  rename src/include/{error.h => rt-error.h} (100%)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 5c738005f778..9225e52aa982 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -36,7 +36,7 @@
>  
>  #include "rt-utils.h"
>  #include "rt-numa.h"
> -#include "error.h"
> +#include "rt-error.h"
>  
>  #include <bionic.h>
>  
> diff --git a/src/include/pip_stress.h b/src/include/pip_stress.h
> index ee8b545ab117..f03aaf397897 100644
> --- a/src/include/pip_stress.h
> +++ b/src/include/pip_stress.h
> @@ -14,8 +14,9 @@
>  #include <sys/wait.h>
>  #include <signal.h>
>  #include <sched.h>
> -#include <rt-utils.h>
> -#include "error.h"
> +
> +#include "rt-utils.h"
> +#include "rt-error.h"
>  
>  void low(pid_t pid);	/* low priority process */
>  void medium(void);	/* medium priority process */
> diff --git a/src/include/error.h b/src/include/rt-error.h
> similarity index 100%
> rename from src/include/error.h
> rename to src/include/rt-error.h
> diff --git a/src/lib/error.c b/src/lib/error.c
> index 4434a842da17..616f70b044e0 100644
> --- a/src/lib/error.c
> +++ b/src/lib/error.c
> @@ -5,7 +5,7 @@
>   * error routines, similar to those found in
>   * Advanced Programming in the UNIX Environment 2nd ed.
>   */
> -#include "error.h"
> +#include "rt-error.h"
>  
>  /* Print an error message, plus a message for err and exit with error err */
>  void err_exit(int err, char *fmt, ...)
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index 04f2e9adb4b1..4a0865715141 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -10,7 +10,7 @@
>  #include <sched.h>
>  #include <pthread.h>
>  
> -#include "error.h"
> +#include "rt-error.h"
>  #include "rt-numa.h"
>  
>  int get_available_cpus(struct bitmask *cpumask)
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 2d68d62cd875..321a11b1172d 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -20,9 +20,10 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <sys/syscall.h> /* For SYS_gettid definitions */
> +
>  #include "rt-utils.h"
>  #include "rt-sched.h"
> -#include "error.h"
> +#include "rt-error.h"
>  
>  #define  TRACEBUFSIZ  1024
>  
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 0811079d9f04..9e6f70600830 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -43,7 +43,7 @@
>  
>  #include "rt-utils.h"
>  #include "rt-numa.h"
> -#include "error.h"
> +#include "rt-error.h"
>  
>  #ifdef __GNUC__
>  # define atomic_inc(ptr)   __sync_add_and_fetch((ptr), 1)
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 538d12c975aa..49f89b7b0136 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -47,8 +47,7 @@
>  
>  #include "rt-sched.h"
>  #include "rt-utils.h"
> -
> -#include "error.h"
> +#include "rt-error.h"
>  
>  /* test timeout */
>  #define TIMEOUT 2
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 5f7a24d55db6..349b47741003 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -21,11 +21,11 @@
>  #include <linux/unistd.h>
>  #include <utmpx.h>
>  #include <mqueue.h>
> +#include <pthread.h>
> +
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> -#include "error.h"
> -
> -#include <pthread.h>
> +#include "rt-error.h"
>  
>  #define SYNCMQ_NAME "/syncmsg%d"
>  #define TESTMQ_NAME "/testmsg%d"
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index f8f075591f4b..7d4ca97773d6 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -19,11 +19,11 @@
>  #include <sys/mman.h>
>  #include <linux/unistd.h>
>  #include <utmpx.h>
> +#include <pthread.h>
> +
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> -#include "error.h"
> -
> -#include <pthread.h>
> +#include "rt-error.h"
>  
>  enum {
>  	AFFINITY_UNSPECIFIED,
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 98eb367248ac..19a7fcb6c488 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -30,9 +30,9 @@
>  #include <linux/unistd.h>
>  #include <linux/magic.h>
>  
> -#include <rt-utils.h>
> -#include <rt-sched.h>
> -#include <error.h>
> +#include "rt-utils.h"
> +#include "rt-sched.h"
> +#include "rt-error.h"
>  
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 5427db7f8d85..c34bc994d886 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -31,7 +31,7 @@
>  #include <sys/time.h>
>  #include <sys/mman.h>
>  
> -#include "error.h"
> +#include "rt-error.h"
>  #include "rt-utils.h"
>  #include "rt-numa.h"
>  
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 7e287bd2424f..f10c24914d4a 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -42,7 +42,7 @@
>  
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> -#include "error.h"
> +#include "rt-error.h"
>  
>  enum {
>  	AFFINITY_UNSPECIFIED,
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 7388efb3f488..7a298e0dea8c 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -28,9 +28,10 @@
>  #include <sys/sem.h>
>  #include <sys/time.h>
>  #include <sys/mman.h>
> +
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> -#include "error.h"
> +#include "rt-error.h"
>  
>  #define SEM_WAIT_FOR_RECEIVER 0
>  #define SEM_WAIT_FOR_SENDER 1
> -- 
> 2.29.2
> 
> 
This looks good, I will apply it after we're done with all the
rt-numa changes first
