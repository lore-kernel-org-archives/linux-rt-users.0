Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41ADC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 10:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDF02313B
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 10:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbhAGKqn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKqm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jan 2021 05:46:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9BC0612F4;
        Thu,  7 Jan 2021 02:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EZKc6JiWIIcJxEETAlkAtOFPKHvjCYewp6b1efPwaA8=; b=LaVWe1dbfhZ6njw8CV1APm8ggg
        Zr24H8QkTfqsv9yuhm2WPykWE1yYVeiWYa4VH5BpyAzRH4QxO7Vwsrwx8rjXUhkVfV9OnauDWbvX6
        OPrJeXgQKEKIDczo4w08dWJ+OMNdUgEb4mEcmc/vQfCxlPBruBaKRHJhS5wPy+bYeb4FtrHgEj9Fm
        DcDWP0Rmt85SMpV4FTC+A8PZkHohzE6XSQfgceaeOhE+C9yxZBjllSC9ek30uQfzFkw5tnN4WlBvN
        Ksg8TzXC+858328jaDMfcXEf8hl4frCrA7DqEjr/3iHG6LT6FmT/eeJGwtk7h3TS4rAcgJQVyx4Yt
        1KBpUDmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxSnX-0004zI-D0; Thu, 07 Jan 2021 10:45:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A0B83013E5;
        Thu,  7 Jan 2021 11:45:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57A3D200E972D; Thu,  7 Jan 2021 11:45:39 +0100 (CET)
Date:   Thu, 7 Jan 2021 11:45:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Message-ID: <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107091841.19798-1-ran.wang_1@nxp.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 07, 2021 at 05:18:41PM +0800, Ran Wang wrote:
> +
> +			if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +			    !strncmp(p->comm, "ksoftirqd/", 10))
> +				schedule_hrtimeout(&to,
> +					HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
> +			else
> +				schedule_hrtimeout(&to, HRTIMER_MODE_REL);

This is horrific, why did you not self-censor and spare me the mental
anguish of having to formulate a CoC compliant response?

It also violates coding style, but given the total lack of any sense,
that seems like a minor detail.

Why can't we use HRTIMER_MODE_HARD unconditionally?
