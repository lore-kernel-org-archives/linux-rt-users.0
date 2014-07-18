From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH RFC tip/core/rcu 2/2] rcu: Create rcuo kthreads only for
 onlined CPUs
Date: Fri, 18 Jul 2014 09:10:01 -0400
Message-ID: <53C91CA9.7060103@oracle.com>
References: <20140714100604.GA9905@linux.vnet.ibm.com> <1405332404-10094-1-git-send-email-paulmck@linux.vnet.ibm.com> <1405332404-10094-2-git-send-email-paulmck@linux.vnet.ibm.com> <53C9023D.3090007@oracle.com> <20140718125516.GH8690@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
	laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de,
	peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
	edumazet@google.com, dvhart@linux.intel.com, fweisbec@gmail.com,
	oleg@redhat.com, sbw@mit.edu, linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718125516.GH8690@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 07/18/2014 08:55 AM, Paul E. McKenney wrote:
> On Fri, Jul 18, 2014 at 07:17:17AM -0400, Sasha Levin wrote:
>> > On 07/14/2014 06:06 AM, Paul E. McKenney wrote:
>>> > > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>>> > > 
>>> > > RCU currently uses for_each_possible_cpu() to spawn rcuo kthreads,
>>> > > which can result in more rcuo kthreads than one would expect, for
>>> > > example, derRichard reported 64 CPUs worth of rcuo kthreads on an
>>> > > 8-CPU image.  This commit therefore creates rcuo kthreads only for
>>> > > those CPUs that actually come online.
>>> > > 
>>> > > Reported-by: derRichard
>>> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > 
>> > Hey Paul,
>> > 
>> > Me again. :)
>> > 
>> > It seems that this patch moved thread initialization to a point way
>> > too early during boot, before rest_init() which initializes kthreadd_task
>> > runs, so creating a new kthread triggers a NULL ptr deref:
> This should be fixed by commit 918179699e4a in -rcu.  My guess is that
> you are instead using commit c6e2955266d14, which, said to say, made it
> into -next yesterday.  :-(
> 
> If my guess is wrong, please let me know!

Your guess is correct.

I'll wait for the next -next tree and retry.


Thanks,
Sasha
