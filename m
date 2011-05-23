From: Joe Howard <howardj@esi.com>
Subject: Re: Disabling lapic timer for a certain core
Date: Mon, 23 May 2011 14:40:55 -0700
Message-ID: <5A76E600A0235B469F3CC8AD2A6AC17340CCEDDC76@pdxex02.esi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.esio.com ([198.102.182.28]:59122 "EHLO mail3.esi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab1EWVqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 May 2011 17:46:08 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Apologies if this is improper etiquette top-posting and bumping a thread that is over 1 year old, but I am curious if any progress has been made toward the desire to shield one or more cores from other interrupts and processes?  Particularly the lapic timer interrupt.

It seems the combination of cpusets and irq smp_affinity get 95% of the way there, but the "Local timer interrupts" cannot be disabled for a given core.  My application runs a polling loop that consumes 100% cpu time on a "shielded" core.  The code in the loop takes about 500ns to execute and runs once every 5000ns (using "rdtsc" instruction to throttle).  I'm seeing an increase of 3000ns duration in one cycle out of every 200 (corresponding to the default HZ=1000).

Thanks,
	-Joe H


On Fri, 5 Mar 2010, Mark Hounschell wrote:
> On 03/04/2010 09:04 AM, Luis Claudio R. Goncalves wrote:
> > On Thu, Mar 04, 2010 at 01:29:53PM +0100, M. Koehrer wrote:
> > | Is it possible to disable the "Local Timer Interrupt" for core 3 as it is actually not required here?
> > | I want to use the full 100% CPU core time for this single loop.
> > | 
> > | Any help or ideas are welcome!
> > | 
> 
> This has been a long standing issue with me too. Moving your process to
> another socket won't help you. It is not a cache issue. It is the local
> timer interrupt just as you suspect. I've played with disabling it on a
> core but haven't been successful. This is a problem with both the vanilla
> and RT kernels. No matter what you do as far as isolation of tasks and
> normal interrupts, the local timer interrupt kills ya. The kernel is broken
> in this regard, by design. Your processors aren't yours. The kernel
> developers insist on claiming a piece of every one of them for their code.
> The kernel people will never change/fix this flaw in it's basic design
> because only a few (hard real-time) consider it a problem. Those people are
> told to use something else and that Linux wasn't designed for that kind of
> thing.

That's crap in several ways.

1) This is not a problem where only real-time folks are interested
   in. HPC folks complain about the same thing.

2) As I said yesterday, we are aware of the problem and people are
   working on a solution. It's just not that trivial as disabling the
   timer interrupt. We need to sort out housekeeping stuff and solve
   other problems to gain full isolation of a core.

I'm really fed up with the attitude of folks who claim that the kernel
is broken and we just are not interested to fix it. This has been
discussed several times in great length and all the details have been
pointed out which need work. But we have not seen a single patch from
the very people who whine about it.

> Unfortunately, the instructions (rdmsr and wrmsr) that could be used to
> disable/re-enable the local timer interrupt require DOM-0 privileges and
> can't be executed from user land. If it were not for that one little thing
> a solution would be easy. You wouldn't even need the RT patch set any more.
> 
> You could probably hack the kernel up such that you could get DOM-0
> privileges in user land but don't expect any help from any kernel people
> for that sort of thing.

True, simply because we are not interested in hacked up one off shit,
which breaks things left and right.
 
Thanks,

	tglx

