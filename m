From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: Priorities of IRQ handlers
Date: Wed, 28 Nov 2007 08:12:24 -0600
Message-ID: <474D7748.8@cybsft.com>
References: <474AE6C7.4090204@free.fr> <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com> <474D4B76.8080001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xmnp015.utc.com ([159.82.164.203]:49512 "EHLO xmnp015.utc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929AbXK1OOo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 09:14:44 -0500
In-Reply-To: <474D4B76.8080001@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Sigler wrote:
> Hello Steven,
> 
> Steven Rostedt wrote:
> 
>> John Sigler wrote:
>>
>>> I need to change the priorities of several soft and hard IRQ handlers.
>>>
>>> Namely,
>>>
>>> o reduce the prio of "softirq-timer" handler to 10
>>>
>>> o reduce the prio of IRQ14 and IRQ15 handlers to 20
>>>    (my flash drives do not support DMA BTW...)
>>>
>>> o boost the prio of my I/O boards' IRQ handlers to 60
>>>    (there can be 1 or 2 boards, the driver is a kernel module
>>>     which is loaded after the system has booted.)
>>>
>>> I've written a short program that calls
>>>    sched_setscheduler(pid, SCHED_FIFO, &param);
>>> with the appropriate pid, which I look up using ps -ef
>>
>> Look for the program "chrt". It does this for you. This program is
>> available in all major distributions of Linux.
> 
> Thanks for the tip.
> 
> For the record, I found schedutils on Robert Love's page:
> 
> http://rlove.org/
> http://rlove.org/misc/schedutils-1.5.0.tar.gz
> 
> However, I had already solved that part of the problem with a
> program of my own.
> 
> My real problem is: the IRQ handlers for the I/O boards are
> only instantiated when the kernel module is inserted. How do
> I /reliably/ determine their pid?

What about something like:
chrt -f -p 99 `/sbin/pidof 'IRQ 8'`

> 
> e.g. on one system, the IRQ handler for my I/O board is IRQ5
> with pid 745. On another system, it's IRQ20 with pid 808.
> On a third system they're IRQ20 and IRQ21 with pid 239 and 240.
> 
> The only solution I see is to examine /proc/interrupts to find the
> IRQ handler(s) then ps to lookup their pid, but that feels like a
> dirty hack.
> 
> These interrupt handlers are all spawned by kthreadd. I thought
> there would be some way to ask kthreadd to tweak the priorities.

I have created patches to do this in the past. However, because you are
setting different threads to different priorities it probably makes more
sense to do this from user space. Much more flexible.

> 
>>> I need to automate the process of tweaking priorities.
>>>
>>> Can someone offer advice and / or pointers?
>>
>> Perhaps look at one of the startup scripts, and add the chrt
>> command there.
> 
> Which startup scripts?
> 
> Regards.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
   kr
