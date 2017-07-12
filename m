From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 00/32] tracing: Inter-event (e.g. latency) support
Date: Wed, 12 Jul 2017 14:17:38 -0500
Message-ID: <1499887058.3995.28.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <CAEi0qN=FNd056iBufikmRuuVLUPZbsYH=bAZNVnaOmRVjoQHuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEi0qN=FNd056iBufikmRuuVLUPZbsYH=bAZNVnaOmRVjoQHuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Joel,

Sorry for the delayed reply, was out for the holidays..

On Sat, 2017-07-01 at 00:01 -0700, Joel Fernandes (Google) wrote:
> Hi Tom,
> Nice series and nice ELC talk as well. Thanks.
> 
> On Mon, Jun 26, 2017 at 3:49 PM, Tom Zanussi
> <tom.zanussi@linux.intel.com> wrote:
> > This patchset adds support for 'inter-event' quantities to the trace
> > event subsystem.  The most important example of inter-event quantities
> > are latencies, or the time differences between two events.
> 
> I tried your patches out and they are working fine for me. I will test
> them out more.
> 
> I think for the wakeup latency in your examples, its better / more
> accurate to use sched_waking instead of sched_wakeup tracepoint? [1]
> 

Yeah, makes sense - thanks for pointing it out.

> Also, one other comment I had is, it would be nice to suppress the
> output of individual trace events that are part of the synthetic event
> into the trace buffer. Otherwise I feel the value of it is slightly
> diminished - because one can simply post-process the individual
> non-synthetic trace events themselves to get wake up latencies which
> the synthetic events is trying to calculate in the first place.
> Inorder to conserve space, if a user doesn't care about individual
> events, and just the synthetic events then the individual ones
> shouldn't be written to the trace buffer IMO.
> 

Yes, you're right, this is also something I need to fix.  I added a flag
to avoid discards, but this has the effect of, well, avoiding discards,
so unwanted events appear in the trace buffer.  Also, regardless, any
trigger that exists simply to provide input to a synthetic event should
be filtered out, regardless of the enable state.  I'll have to think
about a better way do handle all this...

Thanks,

Tom

> -Joel
> 
> [1] commit fbd705a0c6184580d0e2fbcbd47a37b6e5822511 (sched: Introduce
> the 'trace_sched_waking' tracepoint)
