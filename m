Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94069C3A5A6
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600622070B
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566921206;
	bh=ALDr8DPz8kipYUZjkPfROZGZsV1Fl4RM8So6TeuTe3Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vOhAZdcA+cL/GXrljXgaaaqCLgYk5uW5KXBUPqcPhAohPuu5TAFBG+HdsNZ7fkJ1t
	 c8da3YrH/VPfZO611i3zIm4Qovb7b8yzjmAcpiSgLXEXet80J574fE8QioztoKS981
	 J6kV2sh7tiRJBaDED6Y5uNduuN0y01J2CwLEK7a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfH0PxV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:53:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbfH0PxV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 11:53:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RFqiaP145914;
        Tue, 27 Aug 2019 11:53:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un74u99s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 11:53:08 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7RFr7ND147435;
        Tue, 27 Aug 2019 11:53:08 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un74u99r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 11:53:07 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7RFowvu028533;
        Tue, 27 Aug 2019 15:53:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 2umpcta4nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 15:53:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7RFr61B44368266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 15:53:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D25CB2064;
        Tue, 27 Aug 2019 15:53:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F001B205F;
        Tue, 27 Aug 2019 15:53:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 15:53:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5444A16C65CC; Tue, 27 Aug 2019 08:53:06 -0700 (PDT)
Date:   Tue, 27 Aug 2019 08:53:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190827155306.GF26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827092333.jp3darw7teyyw67g@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270158
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 27, 2019 at 11:23:33AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-26 09:29:45 [-0700], Paul E. McKenney wrote:
> > > The mechanism that is used here may change in future. I just wanted to
> > > make sure that from RCU's side it is okay to schedule here.
> > 
> > Good point.
> > 
> > The effect from RCU's viewpoint will be to split any non-rcu_read_lock()
> > RCU read-side critical section at this point.  This alrady happens in a
> > few places, for example, rcu_note_context_switch() constitutes an RCU
> > quiescent state despite being invoked with interrupts disabled (as is
> > required!).  The __schedule() function just needs to understand (and does
> > understand) that the RCU read-side critical section that would otherwise
> > span that call to rcu_node_context_switch() is split in two by that call.
> 
> Okay. So I read this as invoking schedule() at this point is okay. 

As long as no one is relying on a non-rcu_read_lock() RCU
read-side critical section (local_bh_disable(), preempt_disable(),
local_irq_disable(), ...) spanning this call.  But that depends on the
calling code and on other code it interacts with it, not on any specific
need on the part of RCU itself.

> Looking at this again, this could also happen on a PREEMPT=y kernel if
> the kernel decides to preempt a task within a rcu_read_lock() section
> and put it back later on another CPU.

This is an rcu_read_lock() critical section, so yes, on a PREEMPT=y
kernel, executing schedule() will cause the corresponding RCU read-side
critical section to persist, following the preempted tasks.  Give or
take lockdep complaints.

On a PREEMPT=n kernel, schedule() within an RCU read-side critical
section instead results in that critical section being split in two.
And this will also results in lockdep complaints.

> > However, if this was instead an rcu_read_lock() critical section within
> > a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> > RCU would consider that critical section to be preempted.  This means
> > that any RCU grace period that is blocked by this RCU read-side critical
> > section would remain blocked until stop_one_cpu() resumed, returned,
> > and so on until the matching rcu_read_unlock() was reached.  In other
> > words, RCU would consider that RCU read-side critical section to span
> > the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> 
> Isn't that my example from above and what we do in RT? My understanding
> is that this is the reason why we need BOOST on RT otherwise the RCU
> critical section could remain blocked for some time.

At this point, I must confess that I have lost track of whose example
it is.  It was first reported in 2006, if I remember correctly.  ;-)

But yes, you are correct, the point of RCU priority boosting is to
cause tasks that have been preempted while within RCU read-side critical
sections to be scheduled so that they can reach their rcu_read_unlock()
calls, thus allowing the current grace period to end.

> > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > would split even an rcu_read_lock() critical section.  Which is why I
> > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > complaints in that case.
> 
> sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
> spin_lock() implementation and used by RCU (rcu_note_context_switch())
> to not complain if invoked within a critical section.

Then this is being called when we have something like this, correct?

	DEFINE_SPINLOCK(mylock); // As opposed to DEFINE_RAW_SPINLOCK().

	...

	rcu_read_lock();
	do_something();
	spin_lock(&mylock); // Can block in -rt, thus needs sleeping_lock_inc()
	...
	rcu_read_unlock();

Without sleeping_lock_inc(), lockdep would complain about a voluntary
schedule within an RCU read-side critical section.  But in -rt, voluntary
schedules due to sleeping on a "spinlock" are OK.

Am I understanding this correctly?

							Thanx, Paul
