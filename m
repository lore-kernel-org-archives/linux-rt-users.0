From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Thu, 22 Aug 2013 14:53:14 -0400
Message-ID: <20130822145314.32bdb0f9@gandalf.local.home>
References: <20130822182127.GA7606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130822182127.GA7606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 22 Aug 2013 20:21:27 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Known issues:
> 
>       - SLAB support not working
> 
>       - The cpsw network driver shows some issues.
> 
>       - bcache does not compile.

For now, it may be prudent to just make bcache depend on !PREEMPT_RT.

I can send a patch if you want.

-- Steve

> 
>       - set_affinity callbacks result in splat due to sleeping while
>         atomic
> 
>       - an ancient race (since we got sleeping spinlocks) where the
>         TASK_TRACED state is temporary replaced while waiting on a rw
>         lock and the task can't be traced.
> 
