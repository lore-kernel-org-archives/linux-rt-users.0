From: mgross <640e9920@gmail.com>
Subject: Re: RT_PREEMPT and Serial Port
Date: Sun, 13 Apr 2008 11:00:08 -0700
Message-ID: <20080413180007.GA4955@mgross-t43>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl> <20080412200837.GA6223@mgross-t43> <20080412233428.GA4261@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Mauricio =?utf-8?Q?A=2E_Araya_L=EF=BF=BDpez?= <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:62921 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbYDMSAL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Apr 2008 14:00:11 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1795499waf.23
        for <linux-rt-users@vger.kernel.org>; Sun, 13 Apr 2008 11:00:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080412233428.GA4261@alumnos.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Apr 12, 2008 at 07:34:28PM -0400, Mauricio A. Araya L=EF=BF=BDp=
ez wrote:
> On Sat, Apr 12, 2008 at 01:08:37PM -0700, mgross wrote:
> > On Fri, Apr 04, 2008 at 03:57:53AM -0400, Mauricio A. Araya L=EF=BF=
=BDpez wrote:
> > > Hi all,
> > >=20
> > > I've been searching on the web (and in the rt-wiki) for the curre=
nt
> > > status of the real-time support for devices. For instance
> > > the serial port, CAN Bus, etc.
> > >=20
> [...]
>=20
> > FWIW I was able to get +/- 30usec jitter from a serial port experim=
ent
> > where I programmed a PIC to push 5 bytes over the serial line every
> > 20ms.=20
> My results are similar. A 30 usec jitter it seems to be the limit,
> but indeed the jitter is less, because the latency is near the
> 10 usec. But, that is "on average", because I've run several
> test during long time periods, and my worst jitter is like 5 msec!,
> which is too much. Maybe it is a hardware problem, but I am using
> no swap, no usb and no DMA, and I dont know which other thing
> i should disable to not have this huge random jitter.
> (Obviosly I am locking the memory to have no paging)

How long did you need to run it to hit a 5msec jitter?

My tests where only for a few min while I test compiled the kernel a
few times to see if that would effect things.

>=20
> > I had a blocking read from a FIFO pthread that would wake up
> > and call gettimeofday, which I used to measure the jitter. =20
>=20
> I have the same idea, but using clock_gettime which use timespec
> (nanoseconds) like nanosleep.=20
>=20
> > It was
> > very impressive.  I'm pretty confident that *if* you use a hardware
> > serial port (no-USB) you will be able to implement effective PID
> > controls with a real time pthread program running on a RT-preempt
> > kernel.=20
>=20
> In summary, i am reading from other computer the data sent by a seria=
l
> port, and almost always I have a 30-40 usec jitter, but sometimes
> I get a single point where the jitter is like 1-5 msec. The strange
> thing is that the sender shows perfect timing (less that 30 usec),
> but the reader get these strange jumps. I am downloading the last
> kernel to check the serial port driver code: the patch -rt do somethi=
ng
> with the serial port? or generally some hardware related pacth?
>=20
> --=20
> Mauricio Araya L.=20
> ACS-UTFSM Team Leader, cel: 0-81564903
> Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
> counter.li.org: #249395, http://www.inf.utfsm.cl/~maray=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
