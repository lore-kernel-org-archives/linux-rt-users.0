From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] sched/rt: don't try to balance rt_runtime when it is
 futile
Date: Thu, 15 May 2014 19:27:21 +0200
Message-ID: <1400174841.18229.6.camel@marge.simpson.net>
References: <1400080115-12339-1-git-send-email-paul.gortmaker@windriver.com>
	 <20140514154459.GE4570@linux.vnet.ibm.com>
	 <1400123931.5175.38.camel@marge.simpson.net>
	 <20140515144553.GZ4570@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140515144553.GZ4570@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2014-05-15 at 07:45 -0700, Paul E. McKenney wrote: 
> On Thu, May 15, 2014 at 05:18:51AM +0200, Mike Galbraith wrote:
> > On Wed, 2014-05-14 at 08:44 -0700, Paul E. McKenney wrote:
> > 
> > > In practice, not sure how much testing CONFIG_NO_HZ_FULL=y has received
> > > for -rt kernels in production environments.
> > 
> > I took 3.14-rt out for a quick spin on my 64 core box, it didn't work at
> > all with 60 cores isolated.  I didn't have time to rummage, but it looks
> > like there are still bugs to squash. 
> > 
> > Biggest problem with CONFIG_NO_HZ_FULL is the price tag.  It just raped
> > fast mover performance last time I measured.
> 
> I do have a report of the RCU grace-period kthreads (rcu_preempt,
> rcu_sched, and rcu_bh) consuming excessive CPU time on large boxes,
> but this is for workloads with lots of threads and context switches.
> 
> Whether relevant or not to your situation, working on it...

RCU signal was swamped by accounting.

-Mike
