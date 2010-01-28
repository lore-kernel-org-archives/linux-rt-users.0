From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Replacement for Xenomai's Message queues?
Date: Thu, 28 Jan 2010 21:06:33 +0100 (CET)
Message-ID: <5579824.1264709193179.JavaMail.ngmail@webmail08.arcor-online.net>
References: <4B61DDF2.6010309@us.ibm.com> <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: dvhltc@us.ibm.com, mathias_koehrer@arcor.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:40378 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754228Ab0A1UGf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 15:06:35 -0500
In-Reply-To: <4B61DDF2.6010309@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Darren,

thanks for the response.
You are right, I should clarify the needs I have...
I have two real time applications (two processes), each running a few r=
eal time threads.
=46or inter process communication I want to exchange data between the t=
wo applications.
=46or this I want to use two queues - one for direction A->B and one fo=
r B->A.
Now I have the situation that one thread in B that handles the A->B que=
ue is waiting for data from A.
Whenever A has the data available, it writes the data into the A->B que=
ue.
Immediately after receiving data from A, B unblocks and computes some a=
nswer data that is written
into the B->A queue.=20
The time between sending the data in A and getting the data back from B=
 should be as low as possible=20
(real time requirements: at max tens of microseconds...).

The functionality of mq_send, mq_receive looks suitable.
However I am not sure if this can fulfil my performance needs...
Perhaps I still have the "Xenomai" thinking which means that only some =
special API functions are real time capable
all others are not... With the RT_PREEMPT patch this seems to be much e=
asier as I can use all suitable functionality
(or did I miss some important thing here?!?).

Regards

Mathias


> > Hi all,
> >=20
> > I am about to switch an realtime application from Xenomai to the
> RT_PREEMPTION patch.
> > Everything works really smooth, however I have one question.
> > With my Xenomai application I use the message queue which combine t=
ransfer
> (including queuing)
> > of data with activation of the thread.
> > In my Xenomai application I use this feature quite frequently. Now,=
 I am
> not sure how to do an equivalent
> > with the RT_PREEMPT patch.
> > (see
> http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__nati=
ve__que
> ue.html)
> > Of course I could use condition variables and a struct or array to =
hold
> the data I want to pass with the activation
> > of a thread. However, using this approach I do not have the queuing=
 (which
> is some extra effort I could spent...).
> > Another idea I have: I could use sockets which realize the queuing =
but the
> overhead is too high.
> >=20
> > Is there any suitable way to implement a message queue like approac=
h using
> RT_PREEMPT patch?
> > I am running x86 (Dual/Quad Cores).
>=20
> I don't if we have many xenomai experts on this list. It would help t=
o=20
> understand which aspects of the Xenomai message queue are important t=
o=20
> you (other than the ability to block on a queue and wake when a messa=
ge=20
> is available). For a basic message queueing system with the ability t=
o=20
> prioritize messages, you can look to the POSIX.4 Message Queues. A=20
> google search will provide plenty of howto's, and the API appears at=20
> least similar to what you were using with Xenomai.
>=20
> I haven't looked, but I don't think Linux supports message driven=20
> Priority Inheritance=20
> (http://www.qnx.com/developers/docs/6.3.2/neutrino/sys_arch/kernel.ht=
ml#Prio
> rity_inheritance_messages).
>=20
> --=20


--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Immer auf dem Laufenden! Sport, Auto, Reise, Politik und Promis. Von un=
s f=FCr Sie: der neue Arcor.de-Newsletter!
Jetzt anmelden und einfach alles wissen: http://www.arcor.de/rd/footer.=
newsletter
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
