From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Tue, 21 Apr 2015 11:50:27 -0400
Message-ID: <20150421115027.05b562cd@gandalf.local.home>
References: <20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
	<20150420204049.GF24936@home.goodmis.org>
	<20150420211504.GW5561@linux.vnet.ibm.com>
	<20150420165007.295f3fe0@sluggy>
	<20150421012258.GZ5561@linux.vnet.ibm.com>
	<20150421091232.6c66ba7b@gandalf.local.home>
	<20150421150122.GC5561@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421150122.GC5561@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 21 Apr 2015 08:01:22 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > Seem reasonable?
> > 
> > Does chrt override the kthread_prio at run time? If so, then great.
> > Otherwise, the sysadmin should still have a way to control their
> > priorities of kernel threads (with few exceptions like the migration
> > thread).
> 
> Yep, RCU sets the prios only at boot time, so if they are set differently
> at runtime, they should stay set differently.  Unless chrt refuses to
> work on kthreads or something. ;-)

Great! This all sounds reasonable to me :-)

-- Steve
