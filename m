Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB60C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 20:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203872082C
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfFTUyw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbfFTUys (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 16:54:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KKqi34049853;
        Thu, 20 Jun 2019 16:53:52 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8fwbuvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 16:53:52 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5KKoRjB012616;
        Thu, 20 Jun 2019 20:53:51 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 2t4ra6c0bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 20:53:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KKroaS25035082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:53:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A024FB205F;
        Thu, 20 Jun 2019 20:53:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 735C4B2064;
        Thu, 20 Jun 2019 20:53:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 20:53:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A6D716C5DE8; Thu, 20 Jun 2019 13:53:52 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:53:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 1/4] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190620205352.GV26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-2-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619011908.25026-2-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200150
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 18, 2019 at 08:19:05PM -0500, Scott Wood wrote:
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
> ---
>  include/linux/rcupdate.h |  4 ++++
>  kernel/rcu/update.c      |  4 ++++
>  kernel/softirq.c         | 12 +++++++++---
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index fb267bc04fdf..aca4e5e25ace 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -637,10 +637,12 @@ static inline void rcu_read_unlock(void)
>  static inline void rcu_read_lock_bh(void)
>  {
>  	local_bh_disable();
> +#ifndef CONFIG_PREEMPT_RT_FULL

How about this instead?

	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
		return;

And similarly below.

>  	__acquire(RCU_BH);
>  	rcu_lock_acquire(&rcu_bh_lock_map);
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_lock_bh() used illegally while idle");
> +#endif
>  }
>  
>  /*
> @@ -650,10 +652,12 @@ static inline void rcu_read_lock_bh(void)
>   */
>  static inline void rcu_read_unlock_bh(void)
>  {
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_unlock_bh() used illegally while idle");
>  	rcu_lock_release(&rcu_bh_lock_map);
>  	__release(RCU_BH);
> +#endif
>  	local_bh_enable();
>  }
>  
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 3700b730ea55..eb653a329e0b 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -307,7 +307,11 @@ int rcu_read_lock_bh_held(void)
>  		return 0;
>  	if (!rcu_lockdep_current_cpu_online())
>  		return 0;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	return lock_is_held(&rcu_lock_map) || irqs_disabled();
> +#else
>  	return in_softirq() || irqs_disabled();
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 473369122ddd..eb46dd3ff92d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -121,8 +121,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
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
>  
> @@ -155,8 +157,10 @@ void _local_bh_enable(void)
>  	local_irq_restore(flags);
>  #endif
>  
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  }
>  
>  void _local_bh_enable_rt(void)
> @@ -189,8 +193,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	WARN_ON_ONCE(count < 0);
>  	local_irq_enable();
>  
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  
>  	preempt_check_resched();
>  }

And I have to ask...

What did you do to test this change to kernel/softirq.c?  My past attempts
to do this sort of thing have always run afoul of open-coded BH transitions.

							Thanx, Paul
