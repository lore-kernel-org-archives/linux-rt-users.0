From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Fri, 3 May 2013 19:39:15 -0300
Message-ID: <20130503223915.GE17599@uudg.org>
References: <5178F0DE.8030808@huawei.com>
 <20130503204610.GG8230@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Qiang Huang <h.huangqiang@huawei.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:61933 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762266Ab3ECWrM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 18:47:12 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so389722yho.30
        for <linux-rt-users@vger.kernel.org>; Fri, 03 May 2013 15:47:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130503204610.GG8230@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 03, 2013 at 10:46:10PM +0200, Sebastian Andrzej Siewior wrote:
| * Qiang Huang | 2013-04-25 17:01:18 [+0800]:
| 
| >This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
| >(commit 0d939066acdcb in v3.4-rt),.
| >
| >Select_fallback_rq() can be easilly called during system boot, because
| >select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
| >which is 0 during system boot and not in tsk_cpus_allowed, so
| >select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
| >box, 1/3 bounded kernel threads will clear that flag after boot.
| >
| >And it will cause problems, for example:
| ># for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
| >this command will cause system hung.
| >
| >What's more, I don't see why we need to clear this flag any more,
| >because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
| >optimization for PF_THREAD_BOUND on migrate_disable/enable.
| >
| >Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
| 
| I can execute the command you mendtion above on v3.4 and v3.8 with no
| hangs. Can you give me number of your cpus and maybe the config or
| another detail?

I was able to reproduce the original issue on 3.6-rt (PREEMPT_RT_FULL
enabled) running the ltp-cgroups testcase. in fact, as originally reported,
the issue appeared when running the cgroup_fj tests. It usually took from
8~11min to trigger the issue.

After applying the patch I was no longer able to reproduce the issue, even
on 16h-long test runs.

Luis

| I played a little with it on v3.8. That code you asked to remove
| triggers only on cpu down for kernel threads which do not use the
| park/unpark infrastructure that is "posixcputmr" and "migration" which
| get removed later. The only reason why "migration" pops up is so it can
| leave.
| I managed to trigger it as well for worker threads. The threads which
| were bound the CPU, that went down, are marked DISASSOCIATED in
| gcwq_unbind_fn() and we lose that PF_THREAD_BOUND flag once that thread
| is used. After the CPU gets back, it is assigned to the "old" cpu via
| worker_maybe_bind_and_lock() and the PF_THREAD_BOUND flag is missing.
| So that is not looking that good. Will look at this later.
| 
| Sebastian
| --
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html

