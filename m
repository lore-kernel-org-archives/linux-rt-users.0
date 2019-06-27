Return-Path: <SRS0=/7Cv=U2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E2C004E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2C92133F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0Uu5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbfF0Uu5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Jun 2019 16:50:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RKofHZ025802
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2019 16:50:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td56qr09p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2019 16:50:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 21:50:55 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 21:50:50 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RKonHs46793172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 20:50:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E6CB2066;
        Thu, 27 Jun 2019 20:50:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C1EDB2068;
        Thu, 27 Jun 2019 20:50:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 20:50:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 38AA116C5DA5; Thu, 27 Jun 2019 13:50:51 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:50:51 -0700
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
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
 <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
 <20190621235955.GK26519@linux.ibm.com>
 <20190626110847.2dfdf72c@gandalf.local.home>
 <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
 <20190627180007.GA27126@linux.ibm.com>
 <5f4b1e594352ee776c4ccbe2760fee3a72345434.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4b1e594352ee776c4ccbe2760fee3a72345434.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062720-0052-0000-0000-000003D7166E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011342; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224161; UDB=6.00644282; IPR=6.01005349;
 MB=3.00027495; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 20:50:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062720-0053-0000-0000-0000617BF7B6
Message-Id: <20190627205051.GE26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270239
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 27, 2019 at 03:16:09PM -0500, Scott Wood wrote:
> On Thu, 2019-06-27 at 11:00 -0700, Paul E. McKenney wrote:
> > On Wed, Jun 26, 2019 at 11:49:16AM -0500, Scott Wood wrote:
> > > On Wed, 2019-06-26 at 11:08 -0400, Steven Rostedt wrote:
> > > > On Fri, 21 Jun 2019 16:59:55 -0700
> > > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > > 
> > > > > I have no objection to the outlawing of a number of these sequences
> > > > > in
> > > > > mainline, but am rather pointing out that until they really are
> > > > > outlawed
> > > > > and eliminated, rcutorture must continue to test them in mainline.
> > > > > Of course, an rcutorture running in -rt should avoid testing things
> > > > > that
> > > > > break -rt, including these sequences.
> > > > 
> > > > We should update lockdep to complain about these sequences. That would
> > > > "outlaw" them in mainline. That is, after we clean up all the current
> > > > sequences in the code. And we also need to get Linus's approval of
> > > > this
> > > > as I believe he was against enforcing this in the past.
> > > 
> > > Was the opposition to prohibiting some specific sequence?  It's only
> > > certain
> > > misnesting scenarios that are problematic.  The rcu_read_lock/
> > > local_irq_disable restriction can be dropped with the IPI-to-self added
> > > in
> > > Paul's tree.  Are there any known instances of the other two (besides
> > > rcutorture)?

If by IPI-to-self you mean the IRQ work trick, that isn't implemented
across all architectures yet, is it?

> > Given the failure scenario Sebastian Siewior reported today, there
> > apparently are some, at least when running threaded interrupt handlers.
> 
> That's the rcu misnesting, which it looks like we can allow with the IPI-to-
> self; I was asking about the other two.  I suppose if we really need to, we
> could work around preempt_disable()/local_irq_disable()/preempt_enable()/
> local_irq_enable() by having preempt_enable() do an IPI-to-self if
> need_resched is set and IRQs are disabled.  The RT local_bh_disable()
> atomic/non-atomic misnesting would be more difficult, but I don't think
> impossible.  I've got lazy migrate disable working (initially as an attempt
> to deal with misnesting but it turned out to give a huge speedup as well;
> will send as soon as I take care of a loose end in the deadline scheduler);
> it's possible that something similar could be done with the softirq lock
> (and given that I saw a slowdown when that lock was introduced, it may also
> be worth doing just for performance).
> 
> BTW, it's not clear to me whether the failure Sebastian saw was due to the
> bare irq disabled version, which was what I was talking about prohibiting
> (he didn't show the context that was interrupted).  The version where
> preempt is disabled (with or without irqs being disabled inside the preempt
> disabled region) definitely happens and is what I was trying to address with
> patch 3/4.

I don't claim to yet fully understand what Sebastian was seeing, though
I am obviously hoping that my local experiments showing it to be fixed
in current -rcu hold true.

Why not simply make rcutorture check whether it is running in a
PREEMPT_RT_FULL environment and avoid the PREEMPT_RT_FULL-unfriendly
testing only in that case?  This could be done compatibly with mainline by
adding another rcutorture module parameter that suppressed the problematic
testing, disabled by default.  Such a patch could be accepted into
mainline, and then -rt could have a very small patch that changed the
default to enabled for CONFIG_PREEMPT_RT_FULL=y kernels.

And should we later get to a place where the PREEMPT_RT_FULL-unfriendly
scenarios are prohibited across all kernel configurations, then the module
parameter can be removed.  Again, until we know (as opposed to suspect)
that these scenarios really don't happen, mainline rcutorture must
continue testing them.

							Thanx, Paul

