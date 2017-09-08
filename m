From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 28/40] tracing: Add support for 'field variables'
Date: Fri, 08 Sep 2017 10:37:28 -0500
Message-ID: <1504885048.13310.45.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <af32f8a5f2cfc345dc2b3d34d38400a9d81bd1e4.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907194352.7c003f7f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907194352.7c003f7f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-09-07 at 19:43 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:40 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Users should be able to directly specify event fields in hist trigger
> > 'actions' rather than being forced to explicitly create a variable for
> > that purpose.
> > 
> > Add support allowing fields to be used directly in actions, which
> > essentially does just that - creates 'invisible' variables for each
> > bare field specified in an action.  If a bare field refers to a field
> > on another (matching) event, it even creates a special histogram for
> > the purpose (since variables can't be defined on an existing histogram
> > after histogram creation).
> 
> Can you show some examples here to describe what you mean better?
> 

Yeah, I guess that description is pretty opaque without an example.

Here's a simple example that demonstrates both.  Basically the onmatch()
action creates a list of variables corresponding to the parameters of
the synthetic event to be generated, and then uses those values to
generate the event.  So for the wakeup_latency synthetic event 'call'
below the first param, $wakeup_lat, is a variable defined explicitly on
sched_switch, where 'next_pid' is just a normal field on sched_switch,
and prio is a normal field on sched_waking.

Since the mechanism works on variables, those two normal fields just
have 'invisible' variables created internally for them.  In the case of
'prio', which is on another event, we actually need to create an
additional hist trigger and define the invisible event on that, since
once a hist trigger is defined, variables can't be added to it later.

echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> /sys/kernel/debug/tracing/synthetic_events

echo 'hist:keys=pid:ts0=$common_timestamp.usecs >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:
      onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,prio)
      >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

Anyway, I just tested it and a recent change broke the latter case, will
add the fix to v3.

Tom 
