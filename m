From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH 1/3] tracing: Added hardware latency tracer
Date: Fri, 5 Aug 2016 17:28:33 +0200
Message-ID: <866492b0-182c-4810-e738-6d19605c858f@linutronix.de>
References: <20160804145708.158968389@goodmis.org>
 <20160804145839.856286626@goodmis.org> <20160805142521.GA21312@linutronix.de>
 <20160805104413.781611b5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160805104413.781611b5@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/05/2016 04:44 PM, Steven Rostedt wrote:
> On Fri, 5 Aug 2016 16:25:21 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
>> * Steven Rostedt | 2016-08-04 10:57:09 [-0400]:
>>
>>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>>> new file mode 100644
>>> index 000000000000..08dfabe4e862
>>> --- /dev/null
>>> +++ b/kernel/trace/trace_hwlat.c  
>> …
>>> +/* Macros to encapsulate the time capturing infrastructure */
>>> +#define time_type	u64
>>> +#define time_get()	trace_clock_local()
>>> +#define time_to_us(x)	div_u64(x, 1000)
>>> +#define time_sub(a, b)	((a) - (b))
>>> +#define init_time(a, b)	(a = b)
>>> +#define time_u64(a)	a  
>>
>> Do we need a macro for this? In the old code we could choose between
>> CONFIG_TRACING but now we don't.
>>
> 
> Probably not, I kept it for two reasons. 1) to keep the same logic as
> what was in PREEMPT_RT, and 2) in case we can come up with a better
> clock.

I assumed it was a leftover.

> But it's not that important. Should it be nuked? They do somewhat make
> the code easier to read.

that time_get() is close to ktime_get() which is almost u64 nowadays.
So it might not be that cool for upstream. A hwlat prefix makes the
whole thing not prettier.

1. PREEMPT_RT. Do I need any changes? I assumed I could keep this 1:1
   (once it is merged) and throw the current hwlat out.
2. a better clock is an argument. But why would you have a better clock
   for hwlat and not for the whole tracing infrastructure?

If you want to keep it, keep it. I just assumed it was a leftover.
> 
> -- Steve

Sebastian
