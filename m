Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E6DC3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939512070B
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566921506;
	bh=VCZMhlNcgiIGxC4Ve9sFZkVFitxyZ8DZfZcXXWZyMdM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ab/+EkB5BnUDC3YDMZQM6cqB/mu9GqpK44nsOayxZaNo2MkAv+2ZSB3DZx6PZnd0M
	 rxOlvTBv9SacSMhYKFbtoCJVZQmrrmo2cGFEUbzry+XkdAswBDDf59xwweCQnOMti6
	 +TkYIBVCHdkeKriJs3xnpeyqlS3XwI8JElirHUBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfH0P6W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:58:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbfH0P6W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 11:58:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RFvWXv024313;
        Tue, 27 Aug 2019 11:58:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un6t42ng3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 11:58:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7RFvdCJ024728;
        Tue, 27 Aug 2019 11:58:14 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un6t42nfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 11:58:14 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7RFsl4a014636;
        Tue, 27 Aug 2019 15:58:13 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ujvv68hkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 15:58:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7RFwDnD41746914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 15:58:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F6C8B2066;
        Tue, 27 Aug 2019 15:58:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D40F2B2065;
        Tue, 27 Aug 2019 15:58:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 15:58:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2496316C2DD5; Tue, 27 Aug 2019 08:58:13 -0700 (PDT)
Date:   Tue, 27 Aug 2019 08:58:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190827155813.GG26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827130853.GB132568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827130853.GB132568@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270159
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 27, 2019 at 09:08:53AM -0400, Joel Fernandes wrote:
> On Tue, Aug 27, 2019 at 11:23:33AM +0200, Sebastian Andrzej Siewior wrote:
> [snip]
> > > However, if this was instead an rcu_read_lock() critical section within
> > > a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> > > RCU would consider that critical section to be preempted.  This means
> > > that any RCU grace period that is blocked by this RCU read-side critical
> > > section would remain blocked until stop_one_cpu() resumed, returned,
> > > and so on until the matching rcu_read_unlock() was reached.  In other
> > > words, RCU would consider that RCU read-side critical section to span
> > > the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> > 
> > Isn't that my example from above and what we do in RT? My understanding
> > is that this is the reason why we need BOOST on RT otherwise the RCU
> > critical section could remain blocked for some time.
> 
> Not just for boost, it is needed to block the grace period itself on
> PREEMPT=y. On PREEMPT=y, if rcu_note_context_switch() happens in middle of a
> rcu_read_lock() reader section, then the task is added to a blocked list
> (rcu_preempt_ctxt_queue). Then just after that, the CPU reports a QS state
> (rcu_qs()) as you can see in the PREEMPT=y implementation of
> rcu_note_context_switch(). Even though the CPU has reported a QS, the grace
> period will not end because the preempted (or block as could be in -rt) task
> is still blocking the grace period. This is fundamental to the function of
> Preemptible-RCU where there is the concept of tasks blocking a grace period,
> not just CPUs.
> 
> I think what Paul is trying to explain AIUI (Paul please let me know if I
> missed something):
> 
> (1) Anyone calling rcu_note_context_switch() and expecting it to respect
> RCU-readers that are readers as a result of interrupt disabled regions, have
> incorrect expectations. So calling rcu_note_context_switch() has to be done
> carefully.
> 
> (2) Disabling interrupts is "generally" implied as an RCU-sched flavor
> reader. However, invoking rcu_note_context_switch() from a disabled interrupt
> region is *required* for rcu_note_context_switch() to work correctly.
> 
> (3) On PREEMPT=y kernels, invoking rcu_note_context_switch() from an
> interrupt disabled region does not mean that that the task will be added to a
> blocked list (unless it is also in an RCU-preempt reader) so
> rcu_note_context_switch() may immediately report a quiescent state and
> nothing blockings the grace period.
> So callers of rcu_note_context_switch() must be aware of this behavior.
> 
> (4) On PREEMPT=n, unlike PREEMPT=y, there is no blocked list handling and so
> nothing will block the grace period once rcu_note_context_switch() is called.
> So any path calling rcu_note_context_switch() on a PREEMPT=n kernel, in the
> middle of something that is expected to be an RCU reader would be really bad
> from an RCU view point.
> 
> Probably, we should add this all to documentation somewhere.

I think that Sebastian understands this and was using the example of RCU
priority boosting to confirm his understanding.  But documentation would
be good.  Extremely difficult to keep current, but good.  I believe that
the requirements document does cover this.

							Thanx, Paul

> thanks!
> 
>  - Joel
> 
> 
> > > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > > would split even an rcu_read_lock() critical section.  Which is why I
> > > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > > complaints in that case.
> > 
> > sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
> > spin_lock() implementation and used by RCU (rcu_note_context_switch())
> > to not complain if invoked within a critical section.
> > 
> > > Does that help, or am I missing the point?
> > > 
> > > 							Thanx, Paul
> > Sebastian
