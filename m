From: Stanislav Meduna <stano@meduna.org>
Subject: Re: UDP jitter
Date: Fri, 08 Nov 2013 10:39:57 +0100
Message-ID: <527CB16D.3040909@meduna.org>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net> <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	=?ISO-8859-2?Q?Neboj=B9a_=C6o?= =?ISO-8859-2?Q?si=E6?=
	<nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:57202 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756932Ab3KHKTO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 05:19:14 -0500
In-Reply-To: <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08.11.2013 03:07, Thomas Gleixner wrote:

> Simply because it has nothing to do with priority inversion. It's just
> the nature of a single unmanaged queue. The behaviour is completely
> correct.

I cannot comment on the code as I did not analyze it myself
(at least yet), but I think Nebojsa is worried by the situation
where the high-prio thread is not able to _queue_ its packets because
of the low-prio thread is sitting in some lock being preempted
by something unrelated.

> Just for the record. I'm really frightened by the phrase "UDP
> realtime" which was mentioned in this thread more than once. Looking
> at the desperation level of these posts I fear, that there are going
> to be real world products out already or available in the near future
> which are based on the profound lack of understanding of the
> technology they are based on.

Yes there are real-world product using real-time ethernet - not
necessarily UDP but for example anything EtherCAT based absolutely
needs to be able to send certain packets cyclically no more than
100 ms (or 10 ms or 2 ms) apart otherwise all hell breaks loose
with real-world connected hardware. The room for jitter is the
limit minus cycle the packets are being sent, which can be pretty
tight.

On the same wire there is a non-rt traffic, usually sent by another
lower-prio thread. The queuing of the packets itself is not a problem -
this is basically a request-response protocol and there will never
be more than several packets before the higher-level one - but
a priority inversion where the first thread is stuck in the network
code because something preempted the low-prio one that is just queuing
a packet would be a big problem.

There is nothing else on the network interface, but there usually
is another ethernet interface for non-realtime traffic. If some
of the locks involved is driver-wise instead of interface-wise
we already lost (I understand that this case would be the problem
of the driver and not the infrastructure).

If I am understanding the Nebojsa's worries wrong or if the
scenario cannot happen, please disregard.

Regards
-- 
                                     Stano

