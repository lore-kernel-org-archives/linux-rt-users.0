Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3528FC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F0264DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBQDvA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDu6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:50:58 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC19C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:18 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h8so11632297qkk.6
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=d0ZfkQe7NQ+L5YvP34oMNI/p65HZhBp78ZWzsvyXy3I=;
        b=idQhRc4/1Ga0ydUyODpWc8ghCe4kEHYwb47+hhQq7Yc9CJZ+NCesm/clHm6r3tFAyq
         gdQ3WLBtuK8KofZs536s7944pjqSxvnLnb0QMV7brFZup9VCx0b7chvm9hy2SElyN26q
         F7S1YZfjg2TWPwKiZEgdXDoaPO0OLlHPpkmjl/j7Nkb5oAbbNgJKIg5Bj4rwJp3CC8zx
         nWBbFKRD8vyFYODhjEWIdDQuxpHL1aEWiaAGedg6ZCyb8ICijMW7RUwFs1I9UllxC6Ye
         vzVFUwvshrMQfia8qlzsHdp8hR+G0jqII61WqU6U8eAU9umPicIESukNNW69pW4xTfsT
         v/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=d0ZfkQe7NQ+L5YvP34oMNI/p65HZhBp78ZWzsvyXy3I=;
        b=TWKhjIASNAYhtKW7sYSQPDJztjs4elp0cHC9ta9LSZ6d4FF/UXU9ffqEntfyE+dXSx
         TJP12zfDcOpjqHL5GQSZVMETkyl0wvfNbMvTIjrbFHphJL9vk2799AYzql5GsCDoLIHE
         kYb1OsxnzwbNblTHo1ahi3aWNdZCjxKjTQlfDtf5/gF56bQrXb1kFEJQI8b7cGwTS84J
         1ohQQ93Mwd+kfzDu0Y6TwBgZ0Cxk8jEskyW5mH2GkN0kCv8aYKwBbumnlgVVMSsF8ddY
         Vc1S9sfd+rsHsVv09lQ8TQUdrBHtl9a4AF9FfBeww95f2CEsAGxkBrV1ZJHysTyHEGa5
         U24Q==
X-Gm-Message-State: AOAM530+JFPRgeEM5pBui0F/x6+gTfW9u2g8+Tbgzdu/3us7wihGPyS8
        +7PIS7nv+3EyU/bVPXNpKVIzJJz56rw7HQ==
X-Google-Smtp-Source: ABdhPJxGsrwDvmilScQE7E2tIPwl75LbUTSpIu7YpFsCyL/YoQRdXOVOty4JJZYvYj8HyEZFfPsp7w==
X-Received: by 2002:a05:620a:15ea:: with SMTP id p10mr17020414qkm.192.1613533817441;
        Tue, 16 Feb 2021 19:50:17 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id c143sm828604qkg.83.2021.02.16.19.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:50:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:50:16 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v4 16/16] rt-tests: Rename error.h to
 rt-error.h
In-Reply-To: <20210210133450.6991-17-dwagner@suse.de>
Message-ID: <5bc6ef17-105d-27a7-8f56-2caaa8e385f3@redhat.com>
References: <20210210133450.6991-1-dwagner@suse.de> <20210210133450.6991-17-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> Avoid confusion with the system header called error.h.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Makefile                            | 2 +-
>  src/cyclictest/cyclictest.c         | 2 +-
>  src/include/pip_stress.h            | 5 +++--
>  src/include/{error.h => rt-error.h} | 0
>  src/lib/{error.c => rt-error.c}     | 2 +-
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
>  15 files changed, 24 insertions(+), 22 deletions(-)
>  rename src/include/{error.h => rt-error.h} (100%)
>  rename src/lib/{error.c => rt-error.c} (98%)
> 
> diff --git a/Makefile b/Makefile
> index 636f1914a777..b17ac0957adc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -177,7 +177,7 @@ oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
>  %.8.bz2: %.8
>  	bzip2 -c $< > $@
>  
> -LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
> +LIBOBJS =$(addprefix $(OBJDIR)/,rt-error.o rt-get_cpu.o rt-sched.o rt-utils.o)
>  $(OBJDIR)/librttest.a: $(LIBOBJS)
>  	$(AR) rcs $@ $^
>  
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f912bcf82def..c4b2369bee6b 100644
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
> diff --git a/src/lib/error.c b/src/lib/rt-error.c
> similarity index 98%
> rename from src/lib/error.c
> rename to src/lib/rt-error.c
> index 4434a842da17..616f70b044e0 100644
> --- a/src/lib/error.c
> +++ b/src/lib/rt-error.c
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
> index 6dcfd6074085..71cde5781499 100644
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
> 2.30.0
> 
> 
   - Fixed a conflict in cyclictest.c
    - Fixed up rt_numa.h
    Signed-off-by: John Kacur <jkacur@redhat.com>


