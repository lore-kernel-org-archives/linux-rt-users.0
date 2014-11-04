From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: which kernel thread handles NMIs?
Date: Mon, 3 Nov 2014 23:20:49 -0600
Message-ID: <54586231.2030007@windriver.com>
References: <5457EEC3.5010506@windriver.com> <20141103203545.1ee168fd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:38852 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaKDFUz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Nov 2014 00:20:55 -0500
In-Reply-To: <20141103203545.1ee168fd@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/03/2014 07:35 PM, Steven Rostedt wrote:
> On Mon, 3 Nov 2014 15:08:19 -0600
> Chris Friesen <chris.friesen@windriver.com> wrote:
>
>> We're running with the 3.4 kernel with RT patch, and we're trying to
>> debug some issues.
>>
>> One of the issues is that the magic sysrq "l" command to show a stack
>> backtrace on all CPUs doesn't seem to work, though other magic sysrq
>> commands do work properly.
>
> I actually have a series of patches that would make this work nicely on
> -rt. I'm working on them now but they are for mainline, which means if
> you want them you will need to backport the code. Shouldn't be too hard.
>
>>
>> Looking at the code, for X86 it seems to call
>> apic->send_IPI_all(NMI_VECTOR);
>>
>> Does anyone know what kernel thread would handle NMI_VECTOR?  I want to
>> make sure its priority is sufficiently high.
>>
>
> Um, NMI is not a thread. It's a "Non-Maskable Interrupt". Which means
> that nothing will stop it from coming in. This is determined by
> hardware, and not a -rt vs mainline thing.

Yeah, I know what NMI is. :)  I don't have all that much experience with 
the RT kernels though, so I was wondering if the IPI NMI handler got 
turned into a kernel thread the way that most of the other interrupt 
handlers do.

> Your issue is that due to deadlocks that printk can cause, the -rt
> patch has code to prevent printing from interrupt disabled
> (including NMI) context, because some of the printk routines can sleep,
> and we can't let that happen if interrupts are disabled.

Ah, okay.  That makes sense.

> As I said. I have patches that will place the sysrq-l data into a
> temporary buffer and will print them out after all the NMIs have
> finished. And this is done from a nice preemptable context.
>
> You can look at my test code here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>    rfc/seq-buf
>
> As these may be a bit too complex to backport (the original code had
> complaints, and I needed to do much more to get this acceptable), you
> may want to look at the original RFC patches:
>
> http://marc.info/?l=linux-kernel&m=140321402925869&w=2
>
> These may be much easier to backport.

Excellent, thanks!  That sounds like just the ticket.

Chris

