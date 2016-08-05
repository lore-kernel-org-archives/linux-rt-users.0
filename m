From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/3] tracing: Add NMI tracing in hwlat detector
Date: Fri, 5 Aug 2016 10:52:07 -0400
Message-ID: <20160805105207.16e26a41@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
	<20160804125618.6db9b5b3@gandalf.local.home>
	<20160804131645.1ba3244a@gandalf.local.home>
	<20160805143555.GB21312@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160805143555.GB21312@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 5 Aug 2016 16:35:55 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2016-08-04 13:16:45 [-0400]:
> 
> >diff --git a/include/linux/ftrace_irq.h b/include/linux/ftrace_irq.h
> >index dca7bf8cffe2..4ec2c9b205f2 100644
> >--- a/include/linux/ftrace_irq.h
> >+++ b/include/linux/ftrace_irq.h
> >@@ -3,11 +3,34 @@  
> …
> >+static inline void ftrace_nmi_enter(void)
> >+{
> >+#ifdef CONFIG_HWLAT_TRACER
> >+	if (trace_hwlat_callback_enabled)
> >+		trace_hwlat_callback(true);  
> 
> so we take a tracepoint while we enter an nmi

It's not technically a tracepoint. I'm not sure tracepoints
(jumplabels) may be located this early in the NMI handler. This is
before some of the magic of having NMIs dealing with page faults and
break points.

> 
> >--- a/kernel/trace/trace_hwlat.c
> >+++ b/kernel/trace/trace_hwlat.c
> >@@ -64,6 +64,15 @@ static struct dentry *hwlat_sample_window;	/* sample window us */
> > /* Save the previous tracing_thresh value */
> > static unsigned long save_tracing_thresh;
> > 
> >+/* NMI timestamp counters */
> >+static u64 nmi_ts_start;
> >+static u64 nmi_total_ts;
> >+static int nmi_count;
> >+static int nmi_cpu;  
> 
> and this is always limited to one CPU at a time?

Yes. Hence the "nmi_cpu".

> 
> …
> >@@ -125,6 +138,19 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
> > #define init_time(a, b)	(a = b)
> > #define time_u64(a)	a
> > 
> >+void trace_hwlat_callback(bool enter)
> >+{
> >+	if (smp_processor_id() != nmi_cpu)
> >+		return;
> >+
> >+	if (enter)
> >+		nmi_ts_start = time_get();  
> 
> but more interestingly: trace_clock_local() -> sched_clock()
> and of kernel/time/sched_clock.c we do raw_read_seqcount(&cd.seq) which
> means we are busted if the NMI triggers during update_clock_read_data().

Hmm, interesting. Because this is true for general tracing from an NMI.

/me looks at code.

Ah, this is when we have GENERIC_SCHED_CLOCK, which would break tracing
if any arch that has this also has NMIs. Probably need to look at arm64.

For x86, it has its own NMI safe sched_clock. I could make this "NMI"
code depend on:

#ifndef CONFIG_GENERIC_SCHED_CLOCK


-- Steve


> 
> >+	else {
> >+		nmi_total_ts = time_get() - nmi_ts_start;
> >+		nmi_count++;
> >+	}
> >+}  
> 
> Sebastian
