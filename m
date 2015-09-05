From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Sat, 5 Sep 2015 08:18:36 -0400
Message-ID: <20150905081836.2967d80d@gandalf.local.home>
References: <20150904011900.730816481@goodmis.org>
	<alpine.DEB.2.11.1509051217330.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:36220 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751123AbbIEMSj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Sep 2015 08:18:39 -0400
In-Reply-To: <alpine.DEB.2.11.1509051217330.15006@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 5 Sep 2015 12:30:59 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> So the problem we need to solve is:
> 
> retry:
> 	lock(B);
> 	if (!try_lock(A)) {
> 		unlock(B);
> 		cpu_relax();
> 		goto retry;
> 	}
> 
> So instead of doing that proposed magic boost, we can do something
> more straight forward:
> 
> retry:
> 	lock(B);
> 	if (!try_lock(A)) {
> 		lock_and_drop(A, B);
> 		unlock(A);
> 		goto retry;
> 	}
> 
> lock_and_drop() queues the task as a waiter on A, drops B and then
> does the PI adjustment on A. 

That was my original solution, and I believe I added patches to do
exactly that to the networking code in the past. I remember writing
that helper function such that on non PREEMPT_RT it was a nop.

I even had that solution in my slides at LinuxCon/LinuxPlumbers ;-)


But then I talk about dcache.c. Take a look at that file, and the
complexity of that. Is it safe to take the inode and dcache parent
locks after you unlock the other locks?

-- Steve
