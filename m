Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25868C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0308D2070B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFTVKx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbfFTVKw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KL8FFR088897;
        Thu, 20 Jun 2019 17:10:05 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8hsyg2a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:10:04 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5KL5Utw001317;
        Thu, 20 Jun 2019 21:10:04 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2t8hrp00gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 21:10:04 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KLA3n130474734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:10:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF168B2064;
        Thu, 20 Jun 2019 21:10:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B181BB205F;
        Thu, 20 Jun 2019 21:10:03 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 21:10:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AA5FD16C6B85; Thu, 20 Jun 2019 14:10:05 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:10:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 3/4] rcu: unlock special: Treat irq and preempt
 disabled the same
Message-ID: <20190620211005.GW26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-4-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619011908.25026-4-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200152
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 18, 2019 at 08:19:07PM -0500, Scott Wood wrote:
> [Note: Just before posting this I noticed that the invoke_rcu_core stuff
>  is part of the latest RCU pull request, and it has a patch that
>  addresses this in a more complicated way that appears to deal with the
>  bare irq-disabled sequence as well.

Far easier to deal with it than to debug the lack of it.  ;-)

>  Assuming we need/want to support such sequences, is the
>  invoke_rcu_core() call actually going to result in scheduling any
>  sooner?  resched_curr() just does the same setting of need_resched
>  when it's the same cpu.
> ]

Yes, invoke_rcu_core() can in some cases invoke the scheduler sooner.
Setting the CPU-local bits might not have effect until the next interrupt.

So if -rt wants the simpler and slower approach, the change needs to
use IS_ENABLED(CONFIG_PREEMPT_RT_FULL) or similar.  Not that this is
an issue until CONFIG_PREEMPT_RT_FULL hits mainline.

							Thanx, Paul

> Since special should never be getting set inside an irqs-disabled
> critical section, this is safe as long as there are no sequences of
> rcu_read_lock()/local_irq_disable()/rcu_read_unlock()/local_irq_enable()
> (without preempt_disable() wrapped around the IRQ disabling, as spinlocks
> do).  If there are such sequences, then the grace period may be delayed
> until the next time need_resched is checked.
> 
> This is needed because otherwise, in a sequence such as:
> 1. rcu_read_lock()
> 2. *preempt*, set rcu_read_unlock_special.b.blocked
> 3. preempt_disable()
> 4. rcu_read_unlock()
> 5. preempt_enable()
> 
> ...rcu_read_unlock_special.b.blocked will not be cleared during
> step 4, because of the disabled preemption.  If an interrupt is then
> taken between steps 4 and 5, and that interrupt enters scheduler code
> that takes pi/rq locks, and an rcu read lock inside that, then when
> dropping that rcu read lock we will end up in rcu_read_unlock_special()
> again -- but this time, since irqs are disabled, it will call
> invoke_rcu_core() in the RT tree (regardless of PREEMPT_RT_FULL), which
> calls wake_up_process().  This can cause a pi/rq lock deadlock.  An
> example of interrupt code that does this is scheduler_tick().
> 
> The above sequence can be found in (at least) __lock_task_sighand() (for
> !PREEMPT_RT_FULL) and d_alloc_parallel().
> 
> It's potentially an issue on non-RT as well.  While
> raise_softirq_irqoff() doesn't call wake_up_process() when in_interrupt()
> is true, if code between steps 4 and 5 directly calls into scheduler
> code, and that code uses RCU with pi/rq lock held, wake_up_process() can
> still be called.
> 
> On RT, migrate_enable() is such a codepath, so an in_interrupt() check
> alone would not work on RT.  Instead, keep track of whether we've already
> had an rcu_read_unlock_special() with preemption disabled but haven't yet
> scheduled, and rely on the preempt_enable() yet to come instead of
> calling invoke_rcu_core().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/rcu/tree_plugin.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 5d63914b3687..d7ddbcc7231c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -630,14 +630,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
>  		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>  		/* Need to defer quiescent state until everything is enabled. */
> -		if (irqs_were_disabled) {
> -			/* Enabling irqs does not reschedule, so... */
> -			invoke_rcu_core();
> -		} else {
> -			/* Enabling BH or preempt does reschedule, so... */
> -			set_tsk_need_resched(current);
> -			set_preempt_need_resched();
> -		}
> +		set_tsk_need_resched(current);
> +		set_preempt_need_resched();
>  		local_irq_restore(flags);
>  		return;
>  	}
> -- 
> 1.8.3.1
> 
