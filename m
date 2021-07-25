Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9247C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 05:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF8C60F11
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 05:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGYEXY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 00:23:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58710 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYEXU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 00:23:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24F131C0B76; Sun, 25 Jul 2021 07:03:50 +0200 (CEST)
Date:   Sun, 25 Jul 2021 07:03:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
Message-ID: <20210725050349.GA983@bug>
References: <20210709215953.122804544@goodmis.org>
 <20210709220018.003428207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709220018.003428207@goodmis.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi!

> 5.10.47-rt46-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> Add set_affinity_pending::stop_pending, to indicate if a stopper is in
> progress.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9cbe12d8c5bd..20588a59300d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1900,6 +1900,7 @@ struct migration_arg {
>  
>  struct set_affinity_pending {
>  	refcount_t		refs;
> +	unsigned int		stop_pending;
>  	struct completion	done;
>  	struct cpu_stop_work	stop_work;
>  	struct migration_arg	arg;

For better readability, this should be bool, AFAICT.

>  		 * and have the stopper function handle it all race-free.
>  		 */
> +		stop_pending = pending->stop_pending;
> +		if (!stop_pending)
> +			pending->stop_pending = true;
>  
...because it is used as bool.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
