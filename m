From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in wakeup_next_waiter()
Date: Wed, 07 Jul 2010 08:05:04 -0700
Message-ID: <4C3497A0.8030807@us.ibm.com>
References: <1278478019.10245.77.camel@marge.simson.net> <4C348B1D.5060008@linux.vnet.ibm.com> <1278513073.10564.12.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:33494 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0GGPFY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 11:05:24 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o67Ev85l004118
	for <linux-rt-users@vger.kernel.org>; Wed, 7 Jul 2010 08:57:08 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id o67F5CQi212008
	for <linux-rt-users@vger.kernel.org>; Wed, 7 Jul 2010 09:05:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o67F58h0003227
	for <linux-rt-users@vger.kernel.org>; Wed, 7 Jul 2010 09:05:09 -0600
In-Reply-To: <1278513073.10564.12.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/07/2010 07:31 AM, Mike Galbraith wrote:
> On Wed, 2010-07-07 at 19:41 +0530, gowrishankar wrote:
>> On Wednesday 07 July 2010 10:16 AM, Mike Galbraith wrote:
>>> Greetings,
>>>
>>> Stress testing, looking to trigger RCU stalls, I've managed to find a
>>> way to repeatably create fireworks.  (got RCU stall, see attached)
>>>
>>> 1. download ltp-full-20100630.  Needs to be this version because of
>>> testcase bustage in earlier versions, and must be built with gcc>   4.3,
>>> else testcases will segfault due to a gcc bug.
>>>
>>>
>> Hi Mike,
>> I have seen this segfault esp with GCC v4.3.4. I am about to post this
>> patch
>> in ltp:
>>
>> Signed-off-by: Gowrishankar<gowrishankar.m@in.ibm.com>
>> ---
>>    testcases/realtime/include/librttest.h |    6 +++---
>>    1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/realtime/include/librttest.h
>> b/testcases/realtime/include/librttest.h
>> index e526ab4..273de6f 100644
>> --- a/testcases/realtime/include/librttest.h
>> +++ b/testcases/realtime/include/librttest.h
>> @@ -118,9 +118,9 @@ static inline int atomic_add(int i, atomic_t *v)
>>           int __i;
>>           __i = i;
>>           asm volatile(
>> -                       "lock; xaddl %0, %1;"
>> -                       :"=r"(i)
>> -                       :"m"(v->counter), "0"(i));
>> +                       "lock; xaddl %1, %0;"
>> +                       :"=m"(v->counter)
>> +                       :"r"(i), "m" (v->counter));
>>           return i + __i;
>>    #elif defined(__powerpc__)
>>    #define ISYNC_ON_SMP   "\n\tisync\n"
>> --
>>
>> Please let me know if this patch helps.
>
> Yup, all better.

So with this, the "volatile struct" patch isn't necessary?

If so, perhaps we would be better off converting librttest.h to 
implement the atomic functions using the glibc built-ins, ie:

static inline int
atomic_add(atomic_t *addr, int i)
{
	return __sync_add_and_fetch(&addr->val, i);
}

It's more maintainable than inline asm and better tested than a roll 
your own implementation. Oddly, I believe the original was patterned 
after what is in the Linux kernel...

--
Darren



>
> 	-Mike
>


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
