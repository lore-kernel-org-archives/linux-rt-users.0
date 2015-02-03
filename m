From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Tue, 3 Feb 2015 12:57:05 -0800
Message-ID: <20150203205705.GA19109@linux.vnet.ibm.com>
References: <20150128015508.GA12233@amt.cnet>
 <20150128180335.GR19109@linux.vnet.ibm.com>
 <20150128182512.GB1259@amt.cnet>
 <20150128185552.GT19109@linux.vnet.ibm.com>
 <20150202182450.GA9526@amt.cnet>
 <20150202153553.70dd1a5a@gandalf.local.home>
 <20150202204659.GA13864@amt.cnet>
 <20150202155528.31bcb406@gandalf.local.home>
 <20150202210229.GA14624@amt.cnet>
 <20150203153619.6bf35329@gandalf.local.home>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:37090 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933946AbbBCU5L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Feb 2015 15:57:11 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 3 Feb 2015 13:57:10 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0B6003E4003B
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Feb 2015 13:57:08 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t13KvCV025362586
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Feb 2015 13:57:12 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t13Kv7dm023041
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Feb 2015 13:57:07 -0700
Content-Disposition: inline
In-Reply-To: <20150203153619.6bf35329@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 03, 2015 at 03:36:19PM -0500, Steven Rostedt wrote:
> On Mon, 2 Feb 2015 19:02:29 -0200
> Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> > I am worried about two things:
> > 
> > 1) Something calling raise_softirq(TIMER_SOFTIRQ) and lack of 
> > Paul's d550e81dc0dd.
> > 
> > The result is __run_timers checking all timer wheel "nodes" 
> > and updating base->timer_jiffies, latency is ruined.
> > 
> > Even if one carefully made sure no timer is present.
> > 
> > 2) Reliance on sched timer interrupt to raise timer softirq 
> > in case of pending irq work (your patch) AND no_hz_full.
> > 
> > > Isolation is the *only* way to make that work.
> > 
> > Fine. Please see item 1) above.
> 
> So basically you are saying we just need: d550e81dc0dd ?

fff421580f51 is of course a prerequisite for d550e81dc0dd.  Of the five
related commits, these two are the most important, as they cover things
for CPUs that never have any timers.  The other three handle CPUs that
occasionally have a timer or two.

So you definitely need fff421580f51 and d550e81dc0dd.  Less carefully
tuned systems will benefit from 16d937f88031, 18d8cb64c9c0, and
aea369b959be, but these last three are more in the nice-to-have
category.

							Thanx, Paul

