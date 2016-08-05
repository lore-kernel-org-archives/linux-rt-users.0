From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH 1/3] tracing: Added hardware latency tracer
Date: Fri, 5 Aug 2016 16:25:21 +0200
Message-ID: <20160805142521.GA21312@linutronix.de>
References: <20160804145708.158968389@goodmis.org>
 <20160804145839.856286626@goodmis.org>
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
In-Reply-To: <20160804145839.856286626@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2016-08-04 10:57:09 [-0400]:

>diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>new file mode 100644
>index 000000000000..08dfabe4e862
>--- /dev/null
>+++ b/kernel/trace/trace_hwlat.c
…
>+/* Macros to encapsulate the time capturing infrastructure */
>+#define time_type	u64
>+#define time_get()	trace_clock_local()
>+#define time_to_us(x)	div_u64(x, 1000)
>+#define time_sub(a, b)	((a) - (b))
>+#define init_time(a, b)	(a = b)
>+#define time_u64(a)	a

Do we need a macro for this? In the old code we could choose between
CONFIG_TRACING but now we don't.

Sebastian
