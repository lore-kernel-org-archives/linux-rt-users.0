From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 8/8] trace: Add alternative synthetic event trace
 action syntax
Date: Wed, 19 Sep 2018 08:54:47 +0900
Message-ID: <20180919085447.53b1e87f4c76fdb38bf5ad98@kernel.org>
References: <cover.1536605847.git.tom.zanussi@linux.intel.com>
        <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
        <20180919035446.4fb6b856ab51229984eb2736@kernel.org>
        <1537298203.11628.8.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537298203.11628.8.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Tue, 18 Sep 2018 14:16:43 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Wed, 2018-09-19 at 03:54 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Mon, 10 Sep 2018 14:10:46 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Add a 'trace(synthetic_event_name, params)' alternative to
> > > synthetic_event_name(params).
> > > 
> > > Currently, the syntax used for generating synthetic events is to
> > > invoke synthetic_event_name(params) i.e. use the synthetic event
> > > name
> > > as a function call.
> > > 
> > > Users requested a new form that more explicitly shows that the
> > > synthetic event is in effect being traced.  In this version, a new
> > > 'trace()' keyword is used, and the synthetic event name is passed
> > > in
> > > as the first argument.
> > 
> > Hmm, what is the advantage of adding this new form?
> > 
> 
> There's no real advantage other than user preference - Namhyung thought
> that since the event-name-as-function-call actions are all defined as
> ACTION_TRACE, there should also be an explicit 'trace' action.

Ah, got it. Would this needs documentation and testcase update too?

> 
> So I added it as alternative syntax - the event-name-as-function-call
> form remains unchanged.
> 
> By the way, I also have a patch implementing your alternative syntax
> change, where if you have only one handler, you can do away with the
> explicit action.handler form e.g.
> 
>   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-ts0: \
>     onmax($wakeup_lat): \
>     save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):snapshot() \

Hmm, in this case, I think comma-connected syntax will be clearer when
the action is kicked.

     onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,prev_comm),snapshot()

any thought?

Thank you,

>     if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> It just wasn't ready to go in with the v4 patches yet, so I decided
> to submit it later as a follow-on.
> 
> Tom
> 
> 
> > Thanks,
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
