From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: Re: RT_PREEMPT and Serial Port
Date: Sun, 13 Apr 2008 16:54:57 -0400
Message-ID: <20080413205457.GA25327@alumnos.inf.utfsm.cl>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl> <20080412200837.GA6223@mgross-t43> <20080412233428.GA4261@alumnos.inf.utfsm.cl> <480244EB.90303@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:58360 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbYDMUzI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Apr 2008 16:55:08 -0400
Content-Disposition: inline
In-Reply-To: <480244EB.90303@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Apr 13, 2008 at 07:37:47PM +0200, Wolfgang Grandegger wrote:
> Mauricio =EF=BF=BD wrote:
> > In summary, i am reading from other computer the data sent by a ser=
ial
> > port, and almost always I have a 30-40 usec jitter, but sometimes
> > I get a single point where the jitter is like 1-5 msec. The strange
> > thing is that the sender shows perfect timing (less that 30 usec),
> > but the reader get these strange jumps. I am downloading the last
> > kernel to check the serial port driver code: the patch -rt do somet=
hing
> > with the serial port? or generally some hardware related pacth?
>=20
> Just to be sure, the interrupt thread of your serial port is running =
at
> a higher priority than the others.
>=20

Yes, the priority is 80 and a FIFO scheduler, the other threads have 70=
=2E
In QNX it works as it should. I will try the writer in linux, and the=20
reader in QNX to check what is happenig.

--=20
Mauricio Araya L.=20
ACS-UTFSM Team Leader, cel: 0-81564903
Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
counter.li.org: #249395, http://www.inf.utfsm.cl/~maray=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
