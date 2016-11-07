From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 13:32:07 -0500
Message-ID: <20161107133207.4282de69@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 7 Nov 2016 10:55:38 -0600 (CST)
Christoph Lameter <cl@linux.com> wrote:

> On Mon, 7 Nov 2016, Daniel Bristot de Oliveira wrote:
> 
> > With these two options set, the user will guarantee some runtime
> > for non-rt-tasks on all CPUs, while keeping real-time tasks running
> > as much as possible.  
> 
> Excellent this would improve the situation with deadlocks as a result of
> cgroup_locks not being released due to lack of workqueue processing.

?? What deadlocks do you see? I mean, can you show the situation that
throttling RT tasks will cause deadlock?

Sorry, but I'm just not seeing it.

-- Steve
