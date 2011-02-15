From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 09:40:22 +0100
Message-ID: <4D5A3BF6.6090008@steinhoff.de>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com> <AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59598 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1BOIfA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 03:35:00 -0500
In-Reply-To: <AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

the scheduling is done by the CFS ?

--Armin



Peter LaDow wrote:
> On Mon, Feb 14, 2011 at 3:30 PM, Frank Rowand<frank.rowand@gmail.com>  wrote:
>> On Mon, Feb 14, 2011 at 2:31 PM, Peter LaDow<petela@gocougs.wsu.edu>  wrote:
>>> How is the scheduling of the hrtimers softirq thread handled?
>>>
>>> When querying the RT priority of the hrtimer softirq, I get a priority
>>> of 50.  But when running a priority 99 thread, we still seem to be
>>> getting interrupted.  Shouldn't the hrtimer softirq be put off until
>>> the CPU is idle or a lower priority task is running?
>> Is the hrtimer softirq executing when the priority 99 thread is spinning
>> in it's for loop?  Your "jitter Due to Large Number of Timers" email
>> said that the lower priority tasks don't seem to be interrupting the
>> priority 99 thread.
> Did I?  Hmm, well I mean the lower priority task with 100 threads.  At
> least I think so.  It is hard to tell.
>
> It seems to me that the softirq thread is the source of the problem.
> Since the tight loop is getting such a variety of times (400us of
> jitter only while the other process is running) that it does seem that
> the loop is getting interrupt.
>
>> The hardware timer interupts will interrupt the priority 99 thread.  The
>> cost of these interrupts and the resultant calls to try_to_wake_up()
>> of the hrtimer softirq might be quite large considering the rate of
>> timer expires you mentioned in your first email.
> Sure, we expect the timer interrupt to interfere.  But as we
> understand it, the softirq is what schedules the task switch.  The top
> half only schedules the bottom half.  But since the bottom half is
> priority 50, there shouldn't be any interruption of the priority 99
> expect to handle the low level IRQ.
>
>> Out of curiosity, is the system UP or SMP?
> UP.  Just a single MPC5349.
>
> pete
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

