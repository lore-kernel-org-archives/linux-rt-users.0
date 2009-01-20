From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Which version of preempt_realtime to use?
Date: Tue, 20 Jan 2009 08:49:03 +0100
Message-ID: <20090120074903.GX29067@pengutronix.de>
References: <1232366467.31686.10.camel@localhost.localdomain> <49748567.30201@osadl.org> <4974E686.60105@hedrich-winders.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <Carsten.Emde@osadl.org>, esn@terma.com,
	linux-rt-users@vger.kernel.org
To: =?iso-8859-15?Q?J=FCrgen?= Mell <mell@hedrich-winders.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39092 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZATHta (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Jan 2009 02:49:30 -0500
Content-Disposition: inline
In-Reply-To: <4974E686.60105@hedrich-winders.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

J=FCrgen,

On Mon, Jan 19, 2009 at 09:45:58PM +0100, J=FCrgen Mell wrote:
> The only thing which is missing for me from the 2.6.24.7-rt series is
> the patch
> "x86-fpu-fix-config_preempt-y-corruption-of-application-s-fpu-stack.p=
atch"
> , GIT commit
>  870568b39064cab2dd971fe57969916036982862 from mainline 2.6.25. This
> might cause trouble with applications which are using floating point
> arithmetics. Otherwise I am using the 2.6.24.7-rt series on a machine
> control for a 16 axes machine and it is working mostly well. There ar=
e
> only some points where I get big delays (up to some milliseconds) wit=
h
> my timer routine, where normally delays are below 50 microseconds. Up=
 to
> now I could not find the application ( X ??) which is causing this.

Can you reproduce these long latencies with cyclictest, or does it only
happen with your code?

rsc
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
