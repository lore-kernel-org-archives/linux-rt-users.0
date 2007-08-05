From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG  RT] - rcupreempt.c:133 on 2.6.23-rc1-rt7
Date: Sun, 5 Aug 2007 10:24:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com>
References: <1186289484.636.5.camel@localhost.localdomain>
 <1186290332.636.8.camel@localhost.localdomain> <20070805065948.GB515@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:50964 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbXHEOYZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 10:24:25 -0400
In-Reply-To: <20070805065948.GB515@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Sun, 5 Aug 2007, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > I don't have time to look further now, and it's something that isn't
> > > easily reproducible (Well, it happened once out of two boots). If
> > > you need me to look further, or need a config or dmesg (I have
> > > both), then just give me a holler.
> >
> > Silly me. FYI, I was running with !PREEMPT_RT, but with Hard and
> > Softirqs as threads.  Must have copied the wrong config over :-/
>
> it's still not supposed to happen ... rcu read lock nesting that deep?
>

The code on line 133 is:

	WARN_ON_ONCE(current->rcu_read_lock_nesting > NR_CPUS);

I have NR_CPUS set to 2 since the box I'm running this on only has
2 cpus and I see no reason to waste more data structures.

Is rcu read lock nesting deeper than 2?

-- Steve
