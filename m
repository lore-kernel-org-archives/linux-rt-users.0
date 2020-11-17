Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD51C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 11:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D92A2078E
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 11:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8kf7c54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKQLGo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgKQLGo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Nov 2020 06:06:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806BCC0613CF;
        Tue, 17 Nov 2020 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BRrBBz1KgvikzkccKqFTVSAPFjaDPkfexbTOVrIOZI8=; b=u8kf7c54YIWfDuyxYoHulRHvoS
        h0L8H4TE1o3yzAlu35DwMUMyAql7jIOPyCMJ8/V3Nii5adSvXvbWwcNrGoTFGaKnB522jlan70HxA
        0/jh5hu/bWr1ulwp74ouOm4lEY5raFw0z9armYVRw98qK0EBvFzp2TQGnf9uhZua/Zs5Ko0tji9GN
        H1QhGjaeQ1HJdPkLHoyaSfzMIRcq8XoZ4dfRGveCIBN7FtM/iIz4IM95gHu8juWLdoKe0knSW/csN
        jbHra8ntqpMv9Z1Bso3KGEAxUWAbZEabelzXjZi3sOIhezFPdvF8W2txAgmwK01hUu1IS1e4jgTAN
        j4r/gbaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keyob-0001aY-65; Tue, 17 Nov 2020 11:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B29BD305CC3;
        Tue, 17 Nov 2020 12:06:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 987F720159855; Tue, 17 Nov 2020 12:06:20 +0100 (CET)
Date:   Tue, 17 Nov 2020 12:06:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013
 migration_cpu_stop+0x2e3/0x330
Message-ID: <20201117110620.GG3121378@hirez.programming.kicks-ass.net>
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
 <jhj3619y63v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj3619y63v.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 16, 2020 at 10:00:14AM +0000, Valentin Schneider wrote:
> 
> On 15/11/20 22:32, Oleksandr Natalenko wrote:
> > Hi.
> >
> > I'm running v5.10-rc3-rt7 for some time, and I came across this splat in 
> > dmesg:
> >
> > ```
> > [118769.951010] ------------[ cut here ]------------
> > [118769.951013] WARNING: CPU: 19 PID: 146 at kernel/sched/core.c:2013 
> 
> Err, I didn't pick up on this back then, but isn't that check bogus? If the
> task is enqueued elsewhere, it's valid for it not to be affined
> 'here'. Also that is_migration_disabled() check within is_cpu_allowed()
> makes me think this isn't the best thing to call on a remote task.
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1218f3ce1713..47d5b677585f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2010,7 +2010,7 @@ static int migration_cpu_stop(void *data)
>  		 * valid again. Nothing to do.
>  		 */
>  		if (!pending) {
> -			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
> +			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr));

Ho humm.. bit of a mess that. I'm trying to figure out if we need that
is_per_cpu_kthread() test here or not.

I suppose not, what we want here is to ensure the CPU is in cpus_mask
and not care about the whole hotplug mess.

Would it makes sense to replace both instances in migration_cpu_stop()
with:

	WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_mask));

?
