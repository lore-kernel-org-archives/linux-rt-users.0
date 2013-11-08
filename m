From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 12:30:39 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
 <527CB16D.3040909@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-2?Q?Neboj=B9a_=C6osi=E6?= <nebojsa@asnn.org>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57631 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab3KHLap (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 06:30:45 -0500
In-Reply-To: <527CB16D.3040909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 8 Nov 2013, Stanislav Meduna wrote:
> On the same wire there is a non-rt traffic, usually sent by another
> lower-prio thread. The queuing of the packets itself is not a problem -
> this is basically a request-response protocol and there will never
> be more than several packets before the higher-level one - but

So you exactly know that the non-rt traffic is never going to queue
enough traffic to disturb your high prio traffic? That might be true
for your particular scenario, but definitely not true for the general
case as I showed with a very trivial example.

> a priority inversion where the first thread is stuck in the network
> code because something preempted the low-prio one that is just queuing
> a packet would be a big problem.

Did you even take the time to read and understand what I wrote? It's
not a priority inversion problem. It's a problem of not understanding
the technology.

The default queue of the network stack is a single fifo queue. So what
are you expecting from a single queue? That it's magically allowing
your high priority task to succeed? And just because you are too lazy
or unable to understand the concepts of advanced networking you join
the choir and shout "priority inversion"?

I explained, that this is an expected and completely correct behaviour
which has absolutely nothing to do with priority inversion.

There are other ways to solve this without touching a single line of
kernel code. The technology is all there, you just have to use it. Of
course that requires to understand it in the first place, though this
seems to be way harder than spending a lot of time tracing the problem
and then yelling "priority inversion" and hope that the RT folks are
going to "fix" it.

Hell no, there is no way to cure blissful ignorance with kernel
patches.

Thanks,

	tglx
