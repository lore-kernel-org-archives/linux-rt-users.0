From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Tue, 8 Jan 2008 22:25:18 +0100
Message-ID: <200801082225.19774.jbe@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <4783A7A6.6030808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wolfgang Grandegger <wg@grandegger.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:57684 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751152AbYAHVZ0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jan 2008 16:25:26 -0500
In-Reply-To: <4783A7A6.6030808@grandegger.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 08 January 2008 17:41, Wolfgang Grandegger wrote:
> Robert Schwebel wrote:
> > Hi Wolfgang,
> >
> > On Tue, Jan 08, 2008 at 11:13:11AM +0100, Wolfgang Grandegger wrote=
:
> >> I gave -rt another try on my Icecube-MPC5200 board with
> >> patch-2.6.24-rc5-rt1
> >
> > Unfortunately, I only have 2.6.23.1-rt5 for the phyCORE-MPC5200B-ti=
ny
> > (400 MHz) at the moment, but I can refactor it to match your versio=
n.
>
> You are obviously using a 2.6.23.1 with private patches for MPC5200 a=
s
> there is no FEC driver or no clock event support in that version. The
> _official_ 2.6.24-rc5 finally builds fine and works for my
> Icecube-Eval-Board :-). Yes, it would make sense to add board support
> for the phyCORE-MPC5200B-tiny for that version.
>
> >> and this time I got it working with the attached little patch fixi=
ng
> >> an oops in the serial driver. Unfortunately, cyclictest reports ra=
ther
> >> high latencies up to 500 us under load:
> >
> > Can you elaborate which load you are using?
>
> "while ls; do ls; done" in a telnet window, "ping -f <host-ip>" and t=
he
> cache calibrator.
>
> >> # ./cyclictest -n -p80 -t1 -i10000
> >> 3.55 2.82 1.55 2/45 9971
> >>
> >> T: 0 (  922) P:80 I:10000 C: 64228 Min: 28 Act: 71 Avg: 78 Max: 50=
2

Please try to run cyclictest with "-q" (=3Davoid interrupts on serial o=
r network=20
connection) and test if it makes a difference.

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
