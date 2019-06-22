Return-Path: <SRS0=PqXR=UV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ADC48BE8
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631FA20820
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFVTN1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:13:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfFVTN0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Jun 2019 15:13:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5MJBQ3I075842
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Jun 2019 15:13:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t9d7tswh7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Jun 2019 15:13:25 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 22 Jun 2019 20:13:24 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Jun 2019 20:13:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5MJDK1k37355880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 19:13:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB2BBB2064;
        Sat, 22 Jun 2019 19:13:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B71F0B2066;
        Sat, 22 Jun 2019 19:13:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 22 Jun 2019 19:13:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8607816C1D77; Sat, 22 Jun 2019 12:13:20 -0700 (PDT)
Date:   Sat, 22 Jun 2019 12:13:20 -0700
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
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-4-swood@redhat.com>
 <20190620211005.GW26519@linux.ibm.com>
 <cf42d8516ac99f69913b1f7a7e8abe578ad27e7f.camel@redhat.com>
 <20190620222505.GB26519@linux.ibm.com>
 <5d24d1243849d9f8f6884348e1ceafcc3b7314fd.camel@redhat.com>
 <20190622002606.GL26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622002606.GL26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062219-0060-0000-0000-000003534C2F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011310; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01221787; UDB=6.00642826; IPR=6.01002926;
 MB=3.00027424; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-22 19:13:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062219-0061-0000-0000-000049DD6631
Message-Id: <20190622191320.GA23577@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906220175
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jun 21, 2019 at 05:26:06PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 20, 2019 at 06:08:19PM -0500, Scott Wood wrote:
> > On Thu, 2019-06-20 at 15:25 -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 20, 2019 at 04:59:30PM -0500, Scott Wood wrote:
> > > > On Thu, 2019-06-20 at 14:10 -0700, Paul E. McKenney wrote:
> > > > > On Tue, Jun 18, 2019 at 08:19:07PM -0500, Scott Wood wrote:
> > > > > > [Note: Just before posting this I noticed that the invoke_rcu_core
> > > > > > stuff
> > > > > >  is part of the latest RCU pull request, and it has a patch that
> > > > > >  addresses this in a more complicated way that appears to deal with
> > > > > > the
> > > > > >  bare irq-disabled sequence as well.
> > > > > 
> > > > > Far easier to deal with it than to debug the lack of it.  ;-)
> > > > > 
> > > > > >  Assuming we need/want to support such sequences, is the
> > > > > >  invoke_rcu_core() call actually going to result in scheduling any
> > > > > >  sooner?  resched_curr() just does the same setting of need_resched
> > > > > >  when it's the same cpu.
> > > > > > ]
> > > > > 
> > > > > Yes, invoke_rcu_core() can in some cases invoke the scheduler sooner.
> > > > > Setting the CPU-local bits might not have effect until the next
> > > > > interrupt.
> > > > 
> > > > Maybe I'm missing something, but I don't see how (in the non-use_softirq
> > > > case).  It just calls wake_up_process(), which in resched_curr() will
> > > > set
> > > > need_resched but not do an IPI-to-self.
> > > 
> > > The common non-rt case will be use_softirq.  Or are you referring
> > > specifically to this block of code in current -rcu?
> > > 
> > > 		} else if (exp && irqs_were_disabled && !use_softirq &&
> > > 			   !t->rcu_read_unlock_special.b.deferred_qs) {
> > > 			// Safe to awaken and we get no help from enabling
> > > 			// irqs, unlike bh/preempt.
> > > 			invoke_rcu_core();
> > 
> > Yes, that one.  If that block is removed the else path should be sufficient,
> > now that an IPI-to-self has been added.
> 
> I will give it a try and let you know what happens.

How about the following?

								Thanx, Paul

------------------------------------------------------------------------

commit 2fd23b1b649bf7e0754fa1dfce01e945bc62f4af
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Sat Jun 22 12:05:54 2019 -0700

    rcu: Simplify rcu_read_unlock_special() deferred wakeups
    
    In !use_softirq runs, we clearly cannot rely on raise_softirq() and
    its lightweight bit setting, so we must instead do some form of wakeup.
    In the absence of a self-IPI when interrupts are disabled, these wakeups
    can be delayed until the next interrupt occurs.  This means that calling
    invoke_rcu_core() doesn't actually do any expediting.
    
    In this case, it is better to take the "else" clause, which sets the
    current CPU's resched bits and, if there is an expedited grace period
    in flight, uses IRQ-work to force the needed self-IPI.  This commit
    therefore removes the "else if" clause that calls invoke_rcu_core().
    
    Reported-by: Scott Wood <swood@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 841060fce33c..c631413f457f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -629,17 +629,12 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
-		} else if (exp && irqs_were_disabled && !use_softirq &&
-			   !t->rcu_read_unlock_special.b.deferred_qs) {
-			// Safe to awaken and we get no help from enabling
-			// irqs, unlike bh/preempt.
-			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
-			if (IS_ENABLED(CONFIG_IRQ_WORK) &&
+			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    !rdp->defer_qs_iw_pending && exp) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.

