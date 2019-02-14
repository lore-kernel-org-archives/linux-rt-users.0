From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH v2 0/5] tracing: common error_log for ftrace
Date: Thu, 14 Feb 2019 09:15:23 -0600
Message-ID: <1550157323.2498.2.camel@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
         <20190214121357.727a0f34246b51e6660354bc@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214121357.727a0f34246b51e6660354bc@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Thu, 2019-02-14 at 12:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> Thank you for your great work!

Thanks!

> 
> On Wed, 13 Feb 2019 12:17:51 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Last April, I posted an RFC patchset [1] implementing a common
> > error_log interface as suggested by Masami [2].  We were supposed
> > to
> > discuss it at Plumbers but that never happened, and Steve recently
> > asked about patches for a follow-on discussion [3], so here they
> > are.
> > 
> > 

[snip]

> >   # cat /sys/kernel/debug/tracing/error_log
> >   hist:sched:sched_wakeup: error: Variable already defined
> >   Command: keys=pid:ts0=common_timestamp.usecs if
> > comm=="cyclictest"
> >                     ^
> >   hist:sched:sched_waking: error: Couldn't find onmax or onchange
> > variable
> >     Command: key=comm:p=prio:onchange($q).snapshot()
> >                                        ^
> >   hist:sched:sched_wakeup: error: Hist trigger already exists
> >     Command: keys=pid
> >              ^
> >   event filter parse error: error: Invalid operator
> >     Command: comm="cyclictest"
> >                   ^
> >   event filter parse error: error: Field not found
> >     Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm !=
> > bash
> >                                               ^  
> 
> I like this very much! One point I would like to comment is to add a
> kind of
> entry number tag, so that user distinguish the error message, e.g.
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if
> comm=="cyclictest"
>                     ^
>   [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange
> variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   [3] hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   ...
> 
> What would you think?
> 

I think that makes sense and would be simple to add - will do in the
next version.

Thanks,

Tom

> Thank you,
> 
