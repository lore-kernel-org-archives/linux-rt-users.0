From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
Date: Tue, 27 Nov 2018 16:53:45 -0600
Message-ID: <1543359225.4223.5.camel@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
         <20181126220332.215b461779d1d57f37b46e20@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126220332.215b461779d1d57f37b46e20@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Mon, 2018-11-26 at 22:03 +0900, Masami Hiramatsu wrote:
> On Wed, 14 Nov 2018 14:18:06 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying the basic functionality of the
> > hist:snapshot() action.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../inter-event/trigger-snapshot-action-hist.tc    | 43
> > ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > snapshot-action-hist.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > new file mode 100644
> > index 000000000000..a0a51e6a6a0c
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > @@ -0,0 +1,43 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test inter-event histogram trigger
> > snapshot action
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
> > +grep -q "onchange(var)" README > /dev/null || exit_unsupported #
> > version issue
> > +
> > +grep -q "snapshot()" README > /dev/null || exit_unsupported #
> > version issue
> 
> "grep -q ... > /dev/null" is redundant, since -q doesn't show
> anything.
> please drop "> /dev/null" redirection.
> 
> > +
> > +echo "Test snapshot action"
> > +
> > +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> > +
> > +echo
> > 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onc
> > hange($newprio).snapshot() if comm=="ping"' >>
> > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> 
> This tests onchange().snapshot(), but document change only describes
> onmax().snapshot().
> Maybe we should improve document too.
> 

Yes, good point, will do.

> > +
> > +ping $LOCALHOST -c 3
> > +nice -n 1 ping $LOCALHOST -c 3
> > +
> > +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> 
> Shouldn't we stop tracing instead of disabling the event?
> 

This is just reversing the enable, so should be fine, but I can stop
tracing instead if you prefer.

Thanks,

Tom
