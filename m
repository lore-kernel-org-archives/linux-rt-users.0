From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 6/9] RCU priority boosting for preemptible RCU
Date: Fri, 28 Sep 2007 19:05:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709281901470.17405@gandalf.stny.rr.com>
References: <20070910183004.GA3299@linux.vnet.ibm.com>
 <20070910183901.GF3819@linux.vnet.ibm.com> <20070928225649.GA9899@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org,
	dipankar@in.ibm.com, josht@linux.vnet.ibm.com, tytso@us.ibm.com,
	dvhltc@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
	a.p.zijlstra@chello.nl, bunk@kernel.org, oleg@tv-sign.ru,
	srostedt@redhat.com
To: Gautham R Shenoy <ego@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55775 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbXI1XFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Sep 2007 19:05:37 -0400
In-Reply-To: <20070928225649.GA9899@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Fri, 28 Sep 2007, Gautham R Shenoy wrote:

> >
> > +#ifdef CONFIG_PREEMPT_RCU_BOOST
> > +/*
> > + * Task state with respect to being RCU-boosted.  This state is changed
> > + * by the task itself in response to the following three events:
> 							^^^
> > + * 1. Preemption (or block on lock) while in RCU read-side critical section.
>
> I am wondering, can a task block on a lock while in RCU read-side
> critical section?

I think this may be specific to the -rt patch. In the -rt patch,
spin_locks turn into mutexes, and therefor can block a read-side critical
section.


> > + * 2. Outermost rcu_read_unlock() for blocked RCU read-side critical section.
> > + *
>
> Event #3. is missing?

I guess Paul needs to answer that one ;-)

-- Steve
