Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE3C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A9233FD
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfHVP1Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:27:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbfHVP1Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 11:27:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MFM642094538;
        Thu, 22 Aug 2019 11:27:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhw1bj694-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 11:27:08 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7MFM5s9094473;
        Thu, 22 Aug 2019 11:27:08 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhw1bj683-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 11:27:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7MFQU7R004861;
        Thu, 22 Aug 2019 15:27:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 2ue977crpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 15:27:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MFR5e736503854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 15:27:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC59B2064;
        Thu, 22 Aug 2019 15:27:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B90DDB2067;
        Thu, 22 Aug 2019 15:27:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 15:27:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A5EC616C0F61; Thu, 22 Aug 2019 08:27:06 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:27:06 -0700
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
Message-ID: <20190822152706.GB28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822133955.GA29841@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220151
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 09:39:55AM -0400, Joel Fernandes wrote:
> On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > A plain local_bh_disable() is documented as creating an RCU critical
> > > section, and (at least) rcutorture expects this to be the case.  However,
> > > in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> > > preempt_count() directly.  Even if RCU were changed to check
> > > in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> > > 
> > > Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> > > rcu_read_lock_bh_held() accordingly.
> > 
> > Cool!  Some questions and comments below.
> > 
> > 							Thanx, Paul
> > 
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > ---
> > > Another question is whether non-raw spinlocks are intended to create an
> > > RCU read-side critical section due to implicit preempt disable.
> > 
> > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > consolidation?  If not, I don't see why they should do so after that
> > consolidation in -rt.
> 
> May be I am missing something, but I didn't see the connection between
> consolidation and this patch. AFAICS, this patch is so that
> rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?

I was interpreting Scott's question (which would be excluded from the
git commit log) as relating to a possible follow-on patch.

The question is "how special can non-raw spinlocks be in -rt?".  From what
I can see, they have been treated as sleeplocks from an RCU viewpoint,
so maybe that should continue to be the case.  It does deserve some
thought because in mainline a non-raw spinlock really would block a
post-consolidation RCU grace period, even in PREEMPT kernels.

But then again, you cannot preempt a non-raw spinlock in mainline but
you can in -rt, so extending that exception to RCU is not unreasonable.

Either way, we do need to make a definite decision and document it.
If I were forced to make a decision right now, I would follow the old
behavior, so that only raw spinlocks were guaranteed to block RCU grace
periods.  But I am not being forced, so let's actually discuss and make
a conscious decision.  ;-)

							Thanx, Paul
