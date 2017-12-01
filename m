From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Null pointer 4.14.1-rt3
Date: Fri, 1 Dec 2017 13:26:05 +0100
Message-ID: <20171201122605.GD1612@linutronix.de>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
 <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
 <20171130112232.4c0cb600@gandalf.local.home>
 <20171130162433.GG11362@linutronix.de>
 <20171130113533.4485d894@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130113533.4485d894@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-11-30 11:35:33 [-0500], Steven Rostedt wrote:
> Hmm, I'm not sure I tested this on a UP machine. Perhaps I should boot
> with CPUs=1

It does not crash everywhere. For instance Dra7x, imx6 do not crash
because they have GICv3 which does set required SMP function even on UP
systems. BBB which uses the ti,am33xx-intc / INTC does not and here we
boom.
>From what I see (in qemu) it won't explode on a x86-SMP config with one
CPU either because it sets that function, too (on APIC).

For RT it is enough to start one cyclictest. For !RT it looks to be
enough to enable SW-Watchdog and RCU boosting and I see 
	pull_rt_task() -> tell_cpu_to_push -> irq_work_queue_on()
on v4.14.2 with "sched/rt: Simplify the IPI based RT balancing logic"

Now, what do we do about it?
- does it make sense to tell tell_cpu_to_push() to not do anything if
  the target CPU is the same as the current?

- irq_work_queue() uses arch_irq_work_raise() which has a check (on ARM)
  and uses it only if it is really on SMP. The other user of
  arch_send_call_function_single_ipi() is generic_exec_single() and this
  one skips the invocation if target CPU == current CPU and invokes the
  function directly. We could invoke arch_irq_work_raise() instead for
  "local" case.

- disable RT_PUSH_IPI if booted on UP. After all there is not much
  benefit here, is there?

- make a requirement for working arch_send_call_function_single_ipi()
  but I guess invoking code for no reason make no sense.

Sebastian
