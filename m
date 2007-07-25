From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 15:20:05 +0200
Message-ID: <46A74E05.50504@free.fr>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu> <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu> <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr> <20070725130536.GA12334@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:57152 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761975AbXGYNUJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 09:20:09 -0400
In-Reply-To: <20070725130536.GA12334@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(Dropping oprofile-list@lists.sourceforge.net)

Ingo Molnar wrote:

> John Sigler wrote:
> 
>>> With a pair of the following in the middle:
>>>
>>> softirq--4     0....  670us : call_rcu (rt_run_flush)
>>> softirq--4     0D..1  670us : __rcu_advance_callbacks (call_rcu)
> 
>> Any idea what went wrong in the above function trace? Why is the 
>> kernel spinning in circles that way?
> 
> does your test-app have higher priority than softirq--4 ?

PID 4 is [softirq-timer/0] and has priority 50 in SCHED_FIFO.
My process has priority 80 in SCHED_RR. It is waiting for IRQ10.

My user-space app has higher priority than everything except
PID 2 which is [posix_cpu_timer]

Is this a priority inversion issue?

Regards.
