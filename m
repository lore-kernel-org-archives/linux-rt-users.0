From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Disabling lapic timer for a certain core
Date: Thu, 4 Mar 2010 22:03:47 +0100 (CET)
Message-ID: <6756648.1267736627501.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: lclaudio@uudg.org, mathias_koehrer@arcor.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:60954 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756469Ab0CDVDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Mar 2010 16:03:54 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Luis,

thanks for the reply.
It is an Intel Core2Quad CPU - one CPU with 4 cores, =20
this is a SMP system...
Concerning the SMI issue:
I have globally disabled SMI with the LPC registers...
The main board is a server board from Supermicro,=20
no USB enabled, VGA text mode only. No X running.

The total amount of time we have for a cycle is 40us,
most often the application manages to run within 25-30us,=20
however there are some jitters=20
that increases the run time to be 45us which is too slow.
I have done a kernel hack to be able to return directly from
the interrupt routine of the "Local Timer Interrupt" for core 3.
This helps, however it is really an ugly hack and I am looking
for a smarter way to do that. I have done this just to identify
the cause of the jitter.

The issue is here, that the interrupt routine of the kernel
takes too long here.
It would be fine to have the timer interrupt called more=20
often and to process with each call only a subset of the=20
jobs to be done...
This would reduce the time the CPU the user mode=20
is interrupted by the timer routine.

The idea of running this application in an endless loop is to avoid
to use timers (including the interrupt latency caused by them).
By pure polling, no interrupt is required.

Regards

Mathias

> | Hi all!
> |=20
> | I am running the RT_PREEMPT kernel 2.6.31.2-rt13 on a Intel Quad Co=
re
> CPU.
> | I start my kernel with isolcpus=3D1-7 option to force all processes=
 to run
> on CPU core 0 only.
> | Now we have the need for a very fast loop. Within this loop some ac=
cesses
> from/to a PCIe I/O board
> | (mapped in user space) and some additional computation has to be do=
ne.
> | For this, I use a real time thread, run this on CPU core 3 and let =
it run
> in an endless polling loop.
> | So far everything works fine.
> | This thread is the only running user mode thread on CPU core 3.
> | However, we measure some run time jitters when accessing the I/O bo=
ard in
> the range of up to=20
> | 15 microseconds which are not tolerable by the application.
> | I see that on all cores the "Local Timer Interrupt" occurs 100 time=
s a
> | second (of course this is the timer frequency select in the kernel
> configuration).
>=20
> Are CPU0 and CPU3 on the same socket? Are you using a SMP or a NUMA b=
ox? I
> would suggest running your application in a CPU on a different socket=
 just
> to ensure you are not having any cache issues.
>=20
> Have you tried running hwlat_detect or smi-test? Your 15us threshold =
is
> pretty
> tight and could easilly be affected by SMI spikes (if present in your
> system).
>=20
> Luis
>=20


--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst=
 mit und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
