From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Sat, 5 Sep 2015 12:30:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509051217330.15006@nanos>
References: <20150904011900.730816481@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150904011900.730816481@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 3 Sep 2015, Steven Rostedt wrote:
> There are a lot of trylocks in the kernel, and I'm sure there's more around
> that need to be convert to this method.

The only ones we need to convert are those which do an actual trylock
loop. The others, which simply bail if the trylock fails are
completely irrelevant.

> I think this is an elegant solution but others may feel
> differently. As I think a msleep() hail mary is extremely non
> deterministic, it's a blemish for a kernel that prides itself on
> adding determinism.

I agree that the msleep hack is horrible. Though I do not agree that
this solution is elegant. It's clever.

I was looking into that a few days ago and did not come up with
something sensible, but your patch and reading up on your well done
explanation made me look another time.

So the problem we need to solve is:

retry:
	lock(B);
	if (!try_lock(A)) {
		unlock(B);
		cpu_relax();
		goto retry;
	}

So instead of doing that proposed magic boost, we can do something
more straight forward:

retry:
	lock(B);
	if (!try_lock(A)) {
		lock_and_drop(A, B);
		unlock(A);
		goto retry;
	}

lock_and_drop() queues the task as a waiter on A, drops B and then
does the PI adjustment on A. 

Thoughts?

Thanks,

	tglx
