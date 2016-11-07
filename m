From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 19:49:03 +0100
Message-ID: <47238aa4-cc41-96ac-4d6e-c182a340db85@bristot.me>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
 <20161107133207.4282de69@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107133207.4282de69@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/07/2016 07:32 PM, Steven Rostedt wrote:
>> Excellent this would improve the situation with deadlocks as a result of
>> > cgroup_locks not being released due to lack of workqueue processing.
> ?? What deadlocks do you see? I mean, can you show the situation that
> throttling RT tasks will cause deadlock?
> 
> Sorry, but I'm just not seeing it.

It is not a deadlock in the theoretical sense of the word, but it is
more a side effect of the starvation - that looks like a deadlock.

There is a case where the removal of a cgroup dir calls
lru_add_drain_all(), that might schedule a kworker in the CPU that is
running the spinning-rt task. The kworker will starve - because they are
SCHED_OTHER by design, the lru_add_drain_all() will wait forever while
holding the cgroup lock and this will cause a lot of problems on other
tasks.

This problem was fixed on -rt using a -rt specific lock mechanism, but
the problem still exist in the non-rt kernel. Btw, this is just an
example of side effects of the starvation of non-rt-tasks. We can have
more examples...

-- Daniel
