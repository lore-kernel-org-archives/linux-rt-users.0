From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [RT PATCH v2] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 14:12:55 -0400
Message-ID: <48B83C27.3090908@gmail.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <20080829180135.22450.54780.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B2C7BEE8E0D67C0E25B9BD4"
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	shemminger@vyatta.com
To: andi@firstfloor.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:40178 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbYH2SPS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 14:15:18 -0400
Received: by py-out-1112.google.com with SMTP id p76so586910pyb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Aug 2008 11:15:18 -0700 (PDT)
In-Reply-To: <20080829180135.22450.54780.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B2C7BEE8E0D67C0E25B9BD4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gregory Haskins wrote:
> *Patch submitted for inclusion in PREEMPT_RT 26-rt4.  Applies to 2.6.26=
=2E3-rt3*
>
> Hi Ingo, Steven, Thomas,
>   Please consider for -rt4.  This fixes a nasty deadlock on my systems =
under
>   heavy load.
>
> [
> Changelog:
> 	v2: only touch seqlock_t because raw_seqlock_t doesn't require
> 	    serialization and userspace cannot modify data during a read
>
> 	v1: initial release
> ]
>  =20

Hi Andi,
  As it turns out, my distcc backend was an x86_64 machine running the
v1 patch and I started to notice sometime today that certain cc1 jobs
were sometimes (albeit rarely) segfaulting on me.  I noticed that before
I even published the first patch, but I chalked it up to a corrupt .o on
my NFS home.  Plus I was forgetting that the distcc machine was running
the patch, and I would probably have never made the userspace connection
had you not mentioned it.  In any case, I self-built this v2 patch with
v2 applied, and the segfaults have gone away.  So I think we know
several things:

1) You were right that this would cause an issue if the slow path is hit.=

2) Steven was right that userspace must use raw_seqlock_t because it no
longer crashes with v2.
3) I am satisfied that my primary concern is still properly addressed.

Hopefully everyone is satisfied with this patch now.

Thanks for the help.  It's much appreciated!

-Greg



--------------enig1B2C7BEE8E0D67C0E25B9BD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki4PCgACgkQP5K2CMvXmqHiFgCggrJAb0vr4nQBTAuUIvPIh108
PlYAn0WHqPnuA0T/WSjNF5d5MurKyPFI
=Gvsv
-----END PGP SIGNATURE-----

--------------enig1B2C7BEE8E0D67C0E25B9BD4--
