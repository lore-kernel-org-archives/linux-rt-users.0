Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC94C4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 00:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544B2084B
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 00:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1Axi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:53:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbfF1Axi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Jun 2019 20:53:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5S0CiUM135961;
        Thu, 27 Jun 2019 20:52:59 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2td4fehsfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 20:52:59 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5S0F85a017280;
        Fri, 28 Jun 2019 00:52:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2t9by7a975-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 00:52:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5S0qvBg47972810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 00:52:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA782B2067;
        Fri, 28 Jun 2019 00:52:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFD56B2064;
        Fri, 28 Jun 2019 00:52:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.201.148])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 00:52:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A68316C6BA7; Thu, 27 Jun 2019 17:52:57 -0700 (PDT)
Date:   Thu, 27 Jun 2019 17:52:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190628005257.GM26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
 <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
 <20190621235955.GK26519@linux.ibm.com>
 <20190626110847.2dfdf72c@gandalf.local.home>
 <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
 <20190627180007.GA27126@linux.ibm.com>
 <5f4b1e594352ee776c4ccbe2760fee3a72345434.camel@redhat.com>
 <20190627205051.GE26519@linux.ibm.com>
 <4dc801b715baae4a87043fed20f682409446bb09.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc801b715baae4a87043fed20f682409446bb09.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 27, 2019 at 05:46:27PM -0500, Scott Wood wrote:
> On Thu, 2019-06-27 at 13:50 -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 03:16:09PM -0500, Scott Wood wrote:
> > > On Thu, 2019-06-27 at 11:00 -0700, Paul E. McKenney wrote:
> > > > On Wed, Jun 26, 2019 at 11:49:16AM -0500, Scott Wood wrote:
> > > > > > 
> > > > > > On Fri, 21 Jun 2019 16:59:55 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > > > > 
> > > > > > > I have no objection to the outlawing of a number of these
> > > > > > > sequences
> > > > > > > in
> > > > > > > mainline, but am rather pointing out that until they really are
> > > > > > > outlawed
> > > > > > > and eliminated, rcutorture must continue to test them in
> > > > > > > mainline.
> > > > > > > Of course, an rcutorture running in -rt should avoid testing
> > > > > > > things
> > > > > > > that
> > > > > > > break -rt, including these sequences.
> > > > > > 
> > > > > > sequences in the code. And we also need to get Linus's approval of
> > > > > > this
> > > > > > as I believe he was against enforcing this in the past.
> > > > > 
> > > > > Was the opposition to prohibiting some specific sequence?  It's only
> > > > > certain
> > > > > misnesting scenarios that are problematic.  The rcu_read_lock/
> > > > > local_irq_disable restriction can be dropped with the IPI-to-self
> > > > > added
> > > > > in
> > > > > Paul's tree.  Are there any known instances of the other two
> > > > > (besides
> > > > > rcutorture)?
> > 
> > If by IPI-to-self you mean the IRQ work trick, that isn't implemented
> > across all architectures yet, is it?
> 
> Right... smp_send_reschedule() has wider coverage, but even then there's
> some hardware that just can't do it reasonably (e.g. pre-APIC x86).

Except that smp_send_reschedule() won't do anything unless the scheduler
things something needs to be done, as it its wake list is non-empty.
Which might explain why Peter Zijlstra didn't suggest it.

>                                                                      So I
> guess the options are:
> 
> 1. Accept that such hardware might experience delayed grace period
> completion in certain configurations,
> 2. Have such hardware check for need_resched in local_irq_enable() (not nice
> if sharing a kernel build with hardware that doesn't need it), or
> 3. Forbid the sequence (enforced by debug checks).  Again, this would only
> prohibit rcu_read_lock()/local_irq_disable()/rcu_read_unlock()/
> local_irq_enable() *without* preempt disabling around the IRQ-disabled
> region.

4. If further testing continues to show it to be reliable, continue
using the scheme in -rcu.
5. Use a short-duration hrtimer to get a clean environment in short
order.  Yes, the timer might fire while preemption and/or softirqs
are disabled, but then the code can rely on the following
preempt_enable(), local_bh_enable(), or whatever.  This condition
should be sufficiently rare to avoid issues with hrtimer overhead.
6. Use smp_call_function_single() to IPI some other poor slob of a
CPU, which then does the same back.  Non-waiting version in both
cases, of course.

Probably others as well.

> > Why not simply make rcutorture cyheck whether it is running in a
> > PREEMPT_RT_FULL environment and avoid the PREEMPT_RT_FULL-unfriendly
> > testing only in that case?
> >
> > And should we later get to a place where the PREEMPT_RT_FULL-unfriendly
> > scenarios are prohibited across all kernel configurations, then the module
> > parameter can be removed.  Again, until we know (as opposed to suspect)
> > that these scenarios really don't happen, mainline rcutorture must
> > continue testing them.
> 
> Yes, I already acknowledged that debug checks detecting the sequences should
> come before the test removal

OK, good to hear.  As you may have noticed, I was getting the impression
that you might have changed your mind on this point.  ;-)

>                              (including this patch as an RFC at this point
> was mainly meant as a demonstration of what's needed to get rcutorture to
> pass), but it'd be nice to have some idea of whether there would be
> opposition to the concept before coding up the checks.  I'd rather not
> continue the state of "these sequences can blow up on RT and we don't know
> if they exist or not" any longer than necessary.  Plus, only one of the
> sequences is exclusively an RT issue (though it's the one with the worst
> consequences).

Steve Rostedt's point about enlisting the aid of lockdep seems worth
looking into.

							Thanx, Paul
