From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: diagnosing unexpected sched_stat_wait
Date: Mon, 7 Mar 2016 11:28:29 -0300
Message-ID: <20160307142829.GC3604@kernel.org>
References: <CAJOrw7was05Absp0UiCVO5mZEoZqXHD-ZNOoDwoG7t1S1DED_A@mail.gmail.com>
 <20160304220531.GB3604@kernel.org>
 <CAJOrw7wUwZmdkMNjB3gHptUR1AFDLXMqt9dAEOFsRcofrbtx6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Jonah Petri <jpetri@izotope.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53493 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcCGO2f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 09:28:35 -0500
Content-Disposition: inline
In-Reply-To: <CAJOrw7wUwZmdkMNjB3gHptUR1AFDLXMqt9dAEOFsRcofrbtx6A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Fri, Mar 04, 2016 at 05:24:56PM -0500, Jonah Petri escreveu:
> Hi, thanks for the reply!
> 
> I have gone down that route, but I don't get user stack traces at all.
>   I suspect this is because I'm on ARM 3.14.52, which does not support
> CONFIG_USER_STACKTRACE_SUPPORT.  Nor does it support
> CONFIG_ARCH_SUPPORTS_UPROBES.

probably the two options above are unrelated, I'm not familiar with
ARM, but I doubt they are required for perf to collect userland
stacktraces.
 
> All that said, I DO get stack traces when using straight perf record
> with "--call-graph dwarf".  (Does that imply "-e cpu-clock"?).  So, I

Ok, good data point, as what 'perf record --callgraph dwarf' does is to
take register and userland stack samples so that later it can use it
together with CFI information from the binaries involved to do the stack
unwinding.

> was hoping that whatever is enabling that event to get stack traces
> might be available to me.

So what you are not managing to do is to collect userland stacktraces
from tracepoints, right?

Any ARM person here to try to help diagnose why this does work on x86_64
but not on ARM?

- Arnaldo
 
> Jonah
> 
> 
> On Fri, Mar 4, 2016 at 5:05 PM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Fri, Mar 04, 2016 at 02:15:25PM -0500, Jonah Petri escreveu:
> >> Hello,
> >>
> >> My application is doing realtime low-latency audio, and we're seeing
> >> occasional dropouts, which we've traced (via ftrace) to an unexplained
> >> sched_stat_wait event on our audio-handling user thread.
> >>
> >> We're really not sure what might be causing this, but if I could get
> >> the user stack trace causing this event, it would let me see exactly
> >> the problem.  Even the top frame of the stack would be invaluable.
> >>
> >> Is there a way to get this info?  Preferrably with ftrace, but any
> >> methods or hints would be much appreciated.
> >
> > [root@jouet ~]# perf list *:sched_stat_wait
> >
> > List of pre-defined events (to be used in -e):
> >
> >   sched:sched_stat_wait                              [Tracepoint event]
> >
> > [root@jouet ~]# perf record -a --call-graph dwarf -e sched:*stat_wait
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 4.157 MB perf.data (763 samples) ]
> >
> > [root@jouet ~]#
> > [root@jouet ~]# perf report --stdio | head -53
> > Failed to open /tmp/perf-7459.map, continuing without symbols
> > no symbols found in /usr/sbin/rngd, maybe install a debug package?
> > # To display the perf.data header info, please use --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 763  of event 'sched:sched_stat_wait'
> > # Event count (approx.): 2027097
> > #
> > # Children      Self  Trace output
> > # ........  ........  ...............................................
> > #
> >      8.94%     8.94%  comm=Xorg pid=2730 delay=181323 [ns]
> >             |
> >             ---entry_SYSCALL_64_fastpath
> >                sys_poll
> >                do_sys_poll
> >                poll_schedule_timeout
> >                schedule_hrtimeout_range
> >                schedule_hrtimeout_range_clock
> >                schedule
> >                __schedule
> >                pick_next_task_fair
> >                set_next_entity
> >                update_stats_wait_end
> >                0x563bfb142909
> >                __libc_start_main
> >                main
> >                meta_run
> >                g_main_loop_run
> >                g_main_context_iterate.isra.29
> >                0x7fb1060a9fdd
> >
> >      4.73%     4.73%  comm=gnome-terminal- pid=3412 delay=95977 [ns]
> >             |
> >             ---entry_SYSCALL_64_fastpath
> >                sys_poll
> >                do_sys_poll
> >                poll_schedule_timeout
> >                schedule_hrtimeout_range
> >                schedule_hrtimeout_range_clock
> >                schedule
> >                __schedule
> >                pick_next_task_fair
> >                set_next_entity
> >                update_stats_wait_end
> >                _start
> >                __libc_start_main
> >                main
> >                g_application_run
> >                g_main_context_iteration
> >                g_main_context_iterate.isra.29
> >                0x7fd2cbd9bfdd
> >
> > [root@jouet ~]#
> >
> > Replace 'record -a' with 'record --pid YOUR-PID' or workload, etc, see:
> >
> > man perf-record
> >
> > If you get some unresolved symbols, install 'gcc -g' built binaries or
> > -debuginfo packages or equivalent in !fedora/RHEL distros.
> >
> > - Arnaldo
