From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 16:48:05 +0100
Message-ID: <200801101648.05550.jbe@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51065 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755146AbYAJPsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 10:48:13 -0500
In-Reply-To: <47861ACE.9060301@grandegger.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 10 January 2008 14:17, Wolfgang Grandegger wrote:
> Hi Robert,
>
> Robert Schwebel wrote:
> > Wolfgang,
> >
> > On Wed, Jan 09, 2008 at 11:51:07PM +0100, Robert Schwebel wrote:
> >> Throwing in the versions from 2.6.23.3-rt5 doesn't help, the effec=
t
> >> stays the same. So I assume it is a side effect.
> >
> > Can you test the following patch by John Stulz (thanks to John for =
the
> > quick help on irc!), which fixes the issues on my board:
> >
> > ----------8<----------
> > Index: linux-2.6.24-rc5/arch/powerpc/kernel/time.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.24-rc5.orig/arch/powerpc/kernel/time.c
> > +++ linux-2.6.24-rc5/arch/powerpc/kernel/time.c
> > @@ -773,7 +773,7 @@ void update_vsyscall(struct timespec *wa
> >  	stamp_xsec =3D (u64) xtime.tv_nsec * XSEC_PER_SEC;
> >  	do_div(stamp_xsec, 1000000000);
> >  	stamp_xsec +=3D (u64) xtime.tv_sec * XSEC_PER_SEC;
> > -	update_gtod(clock->cycle_last, stamp_xsec, t2x);
> > +	update_gtod(clock->cycle_last-clock->cycle_accumulated, stamp_xse=
c,
> > t2x); }
> >
> >  void update_vsyscall_tz(void)
> > ----------8<----------
> >
> > With this patch ontop of 2.6.24-rc5-rt1 plus the board support patc=
hes
> > for the phyCORE-MPC5200B-tiny, I get this result from cyclictest, a=
gain
> > under "(while true; do hackbench 10; done) &" load:
> >
> > T: 0 (  867) P:80 I:   10000 C:  105002 Min:      31 Act:      48 A=
vg:  =20
> >   51 Max:      92
>
> Unfortunately, it doesn't really help on my Icecube board.
>
> bash-3.00# ./cyclictest -n -p80 -i1000
> 129.85 93.18 38.05 4/45 6354
> 130.41 162.23 83.05 3/49 8395
> T: 0 ( 4621) P:80 I:1000 C: 477097 Min:     25 Act:   64 Avg:   67 Ma=
x:
>     286
>
> bash-3.00# ./hackbench 10
> Time: 95.402
>
> Could you run your cyclictest much longer?
>
> And hackbench takes ages, already without running cyclictest:

Did your read http://lkml.org/lkml/2007/12/7/181 ? Don't know if it is=20
relevant here.

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
