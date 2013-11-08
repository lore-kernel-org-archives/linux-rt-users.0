From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 14:32:14 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311081406040.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de> <527CB16D.3040909@meduna.org>
 <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de> <527CD59A.7000304@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-2?Q?Neboj=B9a_=C6osi=E6?= <nebojsa@asnn.org>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58385 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3KHNcU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 08:32:20 -0500
In-Reply-To: <527CD59A.7000304@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 8 Nov 2013, Stanislav Meduna wrote:
> On 08.11.2013 12:30, Thomas Gleixner wrote:
> 
> > The default queue of the network stack is a single fifo queue. So what
> > are you expecting from a single queue? That it's magically allowing
> > your high priority task to succeed? And just because you are too lazy
> > or unable to understand the concepts of advanced networking you join
> > the choir and shout "priority inversion"?
> 
> I did not meant the priority inversion in the strict thread running/blocked
> sense. If the
> 
>   On 08.11.2013 11:51, eg Engleder Gerhard wrote:
> 
>   > In my situation the transmission of the packet from the high-prio
>   > thread is delayed until the low-prio thread is scheduled again.
> 
> is true then to me it is a kind of priority inversion.

It's a simple queueing problem. FIFO queue:

     This principle states that customers are served one at a time and
     that the customer that has been waiting the longest is served
     first. It also implies that the customer who arrived last will
     have to wait until all others before him have been served.
 
That's exactly what happening here. No matter how important you
believe to be, you still have to wait in the line, if there is only a
single one. There is a reason why busses have reserved lanes in big
cities.

> > Hell no, there is no way to cure blissful ignorance with kernel
> > patches.
> 
> The thing is that the userspace developers assume things. In this
> case they assume that if a higher prio thread wants to send
> a network packet and the send() returns, the maximum time until
> that one packet gets out on the wire is the time all the already
> queued packets need to get out. If this is true, I'm perfectly
> fine - but from what Nebojsa and Gerhard are writing I have
> my doubts and I am a bit scared as it can affect what we are
> doing. As my job is not a kernel developer, I have to trust
> others on this...
> 
> If not, I would not call it ignorance. This is IMHO a reasonable
> assumption.

It seems there are really frightening assumptions made when it comes
to real time systems. Stuff does not get magically deterministic just
by throwing a real time kernel at it and by setting priorities.

real time systems always must be carefully designed, and if your
system requires deterministic networking, you have to understand how
networking works. Nobody is asking a user space developer to grok the
kernel internals, but understanding the basic principles of technology
on which an application depends on, is still required.

If people developing real time systems just make uninformed
assumptions and then blame the kernel for getting it wrong, I call
that ignorance.

Thanks,

	tglx

