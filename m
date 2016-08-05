From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH 4/3] tracing: Add NMI tracing in hwlat detector
Date: Fri, 5 Aug 2016 16:35:55 +0200
Message-ID: <20160805143555.GB21312@linutronix.de>
References: <20160804145708.158968389@goodmis.org>
 <20160804125618.6db9b5b3@gandalf.local.home>
 <20160804131645.1ba3244a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160804131645.1ba3244a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2016-08-04 13:16:45 [-0400]:

>diff --git a/include/linux/ftrace_irq.h b/include/linux/ftrace_irq.h
>index dca7bf8cffe2..4ec2c9b205f2 100644
>--- a/include/linux/ftrace_irq.h
>+++ b/include/linux/ftrace_irq.h
>@@ -3,11 +3,34 @@
…
>+static inline void ftrace_nmi_enter(void)
>+{
>+#ifdef CONFIG_HWLAT_TRACER
>+	if (trace_hwlat_callback_enabled)
>+		trace_hwlat_callback(true);

so we take a tracepoint while we enter an nmi

>--- a/kernel/trace/trace_hwlat.c
>+++ b/kernel/trace/trace_hwlat.c
>@@ -64,6 +64,15 @@ static struct dentry *hwlat_sample_window;	/* sample window us */
> /* Save the previous tracing_thresh value */
> static unsigned long save_tracing_thresh;
> 
>+/* NMI timestamp counters */
>+static u64 nmi_ts_start;
>+static u64 nmi_total_ts;
>+static int nmi_count;
>+static int nmi_cpu;

and this is always limited to one CPU at a time?

…
>@@ -125,6 +138,19 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
> #define init_time(a, b)	(a = b)
> #define time_u64(a)	a
> 
>+void trace_hwlat_callback(bool enter)
>+{
>+	if (smp_processor_id() != nmi_cpu)
>+		return;
>+
>+	if (enter)
>+		nmi_ts_start = time_get();

but more interestingly: trace_clock_local() -> sched_clock()
and of kernel/time/sched_clock.c we do raw_read_seqcount(&cd.seq) which
means we are busted if the NMI triggers during update_clock_read_data().

>+	else {
>+		nmi_total_ts = time_get() - nmi_ts_start;
>+		nmi_count++;
>+	}
>+}

Sebastian
