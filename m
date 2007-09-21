From: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH RFC 3/9] RCU: Preemptible RCU
Date: Fri, 21 Sep 2007 11:26:11 +0530
Message-ID: <20070921055611.GA17461@in.ibm.com>
References: <20070910183004.GA3299@linux.vnet.ibm.com> <20070910183412.GC3819@linux.vnet.ibm.com> <20070921041721.GB15697@goodmis.org>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, akpm@linux-foundation.org, josht@linux.vnet.ibm.com,
	tytso@us.ibm.com, dvhltc@us.ibm.com, tglx@linutronix.de,
	a.p.zijlstra@chello.nl, bunk@kernel.org, ego@in.ibm.com,
	oleg@tv-sign.ru, srostedt@redhat.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:34253 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXIUF5d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 01:57:33 -0400
Content-Disposition: inline
In-Reply-To: <20070921041721.GB15697@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Sep 21, 2007 at 12:17:21AM -0400, Steven Rostedt wrote:
> [ continued here from comment on patch 1]
> 
> On Mon, Sep 10, 2007 at 11:34:12AM -0700, Paul E. McKenney wrote:
> >  /* softirq mask and active fields moved to irq_cpustat_t in
> > diff -urpNa -X dontdiff linux-2.6.22-b-fixbarriers/include/linux/rcuclassic.h linux-2.6.22-c-preemptrcu/include/linux/rcuclassic.h
> > --- linux-2.6.22-b-fixbarriers/include/linux/rcuclassic.h	2007-08-22 14:42:23.000000000 -0700
> > +++ linux-2.6.22-c-preemptrcu/include/linux/rcuclassic.h	2007-08-22 15:21:06.000000000 -0700
> > @@ -142,8 +142,6 @@ extern int rcu_needs_cpu(int cpu);
> >  #define RCU_HEAD_INIT 	{ .next = NULL, .func = NULL }
> >  #define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT
> > @@ -218,10 +222,13 @@ extern void FASTCALL(call_rcu_bh(struct 
> >  /* Exported common interfaces */
> >  extern void synchronize_rcu(void);
> >  extern void rcu_barrier(void);
> > +extern long rcu_batches_completed(void);
> > +extern long rcu_batches_completed_bh(void);
> >
> 
> And here we put back rcu_batches_completed and rcu_batches_completed_bh
> from rcuclassic.h to rcupdate.h ;-)

Good questions :) I can't remember why I did this - probably because
I was breaking up into classic and preemptible RCU in incremental
patches with the goal that the break-up patch can be merged
before the rcu-preempt patches. IIRC, I had to make *batches_completed*()
a common RCU API later on.

Thanks
Dipankar
