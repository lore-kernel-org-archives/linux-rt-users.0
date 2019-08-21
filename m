Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EEC3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990F42339E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfHUXgM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:36:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbfHUXgL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 19:36:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LNWQN3114497;
        Wed, 21 Aug 2019 19:36:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhc7wxx74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:36:00 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7LNWpgK116321;
        Wed, 21 Aug 2019 19:35:58 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhc7wxx5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:35:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7LNUY03002791;
        Wed, 21 Aug 2019 23:35:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2ue9777e6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 23:35:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LNZtkO51642748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 23:35:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE4AEB2065;
        Wed, 21 Aug 2019 23:35:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B9FDB206A;
        Wed, 21 Aug 2019 23:35:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.200.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 23:35:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4CA0C16C65BA; Wed, 21 Aug 2019 16:35:55 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:35:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190821233555.GV28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231906.4224-3-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=882 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210231
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 21, 2019 at 06:19:05PM -0500, Scott Wood wrote:
> Without this, rcu_note_context_switch() will complain if an RCU read
> lock is held when migrate_enable() calls stop_one_cpu().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

I have to ask...  Both sleeping_lock_inc() and sleeping_lock_dec() are
no-ops if not CONFIG_PREEMPT_RT_BASE?

							Thanx, Paul

> ---
> v2: Added comment.
> 
> If my migrate disable changes aren't taken, then pin_current_cpu()
> will also need to use sleeping_lock_inc() because calling
> __read_rt_lock() bypasses the usual place it's done.
> 
>  include/linux/sched.h    | 4 ++--
>  kernel/rcu/tree_plugin.h | 2 +-
>  kernel/sched/core.c      | 8 ++++++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7e892e727f12..1ebc97f28009 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -673,7 +673,7 @@ struct task_struct {
>  	int				migrate_disable_atomic;
>  # endif
>  #endif
> -#ifdef CONFIG_PREEMPT_RT_FULL
> +#ifdef CONFIG_PREEMPT_RT_BASE
>  	int				sleeping_lock;
>  #endif
>  
> @@ -1881,7 +1881,7 @@ static __always_inline bool need_resched(void)
>  	return unlikely(tif_need_resched());
>  }
>  
> -#ifdef CONFIG_PREEMPT_RT_FULL
> +#ifdef CONFIG_PREEMPT_RT_BASE
>  static inline void sleeping_lock_inc(void)
>  {
>  	current->sleeping_lock++;
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 23a54e4b649c..7a3aa085ce2c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -292,7 +292,7 @@ void rcu_note_context_switch(bool preempt)
>  	barrier(); /* Avoid RCU read-side critical sections leaking down. */
>  	trace_rcu_utilization(TPS("Start context switch"));
>  	lockdep_assert_irqs_disabled();
> -#if defined(CONFIG_PREEMPT_RT_FULL)
> +#if defined(CONFIG_PREEMPT_RT_BASE)
>  	sleeping_l = t->sleeping_lock;
>  #endif
>  	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1bdd7f9be05..0758ee85634e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7405,7 +7405,15 @@ void migrate_enable(void)
>  			unpin_current_cpu();
>  			preempt_lazy_enable();
>  			preempt_enable();
> +
> +			/*
> +			 * sleeping_lock_inc suppresses a debug check for
> +			 * sleeping inside an RCU read side critical section
> +			 */
> +			sleeping_lock_inc();
>  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> +			sleeping_lock_dec();
> +
>  			return;
>  		}
>  	}
> -- 
> 1.8.3.1
> 
