From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 0/6] tracing: trace event error_log and inter-event
 bugfixes
Date: Wed, 16 Jan 2019 09:42:35 -0600
Message-ID: <e885d1fd02e76f121d6cc2bb28e58b523e2434a7.camel@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
         <20190115223126.366d854c@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115223126.366d854c@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Tue, 2019-01-15 at 22:31 -0500, Steven Rostedt wrote:
> Hi Tom,
> 
> This thread sorta died and appears to be forgotten. Is there follow
> up
> patches on this?
> 

No, there wasn't a followup v2 for this - the last suggestion was that
we'd discuss this face-to-face at Plumbers, but I didn't get to go to
Plumbers...

Anyway, there were some good suggestions in the thread - let me spin up
a v2 that incorporates them, and we can go from there.

Tom

> Thanks!
> 
> -- Steve
> 
> 
> On Thu, 12 Apr 2018 10:13:15 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi Steve,
> > 
> > Here are a few patches that should be applied on top of the
> > 'Inter-event (e.g. latency) support v9' patchset.
> > 
> > The first fixes another problem I noticed when printing flags.
> > 
> > The rest implement the tracing/events/error_log suggested by
> > Masami,
> > and update the inter-event code to use it (and remove the old hist
> > file error mechanism).
> > 
> > Thanks,
> > 
> > Tom
> > 
> > The following changes since commit
> > 404bb11b24fb9a592023c077b878d30ad6da4322:
> > 
> >   tracing: Enforce passing in filter=NULL to create_filter() (2018-
> > 04-11 11:18:42 -0400)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/tzanussi/linux-trace-inter-event.git
> > tzanussi/inter-event-update2
> >   
> > https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update2
> > 
> > Tom Zanussi (6):
> >   tracing: Restore proper field flag printing when displaying
> > triggers
> >   tracing: Add trace event error log
> >   tracing: Save the last hist command's associated event name
> >   tracing: Use trace event error_log with hist triggers
> >   tracing: Add field parsing trace event errors for hist triggers
> >   selftests: ftrace: Fix extended error support testcase
> > 
> >  kernel/trace/trace.h                               |   3 +
> >  kernel/trace/trace_events.c                        | 172
> > +++++++++++++++++++
> >  kernel/trace/trace_events_hist.c                   | 188
> > +++++++++++----------
> >  .../inter-event/trigger-extended-error-support.tc  |   2 +-
> >  4 files changed, 274 insertions(+), 91 deletions(-)
> > 
> 
> 
