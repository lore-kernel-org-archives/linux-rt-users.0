From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: Disabling lapic timer for a certain core
Date: Fri, 05 Mar 2010 04:59:52 -0500
Message-ID: <4B90D618.2060100@cfl.rr.com>
References: <14900780.1267705793289.JavaMail.ngmail@webmail16.arcor-online.net> <20100304140453.GX2553@uudg.org>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org,
	Mark Hounschell <dmarkh@cfl.rr.com>,
	Mark Hounschell <markh@compro.net>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55967 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab0CEJ7y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Mar 2010 04:59:54 -0500
In-Reply-To: <20100304140453.GX2553@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/04/2010 09:04 AM, Luis Claudio R. Goncalves wrote:
> On Thu, Mar 04, 2010 at 01:29:53PM +0100, M. Koehrer wrote:
> | Hi all!
> | 
> | I am running the RT_PREEMPT kernel 2.6.31.2-rt13 on a Intel Quad Core CPU.
> | I start my kernel with isolcpus=1-7 option to force all processes to run on CPU core 0 only.
> | Now we have the need for a very fast loop. Within this loop some accesses from/to a PCIe I/O board
> | (mapped in user space) and some additional computation has to be done.
> | For this, I use a real time thread, run this on CPU core 3 and let it run in an endless polling loop.
> | So far everything works fine.
> | This thread is the only running user mode thread on CPU core 3.
> | However, we measure some run time jitters when accessing the I/O board in the range of up to 
> | 15 microseconds which are not tolerable by the application.
> | I see that on all cores the "Local Timer Interrupt" occurs 100 times a
> | second (of course this is the timer frequency select in the kernel configuration).
> 
> Are CPU0 and CPU3 on the same socket? Are you using a SMP or a NUMA box? I
> would suggest running your application in a CPU on a different socket just
> to ensure you are not having any cache issues.
> 
> Have you tried running hwlat_detect or smi-test? Your 15us threshold is pretty
> tight and could easilly be affected by SMI spikes (if present in your
> system).
> 
> Luis
> 
> | My question is now:
> | Is it possible to disable the "Local Timer Interrupt" for core 3 as it is actually not required here?
> | I want to use the full 100% CPU core time for this single loop.
> | 
> | Any help or ideas are welcome!
> | 

This has been a long standing issue with me too. Moving your process to
another socket won't help you. It is not a cache issue. It is the local
timer interrupt just as you suspect. I've played with disabling it on a
core but haven't been successful. This is a problem with both the vanilla
and RT kernels. No matter what you do as far as isolation of tasks and
normal interrupts, the local timer interrupt kills ya. The kernel is broken
in this regard, by design. Your processors aren't yours. The kernel
developers insist on claiming a piece of every one of them for their code.
The kernel people will never change/fix this flaw in it's basic design
because only a few (hard real-time) consider it a problem. Those people are
told to use something else and that Linux wasn't designed for that kind of
thing.

Unfortunately, the instructions (rdmsr and wrmsr) that could be used to
disable/re-enable the local timer interrupt require DOM-0 privileges and
can't be executed from user land. If it were not for that one little thing
a solution would be easy. You wouldn't even need the RT patch set any more.

You could probably hack the kernel up such that you could get DOM-0
privileges in user land but don't expect any help from any kernel people
for that sort of thing.

Your best bet will be to attempt to use a high speed video cards GPU for
your process. There are methods available (out side of the kernel) for
this. I haven't got there yet but I think NVIDIA's CUDA may be an answer.


http://en.wikipedia.org/wiki/CUDA


Regards
Mark
