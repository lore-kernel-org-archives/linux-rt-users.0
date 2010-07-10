From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 1/4] rtmutex: avoid null derefence in WARN_ON
Date: Sat, 10 Jul 2010 07:42:45 -0700
Message-ID: <4C3886E5.8060506@us.ibm.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com> <1278714780-788-2-git-send-email-dvhltc@us.ibm.com> <1278721788.1537.170.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>, Mike Galbraith <efault@gmx.de>,
	linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:46927 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0GJOmu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Jul 2010 10:42:50 -0400
In-Reply-To: <1278721788.1537.170.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/09/2010 05:29 PM, Steven Rostedt wrote:
> On Fri, 2010-07-09 at 15:32 -0700, Darren Hart wrote:
>> If the pi_blocked_on variable is NULL, the subsequent WARN_ON's
>> will cause an OOPS. Only perform the susequent checks if
>> pi_blocked_on is valid.
>>
>> Signed-off-by: Darren Hart<dvhltc@us.ibm.com>
>> Cc: Thomas Gleixner<tglx@linutronix.de>
>> Cc: Peter Zijlstra<peterz@infradead.org>
>> Cc: Ingo Molnar<mingo@elte.hu>
>> Cc: Eric Dumazet<eric.dumazet@gmail.com>
>> Cc: John Kacur<jkacur@redhat.com>
>> Cc: Steven Rostedt<rostedt@goodmis.org>
>> Cc: Mike Galbraith<efault@gmx.de>
>> ---
>>   kernel/rtmutex.c |    7 ++++---
>>   1 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
>> index 23dd443..baac7d9 100644
>> --- a/kernel/rtmutex.c
>> +++ b/kernel/rtmutex.c
>> @@ -579,9 +579,10 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
>>
>>   	raw_spin_lock(&pendowner->pi_lock);
>>
>> -	WARN_ON(!pendowner->pi_blocked_on);
>> -	WARN_ON(pendowner->pi_blocked_on != waiter);
>> -	WARN_ON(pendowner->pi_blocked_on->lock != lock);
>> +	if (!WARN_ON(!pendowner->pi_blocked_on)) {
>> +		WARN_ON(pendowner->pi_blocked_on != waiter);
>
> The above actually has no issue if the pi_blocked_on is NULL.

It doesn't, but it's also redundant and makes the console noisier for no 
reason. Seemed worth while to drop it under the if in the same go.

--
Darren


> The below, well yeah.
>
> -- Steve
>
>> +		WARN_ON(pendowner->pi_blocked_on->lock != lock);
>> +	}
>>
>>   	pendowner->pi_blocked_on = NULL;
>>
>
>


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
