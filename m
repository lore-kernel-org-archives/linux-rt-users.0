Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DBC56201
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B265246B0
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4i1WfKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRVJU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVJU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:09:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C58C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:09:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g20so2799948qtu.4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eH+MMv3Jg0Sa/jReOdihjWLZOHy5Y9PHKzYDwKXZ+/E=;
        b=Z4i1WfKrkJ2t3fr1fYI6Qt6pOUOp3GfoFMN1ukA90BjM4qHu4nq6GQD83JMNRLe/ct
         q4n2Rg02XHk3TUcuJGvAYmK8ohWCweVboE8Mrzqy/fA9UtYXogb0uH/UhCHOvMdMRvhP
         adr5m2ub2xHXK3Sf9cs0qa65Htbxd7iTSDdMc/MFD5q/QkHAhh+ZvnVO+9c1TB+PEbOh
         kCaG4VD4aUYxohPGS6U2HCdOpOvgZztBRhm/fnaeQsnEKZd4vA9Zhssg0TG9+EoSHDX8
         GI7GmZ8Z03XHObKsKAzIbzRxgsenTb7wkRvZ8aZSZAnuYZx9GvZrheb/uWHiHPNYR9kV
         N+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=eH+MMv3Jg0Sa/jReOdihjWLZOHy5Y9PHKzYDwKXZ+/E=;
        b=rlywh85ZrH2OybL/GsbV/iqxrlwnD/xjYnUs201S+R2eKH6Hf9fl7vHfl6sHxDnBDn
         4Kn5CJX4Jui9uNjN5ResxJFZSMDmZv63Y6puNzJN46+qEYkS6rvzZbCjP4UKYj59KkSQ
         yChs1ZbUODBd2t2SZAQB2aT9exp0sds6baMDSWqKXwzlcb/Z6pr7KXE8Z8NV9rB5Tx+Z
         HED53JKu65almI1Gwv1MY5Az5cyRCpx0EIBpIMmTyKOh4/T9RkkxdxsKfNrQrrkRj7iJ
         FsnIp8MTbrc0vXVsXpfxdcFL8wO9oE6eiQ1jBT+q7/E9dqv2j0hSPAHNYTmkhEZEvIC9
         7Riw==
X-Gm-Message-State: AOAM533GL5oWRCxoYbaPl/n3IqX73XrnatTMygJVgOc2pBB47SZ7cut+
        moIajGvNYbzx54baq/sYyyEZhpnnda71iQ==
X-Google-Smtp-Source: ABdhPJwY7PkKWuHHciXegUCyrCwU1xxykx00utC9jfQ4FHmngZEudyqSoBfBQiIlBi4jfXGdP3V5BQ==
X-Received: by 2002:ac8:46cf:: with SMTP id h15mr5894667qto.99.1605733759616;
        Wed, 18 Nov 2020 13:09:19 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id b21sm5018362qtp.90.2020.11.18.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:09:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:09:18 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] rt-numa: Introduce NUMA helpers
