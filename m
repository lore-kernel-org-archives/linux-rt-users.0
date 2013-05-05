From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Sun, 5 May 2013 07:44:40 -0700
Message-ID: <02BF8ED6-797D-4BEE-AF53-3522A1A183C4@thebigcorporation.com>
References: <5178F0DE.8030808@huawei.com> <20130503204610.GG8230@linutronix.de> <20130503223915.GE17599@uudg.org> <5185FE4C.8090401@huawei.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:50031 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3EEOol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 May 2013 10:44:41 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so1589441pbb.27
        for <linux-rt-users@vger.kernel.org>; Sun, 05 May 2013 07:44:41 -0700 (PDT)
In-Reply-To: <5185FE4C.8090401@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On May 4, 2013, at 23:38, Qiang Huang <h.huangqiang@huawei.com> wrote:

> On 2013/5/4 6:39, Luis Claudio R. Goncalves wrote:
>> On Fri, May 03, 2013 at 10:46:10PM +0200, Sebastian Andrzej Siewior wrote:
>> | * Qiang Huang | 2013-04-25 17:01:18 [+0800]:
>> | 
>> | >This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
>> | >(commit 0d939066acdcb in v3.4-rt),.
>> | >
>> | >Select_fallback_rq() can be easilly called during system boot, because
>> | >select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
>> | >which is 0 during system boot and not in tsk_cpus_allowed, so
>> | >select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
>> | >box, 1/3 bounded kernel threads will clear that flag after boot.
>> | >
>> | >And it will cause problems, for example:
>> | ># for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
>> | >this command will cause system hung.
>> | >
>> | >What's more, I don't see why we need to clear this flag any more,
>> | >because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
>> | >optimization for PF_THREAD_BOUND on migrate_disable/enable.
>> | >
>> | >Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
>> | 
>> | I can execute the command you mendtion above on v3.4 and v3.8 with no
>> | hangs. Can you give me number of your cpus and maybe the config or
>> | another detail?
> 
> My cpu number is 16, and I think SMP is necessary for reproduce the
> problem which should fit for most of us.
> 
> But the config maybe an issue, with RT disabled, the problem is easy
> to be reproduced, but with RT enabled, I do met an situation which can
> not trigger the problem, and I haven't found the root cause yet, I have
> both configs which can trigger the problem and not(with RT enabled), I
> can send them to you privately if you need them.

Your config - is it proprietary somehow that you cannot share it?


