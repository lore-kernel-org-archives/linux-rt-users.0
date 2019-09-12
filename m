Return-Path: <SRS0=iEIM=XH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEDC4CEC8
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Sep 2019 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E5720856
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Sep 2019 22:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W/5NCKT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfILWJn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:09:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36610 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILWJn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Sep 2019 18:09:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so12346311plr.3
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Sep 2019 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1NxeIc8kdbb1mtpMHLFI7ESi2lNJyG1ruAa5EmaZJI=;
        b=W/5NCKT5I0KAKwvDWMakHiNM3E2P2jPhKQFcWA+DTfZmRgSQFOnwamoRDtGHE33Hic
         K6PiVIEBtnBXT8+rpGTlyjxYYuQpJFgdLPwuJFKdz/1qr+b9f/G9m4D/Mmh8UAZhU5WW
         qFfI81VKGdvvCdnf80fEBZGdfr2L/iTKni4CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1NxeIc8kdbb1mtpMHLFI7ESi2lNJyG1ruAa5EmaZJI=;
        b=iJdJQksNsXuiXMBJLNdRXId4weh3XFxnA+vy2o28Nb4NYKSC25vYxDKhgwuhc3L3GS
         DjZCswyHDXHi2tCK15WNgYPX0LP2JS9aCw0cfRnH7A8hJWrX066MP4O+ptVO0aQOZbzA
         IxaW15RIMqGOs63p0AhIihK6cP3ad393xjD1c4vScdk9WQclSyDDjH1edJgwoHEKZODh
         lcfJAFyoAosCrMUJEJRAstwgMG2PgvVdsu4RHvx79yLyxdozEz7AIA2XvAnclK+uuYlT
         ljJDE1EaJvcHvXez8CLzxOEKgzejH6D7tNr3lEiTDU9aws/UbQZZgxSb5lCA3Gt87Xp3
         K3Pw==
X-Gm-Message-State: APjAAAXwmVMktUSh8YvZbuqPhWqPbpgnQMoC8p5nUGf6QpHsV/BNOiuq
        OSqz5MrvKK4faeUmv2Qhh1LM8A==
X-Google-Smtp-Source: APXvYqymEWxw8JW732tbtAlQJU1m3Y+4Qy5o7vaXWkDd5px6WpRvlu/Jz3J7LJ2MAKYYTNR8raF03g==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr1255401plm.106.1568326182396;
        Thu, 12 Sep 2019 15:09:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm41501297pfq.121.2019.09.12.15.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:09:41 -0700 (PDT)
Date:   Thu, 12 Sep 2019 18:09:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190912220940.GB150506@google.com>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-2-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-2-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 11, 2019 at 05:57:25PM +0100, Scott Wood wrote:
> A plain local_bh_disable() is documented as creating an RCU critical
> section, and (at least) rcutorture expects this to be the case.  However,
> in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> preempt_count() directly.  Even if RCU were changed to check
> in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> 
> Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> rcu_read_lock_bh_held() accordingly.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
> v3: Remove change to rcu_read_lock_bh_held(), and move debug portions
> of rcu_read_[un]lock_bh() to separate functions
> ---
>  include/linux/rcupdate.h | 40 ++++++++++++++++++++++++++++++++--------
>  kernel/softirq.c         | 12 +++++++++---
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
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
> @@ -628,10 +655,7 @@ static inline void rcu_read_lock_bh(void)
>   */
>  static inline void rcu_read_unlock_bh(void)
>  {
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> -			 "rcu_read_unlock_bh() used illegally while idle");
> -	rcu_lock_release(&rcu_bh_lock_map);
> -	__release(RCU_BH);
> +	rcu_bh_lock_release();
>  	local_bh_enable();
>  }
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index d16d080a74f7..6080c9328df1 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -115,8 +115,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  	long soft_cnt;
>  
>  	WARN_ON_ONCE(in_irq());
> -	if (!in_atomic())
> +	if (!in_atomic()) {
>  		local_lock(bh_lock);
> +		rcu_read_lock();
> +	}
>  	soft_cnt = this_cpu_inc_return(softirq_counter);
>  	WARN_ON_ONCE(soft_cnt == 0);
>  	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
> @@ -151,8 +153,10 @@ void _local_bh_enable(void)
>  #endif
>  
>  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  }
>  
>  void _local_bh_enable_rt(void)
> @@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	WARN_ON_ONCE(count < 0);
>  	local_irq_enable();
>  
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  
>  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
>  	preempt_check_resched();
> -- 
> 1.8.3.1
> 
