From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: nvidia-kernel-source 185.18.36-2 fails to build against
	linux-image-2.6.31.2-rt13-1-amd64
Date: Mon, 2 Nov 2009 10:35:16 +0100
Message-ID: <20091102093516.GA22374@pengutronix.de>
References: <200910261411.52764.fabo@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de, linux-rt-users@vger.kernel.org,
	pkg-nvidia-devel@lists.alioth.debian.org
To: Fathi Boudra <fabo@debian.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39339 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZKBJgD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2009 04:36:03 -0500
Content-Disposition: inline
In-Reply-To: <200910261411.52764.fabo@debian.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hallali Fathi,

On Mon, Oct 26, 2009 at 02:11:52PM +0100, Fathi Boudra wrote:
> Hi,
>=20
> Everything is in the title. I'm using:
>=20
> ii  linux-image-2.6.31.2-rt13-1-amd64            2.6.31.2-rt13-1
> ii  nvidia-kernel-source                         185.18.36-2
>
> nvidia-kernel-source package builds against linux-image-2.6.31-1-amd6=
4=20
> successfully.
>=20
> you can found the build logs attached.
Generally the nvidia patches seem to introduce latencies, so you should
reconsider if you really want them.

Other than that, can you try the patch available at

	http://article.gmane.org/gmane.linux.rt.user/5065

(append "/raw" to extract the patch)?

The patch that makes the nvidia patch fail is
a15032a6f554018c0a96e923645e01f51519e22b[1].  The commit log suggests
that this might become a mainline problem later.

Best regards
Uwe

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;a=
=3Dcommitdiff;h=3Da15032a6f554018c0a96e923645e01f51519e22b;hp=3D2e27257=
04777fd240f99e568bff4e37bf03f1c73

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
