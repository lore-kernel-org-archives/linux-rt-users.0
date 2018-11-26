From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
Date: Mon, 26 Nov 2018 22:03:32 +0900
Message-ID: <20181126220332.215b461779d1d57f37b46e20@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 14 Nov 2018 14:18:06 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case verifying the basic functionality of the
> hist:snapshot() action.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../inter-event/trigger-snapshot-action-hist.tc    | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> new file mode 100644
> index 000000000000..a0a51e6a6a0c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger snapshot action
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f snapshot ]; then
> +    echo "snapshot is not supported"
> +    exit_unsupported
> +fi
> +
> +grep -q "onchange(var)" README > /dev/null || exit_unsupported # version issue
> +
> +grep -q "snapshot()" README > /dev/null || exit_unsupported # version issue

"grep -q ... > /dev/null" is redundant, since -q doesn't show anything.
please drop "> /dev/null" redirection.

> +
> +echo "Test snapshot action"
> +
> +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +
> +echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

This tests onchange().snapshot(), but document change only describes onmax().snapshot().
Maybe we should improve document too.

> +
> +ping $LOCALHOST -c 3
> +nice -n 1 ping $LOCALHOST -c 3
> +
> +echo 0 > /sys/kernel/debug/tracing/events/sched/enable

Shouldn't we stop tracing instead of disabling the event?

Thank you,

> +
> +if ! grep -q "changed:" events/sched/sched_waking/hist; then
> +    fail "Failed to create onchange action inter-event histogram"
> +fi
> +
> +if ! grep -q "comm=ping" snapshot; then
> +    fail "Failed to create snapshot action inter-event histogram"
> +fi
> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
