Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8EEC3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025922DD3
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfHUXeK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:34:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727629AbfHUXeK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 19:34:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LNWPsn049903;
        Wed, 21 Aug 2019 19:34:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uhekchyt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:34:00 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7LNXxvJ054492;
        Wed, 21 Aug 2019 19:33:59 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uhekchysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:33:59 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7LNUcJN007069;
        Wed, 21 Aug 2019 23:33:59 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2ufye0d701-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 23:33:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LNXwmN43319718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 23:33:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CCBB205F;
        Wed, 21 Aug 2019 23:33:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BBE2B2065;
        Wed, 21 Aug 2019 23:33:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.200.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 23:33:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A56D16C65BA; Wed, 21 Aug 2019 16:33:58 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:33:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190821233358.GU28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231906.4224-2-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210231
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> A plain local_bh_disable() is documented as creating an RCU critical
> section, and (at least) rcutorture expects this to be the case.  However,
> in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> preempt_count() directly.  Even if RCU were changed to check
> in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> 
> Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> rcu_read_lock_bh_held() accordingly.

Cool!  Some questions and comments below.

							Thanx, Paul

> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> Another question is whether non-raw spinlocks are intended to create an
> RCU read-side critical section due to implicit preempt disable.

Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
consolidation?  If not, I don't see why they should do so after that
consolidation in -rt.

>                                                                  If they
> are, then we'd need to add rcu_read_lock() there as well since RT doesn't
> disable preemption (and rcutorture should explicitly test with a
> spinlock).  If not, the documentation should make that clear.

True enough!

>  include/linux/rcupdate.h |  4 ++++
>  kernel/rcu/update.c      |  4 ++++
>  kernel/softirq.c         | 12 +++++++++---
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 388ace315f32..d6e357378732 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
>  static inline void rcu_read_lock_bh(void)
>  {
>  	local_bh_disable();
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	__acquire(RCU_BH);
>  	rcu_lock_acquire(&rcu_bh_lock_map);
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_lock_bh() used illegally while idle");
> +#endif

Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
for lockdep-enabled -rt kernels, right?

>  }
>  
>  /*
> @@ -628,10 +630,12 @@ static inline void rcu_read_lock_bh(void)
>   */
>  static inline void rcu_read_unlock_bh(void)
>  {
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_unlock_bh() used illegally while idle");
>  	rcu_lock_release(&rcu_bh_lock_map);
>  	__release(RCU_BH);
> +#endif

Ditto.

>  	local_bh_enable();
>  }
>  
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 016c66a98292..a9cdf3d562bc 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -296,7 +296,11 @@ int rcu_read_lock_bh_held(void)
>  		return 0;
>  	if (!rcu_lockdep_current_cpu_online())
>  		return 0;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	return lock_is_held(&rcu_lock_map) || irqs_disabled();
> +#else
>  	return in_softirq() || irqs_disabled();
> +#endif

And globally.

>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
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

The return from in_atomic() is guaranteed to be the same at
local_bh_enable() time as was at the call to the corresponding
local_bh_disable()?

I could have sworn that I ran afoul of this last year.  Might these
added rcu_read_lock() and rcu_read_unlock() calls need to check for
CONFIG_PREEMPT_RT_FULL?

>  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
>  	preempt_check_resched();
> -- 
> 1.8.3.1
> 
