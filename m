From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Do not pull from current CPU if only one cpu
 to pull
Date: Mon, 4 Dec 2017 03:09:16 -0500
Message-ID: <20171204030916.0cf09b0f@vmware.local.home>
References: <20171202130454.4cbbfe8d@vmware.local.home>
        <20171204074517.GA26712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204074517.GA26712@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 4 Dec 2017 08:45:17 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> Right. I was wondering however if for the truly UP case we shouldn't be
> initiating/queueing callbacks (pull/push) at all?

If !CONFIG_SMP then it's not compiled in. The issue came up when Daniel
ran a CONFIG_SMP kernel on an arch that only supports UP.

> 
> DEADLINE doesn't use (yet?) the PUSH_IPI, but we will need a similar
> patch to keep logics aligned.

Maybe.

-- Steve
