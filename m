From: John Sigler <linux.kernel@free.fr>
Subject: Re: Request for comments on dejittering app
Date: Mon, 13 Aug 2007 16:52:09 +0200
Message-ID: <46C07019.4050304@free.fr>
References: <46BC86A5.4010506@free.fr> <Pine.LNX.4.58.0708130849230.11768@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fb2.tech.numericable.fr ([82.216.111.50]:41379 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935119AbXHMPNL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Aug 2007 11:13:11 -0400
Received: from smtp2.tech.numericable.fr (smtp2.nc.sdv.fr [10.0.0.36])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id 2887A39501
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Aug 2007 16:51:56 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0708130849230.11768@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:

> John Sigler wrote:
>=20
>> Any comments so far?
>=20
> Well, some NICs buffer writes, and some even buffer receives. So your=
 NIC
> may be buffering underneath you too.

Now that you mention it, I did notice that /proc/interrupts did not=20
report the same numbers whether I send 1 packet every X ms OR N packets=
=20
every N*X ms.

By the way, what does /proc/interrupts report? The number of IRQs that=20
were actually serviced by the OS?

>> Now all this seems nice in theory, but I'd also like to make it work=
 in
>> practice! (And I'm having some problems.)
>>
>> R is typically 38 Mbit/s =3D> B/R is typically 277 =B5s
>> Obviously, I'm going to need high-resolution timers if I want to sle=
ep
>> for so small an interval.
>>
>> As far as I understand, each packet received will generate one IRQ, =
and
>> each write to the PCI output device will generate one IRQ. This mean=
s
>> 3600 IRQs per second from the NIC, and 3600 IRQs per second from the=
 PCI
>> device. Is that reasonable? (Considering a 1267 MHz P3 with no IO-AP=
IC.)
>=20
> As mentioned above, the NIC may buffer too, so it may not be sending =
the
> packets out immediately.  Usually, a driver would send out several pa=
ckets
> before sending a transmit IRQ. In fact, that transmit IRQ is usually =
so
> to tell the driver that it can write more after a certain threshold h=
as
> been reached. (It's been several years since I wrote a NIC driver, so=
 I'm
> going off of my old memory ;-)

Is /proc/interrupts a good way to tell whether the NIC is grouping=20
transmits before generating an IRQ?

>> It is easy to reduce the number of IRQs from the PCI device by group=
ing
>> several packets for a single write. It might be worthwhile.
>=20
> May not be needed if the driver already does it.
>=20
>> One problem I have is that the PCI device's driver blocks until the
>> device has acknowledged the data, and the write operation sometimes
>> blocks for 200, 300, even 400 =B5s (I have not been able to tell why=
).
>=20
> Not sure what you mean by saying the driver "blocks". Is it a sleepin=
g
> thread (in -rt) or from an interrupt?  Can you be more specific here.

(I may have several misconceptions.) In the case of network drivers,=20
when a user space process calls send, the driver copies the user data,=20
and schedules the operation to happen "sometime later".

But it "feels" like my PCI device's driver didn't copy the user space=20
data, and instead programmed the DMA directly from the user space=20
buffer, which means it has to put the user space process to sleep until=
=20
the operation is complete, which sometimes takes 100s of =B5s.

Or perhaps, there are only a few buffers (I've read something about pin=
g=20
pong DMA in the data sheet) in the driver, and because I'm writing only=
=20
small amounts of data, they are sometimes all full, because some DMA=20
operations are taking longer than usual.

The driver source code is available here:
http://dektec.com/Products/LinuxSDK/Downloads/LinuxSDK.zip

I will take a hard look at it when I come back at the office.

>> I might not need -rt, if I'm willing to handle several packets every
>> time I wake up?
>=20
> For any reaction time less than 100 us (or maybe even higher), you wi=
ll
> need -rt.

I'm still unsure whether there is a place in my app where I need a quic=
k=20
reaction time. What's your opinion?

Regards.
