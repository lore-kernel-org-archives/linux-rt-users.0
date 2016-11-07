From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 10:55:38 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
Content-Type: text/plain; charset=US-ASCII
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 7 Nov 2016, Daniel Bristot de Oliveira wrote:

> With these two options set, the user will guarantee some runtime
> for non-rt-tasks on all CPUs, while keeping real-time tasks running
> as much as possible.

Excellent this would improve the situation with deadlocks as a result of
cgroup_locks not being released due to lack of workqueue processing.
