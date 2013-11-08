From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 11:32:50 +0100
Message-ID: <20131108113250.2abdb8b7@sth491dt.servo.net>
References: <20130429222238.2b440d8c@sanja.asnn.org>
	<517FE1A5.1090702@osadl.org>
	<20130430192653.5c6c08b6@sanja.asnn.org>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
	<20131106125709.2e091182@sth491dt.servo.net>
	<alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
	<20131107103325.65938975@sanja.asnn.org>
	<alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
	<527CB16D.3040909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:54712 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab3KHKcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 05:32:54 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id EBE37EA0CE
	for <linux-rt-users@vger.kernel.org>; Fri,  8 Nov 2013 11:32:52 +0100 (CET)
In-Reply-To: <527CB16D.3040909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> On 08.11.2013 03:07, Thomas Gleixner wrote:
>=20
> > Simply because it has nothing to do with priority inversion. It's j=
ust
> > the nature of a single unmanaged queue. The behaviour is completely
> > correct.
>=20
> I cannot comment on the code as I did not analyze it myself
> (at least yet), but I think Nebojsa is worried by the situation
> where the high-prio thread is not able to _queue_ its packets because
> of the low-prio thread is sitting in some lock being preempted
> by something unrelated.
>=20
> > Just for the record. I'm really frightened by the phrase "UDP
> > realtime" which was mentioned in this thread more than once. Lookin=
g
> > at the desperation level of these posts I fear, that there are goin=
g
> > to be real world products out already or available in the near futu=
re
> > which are based on the profound lack of understanding of the
> > technology they are based on.
>=20
> Yes there are real-world product using real-time ethernet - not
> necessarily UDP but for example anything EtherCAT based absolutely
> needs to be able to send certain packets cyclically no more than
> 100 ms (or 10 ms or 2 ms) apart otherwise all hell breaks loose
> with real-world connected hardware. The room for jitter is the
> limit minus cycle the packets are being sent, which can be pretty
> tight.
>=20
> On the same wire there is a non-rt traffic, usually sent by another
> lower-prio thread. The queuing of the packets itself is not a problem=
 -
> this is basically a request-response protocol and there will never
> be more than several packets before the higher-level one - but
> a priority inversion where the first thread is stuck in the network
> code because something preempted the low-prio one that is just queuin=
g
> a packet would be a big problem.
>=20
> There is nothing else on the network interface, but there usually
> is another ethernet interface for non-realtime traffic. If some
> of the locks involved is driver-wise instead of interface-wise
> we already lost (I understand that this case would be the problem
> of the driver and not the infrastructure).
>=20
> If I am understanding the Nebojsa's worries wrong or if the
> scenario cannot happen, please disregard.
>=20
> Regards

Thanks Stanislav for excellent description.
In my case, bandwidth usage was bellow 5%, and measured delays on udp
messages were in some cases longer than 40ms. Only two nodes where
connected on test bench, and only one network interface per node was
available.
I have to repeat that the code in question worked in my case, which is
very specific, and that reason for discussing it is to try to come to a
proper solution to this problem.
And yes, I do believe that, even if behaviour is documented, it is stil=
l
a problem and can be dealt with in a better way.

--=20
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
