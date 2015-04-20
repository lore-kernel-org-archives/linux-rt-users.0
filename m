From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 20:09:04 +0200
Message-ID: <20150420180904.GA19229@gmail.com>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
 <20150418130340.GA26931@gmail.com>
 <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
 <20150419020541.GA5561@linux.vnet.ibm.com>
 <20150420113554.598e503f@sluggy>
 <20150420170902.GU5561@linux.vnet.ibm.com>
 <20150420180107.GE24936@home.goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36287 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbDTSJJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 14:09:09 -0400
Content-Disposition: inline
In-Reply-To: <20150420180107.GE24936@home.goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, Apr 20, 2015 at 10:09:03AM -0700, Paul E. McKenney wrote:
> > 
> > The sysfs knob might be nice, but as far as I know nobody has been
> > complaining about it.
> > 
> > Besides, we already have the rcutree.kthread_prio= kernel-boot 
> > parameter. So how about if the Kconfig parameter selects either 
> > SCHED_OTHER (the default) or SCHED_FIFO:1, and then the boot 
> > parameter can be used to select other values.
> > 
> > That said, if the lack of a sysfs knob has been causing real 
> > problems, let's make that happen.
> 
> But then it's too late, because the time of something getting into 
> the kernel to the time people can use it can be months if not years.
> 
> I see no harm in adding one. Pretty much every kernel parameter I 
> added for ftrace, has a sysctrl knob for it. (Not a sysfs knob, but 
> a /proc/sys/kernel knob which is different).

So the disadvantage is that if a boot default is wrong, we'll hear 
about it eventually and can fix/improve it.

If a sysctl knob is wrong, people will just 'tune' it and forget to 
propagate it to the kernel proper (why should they).

Which is fine for something like ftrace and other ad-hoc 
instrumentation that is generally very fine tuned to a given bug or 
given piece of hardware, but for something like the RCU implementation 
of the kernel - even if it's just a RT side thought of it - I'm not so 
sure about it.

Thanks,

	Ingo
