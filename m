From: Qiang Huang <h.huangqiang@huawei.com>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Sun, 5 May 2013 14:38:04 +0800
Message-ID: <5185FE4C.8090401@huawei.com>
References: <5178F0DE.8030808@huawei.com> <20130503204610.GG8230@linutronix.de> <20130503223915.GE17599@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:59821 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3EEGjH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 May 2013 02:39:07 -0400
In-Reply-To: <20130503223915.GE17599@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/5/4 6:39, Luis Claudio R. Goncalves wrote:
> On Fri, May 03, 2013 at 10:46:10PM +0200, Sebastian Andrzej Siewior wrote:
> | * Qiang Huang | 2013-04-25 17:01:18 [+0800]:
> | 
> | >This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
> | >(commit 0d939066acdcb in v3.4-rt),.
> | >
> | >Select_fallback_rq() can be easilly called during system boot, because
> | >select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
> | >which is 0 during system boot and not in tsk_cpus_allowed, so
> | >select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
> | >box, 1/3 bounded kernel threads will clear that flag after boot.
> | >
> | >And it will cause problems, for example:
> | ># for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
> | >this command will cause system hung.
> | >
> | >What's more, I don't see why we need to clear this flag any more,
> | >because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
> | >optimization for PF_THREAD_BOUND on migrate_disable/enable.
> | >
> | >Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
> | 
> | I can execute the command you mendtion above on v3.4 and v3.8 with no
> | hangs. Can you give me number of your cpus and maybe the config or
> | another detail?

My cpu number is 16, and I think SMP is necessary for reproduce the
problem which should fit for most of us.

But the config maybe an issue, with RT disabled, the problem is easy
to be reproduced, but with RT enabled, I do met an situation which can
not trigger the problem, and I haven't found the root cause yet, I have
both configs which can trigger the problem and not(with RT enabled), I
can send them to you privately if you need them.

> 
> I was able to reproduce the original issue on 3.6-rt (PREEMPT_RT_FULL
> enabled) running the ltp-cgroups testcase. in fact, as originally reported,
> the issue appeared when running the cgroup_fj tests. It usually took from
> 8~11min to trigger the issue.
> 
> After applying the patch I was no longer able to reproduce the issue, even
> on 16h-long test runs.

That's right, my first trigger is cgroup_fj, and then I found only
cpuset stress test case can trigger the problem, so I simplify the
test, and finally turned to the shell command in my change log. And
I think they all triggered by the same bug with same reason.

> 
> Luis
> 
> | I played a little with it on v3.8. That code you asked to remove
> | triggers only on cpu down for kernel threads which do not use the

But in my box, the code I asked to remove is triggered several time
since kernel boot, as I said, about 1/3 bounded kernel threads will
clear that flag after boot. Do I miss something?

> | park/unpark infrastructure that is "posixcputmr" and "migration" which
> | get removed later. The only reason why "migration" pops up is so it can
> | leave.
> | I managed to trigger it as well for worker threads. The threads which
> | were bound the CPU, that went down, are marked DISASSOCIATED in
> | gcwq_unbind_fn() and we lose that PF_THREAD_BOUND flag once that thread
> | is used. After the CPU gets back, it is assigned to the "old" cpu via
> | worker_maybe_bind_and_lock() and the PF_THREAD_BOUND flag is missing.
> | So that is not looking that good. Will look at this later.
> | 
> | Sebastian
> | --
> | To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> .
> 


