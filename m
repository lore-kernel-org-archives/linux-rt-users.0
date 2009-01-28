From: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Subject: RE: Realtime capability of ioctl() vs. read() and write()
Date: Wed, 28 Jan 2009 09:09:37 +0100
Message-ID: <CEE27071B8F0914B91B3076CEB63C2B6080240F7@de01ex08.GLOBAL.JHCN.NET>
References: <200901280834.28139.claus.gindhart@kontron.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0889570140=="
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Claus Gindhart <claus.gindhart@kontron.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx02.jhcn.net ([194.25.102.130]:42682 "EHLO mx02.jhcn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbZA1IWK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2009 03:22:10 -0500
In-Reply-To: <200901280834.28139.claus.gindhart@kontron.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--===============0889570140==
MIME-Version: 1.0
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

try to use .unlocked_ioctl instead of .ioctl for your drivers file_operatio=
ns struct.

Andreas

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Claus Gindhart
> Sent: Wednesday, January 28, 2009 8:34 AM
> To: linux-rt-users@vger.kernel.org; Gerd Koenig; Peter Widmann
> Cc: klaus weschmann; Jochen Beier
> Subject: Realtime capability of ioctl() vs. read() and write()
>=20
> I am running a Linux 2.6.24.7-rt21 Kernel on our HW.
>=20
> This HW contains a number of IO-Ports, and the drivers for these IO-
> Ports are
> designed in a way, that various ioctl() function provide the interface
> to
> these Ports.
>=20
> Now, i recognized, that processes, which are using such ioctl()'s,
> absolutely
> do not run in realtime (regardless on the priority). If i cat a huge
> file to
> a /dev/ttyX device, the process jitters for many milliseconds.
>=20
> This does NOT happen, if i modify the driver and the user space process
> to
> access IO's via read() and write() instead of ioctl()'s.
>=20
> My question is: Is it a known and intended behaviour, that ioctl()'s
> ruin
> realtime behaviour, and that IO's should only be accessed via read()
> and
> write() ?
> I didnt find any documentation, which would advice me not to use
> ioctl() in
> realtime applications.
>=20
> --
> Mit freundlichen Gruessen / Best regards
>=20
> Claus Gindhart
> SW R&D
> Kontron Modular Computers
> phone :++49 (0)8341-803-374
> mailto:claus.gindhart@kontron-modular.com
> http://www.kontron.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-
> users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============0889570140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------------------------------------------------------------------------=
----------------------------
Registergericht: Traunstein / Registry Court: HRB 275 =E2=80=93 Sitz / Head=
 Office: Traunreut
Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Burkhard
Gesch=C3=A4ftsf=C3=BChrung / Management Board: Thomas Sesselmann (Vorsitzen=
der / Chairman),
Michael Grimm, Matthias Fauser

E-Mail Haftungsausschluss / E-Mail Disclaimer: http://www.heidenhain.de/dis=
claimer


--===============0889570140==--
