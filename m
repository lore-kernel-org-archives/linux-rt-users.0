From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in wakeup_next_waiter()
Date: Fri, 09 Jul 2010 09:35:46 -0700
Message-ID: <4C374FE2.2090309@us.ibm.com>
References: <1278478019.10245.77.camel@marge.simson.net> <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain> <4C368565.3020806@us.ibm.com>  <4C36CD83.6070809@us.ibm.com> <1278683900.10161.8.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:36985 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab0GIQf4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 12:35:56 -0400
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o69GSwm7018460
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 10:28:58 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o69GZo89128942
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 10:35:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o69GZnWr028001
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 10:35:50 -0600
In-Reply-To: <1278683900.10161.8.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/09/2010 06:58 AM, Mike Galbraith wrote:
> On Fri, 2010-07-09 at 00:19 -0700, Darren Hart wrote:
>
>> Walking through it:
>>
>> First the dumps:
>> ------------[ cut here ]------------
>> WARNING: at kernel/rtmutex.c:583 wakeup_next_waiter+0x1ad/0x220()
>>
>>
>> WARN_ON(pendowner->pi_blocked_on != waiter);
>> The pi_blocked_on is not NULL, but it isn't the expected waiter either.
>> This means that the top waiter selected at the beginning of
>> wakeup_next_waiter() is now blocked on a lock with a different waiter
>> structure, possibly on a different lock.
>
> pendowner->pi_blocked_on changes while we're in wakeup_next_waiter().
> The below fi^Wmade it not do that any more.  We hold the wait_lock for
> this lock, but if the wakee blocks on another, what's protecting us?

If pendowner is blocked on "lock" to begin with (he should be as his 
waiter struct in in the rtmutex waiters list) then he can't block on 
someone else until he either acquires this one or removes himself as a 
waiter (due to a timeout for instance) - both of these operations 
require holding lock->wait_lock, which is held by the caller of 
wakeup_next_waiter().

Seems more likely that the below forces a missing memory barrier... not 
sure yet though. Good data point.

--
Darren

>
> bandaid-by: /me
>
> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
> index 23dd443..dd91ede 100644
> --- a/kernel/rtmutex.c
> +++ b/kernel/rtmutex.c
> @@ -525,6 +525,8 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
>   	pendowner = waiter->task;
>   	waiter->task = NULL;
>
> +	raw_spin_lock(&pendowner->pi_lock);
> +
>   	/*
>   	 * Do the wakeup before the ownership change to give any spinning
>   	 * waiter grantees a headstart over the other threads that will
> @@ -577,8 +579,6 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
>   	else
>   		next = NULL;
>
> -	raw_spin_lock(&pendowner->pi_lock);
> -
>   	WARN_ON(!pendowner->pi_blocked_on);
>   	WARN_ON(pendowner->pi_blocked_on != waiter);
>   	WARN_ON(pendowner->pi_blocked_on->lock != lock);
>
>


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
