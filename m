From: John Sigler <linux.kernel@free.fr>
Subject: Re: Priorities of IRQ handlers
Date: Wed, 28 Nov 2007 12:05:26 +0100
Message-ID: <474D4B76.8080001@free.fr>
References: <474AE6C7.4090204@free.fr> <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:42304 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584AbXK1LF3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 06:05:29 -0500
In-Reply-To: <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

Steven Rostedt wrote:

> John Sigler wrote:
> 
>> I need to change the priorities of several soft and hard IRQ handlers.
>>
>> Namely,
>>
>> o reduce the prio of "softirq-timer" handler to 10
>>
>> o reduce the prio of IRQ14 and IRQ15 handlers to 20
>>    (my flash drives do not support DMA BTW...)
>>
>> o boost the prio of my I/O boards' IRQ handlers to 60
>>    (there can be 1 or 2 boards, the driver is a kernel module
>>     which is loaded after the system has booted.)
>>
>> I've written a short program that calls
>>    sched_setscheduler(pid, SCHED_FIFO, &param);
>> with the appropriate pid, which I look up using ps -ef
> 
> Look for the program "chrt". It does this for you. This program is
> available in all major distributions of Linux.

Thanks for the tip.

For the record, I found schedutils on Robert Love's page:

http://rlove.org/
http://rlove.org/misc/schedutils-1.5.0.tar.gz

However, I had already solved that part of the problem with a
program of my own.

My real problem is: the IRQ handlers for the I/O boards are
only instantiated when the kernel module is inserted. How do
I /reliably/ determine their pid?

e.g. on one system, the IRQ handler for my I/O board is IRQ5
with pid 745. On another system, it's IRQ20 with pid 808.
On a third system they're IRQ20 and IRQ21 with pid 239 and 240.

The only solution I see is to examine /proc/interrupts to find the
IRQ handler(s) then ps to lookup their pid, but that feels like a
dirty hack.

These interrupt handlers are all spawned by kthreadd. I thought
there would be some way to ask kthreadd to tweak the priorities.

>> I need to automate the process of tweaking priorities.
>>
>> Can someone offer advice and / or pointers?
> 
> Perhaps look at one of the startup scripts, and add the chrt
> command there.

Which startup scripts?

Regards.
