From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 14:01:07 -0400
Message-ID: <20150420180107.GE24936@home.goodmis.org>
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
> 
> That said, if the lack of a sysfs knob has been causing real problems,
> let's make that happen.

But then it's too late, because the time of something getting into the kernel
to the time people can use it can be months if not years.

I see no harm in adding one. Pretty much every kernel parameter I added for
ftrace, has a sysctrl knob for it. (Not a sysfs knob, but a /proc/sys/kernel
knob which is different).

-- Steve
