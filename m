Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E5BC43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B092070B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFTVTI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:19:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbfFTVTI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:19:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KL8EAW118843;
        Thu, 20 Jun 2019 17:18:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8hsxgb6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:18:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5KL5VfF023304;
        Thu, 20 Jun 2019 21:18:25 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2t8hrnr1wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 21:18:25 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KLIOwC15139216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:18:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CA4FB205F;
        Thu, 20 Jun 2019 21:18:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D44CB2066;
        Thu, 20 Jun 2019 21:18:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 21:18:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 34A8616C2A15; Thu, 20 Jun 2019 14:18:26 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:18:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190620211826.GX26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619011908.25026-5-swood@redhat.com>
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

On Tue, Jun 18, 2019 at 08:19:08PM -0500, Scott Wood wrote:
> rcutorture was generating some nesting scenarios that are not
> reasonable.  Constrain the state selection to avoid them.
> 
> Example #1:
> 
> 1. preempt_disable()
> 2. local_bh_disable()
> 3. preempt_enable()
> 4. local_bh_enable()
> 
> On PREEMPT_RT, BH disabling takes a local lock only when called in
> non-atomic context.  Thus, atomic context must be retained until after BH
> is re-enabled.  Likewise, if BH is initially disabled in non-atomic
> context, it cannot be re-enabled in atomic context.
> 
> Example #2:
> 
> 1. rcu_read_lock()
> 2. local_irq_disable()
> 3. rcu_read_unlock()
> 4. local_irq_enable()
> 
> If the thread is preempted between steps 1 and 2,
> rcu_read_unlock_special.b.blocked will be set, but it won't be
> acted on in step 3 because IRQs are disabled.  Thus, reporting of the
> quiescent state will be delayed beyond the local_irq_enable().
> 
> Example #3:
> 
> 1. preempt_disable()
> 2. local_irq_disable()
> 3. preempt_enable()
> 4. local_irq_enable()
> 
> If need_resched is set between steps 1 and 2, then the reschedule
> in step 3 will not happen.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

OK for -rt, but as long as people can code those sequences without getting
their wrists slapped, RCU needs to deal with it.  So I cannot accept
this in mainline at the current time.  Yes, I will know when it is safe
to accept it when rcutorture's virtual wrist gets slapped in mainline.
Why did you ask?  ;-)

But I have to ask...  With this elaboration, is it time to make this a
data-driven state machine?  Or is the complexity not yet to the point
where that would constitute a simplification?

							Thanx, Paul

