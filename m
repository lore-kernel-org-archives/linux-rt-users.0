From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: RT_PREEMPT and Serial Port
Date: Sun, 13 Apr 2008 15:56:48 -0300
Message-ID: <20080413185648.GC11343@ghostprotocols.net>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl> <20080412200837.GA6223@mgross-t43> <20080412233428.GA4261@alumnos.inf.utfsm.cl> <20080413180007.GA4955@mgross-t43>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mauricio =?utf-8?Q?A=2E_Araya_L=EF=BF=BDpez?=
	<maray@inf.utfsm.cl>, linux-rt-users@vger.kernel.org
To: mgross <640e9920@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbYDMS45 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Apr 2008 14:56:57 -0400
Content-Disposition: inline
In-Reply-To: <20080413180007.GA4955@mgross-t43>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Sun, Apr 13, 2008 at 11:00:08AM -0700, mgross escreveu:
> On Sat, Apr 12, 2008 at 07:34:28PM -0400, Mauricio A. Araya L=EF=BF=BD=
pez wrote:
> > On Sat, Apr 12, 2008 at 01:08:37PM -0700, mgross wrote:
> > > On Fri, Apr 04, 2008 at 03:57:53AM -0400, Mauricio A. Araya L=EF=BF=
=BDpez wrote:
> > > > Hi all,
> > > >=20
> > > > I've been searching on the web (and in the rt-wiki) for the cur=
rent
> > > > status of the real-time support for devices. For instance
> > > > the serial port, CAN Bus, etc.
> > > >=20
> > [...]
> >=20
> > > FWIW I was able to get +/- 30usec jitter from a serial port exper=
iment
> > > where I programmed a PIC to push 5 bytes over the serial line eve=
ry
> > > 20ms.=20
> > My results are similar. A 30 usec jitter it seems to be the limit,
> > but indeed the jitter is less, because the latency is near the
> > 10 usec. But, that is "on average", because I've run several
> > test during long time periods, and my worst jitter is like 5 msec!,
> > which is too much. Maybe it is a hardware problem, but I am using
> > no swap, no usb and no DMA, and I dont know which other thing
> > i should disable to not have this huge random jitter.
> > (Obviosly I am locking the memory to have no paging)
>=20
> How long did you need to run it to hit a 5msec jitter?
>=20
> My tests where only for a few min while I test compiled the kernel a
> few times to see if that would effect things.

And have you guys tried with a ftrace/latency trace enabled kernel? It
would be really interesting to know what happens in this 5ms :-)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