In-Reply-To: <20201113210910.21807-5-dwagner@suse.de>
Message-ID: <c91d965d-2e3-d7e0-7416-9b6746d298d4@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> A common task is to parse the provided cpumask from the command
> line. Add a helper which uses libnuma. Since we don't want to add
> unnecessary dependencies for tests which don't need this helper create
> a new library containing the NUMA bits.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Makefile              | 18 +++++++-------
>  src/include/rt-numa.h |  9 +++++++
>  src/lib/rt-numa.c     | 56 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 9 deletions(-)
>  create mode 100644 src/include/rt-numa.h
>  create mode 100644 src/lib/rt-numa.c
> 
> diff --git a/Makefile b/Makefile
> index 24895b7f9697..3afdfd4d53a7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -24,6 +24,7 @@ TARGETS = $(sources:.c=)
>  LIBS	= -lrt -lpthread
>  RTTESTLIB = -lrttest -L$(OBJDIR)
>  EXTRA_LIBS ?= -ldl	# for get_cpu
> +RTTESTNUMA = -lrttestnuma -lnuma
>  DESTDIR	?=
>  prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
> @@ -84,11 +85,6 @@ ostype := $(lastword $(subst -, ,$(dumpmachine)))
>  machinetype := $(shell echo $(dumpmachine)| \
>      sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
>  
> -# You have to have libnuma installed, which is fine to do even if you are
> -# running on non-numa machines
> -CFLAGS += -DNUMA
> -NUMA_LIBS = -lnuma
> -
>  include src/arch/android/Makefile
>  
>  VPATH	= src/cyclictest:
> @@ -122,8 +118,8 @@ all: $(TARGETS) hwlatdetect get_cyclictest_snapshot | $(OBJDIR)
>  # Include dependency files, automatically generate them if needed.
>  -include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
>  
> -cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
> +cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
>  
>  cyclicdeadline: $(OBJDIR)/cyclicdeadline.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> @@ -172,8 +168,8 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
>  ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
> -oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
> +oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
>  
>  %.8.gz: %.8
>  	gzip -nc $< > $@
> @@ -185,6 +181,10 @@ LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
>  $(OBJDIR)/librttest.a: $(LIBOBJS)
>  	$(AR) rcs $@ $^
>  
> +LIBNUMAOBJS =$(addprefix $(OBJDIR)/,rt-numa.o)
> +$(OBJDIR)/librttestnuma.a: $(LIBNUMAOBJS)
> +	$(AR) rcs $@ $^
> +
>  CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a *.8.gz *.8.bz2
>  CLEANUP += $(if $(wildcard .git), ChangeLog)
>  
> diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
> new file mode 100644
> index 000000000000..047c8b6257cc
> --- /dev/null
> +++ b/src/include/rt-numa.h
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#ifndef __RT_NUMA_H
> +#define __RT_NUMA_H
> +
> +#include <numa.h>
> +
> +int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
> +
> +#endif
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> new file mode 100644
> index 000000000000..a52a56e8aadd
> --- /dev/null
> +++ b/src/lib/rt-numa.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2020 Daniel Wagner <dwagner@suse.de>
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include "rt-numa.h"
> +
> +/*
> + * After this function is called, affinity_mask is the intersection of
> + * the user supplied affinity mask and the affinity mask from the run
> + * time environment
> + */
> +static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> +{
> +	struct bitmask *curmask;
> +	int i;
> +
> +	curmask = numa_allocate_cpumask();
> +	numa_sched_getaffinity(getpid(), curmask);
> +
> +	/*
> +	 * Clear bits that are not set in both the cpuset from the
> +	 * environment, and in the user specified affinity.
> +	 */
> +	for (i = 0; i < max_cpus; i++) {
> +		if ((!numa_bitmask_isbitset(cpumask, i)) ||
> +		    (!numa_bitmask_isbitset(curmask, i)))
> +			numa_bitmask_clearbit(cpumask, i);
> +	}
> +
> +	numa_bitmask_free(curmask);
> +}
> +
> +int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
> +{
> +	struct bitmask *mask;
> +
> +	mask = numa_parse_cpustring_all(str);
> +	if (!mask)
> +		return -ENOMEM;
> +
> +	if (numa_bitmask_weight(mask) == 0) {
> +		numa_bitmask_free(mask);
> +		*cpumask = NULL;
> +		return 0;
> +	}
> +
> +	use_current_cpuset(max_cpus, mask);
> +	*cpumask = mask;
> +
> +	return 0;
> +}
> -- 
> 2.29.2
> 
> 
    Adding my name to the copyright in the new file src/lib/rt-numa.c
    as some of the functions moved here are ones that I've written or
    modified / maintained etc.
    Signed-off-by: John Kacur <jkacur@redhat.com>

Also, wondering if we should combine the two rt-numa.h files into one?
