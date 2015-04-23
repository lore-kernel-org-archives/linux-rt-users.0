From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 21:51:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504232148520.13914@nanos>
References: <20150423190825.714359844@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423190825.714359844@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015, Steven Rostedt wrote:
> This is the port of the hardware latency detector from the -rt patch
> to mainline. Instead of keeping it as a device that had its own debugfs
> filesystem infrastructure, it made more sense to make it into a tracer
> like irqsoff and wakeup latency tracers currently are.
> 
> With this patch set, a new tracer is enabled if CONFIG_HWLAT_TRACER is
> enabled. Inside the available_tracers file will be hwlat_detector.
> 
>  # cd /sys/kernel/debug/tracing
>  # echo hwlat_detector > current_tracer
> 
> will enable the hwlat_detector that will create per cpu kernel threads
> (which cpus is defined by the tracing/hwlat_detector/cpumask, default
>  is just CPU 0).
> 
> Like the other tracers (function, function_graph, preemptirqsoff,
> and mmiotracer), the hwlat_detector can add a significant performance
> penalty when enabled. As each of the threads created will go into a spin
> checking the trace_local_clock (sched_clock) for any gaps of time
> and will report them if they are greater than the threshold defined
> by tracing/tracing_thresh (usecs, default 10). The spin is performed with
> interrupts disabled and runs for "width" usecs in "window" usecs time. The

That's fine, but this still lacks a detection of NMI
disturbance. We've seen false positives reported over and over when
stuff like the NMI watchdog or perf was enabled while running this.

Aside of that isn't there a way to detect SMI crap with performance
counters on recent hardware?

Thanks,

	tglx
