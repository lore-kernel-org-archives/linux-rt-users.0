From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
 workqueue infrastructure
Date: Wed, 1 Aug 2007 23:48:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708012338380.31416@frodo.shire>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
 <1185940340.2636.97.camel@imap.mvista.com>  <1185969554.9513.106.camel@ghaskins-t60p.haskins.net>
 <1185981025.2636.102.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:28355 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbXHAVsm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 17:48:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so275627ugf
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Aug 2007 14:48:40 -0700 (PDT)
In-Reply-To: <1185981025.2636.102.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 1 Aug 2007, Daniel Walker wrote:

> On Wed, 2007-08-01 at 07:59 -0400, Gregory Haskins wrote:
>> On Tue, 2007-07-31 at 20:52 -0700, Daniel Walker wrote:
>>
>>>
>>> Here's a simpler version .. uses the plist data structure instead of the
>>> 100 queues, which makes for a cleaner patch ..
>>
>> Hi Daniel,
>>
>> I like your idea on the plist simplification a lot.  I will definitely
>> roll that into my series.
>>
>> I am not too psyched about using the rt_mutex_setprio() API directly,
>> however.  It seems broken to be calling that directly from non rt_mutex
>> code, IMHO.  Perhaps the PI subsystem should be broken out from the
>> rt_mutex code so it can be used generally?  There are other areas where
>> PI could potentially be used besides rt_mutex (this patch as a prime
>> example), so this might make sense.
>
> rt_mutex_setprio() is just a function. It was also designed specifically
> for PI , so it seems fairly sane to use it in other PI type
> situations ..
>
> Daniel
>

There seems to be a general need for boosting threads temporarely in a few 
places. HR-timers also have it, last time I checked. And preemptive RCU as 
well for boosting RCU readers. They all seems to deal with the same issues 
of correctly dealing with setting the priority and PI bosting from 
mutexes.

When boosting of RCU readers was discussed I came to the conclusion that 
the boosting property should be taken out of the of the rt_mutex module 
and instead be made into a sub-property of the scheduler:

task->pi_waiters should be replaced with task->prio_boosters being a 
pi_list of struct prio_booster representing something, which temporarely 
wants to boost a task.
A rt_mutex_waiter should of course contain a prio_booster which is added 
to owner->prio_boosters. A work queue element should contain a prio_booster.
When boosting a RCU reader a prio_booster is added  to the reader's 
prio_boosters.

Such a system will correctly deal with boosters going away in arbitrary 
order. Something which is not strait forward when each user of boosting is 
trying to do it on their own.

Esben
