From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RT] convert RCU Preempt tasklet into softirq.
Date: Thu, 7 Jun 2007 21:16:51 -0700
Message-ID: <20070608041651.GA19912@linux.vnet.ibm.com>
References: <1181180051.18444.31.camel@localhost.localdomain> <20070607041411.GB1783@linux.vnet.ibm.com> <1181226138.18444.54.camel@localhost.localdomain> <20070607161754.GA11941@linux.vnet.ibm.com> <1181240819.10408.14.camel@localhost.localdomain> <1181242307.10408.17.camel@localhost.localdomain> <1181247369.10408.20.camel@localhost.localdomain>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55145 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbXFHEQz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Jun 2007 00:16:55 -0400
Content-Disposition: inline
In-Reply-To: <1181247369.10408.20.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jun 07, 2007 at 04:16:09PM -0400, Steven Rostedt wrote:
> On Thu, 2007-06-07 at 14:51 -0400, Steven Rostedt wrote:
> 
> > There might still be an issue here. With the patch I'm getting a really
> > slow response time on networking. But that be because of other patches I
> > have applied.
> 
> I removed this patch and I can still get the network slowdown/hang. So
> this patch is unrelated to this issue. RCU on the otherhand has not been
> cleared of suspicion.

Might the slowdown be due to different kernel threads running at different
priorities?  I could easily believe that changing the priority of the
kernel thread processing RCU callbacks could have a noticeable effect
on performance in some cases.

In other news, passed a set of kernbenches at this end, so starting
an rcutorture.

							Thanx, Paul
