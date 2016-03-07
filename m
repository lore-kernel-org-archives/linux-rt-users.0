From: Yang Shi <yang.shi@windriver.com>
Subject: Re: [4.4-rt PATCH] trace: use rcuidle version for preemptoff_hist
 trace point
Date: Mon, 7 Mar 2016 15:44:53 -0800
Message-ID: <56DE1275.9030309@windriver.com>
References: <1456262603-10075-1-git-send-email-yang.shi@windriver.com>
 <20160307180009.GF12595@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <tglx@linutronix.de>, <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:65214 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190AbcCGXpP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 18:45:15 -0500
In-Reply-To: <20160307180009.GF12595@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 3/7/2016 10:00 AM, Sebastian Andrzej Siewior wrote:
> * Yang Shi | 2016-02-23 13:23:23 [-0800]:
>
>> I recall the rcuidle version is used by 4.1-rt, but not sure why it =
is dropped
>> in 4.4-rt. It looks such fix is still needed.
> I don't recall while I removed it. It was durring v4.1 -> v4.4 port. =
In
> v4.1 we had the idle version only in time_hardirqs_on() + =E2=80=A6_o=
ff(). You
> introduced it also to start_critical_timings() + stop_=E2=80=A6(). Is=
 this
> required?

Yes, the test showed the same problem in start{stop}_critical_timings t=
oo.

> In the meantime I bring back the empty macro of
> trace_preemptirqsoff_hist_rcuidle() back in -RT sine it breaks compil=
e
> latest v4.4.3-RT9

Yes, sorry to forget to bring this in too. The 4.1 patch was submitted=20
by me, but forgot to have it in 4.4.

Yang

>
>> kernel/trace/trace_irqsoff.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqso=
ff.c
>> index 36e584f..069942c 100644
>> --- a/kernel/trace/trace_irqsoff.c
>> +++ b/kernel/trace/trace_irqsoff.c
>> @@ -421,13 +421,13 @@ void start_critical_timings(void)
>> {
>> 	if (preempt_trace() || irq_trace())
>> 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
>> -	trace_preemptirqsoff_hist(TRACE_START, 1);
>> +	trace_preemptirqsoff_hist_rcuidle(TRACE_START, 1);
>> }
>> EXPORT_SYMBOL_GPL(start_critical_timings);
>>
>> void stop_critical_timings(void)
>> {
>> -	trace_preemptirqsoff_hist(TRACE_STOP, 0);
>> +	trace_preemptirqsoff_hist_rcuidle(TRACE_STOP, 0);
>> 	if (preempt_trace() || irq_trace())
>> 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
>> }
> Sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
