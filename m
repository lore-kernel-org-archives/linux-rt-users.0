From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: RT + comedi (dual boot ubuntu 9.10/debian 7.0)
Date: Wed, 26 Jun 2013 16:04:21 +0200
Message-ID: <20130626140421.GA27010@pengutronix.de>
References: <ce1-51cae800-39-67adc880@74461503>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Braud Caroline <Caroline.Braud@univ-lille1.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42194 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab3FZOEX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 10:04:23 -0400
Content-Disposition: inline
In-Reply-To: <ce1-51cae800-39-67adc880@74461503>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Braud,

On Wed, Jun 26, 2013 at 03:08:51PM +0200, Braud Caroline wrote:
> I was using ubuntu 9.10 (ubuntustudio-9.10-alternate-amd64.iso) with =
linux-rt package.
> It was working well, I could run the Cyclictest with good RT jitters.
> Also, I was using comedi and could manage a USBDUX board and a M&C bo=
ard (PCI-DAS6036).
>=20
>  I needed to update my distrib for some reasons, so I did some search=
 and found that Ubuntu does not support anymore the package linux-rt ..=
=2E so I couldn't keep RT with an update version of ubuntu ...
> I installed a debian distrib in dual boot using a liveCD (debian live=
cd 7.0 AMD64, Gnome).
> Everthing went well and I could drive my board (PCI-DAS6036) with com=
edi without any problems.
>=20
> Here is the structure of my disk:
> /dev/sda1 =3D /boot
> /dev/sda2 =3D /  (Unbuntu 9.10)
> /dev/sda6 =3D /  (debian 7.0)
> /dev/sda7 =3D /home=20
>=20
> with a common swap, home and boot for both distributions
>=20
> $ sudo fdisk -l
> Disque /dev/sda : 80.0 Go, 80026361856 octets
> 255 t=EAtes, 63 secteurs/piste, 9729 cylindres, total 156301488 secte=
urs
> Unit=E9s =3D secteurs de 1 * 512 =3D 512 octets
> Taille de secteur (logique / physique) : 512 octets / 512 octets
> taille d'E/S (minimale / optimale) : 512 octets / 512 octets
> Identifiant de disque : 0x000aa812
>=20
> P=E9riph=E9rique Amorce  D=E9but        Fin      Blocs     Id  Syst=E8=
me
> /dev/sda1   *          63      208844      104391   83  Linux
> /dev/sda2          208845    61641404    30716280   83  Linux
> /dev/sda3        61641466   156296384    47327459+   5  =C9tendue
> /dev/sda5        61641468    70027334     4192933+  82  partition d'=E9=
change Linux / Solaris
> /dev/sda6        70027398   131459894    30716248+  83  Linux
> /dev/sda7       131459958   156296384    12418213+  83  Linux
>=20
>=20
> I was quite happy with that and I decided to boot the rt of the debia=
n
> distribution. It was not working (it was frozen at the login stage
You're saying that Debian 7.0 works fine with the non-rt kernel, but
hangs with the -rt flavour kernel? That's the problem I suggest to
address. What means "frozen at the login stage" exactly? Does your
machine is still pingable then? I don't know what the comedi driver is
used for, but IIRC it is still in staging, so can you reproduce without
loading the comedi driver?

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
