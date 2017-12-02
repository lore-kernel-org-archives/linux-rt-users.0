From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Do not do push/pull when there is only one
 CPU
Date: Sat, 2 Dec 2017 12:12:52 -0500
Message-ID: <20171202121252.0bada310@vmware.local.home>
References: <20171201133222.66d41219@gandalf.local.home>
        <20171202125330.xrxspjeedbpr4hk5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171202125330.xrxspjeedbpr4hk5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2 Dec 2017 13:53:31 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> what about a check next to sched_feat(RT_PUSH_IPI)? I don't know if this
> is a hot path or not (due to bitmap_weight). If it is, then I would
> suggest something like a jump-label which is enabled if more than one
> CPU has been enabled on boot.

Yeah I didn't like that because of the overhead. But I was being
optimistic that the cpu weight function would be a nit to the actual
pull logic. But I have a better plan.

I would like to disable RT_PUSH_IPI, but that's a sched feature and
that is a constant if we build without sched debugging.

v2 coming up.

-- Steve
