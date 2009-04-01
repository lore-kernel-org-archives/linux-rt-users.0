From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Difference between chrt and nice
Date: Thu, 2 Apr 2009 01:54:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904020139340.12916@localhost.localdomain>
References: <901f25b80903302243q5ae531fs92113638539ea557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jaakko Sipari <jaakko.sipari@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47483 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbZDAXyo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Apr 2009 19:54:44 -0400
In-Reply-To: <901f25b80903302243q5ae531fs92113638539ea557@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 31 Mar 2009, Jaakko Sipari wrote:

> Hi!
> 
> I've already asked this in a couple of forums but got no answers. I
> would appreciate it if someone in this list could take some time to
> answer to my possibly stupid question(s):
> 
> What's the difference of setting process priority with chrt and nice?

"nice" is an historic utility which was used in the early days of batch
computing to be "nice" to other users and give up some CPU time. It's
still in use and useful and applies only to processes which run with
the SCHED_OTHER policy on Linux. 

"chrt" is a tool to change scheduling policy(SCHED_OTHER, _FIFO, RR)
and the priority of a process/task. With chrt you can either start a
process with such a policy or modify an already running process/tasks
policy. You need to have the permissions to do that.

So the main difference is that "nice" can only operate within the nice
levels of the SCHED_OTHER policy while "chrt" can change the policy
and the priority of a process/task.

> And how do using both of these commands compare with a normal vs.
> realtime-kernel  (PREEMPT_RT)?

Both commands are the same on vanilla and -rt kernels. The difference
is just the runtime behaviour of the -rt enabled kernel. processes /
tasks which run with real time scheduling policy have a deterministic
behaviour which is not and can not (yet) be guaranteed by the vanilla
kernel.

Hope that helps.

Thanks,

	tglx

P.S.: further info at http://rt.wiki.kernel.org
