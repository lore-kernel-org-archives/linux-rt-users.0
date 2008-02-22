From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: [PATCH [RT] 11/14] optimize the !printk fastpath through the
 lock acquisition
Date: Fri, 22 Feb 2008 17:20:53 -0500
Message-ID: <47BF4AC5.7070507@gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net> <20080221152722.4804.77478.stgit@novell1.haskins.net> <20080222191837.GE6060@ucw.cz>
Reply-To: gregory.haskins@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: Pavel Machek <pavel@ucw.cz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:25349 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936611AbYBVWVM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Feb 2008 17:21:12 -0500
Received: by py-out-1112.google.com with SMTP id u52so989095pyb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Feb 2008 14:21:11 -0800 (PST)
In-Reply-To: <20080222191837.GE6060@ucw.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pavel Machek wrote:
> Hi!
> 
>> Decorate the printk path with an "unlikely()"
>>
>> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
>> ---
>>
>>  kernel/rtmutex.c |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
>> index 122f143..ebdaa17 100644
>> --- a/kernel/rtmutex.c
>> +++ b/kernel/rtmutex.c
>> @@ -660,12 +660,12 @@ rt_spin_lock_fastlock(struct rt_mutex *lock,
>>  		void fastcall (*slowfn)(struct rt_mutex *lock))
>>  {
>>  	/* Temporary HACK! */
>> -	if (!current->in_printk)
>> -		might_sleep();
>> -	else if (in_atomic() || irqs_disabled())
>> +	if (unlikely(current->in_printk) && (in_atomic() || irqs_disabled()))
>>  		/* don't grab locks for printk in atomic */
>>  		return;
>>  
>> +	might_sleep();
> 
> I think you changed the code here... you call might_sleep() in
> different cases afaict.

Agreed, but it's still correct afaict.  I added an extra might_sleep() 
to a path that really might sleep.  I should have mentioned that in the 
header.

In any case, its moot.  Andi indicated this patch is probably a no-op so 
I was considering dropping it on the v2 pass.

Regards,
-Greg
