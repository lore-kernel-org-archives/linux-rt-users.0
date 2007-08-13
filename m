From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Request for comments on dejittering app
Date: Mon, 13 Aug 2007 08:55:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708130849230.11768@gandalf.stny.rr.com>
References: <46BC86A5.4010506@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:52325 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030771AbXHMMzW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Aug 2007 08:55:22 -0400
In-Reply-To: <46BC86A5.4010506@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 10 Aug 2007, John Sigler wrote:

> Hello,

Hi John,

>
> I'd like to describe what I'm trying to do, so people can comment.
>

>
> Any comments so far?

Well, some NICs buffer writes, and some even buffer receives. So your N=
IC
may be buffering underneath you too.

>
> Now all this seems nice in theory, but I'd also like to make it work =
in
> practice! (And I'm having some problems.)
>
> R is typically 38 Mbit/s =3D> B/R is typically 277 =B5s
> Obviously, I'm going to need high-resolution timers if I want to slee=
p
> for so small an interval.
>
> As far as I understand, each packet received will generate one IRQ, a=
nd
> each write to the PCI output device will generate one IRQ. This means
> 3600 IRQs per second from the NIC, and 3600 IRQs per second from the =
PCI
> device. Is that reasonable? (Considering a 1267 MHz P3 with no IO-API=
C.)

As mentioned above, the NIC may buffer too, so it may not be sending th=
e
packets out immediately.  Usually, a driver would send out several pack=
ets
before sending a transmit IRQ. In fact, that transmit IRQ is usually so
to tell the driver that it can write more after a certain threshold has
been reached. (It's been several years since I wrote a NIC driver, so I=
'm
going off of my old memory ;-)


>
> It is easy to reduce the number of IRQs from the PCI device by groupi=
ng
> several packets for a single write. It might be worthwhile.

May not be needed if the driver already does it.

>
> One problem I have is that the PCI device's driver blocks until the
> device has acknowledged the data, and the write operation sometimes
> blocks for 200, 300, even 400 =B5s (I have not been able to tell why)=
=2E

Not sure what you mean by saying the driver "blocks". Is it a sleeping
thread (in -rt) or from an interrupt?  Can you be more specific here.

>
> I might not need -rt, if I'm willing to handle several packets every
> time I wake up?

=46or any reaction time less than 100 us (or maybe even higher), you wi=
ll
need -rt.


-- Steve
