From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Mon, 22 Apr 2013 12:00:47 -0400
Message-ID: <1366646447.9609.131.camel@gandalf.local.home>
References: <5170F28F.3060002@huawei.com> <51750563.8050301@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Qiang Huang <h.huangqiang@huawei.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Li Zefan <lizefan@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4107 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab3DVQAs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 12:00:48 -0400
In-Reply-To: <51750563.8050301@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-04-22 at 17:39 +0800, Li Zefan wrote:
> On 2013/4/19 15:30, Qiang Huang wrote:
> > Hi,
> > 
> > I ran cgroup_fj tests on RT kernel with PREEMPT_RT_FULL disabled, it will
> > stick the system when ran cpuset stress tests, it happens everytime.
> > 
> > Here stick the system means there are almost no response from the system and
> > we can hardly do anything on the terminal, but kernel isn't crash nor deadlocked
> > (according to the lockdep message), and it may do some response sometimes.
> > 
> > The problem exists on all RT versions from 3.4.18-rt29 to 3.4.37-rt51 AFAIK, but
> > without RT patches or with PREEMPT_RT_FULL enabled, the problem isn't exists.
> > 
> > When the system is stuck, we will get the following message:
> > # dmesg
> > ...
> 
> I've found the culprit after some investigation:
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 04 Nov 2011 19:48:36 +0000
> Subject: sched-clear-pf-thread-bound-on-fallback-rq.patch
> 
> At system boot when some cpus haven't been up, the scheduler calls select_fallback_rq()
> and schedules tasks in other cpus, which ends up clearing some kernel threads'
> PF_THREAD_BOUND flag...

I'm curious to why this doesn't break when PREEMPT_RT_FULL is enabled. I
would think it would also cause issues there too.

-- Steve


