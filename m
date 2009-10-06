From: Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Tue, 6 Oct 2009 08:47:40 +0200
Message-ID: <20091006064740.GB14219@isw.uni-stuttgart.de>
References: <1804966706.191254768514851.JavaMail.root@groupware>
 <369171892.211254768721569.JavaMail.root@groupware>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from isw70.isw.uni-stuttgart.de ([141.58.102.70]:55444 "EHLO
	mail.isw.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZJFGse (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2009 02:48:34 -0400
Content-Disposition: inline
In-Reply-To: <369171892.211254768721569.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jose,

hmm, i have a similar issue with my network interfaces on one special compu=
ter. At first I thought it is a bug in some pci card driver. But since the =
same setup works on a mainboard with different chipset and CPU, I do not as=
sume that any longer.

My computer with the similar issue has an nVidia chipset, see lspci beneath=
=2E Does your computer have the same chipset?

$ lspci=20
00:00.0 Host bridge: nVidia Corporation MCP73 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
2)
00:01.0 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.1 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.2 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.3 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.4 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.5 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:01.6 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:02.0 RAM memory: nVidia Corporation nForce 630i memory controller (rev a=
1)
00:03.0 ISA bridge: nVidia Corporation MCP73 LPC Bridge (rev a2)
00:03.1 SMBus: nVidia Corporation MCP73 SMBus (rev a1)
00:03.2 RAM memory: nVidia Corporation MCP73 Memory Controller (rev a1)
00:03.4 RAM memory: nVidia Corporation MCP73 Memory Controller (rev a1)
00:04.0 USB Controller: nVidia Corporation GeForce 7100/nForce 630i (rev a1)
00:04.1 USB Controller: nVidia Corporation GeForce 7100/nForce 630i (rev a1)
00:08.0 IDE interface: nVidia Corporation MCP73 IDE (rev a1)
00:09.0 Audio device: nVidia Corporation MCP73 High Definition Audio (rev a=
1)
00:0a.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev a1)
00:0b.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev a1)
00:0c.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev a1)
00:0d.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev a1)
00:0e.0 IDE interface: nVidia Corporation Device 07f0 (rev a2)
00:0f.0 Ethernet controller: nVidia Corporation MCP73 Ethernet (rev a2)
00:10.0 VGA compatible controller: nVidia Corporation GeForce 7100/nForce 6=
30i (rev a2)
01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)


Best regards, Hans-Peter Bock
--=20
(=B0< Hans-Peter Bock, Dipl.-Ing., http://www.isw.uni-stuttgart.de/ >=B0)
(/) ISW - Universit=E4t Stuttgart, Seidenstra=DFe 36, 70174 Stuttgart (\)

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQEcBAEBAgAGBQJKyugMAAoJEFsH0RM0g3luHfEH/2wc/uQSsrrN8ScyUb7zChgj
UXgqCRQAUp880S1yJZzMFKIiXZmUXlZJd78imLzZBQse2bLAfWms80r5ifgdBn5X
BxaZEGQ1X0C3zwKTCDbPvzt+gWjf+VD11sGnKrnGovexf/FR/WUz2Hw2Qd16QOSN
B2hYM+RSxCJxFsBdiBODFPZ3j5bhQKFvPQVcsDOjtlYbzXgey5jaOiITZ2ku0YWE
oXJP1OZGeRRmgqVYZhR0Ti4b/09RC4Q9Jt9MdEEObxVJBOWe0Fw08j7uOJhrbMJD
I5GggDdJJUg9HKRgby6qLZzWKhzJiUKDrrk75tEp/aJGrVGTtbTsvlVYrK0Iy84=
=2nlm
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
