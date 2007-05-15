From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Tue, 15 May 2007 20:08:54 +0200
Message-ID: <200705152008.54949.jbe@pengutronix.de>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it> <1179228729.5139.6.camel@godzilla.tecnorama.it> <1179229315.5704.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alessio Igor Bogani <abogani@texware.it>,
	linux-rt-users@vger.kernel.org
To: Peter Feuerer <peter@piie.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:47919 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755879AbXEOSI7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2007 14:08:59 -0400
In-Reply-To: <1179229315.5704.25.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 15 May 2007 13:41, Peter Feuerer wrote:
> Hi Alessio,
>
> On Tue, 2007-05-15 at 13:32 +0200, Alessio Igor Bogani wrote:
> > Hi Peter,
> >
> > On Tue, 2007-05-15 at 13:26 +0200, Peter Feuerer wrote:
> > [...]
> >
> > > > First of all, running a realtime OS on such a machine is no goo=
d
> > > > idea, as it is full of system management software that steals y=
ou the
> > > > CPU.
> > >
> > > What do you mean by "system management software"? The only softwa=
re
> > > running on my gx1 hardware is my linux system with kernel 2.6.18 =
using
> > > rt preempt patch and compiled for x86.
> >
> > This type of software is implemented into BIOS.
>
> I see. Thanks for this information, that's realy annoying!

No, it makes this x86 system compatible to standard pc. Try to run any =
time=20
critical software and scroll your text console screen (it must be a tex=
t=20
console, no graphical one). You will get very nice results....
(side note: Text mode is completely emulated in SMM)

> > [...]
> >
> > > I tried this for rt-preempt patched kernels > 2.6.18 (where acpi =
is
> > > needed for the highres timer) but still no hard realtime capabili=
ty.
> >
> > I'm trying 2.6.21-rt1 and it _seems_ works (not tested yet).
>
> The kernel itself was booting up, and running fine, but cyclictest an=
d
> my little square wave example
> (http://rt.wiki.kernel.org/index.php/Squarewave-example) were not abl=
e
> to achieve stable timings.

Once again. On this piece of hardware there is no other useful timer as=
 the=20
PIT.

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-5121-206917-7 |  Fax: +49-5121-206917-9
