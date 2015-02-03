From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Tue, 3 Feb 2015 15:36:19 -0500
Message-ID: <20150203153619.6bf35329@gandalf.local.home>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
	<20150128180335.GR19109@linux.vnet.ibm.com>
	<20150128182512.GB1259@amt.cnet>
	<20150128185552.GT19109@linux.vnet.ibm.com>
	<20150202182450.GA9526@amt.cnet>
	<20150202153553.70dd1a5a@gandalf.local.home>
	<20150202204659.GA13864@amt.cnet>
	<20150202155528.31bcb406@gandalf.local.home>
	<20150202210229.GA14624@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:32909 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933946AbbBCUgX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Feb 2015 15:36:23 -0500
In-Reply-To: <20150202210229.GA14624@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2 Feb 2015 19:02:29 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> I am worried about two things:
> 
> 1) Something calling raise_softirq(TIMER_SOFTIRQ) and lack of 
> Paul's d550e81dc0dd.
> 
> The result is __run_timers checking all timer wheel "nodes" 
> and updating base->timer_jiffies, latency is ruined.
> 
> Even if one carefully made sure no timer is present.
> 
> 2) Reliance on sched timer interrupt to raise timer softirq 
> in case of pending irq work (your patch) AND no_hz_full.
> 
> > Isolation is the *only* way to make that work.
> 
> Fine. Please see item 1) above.
> 

So basically you are saying we just need: d550e81dc0dd ?

-- Steve
