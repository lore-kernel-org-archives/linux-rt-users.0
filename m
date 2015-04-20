From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 16:40:49 -0400
Message-ID: <20150420204049.GF24936@home.goodmis.org>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
 <20150418130340.GA26931@gmail.com>
 <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
 <20150419020541.GA5561@linux.vnet.ibm.com>
 <20150420113554.598e503f@sluggy>
 <20150420170902.GU5561@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150420170902.GU5561@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Apr 20, 2015 at 10:09:03AM -0700, Paul E. McKenney wrote:
> 
> The sysfs knob might be nice, but as far as I know nobody has been
> complaining about it.
> 
> Besides, we already have the rcutree.kthread_prio= kernel-boot parameter.
> So how about if the Kconfig parameter selects either SCHED_OTHER
> (the default) or SCHED_FIFO:1, and then the boot parameter can be used
> to select other values.

Hmm, what priority is this for anyway. To change the priority of the boost
value at run time, do we only need to change the priority of the rcub threads?

And the priority of the other rcu threads can change as well with a simple
chrt?

If that's the case, then we don't need a sysctl knob at all.

-- Steve


> 
> That said, if the lack of a sysfs knob has been causing real problems,
> let's make that happen.
