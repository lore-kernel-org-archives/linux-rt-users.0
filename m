From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Tue, 26 Feb 2013 09:10:42 +0100
Message-ID: <20130226081042.GB22886@pengutronix.de>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
 <457E1107-480D-493F-9073-4AE455BA3BD2@thebigcorporation.com>
 <CA+69FtAWbTm-9vJYXnV3xOFNRKd4iKvh0Uo83ct_qqm9S2b9Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758678Ab3BZIKp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 03:10:45 -0500
Content-Disposition: inline
In-Reply-To: <CA+69FtAWbTm-9vJYXnV3xOFNRKd4iKvh0Uo83ct_qqm9S2b9Cw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Mon, Feb 25, 2013 at 11:24:05PM +0200, Hartmut Behrens wrote:
> No, neither of these work (realtime groupnames that were tried:
> realtime  / rtprio)
>=20
> This might be related:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D619938 but I have =
yet
> to dig into the details.
That is not the problem. If you didn't fiddle with your pam config
running as root should work. You can add such a group by following
Clark's suggestion.

Do you run a vanilla Debian system? I guess the kernel was created by
you as I'm not aware that Debian's kernel support gumstix. Can you
provide your .config in that case?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
