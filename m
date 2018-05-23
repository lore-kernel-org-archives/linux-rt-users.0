From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 14/14] tracing/selftest: Add test to test hist
 trigger between kernel event and trace_marker
Date: Wed, 23 May 2018 23:15:59 +0900
Message-ID: <20180523231559.fdc6c528b49ce9764a0ceda5@kernel.org>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.411972764@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516150201.411972764@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 May 2018 11:00:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test that tests a trigger that is initiated by a kernel event
> (sched_waking) and compared to a write to the trace_marker.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../trigger/trigger-trace-marker-synthetic.tc | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> index 3666dd6ab02a..b06996ecd5e0 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> @@ -31,6 +31,11 @@ if [ ! -d events/ftrace/print ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -d events/sched/sched_waking ]; then
> +    echo "event sched_waking is not supported"
> +    exit_unsupported
> +fi

Hmm, this looks no good sign... Can you split this out to another testcase,
since this check is only for new test case below?

[..]
> @@ -63,4 +68,21 @@ grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
>  
>  do_reset
>  
> +echo "Test histogram kernel event to trace_marker latency histogram trigger"
> +
> +echo 'latency u64 lat' > synthetic_events
> +echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
> +echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
> +echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
> +sleep 1
> +echo "hello" > trace_marker
> +
> +grep 'hitcount: *1$' events/ftrace/print/hist > /dev/null || \
> +    fail "hist trigger did not trigger correct times on trace_marker"
> +
> +grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
> +    fail "hist trigger did not trigger "
> +
> +do_reset
> +

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
