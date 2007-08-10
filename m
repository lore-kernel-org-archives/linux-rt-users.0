From: John Sigler <linux.kernel@free.fr>
Subject: Request for comments on dejittering app
Date: Fri, 10 Aug 2007 17:39:17 +0200
Message-ID: <46BC86A5.4010506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:42518 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760616AbXHJPjw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 11:39:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I'd like to describe what I'm trying to do, so people can comment.

Basically I'm just transfering data between two systems over a network=20
(possibly the Internet, but not necessarily).

(Systems A and B are synchronized by NTP.)

System A receives data from an input device on the PCI bus. This input=20
device provides data at constant bit rate R, meaning if the driver=20
requests B bytes, the DMA will take approximately B/R seconds.

I wrote a 'send' (user space) app on system A which requests 1316 bytes=
=20
from the input device, adds an RTP header, and sends this data in a UDP=
=20
datagram to system B. The RTP header provides, notably, a sequence=20
number and a timestamp.

The datagrams travel over several networks, a few get lost, some arrive=
=20
at system B, not necessarily in the order they were sent, and definitel=
y=20
not every B/R seconds.

I wrote a 'recv' (user space) app on system B whose job is to receive=20
the packets from system A and re-send them (either to an output device=20
on the PCI bus, or to another system on the LAN) after having removed=20
the network jitter.

Here's my implementation:

Note: Packet P{i} contains a timestamp T{i}

buffer N packets
grab the current (absolute, CLOCK_REALTIME) time H{0}
send P0

for i=3D1 to infinity
{
   recv() a few packets (e.g. 3 at most)
   compute H{i} =3D H{i-1} + (T{i} - T{i-1})
   sleep until H{i}
   send packet P_i
}

The packets were timestamped on system A,
thus for every i, T{i} - T{i-1} =3D ~B/R
Therefore, most of the network jitter will be removed.

Any comments so far?

Now all this seems nice in theory, but I'd also like to make it work in=
=20
practice! (And I'm having some problems.)

R is typically 38 Mbit/s =3D> B/R is typically 277 =B5s
Obviously, I'm going to need high-resolution timers if I want to sleep=20
for so small an interval.

As far as I understand, each packet received will generate one IRQ, and=
=20
each write to the PCI output device will generate one IRQ. This means=20
3600 IRQs per second from the NIC, and 3600 IRQs per second from the PC=
I=20
device. Is that reasonable? (Considering a 1267 MHz P3 with no IO-APIC.=
)

It is easy to reduce the number of IRQs from the PCI device by grouping=
=20
several packets for a single write. It might be worthwhile.

One problem I have is that the PCI device's driver blocks until the=20
device has acknowledged the data, and the write operation sometimes=20
blocks for 200, 300, even 400 =B5s (I have not been able to tell why).

I might not need -rt, if I'm willing to handle several packets every=20
time I wake up?

buffer N packets
grab the current (absolute) time H{0}
send P0

for i=3D1 to infinity
{
   sleep for at least X ms
   recv() some packets (how many? as much as I can?)
   grab the current time Hnow
   while H{i} < Hnow send P{i}
}

(Rough pseudo-code.)

I'm eager to hear anyone's comments and suggestions.

Regards.
