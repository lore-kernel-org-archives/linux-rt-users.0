Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5ABC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiAXRHm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbiAXRHk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 12:07:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A2C06173D
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jan 2022 09:07:40 -0800 (PST)
Date:   Mon, 24 Jan 2022 18:07:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643044058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZbL1W9wsPQ+49Dz2+V10ZHfKVcdmPO5iGYjEB8koqg=;
        b=V+j3hTQyo6JrXdsF2gsFiam3/iAaYqSrPJss7qIEAjstWbNtUWBi3UgYz/3KgqvAYf1oIb
        9ykTIHLWO4wYP3z8UCrV+7ozHIex/rNaxYOulI/k2eKBL/chAVxwpy5CLWf1hjqWd2mXr8
        HQ60gN9NWyhmbX09Niyy44zkyVH5XACQaqXcwSDr9qFuiSpTtpJ4xaxozI8mchnbOu/4I9
        yuS0yC6smv/eLLu8ED/llOLJa0yBnmcCVmNaYIcaxy1iQ/FW2GlXJJI7UBNiguCjqSUo5w
        +J9twooPexqIMF2Oz2Vx4/mSgTFx0FKi9DIm5r4hbNmRiL6UX4YhUUj648WGzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643044058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZbL1W9wsPQ+49Dz2+V10ZHfKVcdmPO5iGYjEB8koqg=;
        b=s8JJKTkPLiFfRbYEdPR62lDO9UV4rcXai58IKOLY9fzVwFme02rx2ab9pVh03s6sYZdaGX
        HbrPbWyq0OqHEsAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Ye7c2cWSNJvdegmq@linutronix.de>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <Yer4kB0fmR41u19Y@linutronix.de>
 <Ye6id4lSKMcqAZ65@fuller.cnet>
 <Ye7TMlx3mJkTxCsI@linutronix.de>
 <Ye7WkRKz9Ha/ROP1@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ye7WkRKz9Ha/ROP1@fuller.cnet>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-24 13:40:49 [-0300], Marcelo Tosatti wrote:
> > Uses the $CPU (mask) specified. If $CPU is not part of the current CPU
> > mask, why shouldn't it work?
> 
>        -a, --affinity[=PROC-SET]
>               Run threads on the set of processors given by PROC-SET.  If PROC-SET is not specified, all processors will be used.  Threads will be assigned to processors
>               in the set in numeric order, in a round-robin fashion.
>               The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.  The ! character can be used to negate a set.  For example, !B-D means to
>               use all available CPUs except B through D.  The cpu numbers are the same as shown in the processor field in /proc/cpuinfo.  See numa(3) for more
>               information on specifying CPU sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET, if specified, must be a single CPU
>               number.
> 
> 
> /*
>  * After this function is called, affinity_mask is the intersection of
>  * the user supplied affinity mask and the affinity mask from the run
>  * time environment
>  */
> static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> {
>         struct bitmask *curmask;
>         int i;
> 
>         curmask = numa_allocate_cpumask();
>         numa_sched_getaffinity(getpid(), curmask);
> 
>         /*
>          * Clear bits that are not set in both the cpuset from the
>          * environment, and in the user specified affinity.
>          */
>         for (i = 0; i < max_cpus; i++) {
>                 if ((!numa_bitmask_isbitset(cpumask, i)) ||
>                     (!numa_bitmask_isbitset(curmask, i)))
>                         numa_bitmask_clearbit(cpumask, i);
>         }
> 
>         numa_bitmask_free(curmask);
> }
> 
> Consider 8 CPU system booted with isolcpus=3-7, and execution of 
> "cyclictest -a 3-7".
> 
> sched_getaffinity() returns mask with bits set for CPUs 0 and 1.
> The user supplied mask has bits 3-7 set.
> 
> The intersection between the user supplied mask and the affinity mask
> from the run time environment has no bits set.

Okay. But does this make to keep? I understand that the current CPU-mask
needs to be kept for masks like !B or !B-D. But is there a need to use
the current CPU-mask when a specific mask has been specified by the user?

Sebastian