> ---
> TODO: Document restrictions and add debug checks for invalid sequences.
> 
> I had been planning to resolve #1 (only as shown, not the case of
> disabling preemption while non-atomic and enabling while atomic) by
> changing how migrate_disable() works to avoid the split behavior, but
> recently BH disabling was changed to do the same thing.  I still plan to
> send the migrate disable changes as a separate patchset, for the sake of
> the significant performance improvement I saw.
> ---
>  kernel/rcu/rcutorture.c | 92 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 584b0d1da0a3..0523d9e78246 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -73,10 +73,13 @@
>  #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
>  #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
>  #define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
> -#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
> +#define RCUTORTURE_RDR_ATOM_BH	 0x40	/*  ... disabling bh while atomic */
> +#define RCUTORTURE_RDR_ATOM_RBH	 0x80	/*  ... RBH while atomic */
> +#define RCUTORTURE_RDR_NBITS	 8	/* Number of bits defined above. */
>  #define RCUTORTURE_MAX_EXTEND	 \
>  	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
> -	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
> +	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED | \
> +	 RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH)
>  #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
>  					/* Must be power of two minus one. */
>  #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
> @@ -1111,31 +1114,52 @@ static void rcutorture_one_extend(int *readstate, int newstate,
>  	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
>  	rtrsp->rt_readstate = newstate;
>  
> -	/* First, put new protection in place to avoid critical-section gap. */
> +	/*
> +	 * First, put new protection in place to avoid critical-section gap.
> +	 * Disable preemption around the ATOM disables to ensure that
> +	 * in_atomic() is true.
> +	 */
>  	if (statesnew & RCUTORTURE_RDR_BH)
>  		local_bh_disable();
> +	if (statesnew & RCUTORTURE_RDR_RBH)
> +		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_IRQ)
>  		local_irq_disable();
>  	if (statesnew & RCUTORTURE_RDR_PREEMPT)
>  		preempt_disable();
> -	if (statesnew & RCUTORTURE_RDR_RBH)
> -		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_SCHED)
>  		rcu_read_lock_sched();
> +	preempt_disable();
> +	if (statesnew & RCUTORTURE_RDR_ATOM_BH)
> +		local_bh_disable();
> +	if (statesnew & RCUTORTURE_RDR_ATOM_RBH)
> +		rcu_read_lock_bh();
> +	preempt_enable();
>  	if (statesnew & RCUTORTURE_RDR_RCU)
>  		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
>  
> -	/* Next, remove old protection, irq first due to bh conflict. */
> +	/*
> +	 * Next, remove old protection, in decreasing order of strength
> +	 * to avoid unlock paths that aren't safe in the stronger
> +	 * context.  Disable preemption around the ATOM enables in
> +	 * case the context was only atomic due to IRQ disabling.
> +	 */
> +	preempt_disable();
>  	if (statesold & RCUTORTURE_RDR_IRQ)
>  		local_irq_enable();
> -	if (statesold & RCUTORTURE_RDR_BH)
> +	if (statesold & RCUTORTURE_RDR_ATOM_BH)
>  		local_bh_enable();
> +	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
> +		rcu_read_unlock_bh();
> +	preempt_enable();
>  	if (statesold & RCUTORTURE_RDR_PREEMPT)
>  		preempt_enable();
> -	if (statesold & RCUTORTURE_RDR_RBH)
> -		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_SCHED)
>  		rcu_read_unlock_sched();
> +	if (statesold & RCUTORTURE_RDR_BH)
> +		local_bh_enable();
> +	if (statesold & RCUTORTURE_RDR_RBH)
> +		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_RCU)
>  		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
>  
> @@ -1171,6 +1195,12 @@ static int rcutorture_extend_mask_max(void)
>  	int mask = rcutorture_extend_mask_max();
>  	unsigned long randmask1 = torture_random(trsp) >> 8;
>  	unsigned long randmask2 = randmask1 >> 3;
> +	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
> +	unsigned long nonatomic_bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> +	unsigned long atomic_bhs = RCUTORTURE_RDR_ATOM_BH |
> +				   RCUTORTURE_RDR_ATOM_RBH;
> +	unsigned long tmp;
>  
>  	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
>  	/* Most of the time lots of bits, half the time only one bit. */
> @@ -1178,11 +1208,45 @@ static int rcutorture_extend_mask_max(void)
>  		mask = mask & randmask2;
>  	else
>  		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
> -	/* Can't enable bh w/irq disabled. */
> -	if ((mask & RCUTORTURE_RDR_IRQ) &&
> -	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
> -	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
> -		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> +
> +	/*
> +	 * Can't enable bh w/irq disabled.
> +	 *
> +	 * Can't enable preemption with irqs disabled, if irqs had ever
> +	 * been enabled during this preempt critical section (could miss
> +	 * a reschedule).
> +	 */
> +	tmp = atomic_bhs | nonatomic_bhs | preempts;
> +	if (mask & RCUTORTURE_RDR_IRQ)
> +		mask |= oldmask & tmp;
> +
> +	/*
> +	 * Can't release the outermost rcu lock in an irq disabled
> +	 * section without preemption also being disabled, if irqs had
> +	 * ever been enabled during this RCU critical section (could leak
> +	 * a special flag and delay reporting the qs).
> +	 */
> +	if ((oldmask & RCUTORTURE_RDR_RCU) && (mask & RCUTORTURE_RDR_IRQ) &&
> +	    !(mask & preempts))
> +		mask |= RCUTORTURE_RDR_RCU;
> +
> +	/* Can't modify atomic bh in non-atomic context */
> +	if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
> +	    !(mask & preempts_irq)) {
> +		mask |= oldmask & preempts_irq;
> +		if (mask & RCUTORTURE_RDR_IRQ)
> +			mask |= oldmask & tmp;
> +	}
> +	if ((mask & atomic_bhs) && !(mask & preempts_irq))
> +		mask |= RCUTORTURE_RDR_PREEMPT;
> +
> +	/* Can't modify non-atomic bh in atomic context */
> +	tmp = nonatomic_bhs;
> +	if (oldmask & preempts_irq)
> +		mask &= ~tmp;
> +	if ((oldmask | mask) & preempts_irq)
> +		mask |= oldmask & tmp;
> +
>  	if ((mask & RCUTORTURE_RDR_IRQ) &&
>  	    !(mask & cur_ops->ext_irq_conflict) &&
>  	    (oldmask & cur_ops->ext_irq_conflict))
> -- 
> 1.8.3.1
> 
