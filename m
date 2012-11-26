From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 Resend 0/4] Create sched_select_cpu() and use it for
 workqueues and timers
Date: Mon, 26 Nov 2012 14:17:57 -0500
Message-ID: <1353957477.6276.51.camel@gandalf.local.home>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	 <CAKohponTxs983vVQV=6Q8zyesC1W1FhFkzfmpAVeEwU-cQXohA@mail.gmail.com>
	 <1353948027.6276.38.camel@gandalf.local.home>
	 <20121126170358.GE2474@linux.vnet.ibm.com>
	 <1353951352.6276.43.camel@gandalf.local.home>
	 <20121126190354.GJ2474@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar@linaro.org>, pjt@google.com,
	paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org,
	suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com,
	peterz@infradead.org, Arvind.Chauhan@arm.com,
	linaro-dev@lists.linaro.org, patches@linaro.org,
	pdsw-power-team@arm.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121126190354.GJ2474@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-11-26 at 11:03 -0800, Paul E. McKenney wrote:
> On Mon, Nov 26, 2012 at 12:35:52PM -0500, Steven Rostedt wrote:
> > On Mon, 2012-11-26 at 09:03 -0800, Paul E. McKenney wrote:
> > 
> > 
> > > If I understand correctly (though also suffering turkey OD), the idea is
> > > to offload work to more energy-efficient CPUs.
> > 
> > This is determined by a CPU that isn't running the idle task? Is it
> > because a CPU that just woke up may be running at a lower freq, and thus
> > not as efficient? But pushing off to another CPU may cause cache misses
> > as well. Wouldn't that also be a factor in efficiencies, if a CPU is
> > stalled waiting for memory to be loaded?
> 
> Two different microarchitectures -- same instruction set (at user level,
> anyway), but different power/performance characteristics.  One set is
> optimized for performance, the other for energy efficiency.  For example,
> ARM's big.LITTLE architecture.
> 

But I don't see anything in the patch set that guarantees that we will
be moving something off to one of the "big" cores. The only heuristic
that is used is if the CPU is idle or not. In fact, if the big core was
idle we may be pushing work off to a "LITTLE" CPU.

Again, work is only run on the CPU it was queued on (which this patch
set is trying to change). Thus, only work that would be queued on a
LITTLE CPU is by something that ran on that CPU.

I'm still having a bit of trouble understanding where the benefit comes
from.

-- Steve
