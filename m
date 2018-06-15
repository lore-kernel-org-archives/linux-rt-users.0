From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Date: Fri, 15 Jun 2018 11:18:06 -0700
Message-ID: <20180615181806.GA60478@joelaf.mtv.corp.google.com>
References: <20180615010113.127718-1-joel@joelfernandes.org>
 <20180615121603.33007151@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Fernandes <joelaf@google.com>, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org,
        mathieu.desnoyers@efficios.com, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615121603.33007151@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jun 15, 2018 at 12:16:03PM -0400, Steven Rostedt wrote:
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
> > echo 1 > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/enable
> > 
> > With the patch, the stacktrace is triggered only if the filter checks
> > passed. It also seems sensible to call triggers only if filter checks
> > pass so lets do that.
> 
> No, it worked as expected. The filter is only to be used it the event
> should be recorded or not. What you wanted to do is:
> 
>  echo 'stacktrace if lat > 400' > events/synthetic/preemptdisable/trigger

Thanks, that worked!

I was thinking at some point we should add these synthetic event 'recipes' to
the kernel tree as scripts or documentation, or something like that. Do you
have any suggestions on where to add these? A recipe would be 'report
preemptoff times > threshold us' or 'wake up latency > threshold us'. I think
there will be quite a few such useful ones.

Another idea could be to make the 'recipes' a part of ftrace itself.
Something like a 'built in' synthetic event that will set itself up when its
enabled without needing to create the hist triggers and other triggers
explicitly. Thoughts?

thanks!

 - Joel

PS: Your reply also went a weird address (barclay something) on CC. Wondering
what happened. The headers in my original email seemed correct. I have
included back the CC list.
