Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6AC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA69961B80
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhG0QX2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QX1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jul 2021 12:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C769E61B93;
        Tue, 27 Jul 2021 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627403007;
        bh=Kmx4YqSFfCeTWZsfTwDQpSXyGw2cgAovhs1crpCknaM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jrp4mUDoOskJf03UesWUpSZrUCr8fNLu7wyCmLjT2jhdI7FNnXF/FRx5bUVlV9jwN
         gpLaLz0UJvVdBAInSPa2WYJPd2wXERH+GY26jqaa0YQZQKjUmL/inD+2gAINZEAvt1
         FnI9tScDStvOpzQLhxnykVE15zUXqCRZqloNfIPE9+Idnjn4J6SN9kxppw0h4B+puN
         4/9Q7zfvPqFJ8KTvESzj8oAJwypWGhl4g0qVHgKwP7ewWqHG20rZe8ldPkV4UAKaPU
         DGsUdVc7bsAtQYsWEB7mtLLJcp8KAI9CeGc61UcnHdb5GS8saiOcvE/Hcr8V56QjQI
         nlsl1RnEGJJsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 902E55C099F; Tue, 27 Jul 2021 09:23:27 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:23:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/3] sched: Introduce is_pcpu_safe()
Message-ID: <20210727162327.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721115118.729943-1-valentin.schneider@arm.com>
 <20210721115118.729943-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721115118.729943-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 21, 2021 at 12:51:16PM +0100, Valentin Schneider wrote:
> Some areas use preempt_disable() + preempt_enable() to safely access
> per-CPU data. The PREEMPT_RT folks have shown this can also be done by
> keeping preemption enabled and instead disabling migration (and acquiring a
> sleepable lock, if relevant).
> 
> Introduce a helper which checks whether the current task can safely access
> per-CPU data, IOW if the task's context guarantees the accesses will target
> a single CPU. This accounts for preemption, CPU affinity, and migrate
> disable - note that the CPU affinity check also mandates the presence of
> PF_NO_SETAFFINITY, as otherwise userspace could concurrently render the
> upcoming per-CPU access(es) unsafe.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index efdbdf654876..7ce2d5c1ad55 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1707,6 +1707,16 @@ static inline bool is_percpu_thread(void)
>  #endif
>  }
>  
> +/* Is the current task guaranteed not to be migrated elsewhere? */
> +static inline bool is_pcpu_safe(void)
> +{
> +#ifdef CONFIG_SMP
> +	return !preemptible() || is_percpu_thread() || current->migration_disabled;
> +#else
> +	return true;
> +#endif
> +}
> +
>  /* Per-process atomic flags. */
>  #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
>  #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
> -- 
> 2.25.1
> 
