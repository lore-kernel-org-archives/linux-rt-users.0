Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D236C48BDF
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 23:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EF761358
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhFRXiD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhFRXiD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Jun 2021 19:38:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C977C061574;
        Fri, 18 Jun 2021 16:35:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624059348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS1kEFj6NGxOacoKrHgfdHSnLlRh4SbebwWizyJZYAQ=;
        b=bL9fI3hkWv9PH8dWCaMIiufhxPnkLjnyHYN+0q7OBXHCKUBnaV7eaQPujoorCSKLiD5tMC
        SIsn56dSt7/b0XVY9FAfyUzt1yUfJDNAjNl5AKgC4E66LM2EaSLNoLmJSEK7uESfsC/ChC
        MW+wB8Q+XTba+uFDxN9PHw6asAGtfbtBd+5MQd2q0a26FzD7KPZUIIOrhzH54vsc+9gt89
        eUOcXNIXu5qN13/iQu9JkA6rzVni2sAJgDfF35Ic/BtvYQZyD+sb9+e4Co9R/XjDOOnycX
        lyV6WuJdKCPOYPe/Z4j5xE0EoA/wWgiA7Huumyi96UjqnJkOZhVpA1p60kF1Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624059348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS1kEFj6NGxOacoKrHgfdHSnLlRh4SbebwWizyJZYAQ=;
        b=F9n+R9/XKZUhSghkg/hlUe4kVkioHlAPWvPyVzZnBSojsqQV3DYUgVN8ezqSFokGiAi6wA
        /9KadsMRKM1MDtAA==
To:     Juri Lelli <juri.lelli@redhat.com>, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH RT v2 1/2] time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
In-Reply-To: <20210616071705.166658-2-juri.lelli@redhat.com>
References: <20210616071705.166658-1-juri.lelli@redhat.com> <20210616071705.166658-2-juri.lelli@redhat.com>
Date:   Sat, 19 Jun 2021 01:35:47 +0200
Message-ID: <87k0mqeofg.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Juri,

On Wed, Jun 16 2021 at 09:17, Juri Lelli wrote:
> While running cyclictest on isolated CPUs with timer_migration enabled,
> I noticed the following behavior, where CPU0 is one of the housekeeping
> CPUs and CPU2 is isolated:
>
>      <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
>      <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
>      <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
>      <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
>      <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
>  cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
>  cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
>  cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]
>
> While cyclitest was arming the hrtimer while running on isolated CPU2
> (by means of clock_nanosleep), the hrtimer was then firing on CPU0. This
> is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
> time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
> the timer is not pinned and timer_migration is enabled.
>
> The problem with this is that we are measuring wake up latencies across
> isolated and !isolated domains, which is against the purpose of
> configuring the latter.
>
> Since PREEMPT_RT already forces HARD mode for hrtimers armed by tasks
> running with RT policies, it makes sense to also force PINNED mode under
> the same conditions.
>
> This patch implements this behavior, achieving something like the

 git grep 'This patch' Documentation/process

Also look at the recommended usage of 'We, I' while at it.

> @@ -55,6 +55,8 @@ enum hrtimer_mode {
>  	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
>  	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
>  
> +	HRTIMER_MODE_PINNED_HARD = HRTIMER_MODE_PINNED | HRTIMER_MODE_HARD,
> +
>  	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
>  	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
>  };
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 3fa18a01f5b2..f64954d5c8f8 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1842,7 +1842,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> -			mode |= HRTIMER_MODE_HARD;
> +			mode |= HRTIMER_MODE_PINNED_HARD;
>  	}
>  
>  	__hrtimer_init(&sl->timer, clock_id, mode);

It makes sense to some extent, but in fact you are curing the symptom.

The root cause is that all of this is semantically ill defined.

The underlying problem is get_nohz_timer_target() which is a completely
broken heuristics trying to predict which CPU is the proper target for
handling the timer some unspecified time in the future.

In hindsight I regret that I even helped to merge that, but hindsight.
Is get_nohz_timer_target() anything near correct for some unspecified
reason? You surely know that it's not.

In fact your patch makes it even more semantically undefined simply
because it is solving the single RT thread per CPU use case which is
exposed by cyclictest. Is that universaly true for all RT tasks and use
cases?

The wild west of anything which scratches 'my itch' based on 'my use
case numbers' in Linux ended many years ago and while RT was always a
valuable playground for unthinkable ideas we definitely tried hard not
to accept use case specific hacks wihtout a proper justification that it
makes sense in general.

So why are you even trying to sell this to me?

get_nohz_timer_target() is broken by definition and while it made some
sense years ago despite it's heuristic nature, this is something which
really needs to be cleaned up because it causes more trouble than it
solves. Tagging every other timer as pinned just to work around that
underlying nonsense is just wrong.

We have been working on getting rid of this at least for the timer list
timers (which are admittedly the easier part of the problem) on and off
for years. I can't find the public links right now, but I'll ask
Anna-Maria to fill the void. Might take a while as she's AFK for a
while.

Thanks,

        tglx








