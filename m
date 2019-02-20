From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Date: Wed, 20 Feb 2019 11:38:22 -0600
Message-ID: <1550684302.2027.6.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
         <20190220121748.7aa83459@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220121748.7aa83459@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Wed, 2019-02-20 at 12:17 -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 17:42:55 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying that basic action combinations fail as
> > expected.
> > 
> 
> Hi Tom,
> 
> This test appears to fail:
> 
> # echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'
> >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> -bash: echo: write error: Invalid argument
> 
> # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist 
> 
> ERROR: action parsing: Handler doesn't support action: save
>   Last command: keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)
> 
> 
> Is the "save" feature implemented here? It's in the README too.
> Should
> it be removed?
> 

The "save" feature is implemented, but it's not currently supported
with onmatch(), which is why it fails, and is used in the xfail test,
since it's expected to.  So, in this case, the command fails, which
means the xfail test actually passed.  ;-)

There are other tests in the inter-event testcases that use save() but
with onmax() and onchange(), and they pass.

Hope that explains things in this case,

Tom

> -- Steve
> 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../inter-event/trigger-action-hist-xfail.tc       | 30
> > ++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > action-hist-xfail.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-action-hist-xfail.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-action-hist-xfail.tc
> > new file mode 100644
> > index 000000000000..1221240f8cf6
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-action-hist-xfail.tc
> > @@ -0,0 +1,30 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test inter-event histogram trigger
> > expected fail actions
> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +if [ ! -f set_event ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f snapshot ]; then
> > +    echo "snapshot is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +grep -q "snapshot()" README || exit_unsupported # version issue
> > +
> > +echo "Test expected snapshot action failure"
> > +
> > +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >>
> > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger &&
> > exit_fail
> > +
> > +echo "Test expected save action failure"
> > +
> > +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'
> > >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger &&
> > exit_fail
> > +
> > +exit_xfail
> 
> 
