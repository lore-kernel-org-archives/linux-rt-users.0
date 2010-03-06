From: Mark Hounschell <markh@compro.net>
Subject: Re: Disabling lapic timer for a certain core
Date: Sat, 06 Mar 2010 08:12:51 -0500
Message-ID: <4B9254D3.3060004@compro.net>
References: <14900780.1267705793289.JavaMail.ngmail@webmail16.arcor-online.net> <20100304140453.GX2553@uudg.org> <4B90D618.2060100@cfl.rr.com> <alpine.LFD.2.00.1003060955250.2014@localhost.localdomain>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Hounschell <dmarkh@cfl.rr.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:4539 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab0CFN0y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 6 Mar 2010 08:26:54 -0500
In-Reply-To: <alpine.LFD.2.00.1003060955250.2014@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/06/2010 04:10 AM, Thomas Gleixner wrote:
> On Fri, 5 Mar 2010, Mark Hounschell wrote:
>> On 03/04/2010 09:04 AM, Luis Claudio R. Goncalves wrote:
>>> On Thu, Mar 04, 2010 at 01:29:53PM +0100, M. Koehrer wrote:
>>> | Is it possible to disable the "Local Timer Interrupt" for core 3 as it is actually not required here?
>>> | I want to use the full 100% CPU core time for this single loop.
>>> | 
>>> | Any help or ideas are welcome!
>>> | 
>>
>> This has been a long standing issue with me too. Moving your process to
>> another socket won't help you. It is not a cache issue. It is the local
>> timer interrupt just as you suspect. I've played with disabling it on a
>> core but haven't been successful. This is a problem with both the vanilla
>> and RT kernels. No matter what you do as far as isolation of tasks and
>> normal interrupts, the local timer interrupt kills ya. The kernel is broken
>> in this regard, by design. Your processors aren't yours. The kernel
>> developers insist on claiming a piece of every one of them for their code.
>> The kernel people will never change/fix this flaw in it's basic design
>> because only a few (hard real-time) consider it a problem. Those people are
>> told to use something else and that Linux wasn't designed for that kind of
>> thing.
> 
> That's crap in several ways.
> 
> 1) This is not a problem where only real-time folks are interested
>    in. HPC folks complain about the same thing.
> 
> 2) As I said yesterday, we are aware of the problem and people are
>    working on a solution. It's just not that trivial as disabling the
>    timer interrupt. We need to sort out housekeeping stuff and solve
>    other problems to gain full isolation of a core.
> 

This I surely didn't know. I have reported problems in the past that were a
result of my application being an affinitized RT CPU hog and I've been told
that the kernel doesn't support it and there was nothing that could be
done. Between that scenario and local timer interrupts I have heard only
that it is not something that will be supported so what am I too think.
This is just personal experience on LKML. If people are truly thinking
about these things now, I commend that.

> I'm really fed up with the attitude of folks who claim that the kernel
> is broken and we just are not interested to fix it. This has been
> discussed several times in great length and all the details have been
> pointed out which need work. But we have not seen a single patch from
> the very people who whine about it.
> 

I wish I was knowledgeable enough of the kernel to get involved in this but
am currently not. Maybe as a tester of it I would be willing. I'm sorry if
I asserted an attitude, I was just noting personal experiences related to
these sorts of things.

>> Unfortunately, the instructions (rdmsr and wrmsr) that could be used to
>> disable/re-enable the local timer interrupt require DOM-0 privileges and
>> can't be executed from user land. If it were not for that one little thing
>> a solution would be easy. You wouldn't even need the RT patch set any more.
>>
>> You could probably hack the kernel up such that you could get DOM-0
>> privileges in user land but don't expect any help from any kernel people
>> for that sort of thing.
> 
> True, simply because we are not interested in hacked up one off shit,
> which breaks things left and right.

Of coarse and I understand that. And don't expect anything less.

Regards
Mark

