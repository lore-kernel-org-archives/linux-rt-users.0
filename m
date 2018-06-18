From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Date: Sun, 17 Jun 2018 17:15:45 -0700
Message-ID: <20180618001545.GA187086@joelaf.mtv.corp.google.com>
References: <20180615010113.127718-1-joel@joelfernandes.org>
 <20180616224329.02e37ef4aee72c7d5685818e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        namhyung@kernel.org, mathieu.desnoyers@efficios.com,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>, peterz@infradead.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180616224329.02e37ef4aee72c7d5685818e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Jun 16, 2018 at 10:43:29PM +0900, Masami Hiramatsu wrote:
> On Thu, 14 Jun 2018 18:01:13 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Currently, trace event triggers are called regardless of if the event
> > filter checks pass or fail. Thus if one were to enable event triggers
> > and filters at the same time, then the triggers will always be called
> > even if the filter checks didn't pass.
> > 
> > This is a problem for a usecase I was experimenting with: measuring the
> > time preemption is disabled using synthetic events and dump the stack
> > using the stacktrace trigger if the total preempt off time was greater
> > than a threshold. Following are the commands for the same:
> > 
> > Create synthetic event:
> > 
> > echo 'preemptdisable u64 lat' >> \
> > 	      /sys/kernel/debug/tracing/synthetic_events
> > 
> > echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
> > 	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger
> > 
> > echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
> > onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
> > 	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger
> > 
> > Enable synthetic event:
> > 
> > echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> > echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
> 
> Have you tried if statement as below?
> 
> echo "stacktrace if lat > 400" > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> 

Yes I tried this and it works, thanks!

Steven also suggested the same thing in his reply as well.

thanks,

 - Joel
