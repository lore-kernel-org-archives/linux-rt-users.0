From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 19:38:40 +0100
Message-ID: <5d1b0eb1-6bf5-7148-a7b0-58ef1e0fd37f@bristot.me>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161107122221.299d026a@tagon> <20161107133046.7e4458c1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107133046.7e4458c1@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/07/2016 07:30 PM, Steven Rostedt wrote:
>> I'm still reviewing the patch, but I have to wonder why bother with making it a scheduler feature?
>> > 
>> > The SCHED_FIFO definition allows a fifo thread to starve others
>> > because a fifo task will run until it yields. Throttling was added as
>> > a safety valve to allow starved SCHED_OTHER tasks to get some cpu
>> > time.  Adding this unconditionally gets us a safety valve for
>> > throttling a badly written fifo task, but allows the fifo task to
>> > continue to consume cpu cycles if it's not starving anyone. 
>> > 
>> > Or am I missing something that's blazingly obvious?
> Or I say make it the default. If people want the old behavior, they can
> modify SCHED_FEATURES to do so.

I added it as a feature to keep the current behavior by default.
Currently, we have two throttling modes:

With RT_RUNTIME_SHARING (default):
  before throttle, try to borrow some runtime from other CPU.

Without RT_RUNTIME_SHARING:
  throttle the RT task, even if there is nothing else to do.

The problem of the first is that an CPU easily borrow enough runtime to
make the spin-rt-task to run forever, allowing the starvation of the
non-rt-tasks, hence invalidating the mechanism.

The problem of the second is that (with the default values) the CPU will
be idle 5% of the time.

IMHO, the balanced behavior is using GREED option + without
RT_RUNTIME_SHARING: the non-rt tasks will be able to run, while avoiding
CPU going idle.

We can turn it by default setting default options.

Moreover, AFAICS, these sched options are static keys, so they are very
very low overhead conditions.

-- Daniel
