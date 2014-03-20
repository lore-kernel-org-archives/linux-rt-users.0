From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Resend: 3.10.32-rt31: problem with "rcu: Eliminate softirq
 processing from rcutree"
Date: Thu, 20 Mar 2014 10:50:26 -0400
Message-ID: <20140320105026.290bd87b@gandalf.local.home>
References: <CAJAcJWKq1VsSVGWGtbx=-e-kW5kP5sQ9y4mvRbnM==U9BC2NpQ@mail.gmail.com>
	<20140307162145.GC18441@linutronix.de>
	<20140307170419.GI3334@linux.vnet.ibm.com>
	<CAJAcJWJ=TB=6orb3BQMQ7BbFBjP7k7Vn52KrKJGdmJeTZ91A3g@mail.gmail.com>
	<20140308200400.GA3334@linux.vnet.ibm.com>
	<20140318110531.GC10448@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Helmut Buchsbaum <helmut.buchsbaum@gmail.com>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:24884 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932685AbaCTOu3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Mar 2014 10:50:29 -0400
In-Reply-To: <20140318110531.GC10448@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 18 Mar 2014 12:05:31 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Paul E. McKenney | 2014-03-08 12:04:00 [-0800]:
> 
> >On Sat, Mar 08, 2014 at 08:08:35PM +0100, Helmut Buchsbaum wrote:
> >> This is the correct point to tweak the system, I was not yet aware of!
> >> Thanks a lot for the hint. I just enabled RCU_BOOST with its default
> >> settings and the system runs smooth and stable again even in heavy
> >> load situations. Maybe the default for RCU_BOOST should be set to Y on
> >> systems using PREEMPT_RT_FULL ?
> >
> >I must defer to Sebastian on this, but seems like a good approach.
> 
> Hmm. There are a few ways to break an RT system. Afaik RCU_BOOST was
> recommended even before this change. 
> 
> Steven, tglx any opinion on that?
> 
> Another thing we could do is to register_shrinker() which is called
> before OOM. But then boosting is simple enough.

I thought RCU_BOOST was already set for default y when PREEMPT_RT is
set. If not, then please add it. Note, the default should be set, but
not selected. Still let the user disable it.

 default y if PREEMPT_RT_FULL

Thanks,

-- Steve
