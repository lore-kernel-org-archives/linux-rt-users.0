From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 6/9] RCU priority boosting for preemptible RCU
Date: Fri, 5 Oct 2007 08:24:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710050822330.20859@gandalf.stny.rr.com>
References: <20070910183004.GA3299@linux.vnet.ibm.com>
 <20070910183901.GF3819@linux.vnet.ibm.com> <20071005114657.GA17788@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org,
	dipankar@in.ibm.com, josht@linux.vnet.ibm.com, tytso@us.ibm.com,
	dvhltc@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
	a.p.zijlstra@chello.nl, bunk@kernel.org, oleg@tv-sign.ru
To: Gautham R Shenoy <ego@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33762 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbXJEMYc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Oct 2007 08:24:32 -0400
In-Reply-To: <20071005114657.GA17788@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org




On Fri, 5 Oct 2007, Gautham R Shenoy wrote:

> On Mon, Sep 10, 2007 at 11:39:01AM -0700, Paul E. McKenney wrote:
>
> [snip]
>
> > +
> > +/*
> > + * Return the list from which to boost target tasks.
> > + * May only be invoked by the booster task, so guaranteed to
> > + * already be initialized.  Use rcu_boost_dat element least recently
> > + * the destination for task blocking in RCU read-side critical sections.
> > + */
> > +static inline struct rcu_boost_dat *rcu_rbd_boosting(int cpu)
> > +{
> > +	int idx = (rcu_boost_idx + 1) & (RCU_BOOST_ELEMENTS - 1);
>
> Why is this masking required? When we increment
> the rcu_boost_idx in rcu_booster, we do perform a modulo operation
> to ensure that it wraps around RCU_BOOST_ELEMENTS.

Because we are not masking rcu_boost_idx, we are masking
 (rcu_boost_idx + 1) which may extend the bounderies of
RCU_BOOST_ELEMENTS.

-- Steve
