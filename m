From: Nivedita Singhvi <niv@us.ibm.com>
Subject: [Fwd: Re: [Rtibm-dev] [RFC] SLES HZ setting for "soft-realtime"]
Date: Mon, 29 Jun 2009 07:18:06 -0700
Message-ID: <4A48CD1E.7070404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Fulton <fultonm@ca.ibm.com>,
	Alan Stevens <alan_stevens@uk.ibm.com>,
	Mark Stoodley <mstoodle@ca.ibm.com>,
	Sean Foley <Sean_Foley@ca.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60368 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZF2OS2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jun 2009 10:18:28 -0400
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5TEGN6r013632
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 08:16:23 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5TEIBV8169510
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 08:18:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5TEI7Oe028991
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 08:18:07 -0600
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mike,

This was Novell's response.  It's not looking good for
HZ=3D1000 in vanilla SLES train.

If that's the case, what is going to be the customer
impact, from what you can tell?  And for Websphere
Soft Real Time going forward?

thanks,
Nivedita



-------- Original Message --------
Subject: Re: [Rtibm-dev] [RFC] SLES HZ setting for "soft-realtime"
Date: Sat, 27 Jun 2009 15:25:18 +0200
=46rom: Matthias G. Eckermann <mge@novell.com>
Reply-To: marc.ruehrschneck@novell.com, Thomas Staudt <tstaudt@de.ibm.c=
om>, rtibm-dev@forge.novell.com
To: Alex Tsariounov <alext@novell.com>, marc.ruehrschneck@novell.com,  =
Thomas Staudt <tstaudt@de.ibm.com>
CC: niv@linux.vnet.ibm.com, rtibm-dev <rtibm-dev@forge.novell.com>
References: <4A456A05.5020701@us.ibm.com> <1246063597.6101.68.camel@zuu=
l.thistledown>

Hello Alex and all @IBM,

On 2009-06-26 T 18:46 -0600 Alex Tsariounov wrote:
> On Fri, 2009-06-26 at 17:38 -0700, Darren Hart wrote:
> > IBM has recently announced a beta version of WebSphere
> > Realtime (the rt JVM)  with "soft real-time" support running
> > on 32 and 64 bit x86 platforms with standard enterprise
> > distributions.  It just came to my attention that this
> > product requires either HZ=3D1000 or NOHZ in order to meet its
> > timing requirements.  As the SLES 10 SP2 kernel has HZ=3D250,
> > I wanted to raise the issue with the Novell devs and get
> > their take on it.
> >=20
> > At this point in the SLES10 life cycle, I assume that a
> > change to HZ=3D1000 is unlikely and targetting SLES11 as a
> > supported platform would be the preferred course of action.
> > Can someone at Novell please comment?
> >=20
> > Note: I understand this is not SLE-RT related, but it is
> > real-time related, and I thought the recipients would know
> > where to best direct this question if this isn't the right
> > place.
>=20
> Yes, SLES runs at 250 Hz and it is in fact too late for SLES11
> as it has been released for a while. =20
>=20
> I can see how it would be advantageous for SLES to support
> WebSphere Soft Realtime however.  So, in this light I've CC'ed
> Matthias Eckermann who is our Product Manager for SLES to get
> his take on the possibility of changing the HZ value that SLES
> is built with and when such a change could possibly be made.

without going into technical details today to much, please let
me introduce Marc R=C3=BChrschneck (Technical Accound Manager for IBM
with Novell) and Thomas Staudt (LTC Distro Architect for
Novell/SUSE with IBM). All communication regarding feature
requests for SUSE Linux Enterprise should be coordinated by
Thomas and Marc.

According to the rules we jointly (IBM and Novell) have in place for
SUSE Linux Enterprise (Marc and Thomas, please jump in here with
explaining those rules to the teams!), and looking at the negative
impact (mainly regarding throughput) other (non-Novell) Linux Systems
are suffering from with their switch to HZ=3D1000, HZ=3D250 will remain
for SUSE Linux Enterprise Server 11 also with SP 1 and later in the
default kernel, as far as I can say. ( But we have enable CONFIG_NO_HZ
in SLES 11 - isn't that sufficient? )

so long -
	MgE

--=20
Matthias G. Eckermann
Senior Product Manager - SUSE=C2=AE Linux Enterprise  - Server Product =
Line
Phone: +49 30 44315731 - Mobile: +49 179 2949448 - E-Mail: mge@novell.c=
om
SUSE  LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG N=C3=BCrnberg)
_______________________________________________
rtibm-dev mailing list
rtibm-dev@forge.novell.com
http://forge.novell.com/mailman/listinfo/rtibm-dev
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
