From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Sun, 22 Dec 2013 04:07:27 +0100
Message-ID: <1387681647.5412.25.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131221193900.GA8427@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2013-12-21 at 20:39 +0100, Sebastian Andrzej Siewior wrote: 
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> Running RCU out of softirq is a problem for some workloads that would
> like to manage RCU core processing independently of other softirq work,
> for example, setting kthread priority.  This commit therefore moves the
> RCU core work from softirq to a per-CPU/per-flavor SCHED_OTHER kthread
> named rcuc.  The SCHED_OTHER approach avoids the scalability problems
> that appeared with the earlier attempt to move RCU core processing to
> from softirq to kthreads.  That said, kernels built with RCU_BOOST=y
> will run the rcuc kthreads at the RCU-boosting priority.

I'll take this for a spin on my 64 core test box.

I'm pretty sure I'll still end up having to split softirq threads again
though, as big box has been unable to meet jitter requirements without,
and last upstream rt kernel tested still couldn't.

-Mike

Hm.  Another thing I'll have to check again is btrfs locking fix, and
generic IO deadlocks if you don't pull your plug upon first rtmutex
block.  In 3.0, both were required for box to survive heavy fs pounding.
Oh yeah, and the pain of rt tasks playing idle balance for SCHED_OTHER
tasks, and nohz balancing crud, and cpupri cost when cores are isolated
and and.. sigh, big boxen _suck_ ;-)
