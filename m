Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF611C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3A520678
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfIQHpB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:45:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40832 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIQHpB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 03:45:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iA8AT-0005bn-3S; Tue, 17 Sep 2019 09:44:57 +0200
Date:   Tue, 17 Sep 2019 09:44:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190917074456.yj7t3wdwuhn3zcng@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-2-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-2-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-11 17:57:25 [+0100], Scott Wood wrote:
> index 388ace315f32..9ce7c5006a5e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -600,6 +600,36 @@ static inline void rcu_read_unlock(void)
>  	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +/*
> + * On RT, local_bh_disable() calls rcu_read_lock() -- no need to
> + * track it twice.
> + */
> +static inline void rcu_bh_lock_acquire(void)
> +{
> +}
> +
> +static inline void rcu_bh_lock_release(void)
> +{
> +}
> +#else
> +static inline void rcu_bh_lock_acquire(void)
> +{
> +	__acquire(RCU_BH);
> +	rcu_lock_acquire(&rcu_bh_lock_map);
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> +			 "rcu_read_lock_bh() used illegally while idle");
> +}
> +
> +static inline void rcu_bh_lock_release(void)
> +{
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> +			 "rcu_read_unlock_bh() used illegally while idle");
> +	rcu_lock_release(&rcu_bh_lock_map);
> +	__release(RCU_BH);
> +}
> +#endif
> +
>  /**
>   * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
>   *
> @@ -615,10 +645,7 @@ static inline void rcu_read_unlock(void)
>  static inline void rcu_read_lock_bh(void)
>  {
>  	local_bh_disable();
> -	__acquire(RCU_BH);
> -	rcu_lock_acquire(&rcu_bh_lock_map);
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> -			 "rcu_read_lock_bh() used illegally while idle");
> +	rcu_bh_lock_acquire();
>  }
>  
>  /*

I asked previously why do you need to change rcu_read_lock_bh() and you
replied that you don't remember:
   https://lore.kernel.org/linux-rt-users/b948ec6cccda31925ed8dc123bd0f55423fff3d4.camel@redhat.com/

Did this change?

Sebastian
