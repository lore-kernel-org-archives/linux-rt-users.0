From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 4/4] futex: convert hash_bucket locks to raw_spinlock_t
Date: Tue, 13 Jul 2010 00:12:29 -0700
Message-ID: <4C3C11DD.4030308@us.ibm.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com> <1278714780-788-5-git-send-email-dvhltc@us.ibm.com> <1278790882.7352.101.camel@marge.simson.net> <4C3B68B9.5060404@us.ibm.com> <alpine.LFD.2.00.1007122226230.3321@localhost.localdomain> <1278990560.7516.50.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:36879 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0GMHMv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Jul 2010 03:12:51 -0400
In-Reply-To: <1278990560.7516.50.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/12/2010 08:09 PM, Mike Galbraith wrote:
> On Mon, 2010-07-12 at 22:40 +0200, Thomas Gleixner wrote:
>> On Mon, 12 Jul 2010, Darren Hart wrote:
>>> On 07/10/2010 12:41 PM, Mike Galbraith wrote:
>>>> On Fri, 2010-07-09 at 15:33 -0700, Darren Hart wrote:
>>>>>> Out of curiosity, what's wrong with holding his pi_lock across the
>>>>>> wakeup?  He can _try_ to block, but can't until pi state is stable.
>>>>>>
>>>>>> I presume there's a big fat gotcha that's just not obvious to futex
>>>>>> locking newbie :)
>>>
>>> Nor to some of us that have been engrossed in futexes for the last couple
>>> years! I discussed the pi_lock across the wakeup issue with Thomas. While this
>>> fixes the problem for this particular failure case, it doesn't protect
>>> against:
>>>
>>> <tglx>  assume the following:
>>> <tglx>  t1 is on the condvar
>>> <tglx>  t2 does the requeue dance and t1 is now blocked on the outer futex
>>> <tglx>  t3 takes hb->lock for a futex in the same bucket
>>> <tglx>  t2 wakes due to signal/timeout
>>> <tglx>  t2 blocks on hb->lock
>>>
>>> You are likely to have not hit the above scenario because you only had one
>>> condvar, so the hash_buckets were not heavily shared and you weren't likely to
>>> hit:
>>>
>>> <tglx>  t3 takes hb->lock for a futex in the same bucket
>>>
>>>
>>> I'm going to roll up a patchset with your (Mike) spin_trylock patch and run it
>>> through some tests. I'd still prefer a way to detect early wakeup without
>>> having to grab the hb->lock(), but I haven't found it yet.
>>>
>>> +	while(!spin_trylock(&hb->lock))
>>> +		cpu_relax();
>>>   	ret = handle_early_requeue_pi_wakeup(hb,&q,&key2, to);
>>>   	spin_unlock(&hb->lock);
>>
>> And this is nasty as it will create unbound priority inversion :(
>
> Oh ma gawd, _it's a train_ :>

Seriously.

I have a fix. Cleaning it up as we speak, still hope to send out tonight.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
