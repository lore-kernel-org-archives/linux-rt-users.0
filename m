From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Tue, 30 Apr 2013 11:21:35 -0300
Message-ID: <20130430142135.GA3430@uudg.org>
References: <5170F28F.3060002@huawei.com>
 <51750563.8050301@huawei.com>
 <1366646447.9609.131.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Zefan <lizefan@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Qiang Huang <h.huangqiang@huawei.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gg0-f172.google.com ([209.85.161.172]:56116 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760237Ab3D3OVl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 10:21:41 -0400
Received: by mail-gg0-f172.google.com with SMTP id f1so70924ggn.31
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Apr 2013 07:21:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366646447.9609.131.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 22, 2013 at 12:00:47PM -0400, Steven Rostedt wrote:
| On Mon, 2013-04-22 at 17:39 +0800, Li Zefan wrote:
| > On 2013/4/19 15:30, Qiang Huang wrote:
| > > Hi,
| > > 
| > > I ran cgroup_fj tests on RT kernel with PREEMPT_RT_FULL disabled, it will
| > > stick the system when ran cpuset stress tests, it happens everytime.
| > > 
| > > Here stick the system means there are almost no response from the system and
| > > we can hardly do anything on the terminal, but kernel isn't crash nor deadlocked
| > > (according to the lockdep message), and it may do some response sometimes.
| > > 
| > > The problem exists on all RT versions from 3.4.18-rt29 to 3.4.37-rt51 AFAIK, but
| > > without RT patches or with PREEMPT_RT_FULL enabled, the problem isn't exists.
| > > 
| > > When the system is stuck, we will get the following message:
| > > # dmesg
| > > ...
| > 
| > I've found the culprit after some investigation:
| > 
| > From: Thomas Gleixner <tglx@linutronix.de>
| > Date: Fri, 04 Nov 2011 19:48:36 +0000
| > Subject: sched-clear-pf-thread-bound-on-fallback-rq.patch
| > 
| > At system boot when some cpus haven't been up, the scheduler calls select_fallback_rq()
| > and schedules tasks in other cpus, which ends up clearing some kernel threads'
| > PF_THREAD_BOUND flag...
| 
| I'm curious to why this doesn't break when PREEMPT_RT_FULL is enabled. I
| would think it would also cause issues there too.

I does break when PREEMPT_RT_FULL is enabled :)

I was able to consistently reproduce the issue on the latest 3.6-rt kernel
this weekend. And I was also able to confirm that the patch in this thread
did mitigate the issue.

Cheers,
Luis
