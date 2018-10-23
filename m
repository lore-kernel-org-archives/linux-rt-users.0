From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v6 10/15] tracing: Add hist trigger snapshot() action
 test case
Date: Tue, 23 Oct 2018 16:32:07 -0500
Message-ID: <1540330327.6502.13.camel@kernel.org>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
         <75db4ded21471580e5ad8d57c74fd9c8923cd90a.1539288364.git.tom.zanussi@linux.intel.com>
         <20181024000342.d1e82a160a5efecdb9c0d4f5@kernel.org>
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
In-Reply-To: <20181024000342.d1e82a160a5efecdb9c0d4f5@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Wed, 2018-10-24 at 00:03 +0900, Masami Hiramatsu wrote:
> On Thu, 11 Oct 2018 16:02:07 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying the basic functionality of the
> > hist:snapshot() action.
> > 
> 
> I think this is OK for current tracing tree, but for next kernel
> version
> you may need to update it (against the kselftest tree)
> 

OK.

> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../inter-event/trigger-snapshot-action-hist.tc    | 55
> > ++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > snapshot-action-hist.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > new file mode 100644
> > index 000000000000..f427be989296
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > @@ -0,0 +1,55 @@
> > +#!/bin/sh
> > +# description: event trigger - test inter-event histogram trigger
> > snapshot action
> > +
> > +do_reset() {
> > +    reset_trigger
> > +    echo > set_event
> > +    echo 0 > snapshot
> > +    clear_trace
> > +}
> > +
> > +fail() { #msg
> > +    do_reset
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
> > +grep "onchange(var)" README > /dev/null || exit_unsupported #
> > version issue
> 
> grep -q will be better.
> 
> > +
> > +grep "snapshot()" README > /dev/null || exit_unsupported # version
> > issue
> 
> Ditto.
> 
> > +
> > +reset_tracer
> > +do_reset
> 
> Depends on the merge timing, but I already moved this kind of "reset 
> before/after test" into initialize_ftrace(), so you don't need
> do_reset()
> here. It is required only if you reset tracer in between tests.
> 

OK, good to know, thanks.  At this point it probably will be the next
kernel version, so will make all the suggested changes for that
version.

> > +
> > +echo "Test snapshot action"
> > +
> > +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> > +
> > +echo
> > 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onc
> > hange($newprio).snapshot() if comm=="ping"' >>
> > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> > +
> > +ping localhost -c 3
> > +nice -n 1 ping localhost -c 3
> 
> Ditto. please use $LOCALHOST if you send this to the latest tree.
> 
> http://lkml.kernel.org/r/153563862993.29700.6436770573173736555.stgit
> @devbox
> 

OK, thanks for pointing that out.

> > +
> > +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> > +
> > +if ! grep -q "changed:" events/sched/sched_waking/hist; then
> > +    fail "Failed to create onchange action inter-event histogram"
> > +fi
> > +
> > +if ! grep -q "comm=ping" snapshot; then
> > +    fail "Failed to create snapshot action inter-event histogram"
> > +fi
> > +
> > +do_reset
> 
> Also you don't need this.
> 
> 
> BTW, are there no "expected fail" tests? (e.g. passing wrong snapshot
> command to trigger)
> 

Good point, will add an expected fail for snapshot and not
onmax/onchange.

Thanks,

Tom

> Thank you,
> 
> > +
> > +exit 0
> > -- 
> > 2.14.1
> > 
> 
> 
