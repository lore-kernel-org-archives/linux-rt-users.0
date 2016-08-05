From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH 4/3] tracing: Add NMI tracing in hwlat detector
Date: Fri, 5 Aug 2016 17:40:43 +0200
Message-ID: <903851a5-68a6-acaa-6604-c63f6aa11b4c@linutronix.de>
References: <20160804145708.158968389@goodmis.org>
 <20160804125618.6db9b5b3@gandalf.local.home>
 <20160804131645.1ba3244a@gandalf.local.home>
 <20160805143555.GB21312@linutronix.de>
 <20160805105207.16e26a41@gandalf.local.home>
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
In-Reply-To: <20160805105207.16e26a41@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/05/2016 04:52 PM, Steven Rostedt wrote:
>>> --- a/kernel/trace/trace_hwlat.c
>>> +++ b/kernel/trace/trace_hwlat.c
>>> @@ -64,6 +64,15 @@ static struct dentry *hwlat_sample_window;	/* sample window us */
>>> /* Save the previous tracing_thresh value */
>>> static unsigned long save_tracing_thresh;
>>>
>>> +/* NMI timestamp counters */
>>> +static u64 nmi_ts_start;
>>> +static u64 nmi_total_ts;
>>> +static int nmi_count;
>>> +static int nmi_cpu;  
>>
>> and this is always limited to one CPU at a time?
> 
> Yes. Hence the "nmi_cpu".

I was just confused. So we check one CPU at a time. Okay.

>>> @@ -125,6 +138,19 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
>>> #define init_time(a, b)	(a = b)
>>> #define time_u64(a)	a
>>>
>>> +void trace_hwlat_callback(bool enter)
>>> +{
>>> +	if (smp_processor_id() != nmi_cpu)
>>> +		return;
>>> +
>>> +	if (enter)
>>> +		nmi_ts_start = time_get();  
>>
>> but more interestingly: trace_clock_local() -> sched_clock()
>> and of kernel/time/sched_clock.c we do raw_read_seqcount(&cd.seq) which
>> means we are busted if the NMI triggers during update_clock_read_data().
> 
> Hmm, interesting. Because this is true for general tracing from an NMI.
> 
> /me looks at code.
> 
> Ah, this is when we have GENERIC_SCHED_CLOCK, which would break tracing
> if any arch that has this also has NMIs. Probably need to look at arm64.

arm64 should use the generic code as they don't provide sched_clock()
(and I doubt they go for the weak jiffy version).

> For x86, it has its own NMI safe sched_clock. I could make this "NMI"
> code depend on:
> 
> #ifndef CONFIG_GENERIC_SCHED_CLOCK

that would be nice. That would be disable approx $(git grep
sched_clock_register | wc -l) users but better than a lock up I guess.

> 
> -- Steve

Sebastian
