Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EFC3815B
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 13:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9A820735
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 13:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgDTNtj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbgDTNtj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 09:49:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AAC061A0C
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 06:49:39 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jQWnp-00068i-UB; Mon, 20 Apr 2020 15:49:37 +0200
Date:   Mon, 20 Apr 2020 15:49:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     trix@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] Import a new test, jitterz
Message-ID: <20200420134937.fxyjibufftdt6btr@linutronix.de>
References: <20200418141449.19293-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200418141449.19293-1-trix@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-18 07:14:49 [-0700], trix@redhat.com wrote:
> --- /dev/null
> +++ b/src/jitterz/jitterz.c
> @@ -0,0 +1,400 @@
…
> +/*
> + * jitterz
> + *
> + * Copyright 2019-2020 Tom Rix <trix@redhat.com>
> + *
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

in general there is no need of that ifndef and this should be taken care
by the build system (and refuse the build if _GNU_SOURCE makes no
difference/ is not available). And then include the config.h (or so)
first header file. 
In rt-tests, the Makefile already adds this define to the CFLAGS.

…
> +/* Returns clock ticks */
> +static inline uint64_t time_stamp_counter(void)
> +{
> +	uint64_t ret = -1;
> +#if defined(__i386__) || defined(__x86_64__)
> +	uint32_t l, h;
> +
> +	__asm__ __volatile__("lfence");
> +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
> +	ret = ((uint64_t)h << 32) | l;
> +#else
> +	fprintf(stderr,
> +		"Add a time_stamp_counter function for your arch here %s:%d\n",
> +		__FILE__, __LINE__);
> +	exit(1);
> +#endif
> +	return ret;
> +}

I remember I complained about this in `queuelat' and it ended nowhere
once it got merged.
To repeat my question: Is there a reason not to use clock_gettime()?
With VDSO there should be hardly any difference between this and
clock_gettime().

Sebastian
