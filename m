Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E15C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317622078C
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDTSyc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDTSyc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 14:54:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D5C061A0C
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 11:54:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQbYs-0004pE-OP; Mon, 20 Apr 2020 20:54:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0AE41101623; Mon, 20 Apr 2020 20:54:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     trix@redhat.com, williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2] Import a new test, jitterz
In-Reply-To: <20200418141449.19293-1-trix@redhat.com>
References: <20200418141449.19293-1-trix@redhat.com>
Date:   Mon, 20 Apr 2020 20:54:29 +0200
Message-ID: <875zduvvh6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Tom,

trix@redhat.com writes:
> From: Tom Rix <trix@redhat.com>

it seems you are serious about this.

> jitterz is a program for measuring system jitter.

Aside of that not being accurate, there is neither a proper description
of the functionality nor a reasoning why this is useful and should
therefore be part of rt-tests.

> diff --git a/src/jitterz/jitterz.8 b/src/jitterz/jitterz.8
> new file mode 100644
> index 0000000..5b85640
> --- /dev/null
> +++ b/src/jitterz/jitterz.8
> @@ -0,0 +1,39 @@
> +.TH JIITERZ 8 "April 1, 2020"
> +.SH NAME
> +jitterz \- inference of stalls by looking for gaps in executing a tight loop
> +.SH SYNOPSIS
> +.B jitterz
> +.RI "<options>"
> +.SH DESCRIPTION
> +In a tight loop, measure the time between iterations.
> +If the time exceeds a theshold, increment a count in a time
> +bucket.  At the end of test print out the buckets.

Jitter is the deviation from true periodicity of a periodic event.

But that's not what you are measuring here. You try to find gaps in
tight loop execution, which is something completely different.

Now again the question is what's the purpose and the value of this
measurement?

> +/* Returns clock ticks */
> +static inline uint64_t time_stamp_counter(void)
> +{
> +	uint64_t ret = -1;
> +#if defined(__i386__) || defined(__x86_64__)
> +	uint32_t l, h;

First of all. What's wrong with using clock_gettime() ?

> +	__asm__ __volatile__("lfence");
> +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));

Aside of that x86-ism here, what guarantees that the CPU has lfence?

> +	ret = ((uint64_t)h << 32) | l;
> +#else
> +	fprintf(stderr,
> +		"Add a time_stamp_counter function for your arch here %s:%d\n",
> +		__FILE__, __LINE__);

This is brilliant. You know already at compile time that this can't
work, but instead of failing the build you print an error at runtime.

Thanks,

        tglx
