From: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2 Resend 0/4] Create sched_select_cpu() and use it for
	workqueues and timers
Date: Mon, 26 Nov 2012 11:03:54 -0800
Message-ID: <20121126190354.GJ2474@linux.vnet.ibm.com>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	<CAKohponTxs983vVQV=6Q8zyesC1W1FhFkzfmpAVeEwU-cQXohA@mail.gmail.com>
	<1353948027.6276.38.camel@gandalf.local.home>
	<20121126170358.GE2474@linux.vnet.ibm.com>
	<1353951352.6276.43.camel@gandalf.local.home>
Reply-To: paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul.mckenney-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, pjt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353951352.6276.43.camel-f9ZlEuEWxVcJvu8Pb33WZ0EMvNT87kid@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 26, 2012 at 12:35:52PM -0500, Steven Rostedt wrote:
> On Mon, 2012-11-26 at 09:03 -0800, Paul E. McKenney wrote:
> 
> 
> > If I understand correctly (though also suffering turkey OD), the idea is
> > to offload work to more energy-efficient CPUs.
> 
> This is determined by a CPU that isn't running the idle task? Is it
> because a CPU that just woke up may be running at a lower freq, and thus
> not as efficient? But pushing off to another CPU may cause cache misses
> as well. Wouldn't that also be a factor in efficiencies, if a CPU is
> stalled waiting for memory to be loaded?

Two different microarchitectures -- same instruction set (at user level,
anyway), but different power/performance characteristics.  One set is
optimized for performance, the other for energy efficiency.  For example,
ARM's big.LITTLE architecture.

> I should also ask the obvious. Has these patches shown real world
> efficiencies or is this just a theory? Do these patches actually improve
> battery life when applied?

I must defer to Viresh on this one.

							Thanx, Paul

> Just asking.
> 
> -- Steve
> 
> 
