From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH v2 0/5] tracing: common error_log for ftrace
Date: Thu, 14 Feb 2019 12:13:57 +0900
Message-ID: <20190214121357.727a0f34246b51e6660354bc@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

Thank you for your great work!

On Wed, 13 Feb 2019 12:17:51 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Last April, I posted an RFC patchset [1] implementing a common
> error_log interface as suggested by Masami [2].  We were supposed to
> discuss it at Plumbers but that never happened, and Steve recently
> asked about patches for a follow-on discussion [3], so here they are.
> 
> I incorporated comments from the previous discussion, the most
> important of which are:
> 
>  - Incorporated Steve's suggestion of using static strings as in the
>    existing trace event filter code, along with err_info indexing into
>    the string arrays and a position for the error caret.
> 
>  - Converted all the hist trigger errors and the existing trace event
>    filter parse errors to use the new interface.
> 
>  - Converted a few kprobe_event errors to the new interface as
>    examples, but these will require more work - I didn't spend much
>    time figuring out how to get the full kprobe command into the error
>    info, for instance.
> 
>  - Got rid of the custom single-page ring buffer and used standard
>    lists instead.
> 
> For now, this is implemented on top of the latest 'hist trigger
> snapshot and onchange additions' patchset [4].
> 
> Below is an example session of a few failed commands and the
> corresponding error_log contents:
> 
>   # echo > /sys/kernel/debug/tracing/error_log
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
> 
>   # echo 'hist:key=comm:p=prio:onchange($q).snapshot()' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
> 
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: File exists
> 
>   # echo 'comm="cyclictest"' > /sys/kernel/debug/tracing/events/sched/sched_wakeup/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
> 
>   # echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > /sys/kernel/debug/tracing/events/signal/signal_generate/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>   Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                     ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
>   event filter parse error: error: Field not found
>     Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
>                                               ^  

I like this very much! One point I would like to comment is to add a kind of
entry number tag, so that user distinguish the error message, e.g.

  # cat /sys/kernel/debug/tracing/error_log
  [1] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                    ^
  [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  [3] hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  ...

What would you think?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
