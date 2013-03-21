From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 3/7] workqueue: Add helpers to schedule work on any cpu
Date: Wed, 20 Mar 2013 17:12:11 -0700
Message-ID: <20130321001211.GC31256@htj.dyndns.org>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
 <fb2e721fc43fbc3517a7ebb905aa573b12bb83a5.1363617402.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linaro-kernel@lists.linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fb2e721fc43fbc3517a7ebb905aa573b12bb83a5.1363617402.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, Viresh.

On Mon, Mar 18, 2013 at 08:53:25PM +0530, Viresh Kumar wrote:
> queue_work() queues work on current cpu. This may wake up an idle CPU, which is
> actually not required.
> 
> Some of these works can be processed by any CPU and so we must select a non-idle
> CPU here. The initial idea was to modify implementation of queue_work(), but
> that may end up breaking lots of kernel code that would be a nightmare to debug.
> 
> So, we finalized to adding new workqueue interfaces, for works that don't depend
> on a cpu to execute them.
> 
> This patch adds following new routines:
> - queue_work_on_any_cpu
> - queue_delayed_work_on_any_cpu
> 
> These routines would look for the closest (via scheduling domains) non-idle cpu
> (non-idle from schedulers perspective). If the current cpu is not idle or all
> cpus are idle, work will be scheduled on local cpu.

For some reason, I've been always unsure about this patchset.  I've
been thinking about it past few days and I think I now know why.

I can see that strategy like this being useful for timer, and
impressive power saving numbers BTW - we definitely want that.  While
workqueue shares a lot of attributes with timers, there's one
important difference - scheduler is involved in work item executions.

Work item scheduling for per-cpu work items artificially removes the
choice of CPU from the scheduler with the assumption that such
restrictions would lead to lower overall overhead.  There is another
variant of workqueue - WQ_UNBOUND - when such assumption wouldn't hold
too well and it would be best to give the scheduler full latitude
regarding scheduling work item execution including choice of CPU.

Now, this patchset, kinda sorta adds back CPU selection by scheduler
in an ad-hoc way, right?  If we're gonna do that, why not just make it
unbound workqueues?  Then, the scheduler would have full discretion
over them and we don't need to implement this separate ad-hoc thing on
the side.  It's the roundaboutness that bothers me.

I'm not sure about other workqueues but the block one can be very
performance sensitive on machines with high IOPS and it would
definitely be advisable to keep it CPU-affine unless power consumption
is the overriding concern, so how about introducing another workqueue
flag, say WQ_UNBOUND_FOR_POWER (it's terrible, please come up with
something better), which is WQ_UNBOUND on configurations where this
matters and becomes noop if not?

Thanks.

-- 
tejun
