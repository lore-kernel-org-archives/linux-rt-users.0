From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH - sort of] x86: Livelock in handle_pte_fault
Date: Wed, 22 May 2013 09:32:05 +0200
Message-ID: <519C7475.5080400@meduna.org>
References: <5195ED8B.7060002@meduna.org> <1369183168.6828.168.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	riel <riel@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369183168.6828.168.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 22.05.2013 02:39, Steven Rostedt wrote:

> The threads do a mlockall too right? I'm not sure mlock will lock memory
> for a new thread's stack.

They don't. However,
https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memory_locking_and_stack_handling_example
claims

  "Threads started after a call to mlockall(MCL_CURRENT | MCL_FUTURE) will
  generate page faults immediately since the new stack is immediately forced
  to RAM (due to the MCL_FUTURE flag)."

and as the ps -o min_flt reports zero page faults for the threads
so I think it is also the case.

Anyway, both particular addresses were surely mapped long before
the fault.

>> - the application runs with mlockall()
> 
> With both MCL_FUTURE and MCL_CURRENT set, right?

Yes.

>> - there is no swap
> 
> Hmm, doesn't mean that code can't be swapped out, as it is just mapped
> from the file it came from. But you'd think mlockall would prevent that.

mlockall also forces the stack to be mapped immediately and not
generating pagefaults when incrementally expanding.

> Seems a bit extreme. Looks to me there's a missing flush TLB somewhere.

Probably.

One interesting thing: the test for "need to reload something"
looks a bit differently for the ARM architecture in
arch/arm/include/asm/mmu_context.h:

  if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {

and they do something also for the
  !CONFIG_SMP && !cpumask_test_and_set_cpu(cpu, mm_cpumask(next)
case. I don't know what exactly is semantics of mm_cpumask,
but the difference is suspicious.

> Do you have a reproducer you can share. That way, maybe we can all share
> the joy.

Unfortunately not and I have really tried :( If I get new ideas, I will
try again.

Thanks
-- 
                                                   Stano
