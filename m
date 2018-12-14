From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: BUG: ftrace/perf dropping events at the begin of interrupt
 handlers
Date: Fri, 14 Dec 2018 11:21:33 +0100
Message-ID: <e9375c7c-745d-fac3-6e16-539712ceaaea@redhat.com>
References: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
 <20181204141644.6852d450@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
        =?UTF-8?Q?R=c3=b4mulo_Silva_de_Oliveira?=
        <romulo.deoliveira@ufsc.br>, Ingo Molnar <mingo@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204141644.6852d450@vmware.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/4/18 8:16 PM, Steven Rostedt wrote:
> Yes, it's a simple fix. The problem is that the recursion detection of
> the function tracer requires that when its called from interrupt, the
> "in_interrupt" needs to be true, otherwise it thinks that the function
> tracer is recursing on itself (which is common).
> 
> Looking an the dropped events, and the code in __irq_enter() we have
> this:
> 
> #define __irq_enter()					\
> 	do {						\
> 		account_irq_enter_time(current);	\
> 		preempt_count_add(HARDIRQ_OFFSET);	\ <<-- in_interrupt() returns true here
> 		trace_hardirq_enter();			\
> 	} while (0)
> 
> Interesting enough, the dropped events happen to be in
> account_irq_enter_time()!
> 
> Thus what I believe is happening is that an interrupt came in while one
> event was being recorded. When account_irq_enter_time was called, the
> function tracer noticed that its recursion bit for the current context
> was already set, and just dropped the event because it thought it was
> just tracing itself. After we add HARDIRQ_OFFSET to preempt_count, the
> "in_interrupt()" will be set and the function tracer will know its in a
> new context where its safe to continue tracing.
> 
> Can you try this patch to see if it fixes it for you?

Hi Steve,

I finally took some time to play the patch, sorry for the delay. I got the idea
of the patch, but it is not working as expected :-(.

When I enable it, the system [a VM with 1 CPU] mostly freezes when I run that:

# while [ 1 ]; do echo > /dev/null; done &

I still need to investigate why.

The other point is that I got that the patch would start showing
account_irq_enter_time(). But, as far as I understood, it would not trace the
do_IRQ(). Right?

Wouldn't be the case of using a per-cpu variable to set the flag right in the
begin of the handler (in the entry*.s)?

Thoughts?

-- Daniel
