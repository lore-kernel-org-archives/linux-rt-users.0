Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC2DC3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D223402
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfHWCMJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730401AbfHWCMI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N29Pp7027687;
        Thu, 22 Aug 2019 22:11:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uj3jqxdp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 22:11:53 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7N2Bdd1032424;
        Thu, 22 Aug 2019 22:11:52 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uj3jqxdnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 22:11:52 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7N24beW014765;
        Fri, 23 Aug 2019 02:11:51 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2ue976uuxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 02:11:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7N2BpKl33554896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 02:11:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16D60B205F;
        Fri, 23 Aug 2019 02:11:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4FAFB2064;
        Fri, 23 Aug 2019 02:11:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 02:11:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A48D616C1D4F; Thu, 22 Aug 2019 19:11:50 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:11:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823021150.GM28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <20190822152706.GB28441@linux.ibm.com>
 <20190823015009.GA152050@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823015009.GA152050@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230021
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 09:50:09PM -0400, Joel Fernandes wrote:
> On Thu, Aug 22, 2019 at 08:27:06AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 22, 2019 at 09:39:55AM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > > > A plain local_bh_disable() is documented as creating an RCU critical
> > > > > section, and (at least) rcutorture expects this to be the case.  However,
> > > > > in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> > > > > preempt_count() directly.  Even if RCU were changed to check
> > > > > in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> > > > > 
> > > > > Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> > > > > rcu_read_lock_bh_held() accordingly.
> > > > 
> > > > Cool!  Some questions and comments below.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > > ---
> > > > > Another question is whether non-raw spinlocks are intended to create an
> > > > > RCU read-side critical section due to implicit preempt disable.
> > > > 
> > > > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > > > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > > > consolidation?  If not, I don't see why they should do so after that
> > > > consolidation in -rt.
> > > 
> > > May be I am missing something, but I didn't see the connection between
> > > consolidation and this patch. AFAICS, this patch is so that
> > > rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?
> > 
> > I was interpreting Scott's question (which would be excluded from the
> > git commit log) as relating to a possible follow-on patch.
> > 
> > The question is "how special can non-raw spinlocks be in -rt?".  From what
> > I can see, they have been treated as sleeplocks from an RCU viewpoint,
> > so maybe that should continue to be the case.  It does deserve some
> > thought because in mainline a non-raw spinlock really would block a
> > post-consolidation RCU grace period, even in PREEMPT kernels.
> > 
> > But then again, you cannot preempt a non-raw spinlock in mainline but
> > you can in -rt, so extending that exception to RCU is not unreasonable.
> > 
> > Either way, we do need to make a definite decision and document it.
> > If I were forced to make a decision right now, I would follow the old
> > behavior, so that only raw spinlocks were guaranteed to block RCU grace
> > periods.  But I am not being forced, so let's actually discuss and make
> > a conscious decision.  ;-)
> 
> I think non-raw spinlocks on -rt should at least do rcu_read_lock() so that
> any driver or kernel code that depends on this behavior and works on non-rt
> also works on -rt. It also removes the chance a kernel developer may miss
> documentation and accidentally forget that their code may break on -rt. I am
> curious to see how much this design pattern appears in the kernel
> (spin_lock'ed section "intended" as an RCU-reader by code sequences).
> 
> Logically speaking, to me anything that disables preemption on non-RT should
> do rcu_read_lock() on -rt so that from RCU's perspective, things are working.
> But I wonder where we would draw the line and if the bar is to need actual
> examples of usage patterns to make a decision..
> 
> Any thoughts?

Yes.  Let's listen to what the -rt guys have to say.  After all, they
are the ones who would be dealing with any differences in semantics.

							Thanx, Paul
