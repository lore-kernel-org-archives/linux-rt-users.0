From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Does anyone use CONFIG_TINY_PREEMPT_RCU?
Date: Mon, 12 Nov 2012 17:42:52 -0800
Message-ID: <20121113014252.GO2518@linux.vnet.ibm.com>
References: <20121113004906.GA10557@linux.vnet.ibm.com>
 <CAFTL4hyUBAAu_COi_V3aFr5j0eXZxnw48Hv8pe1cRTLO1eKYdA@mail.gmail.com>
 <20121113011712.GA20884@jtriplet-mobl1>
 <CAFTL4hyHHRzgsAy6KbA39YgEjPRkMRdDK17DWy_rehiyoJjo6A@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org,
	rostedt@goodmis.org, Valdis.Kletnieks@vt.edu, dhowells@redhat.com,
	edumazet@google.com, darren@dvhart.com, sbw@mit.edu,
	patches@linaro.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:52990 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2KMBno (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Nov 2012 20:43:44 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 12 Nov 2012 18:43:43 -0700
Content-Disposition: inline
In-Reply-To: <CAFTL4hyHHRzgsAy6KbA39YgEjPRkMRdDK17DWy_rehiyoJjo6A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 13, 2012 at 02:34:06AM +0100, Frederic Weisbecker wrote:
> 2012/11/13 Josh Triplett <josh@joshtriplett.org>:
> > On Tue, Nov 13, 2012 at 02:12:27AM +0100, Frederic Weisbecker wrote:
> >> 2012/11/13 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> >> > Hello!
> >> >
> >> > I know of people using TINY_RCU, TREE_RCU, and TREE_PREEMPT_RCU, but I
> >> > have not heard of anyone using TINY_PREEMPT_RCU for whom TREE_PREEMPT_RCU
> >> > was not a viable option (in contrast, the people running Linux on
> >> > tiny-memmory systems typically use TINY_RCU).  Of course, if no one
> >> > really needs it, the proper thing to do is to remove it.
> >> >
> >> > So, if you need TINY_PREEMPT_RCU, please let me know.  Otherwise, I will
> >> > remove it, probably in the 3.9 timeframe.
> >>
> >> I don't use it personally but if you remove it, does that mean that
> >> RCU couldn't be preemptible on UP?
> >
> > No, it would mean that on UP you could choose between TINY_RCU and
> > TREE_PREEMPT_RCU, depending on whether you want tiny or preemptible.
> 
> Ok. I thought the TREE version wasn't possible anymore on UP when I
> saw some patches that removed optimizations for nr_online_cpus=1.
> Hence the confusion.

Those optimizations are not critically important.  That said, yes, I will
need to restart testing of TREE_PREEMPT_RCU on !SMP kernels.

							Thanx, Paul

