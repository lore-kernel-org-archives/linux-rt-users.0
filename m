From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Sat, 5 Sep 2015 14:04:57 +0200
Message-ID: <20150905120457.GA21338@gmail.com>
References: <20150904011900.730816481@goodmis.org>
 <alpine.DEB.2.11.1509051217330.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35014 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbbIEMFC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Sep 2015 08:05:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509051217330.15006@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Thomas Gleixner <tglx@linutronix.de> wrote:

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
> 
> Thoughts?

So why not do:

	lock(B);
	if (!trylock(A)) {
		unlock(B);
		lock(A);
		lock(B);
	}

?

Or, if this can be done, why didn't we do:

	lock(A);
	lock(B);

to begin with?

i.e. I'm not sure the problem is properly specified.

Thanks,

	Ingo
