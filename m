From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] sched/core: Avoid__schedule() being called twice, the
 second in vain
Date: Wed, 1 Aug 2018 13:18:28 +0200
Message-ID: <20180801111828.ko5t3kgxngv44wg5@linutronix.de>
References: <ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Romulo da Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-30 15:00:00 [+0200], Daniel Bristot de Oliveira wrote:
> Before calling __schedule() to cause a context switch, the schedule()
> function runs sched_submit_work() to dispatch deferred work that was
> postponed to the point that the thread is leaving the processor.
> The function sched_submit_work() checks for the need to wake up a
> kworker; if needed, a kworker thread is awakened. In this context,
> the following behavior takes place.
…
> at line 11, there is nothing to schedule, and so the __schedule() at
> line 18 is called in vain.

I read this as an optimisation for the common case as you put it. 
Applied.

Sebastian
