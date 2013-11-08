From: Stanislav Meduna <stano@meduna.org>
Subject: Re: UDP jitter
Date: Fri, 08 Nov 2013 13:14:18 +0100
Message-ID: <527CD59A.7000304@meduna.org>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net> <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de> <527CB16D.3040909@meduna.org> <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35670 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab3KHMOa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 07:14:30 -0500
In-Reply-To: <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08.11.2013 12:30, Thomas Gleixner wrote:

> The default queue of the network stack is a single fifo queue. So what
> are you expecting from a single queue? That it's magically allowing
> your high priority task to succeed? And just because you are too lazy
> or unable to understand the concepts of advanced networking you join
> the choir and shout "priority inversion"?

I did not meant the priority inversion in the strict thread running/blocked
sense. If the

  On 08.11.2013 11:51, eg Engleder Gerhard wrote:

  > In my situation the transmission of the packet from the high-prio
  > thread is delayed until the low-prio thread is scheduled again.

is true then to me it is a kind of priority inversion.

It is understood that the default implementation will not change
the order of packets already queued for transmission.

> There are other ways to solve this without touching a single line of
> kernel code. The technology is all there, you just have to use it. Of
> course that requires to understand it in the first place,

Fair enough.

> Hell no, there is no way to cure blissful ignorance with kernel
> patches.

The thing is that the userspace developers assume things. In this
case they assume that if a higher prio thread wants to send
a network packet and the send() returns, the maximum time until
that one packet gets out on the wire is the time all the already
queued packets need to get out. If this is true, I'm perfectly
fine - but from what Nebojsa and Gerhard are writing I have
my doubts and I am a bit scared as it can affect what we are
doing. As my job is not a kernel developer, I have to trust
others on this...

If not, I would not call it ignorance. This is IMHO a reasonable
assumption.

Thanks
-- 
                                          Stano

