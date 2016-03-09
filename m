From: Yang Shi <yang.shi@windriver.com>
Subject: Re: [v4.4-rt PATCH] rt: trace: add rcuidle version macro for
 preemptirqsoff_hist and hrtimer_interrupt
Date: Wed, 9 Mar 2016 00:23:14 -0800
Message-ID: <56DFDD72.5020807@windriver.com>
References: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
 <56DE88FC.5080500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<tglx@linutronix.de>, <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56DE88FC.5080500@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 3/8/2016 12:10 AM, Sebastian Andrzej Siewior wrote:
> On 03/08/2016 12:45 AM, Yang Shi wrote:
>> diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
>> index 6122e42..37f6eb8 100644
>> --- a/include/trace/events/hist.h
>> +++ b/include/trace/events/hist.h
>> @@ -9,6 +9,7 @@
>>   
>>   #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
>>   #define trace_preemptirqsoff_hist(a, b)
>> +#define trace_preemptirqsoff_hist_rcuidle(a, b)
>>   #else
>>   TRACE_EVENT(preemptirqsoff_hist,
> I have this piece already in my tree.
>
>>   
>> @@ -33,6 +34,7 @@ TRACE_EVENT(preemptirqsoff_hist,
>>   
>>   #ifndef CONFIG_MISSED_TIMER_OFFSETS_HIST
>>   #define trace_hrtimer_interrupt(a, b, c, d)
>> +#define trace_hrtimer_interrupt_rcuidle(a, b, c, d)
>>   #else
>>   TRACE_EVENT(hrtimer_interrupt,
> I was thinking about this but then I saw no users of it. Do we have
> any? (haven't seen them in v4.1 either).

AFAIK, no users.  It got brought in by the forward port of 4.1 patch. We 
could remove it.

Thanks,
Yang

>
> Sebastian
>
