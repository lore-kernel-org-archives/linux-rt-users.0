From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Fri, 2 Jun 2017 09:37:04 -0500
Message-ID: <b1486490-5a96-7ba3-c280-5d5622c8c488@ni.com>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
 <20170203182112.18053-1-haris.okanovic@ni.com>
 <20170210170207.3kzfqyfa4ueh7mih@linutronix.de>
 <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de>
 <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
 <alpine.DEB.2.20.1705262147510.2137@nanos>
 <4b4df775-53b8-cdeb-381b-af8cabb364a8@ni.com>
 <alpine.DEB.2.20.1705262232590.2137@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.cartwright@ni.com, gratian.crisan@ni.com
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:33736 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751128AbdFBOhP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 10:37:15 -0400
In-Reply-To: <alpine.DEB.2.20.1705262232590.2137@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/26/2017 03:50 PM, Thomas Gleixner wrote:
> On Fri, 26 May 2017, Haris Okanovic wrote:
>
>> Oh crap. I think I see the problem. I decrement expired_count before
>> processing the list. Dropping the lock permits another run of
>> tick_find_expired()->find_expired_timers() in the middle of __expire_timers()
>> since it uses expired_count==0 as a condition.
>>
>> This should fix it, but I'll wait for Anna-Maria's test next week before
>> submitting a patch.
>>
>>>  static void expire_timers(struct timer_base *base)
>>>  {
>>>         struct hlist_head *head;
>>> +       int expCount = base->expired_count;
>
> No camel case for heavens sake!
>
> And this requires:
>
>    	 cnt = READ_ONCE(base->expired_count);
>
>>> -       while (base->expired_count--) {
>>> -               head = base->expired_lists + base->expired_count;
>>> +       while (expCount--) {
>>> +               head = base->expired_lists + expCount;
>>>                 __expire_timers(base, head);
>>>         }
>
> Plus a comment.

Fixed, thanks.

Are your recommending READ_ONCE() purely for documentation purposes?
All reads and writes to base->expired_count happen while base->lock is 
held. It just can't reach zero until expired_lists is ready to be rewritten.

>
>>>         base->expired_count = 0;
>
> Anna-Maria spotted the same issue, but I voted for the revert right now
> because I was worried about the consistency of base->clk under all
> circumstances.
>
> The other thing I noticed was this weird condition which does not do the
> look ahead when base->clk is back for some time.

The soft interrupt fires unconditionally if base->clk hasn't advanced in 
some time to limit how long cpu spends in hard interrupt context.

> Why don't you use the
> existing optimization which uses the bitmap for fast forward?
>

Are you referring to forward_timer_base()/base->next_expiry? I think 
it's only updated in the nohz case. Can you share function name/line 
number(s) if you're thinking of something else.

> The other issue I have is that this can race at all. If you raised the
> softirq in the look ahead then you should not go into that function until
> the softirq has actually completed. There is no point in wasting time in
> the hrtimer interrupt if the softirq is running anyway.
>

Makes sense. Skipping the large `if` block in run_local_timers() when 
`local_softirq_pending() & TIMER_SOFTIRQ`.

> Thanks,
>
> 	tglx
>
>
>
>

I also ran Anna-Maria's test for 12h without failure; I.e. no "Stalled" 
messages. It fails withing 10-15m on my qemu VM without the fix (4-core 
Nehalem, 1GB RAM).

You can view a diff at
https://github.com/harisokanovic/linux/tree/dev/hokanovi/timers-race

-- Haris
