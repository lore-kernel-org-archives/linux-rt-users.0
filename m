From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 Resend 3/4] workqueue: Schedule work on non-idle cpu
	instead of current one
Date: Mon, 26 Nov 2012 09:15:39 -0800
Message-ID: <20121126171539.GZ15971@htj.dyndns.org>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	<ad25c731a6ca1bd1269555245952f05c856a9759.1352196505.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org,
	paul.mckenney-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org,
	pdsw-power-team-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, pjt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ad25c731a6ca1bd1269555245952f05c856a9759.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

Hello, Viresh.

On Tue, Nov 06, 2012 at 04:08:45PM +0530, Viresh Kumar wrote:
> Workqueues queues work on current cpu, if the caller haven't passed a preferred
> cpu. This may wake up an idle CPU, which is actually not required.
> 
> This work can be processed by any CPU and so we must select a non-idle CPU here.
> This patch adds in support in workqueue framework to get preferred CPU details
> from the scheduler, instead of using current CPU.
> 
> Most of the time when a work is queued, the current cpu isn't idle and so we
> will choose it only. There are cases when a cpu is idle when it queues some
> work. For example, consider following scenario:
> - A cpu has programmed a timer and is IDLE now.
> - CPU gets into interrupt handler due to timer and queues a work. As the CPU is
>   currently IDLE, we can queue this work to some other CPU.

I'm pretty skeptical about this.  queue_work() w/o explicit CPU
assignment has always guaranteed that the work item will be executed
on the same CPU.  I don't think there are too many users depending on
that but am not sure at all that there are none.  I asked you last
time that you would at the very least need to audit most users but it
doesn't seem like there has been any effort there.  Given the
seemingly low rate of migration and subtlety of such bugs, things
could get nasty to debug.

That said, if the obtained benefit is big enough, sure, we can
definitely change the behavior, which isn't all that great to begin
with, and try to shake out the bugs quicky by e.g. forcing all work
items to execute on different CPUs, but you're presenting a few
percent of work items being migrated to a different CPU from an
already active CPU, which doesn't seem like such a big benefit to me
even if the migration target CPU is somewhat more efficient.  How much
powersaving are we talking about?

Thanks.

-- 
tejun
