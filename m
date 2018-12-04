From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: ftrace/perf dropping events at the begin of interrupt
 handlers
Date: Tue, 4 Dec 2018 14:16:44 -0500
Message-ID: <20181204141644.6852d450@vmware.local.home>
References: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Marko Pusch <marko.pusch@siemens.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?UTF-8?B?UsO0bXVsbw==?= Silva de Oliveira
        <romulo.deoliveira@ufsc.br>, Ingo Molnar <mingo@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 22 Nov 2018 10:45:05 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> While developing the automata [1], I've hit cases in which need resched
> and/or sched wakeup events were being fired with preemption and/or
> interrupts enabled. However, this is not possible because interrupts must
> be disabled to avoid concurrence with an interrupt handler, and the
> preemption must be disabled to avoid concurrence with the scheduler.
> The tool I use to validate the model is based on perf, and it was
> complaining about this situation. I’ve talked to Arnaldo about it
> two months.
> 
> Further debug on perf has shown that those cases always took place
> associated with the occurrence of interrupts. At ELC Europe
> Marko Pusch (Siemens) also mentioned hitting cases in which he saw
> missing events related to IRQ handling, but using ftrace. Steven and
> I also discussed this during the last Plumbers (Vancouver - CA) and we
> agreed that there is a problem on ftrace too.
> 
> To reproduce this problem with ftrace, one needs to enable function
> tracer and do kernel operations in a CPU in which IRQs are taking place.
> 
> For instance, in a single CPU VM, run:
> 
> # while [ 1 ]; do echo > /dev/null; done
> 
> In a shell, and 
> 
> # trace-cmd record -b [enough buff to avoid missing trace because of buffer overun] -p function sleep 5
> 
> In another shell.
> 
> Then, using trace-cmd report --debug, we can see the problem. Here is one
> example of output, first the expected one:
> 
> 


> ================ Faulty execution =================
> 
> Thus, ftrace and perf, sometimes, are dropping events at the begin of
> interrupt handlers. And that is The reason why interrupt disable and
> preempt disable were not being recorded (and causing problem in the
> automata execution) is that these events take place in the very early
> execution of the interrupt handler, in the section in which the
> perf/ftrace are dropping events [ without notifying ].
> 
> [1] This is a good demonstration of problems that can be found using the
> automata model presented in this workshop paper:
> 
> Modeling the Behavior of Threads in the PREEMPT_RT Linux Kernel Using
> Automata. Daniel Bristot de Oliveira, Tommaso Cucinotta, Rômulo Silva de
> Oliveira - EWiLi'2018 – Embedded operating system workshop Torino, Italy,
> 4 October 2018.
> 
> And in the presentations:
> "Mind the gap between real-time Linux and real-time theory"
> "How can we catch problems that can break the PREEMPT_RT preemption model?"
> At the Linux Plumbers (Vancouver - CA)
> 
> Steven is already aware of this problem, and he is working on it.

Yes, it's a simple fix. The problem is that the recursion detection of
the function tracer requires that when its called from interrupt, the
"in_interrupt" needs to be true, otherwise it thinks that the function
tracer is recursing on itself (which is common).

Looking an the dropped events, and the code in __irq_enter() we have
this:

#define __irq_enter()					\
	do {						\
		account_irq_enter_time(current);	\
		preempt_count_add(HARDIRQ_OFFSET);	\ <<-- in_interrupt() returns true here
		trace_hardirq_enter();			\
	} while (0)

Interesting enough, the dropped events happen to be in
account_irq_enter_time()!

Thus what I believe is happening is that an interrupt came in while one
event was being recorded. When account_irq_enter_time was called, the
function tracer noticed that its recursion bit for the current context
was already set, and just dropped the event because it thought it was
just tracing itself. After we add HARDIRQ_OFFSET to preempt_count, the
"in_interrupt()" will be set and the function tracer will know its in a
new context where its safe to continue tracing.

Can you try this patch to see if it fixes it for you?

-- Steve

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 0fbbcdf0c178..0290531ebe3c 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -35,8 +35,8 @@ extern void rcu_nmi_exit(void);
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
+		account_irq_enter_time(current);	\
 		trace_hardirq_enter();			\
 	} while (0)
 
