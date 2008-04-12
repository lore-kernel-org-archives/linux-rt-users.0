From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: Re: RT_PREEMPT and Serial Port
Date: Sat, 12 Apr 2008 19:34:28 -0400
Message-ID: <20080412233428.GA4261@alumnos.inf.utfsm.cl>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl> <20080412200837.GA6223@mgross-t43>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: mgross <640e9920@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:54165 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbYDLXef (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Apr 2008 19:34:35 -0400
Content-Disposition: inline
In-Reply-To: <20080412200837.GA6223@mgross-t43>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Apr 12, 2008 at 01:08:37PM -0700, mgross wrote:
> On Fri, Apr 04, 2008 at 03:57:53AM -0400, Mauricio A. Araya L=EF=BF=BD=
pez wrote:
> > Hi all,
> >=20
> > I've been searching on the web (and in the rt-wiki) for the current
> > status of the real-time support for devices. For instance
> > the serial port, CAN Bus, etc.
> >=20
[...]

> FWIW I was able to get +/- 30usec jitter from a serial port experimen=
t
> where I programmed a PIC to push 5 bytes over the serial line every
> 20ms.=20
My results are similar. A 30 usec jitter it seems to be the limit,
but indeed the jitter is less, because the latency is near the
10 usec. But, that is "on average", because I've run several
test during long time periods, and my worst jitter is like 5 msec!,
which is too much. Maybe it is a hardware problem, but I am using
no swap, no usb and no DMA, and I dont know which other thing
i should disable to not have this huge random jitter.
(Obviosly I am locking the memory to have no paging)

> I had a blocking read from a FIFO pthread that would wake up
> and call gettimeofday, which I used to measure the jitter. =20

I have the same idea, but using clock_gettime which use timespec
(nanoseconds) like nanosleep.=20

> It was
> very impressive.  I'm pretty confident that *if* you use a hardware
> serial port (no-USB) you will be able to implement effective PID
> controls with a real time pthread program running on a RT-preempt
> kernel.=20

In summary, i am reading from other computer the data sent by a serial
port, and almost always I have a 30-40 usec jitter, but sometimes
I get a single point where the jitter is like 1-5 msec. The strange
thing is that the sender shows perfect timing (less that 30 usec),
but the reader get these strange jumps. I am downloading the last
kernel to check the serial port driver code: the patch -rt do something
with the serial port? or generally some hardware related pacth?

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
