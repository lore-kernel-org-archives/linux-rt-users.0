From: Yoann LE BARS <yoann@le-bars.net>
Subject: Non-free firmware and proprietary Radeon driver on OSADL kernel
Date: Sat, 19 May 2012 00:54:02 +0200
Message-ID: <4FB6D30A.4030902@le-bars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 85-171-141-56.rev.numericable.fr ([85.171.141.56]:46117 "EHLO
	obm.le-bars.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946463Ab2ERXEu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2012 19:04:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by obm.le-bars.net (Postfix) with ESMTP id E334DF683F
	for <linux-rt-users@vger.kernel.org>; Sat, 19 May 2012 01:03:24 +0200 (CEST)
Received: from obm.le-bars.net ([127.0.0.1])
	by localhost (obm.le-bars.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OM39Uewo8Alc for <linux-rt-users@vger.kernel.org>;
	Sat, 19 May 2012 01:03:20 +0200 (CEST)
Received: from [192.168.1.22] (18.239.77.86.rev.sfr.net [86.77.239.18])
	(Authenticated sender: yoann@le-bars.net)
	by obm.le-bars.net (Postfix) with ESMTPA id AA9E6F6803
	for <linux-rt-users@vger.kernel.org>; Sat, 19 May 2012 01:03:20 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello everybody out there!

	I use OSADL last stable real-time kernel from Pengutronix
(<http://pengutronix.de/software/linux-rt/debian_en.html>) on a compute=
r
which configuration is given in the end of this message.

	On this computer, I am using Debian Squeeze (6.0), and, because I have
to do some live recording combined with MIDI playing, I need to use a
real-time kernel. As I am using Debian stable, I want to use the most
stable kernel. Therefore, I have chosen OSADL kernel.

	But I am experiencing some troubles, linked with my graphic card.
Tested on the classic kernel, I need to install =93firmware-linux-nonfr=
ee=94
and the proprietary Catalyst driver for my graphic card. If not, then
power consumption is too important, then too much heat is dissipated an=
d
display freezes after few minutes. To install the proprietary driver, I
have done the following:

# aptitude install fglrx-source fglrx-driver fglrx-glx fglrx-control
fglrx-atieventsd module-assistant build-essential linux-headers-2.6
# module-assistant a-i fglrx
# aticonfig --inital

	When I use the classic kernel, everything goes fine.

	During the installation of the real-time kernel, the configuration of
the package which should replace =93firmware-linux-nonfree=94 =96
unfortunately, I have forgotten its name =96 have failed. Also, when I =
run
the real-time kernel, it is the open-source driver that is in use. As a
consequence, after few minutes, the display freezes.

	I guess the first step is to configure the equivalent of
=93firmware-linux-nonfree=94. Unfortunately, I do not have a clue on ho=
w to
do this. As Pengutronix advises to use this mailing list, I come here t=
o
ask if anybody can help me in achieving this.

	Regards.

							Yoann

The configuration of my computer:

=96 Case: Fractal 3R;
=96 power supply: Corsair VX 450W;
=96 fan: 120mm Noctua NF-S12B ULN;
=96 motherboard: Gigabyte H55M-USB3 (=B5ATX LGA1156+DDR3+PCI-E);
=96 processor: Intel Core i5 760 (2.8 QuadCore LGA1156);
=96 radiator: Noctua NH-U9B SE2 775/1156/1366;
=96 memory: 2x2 =3D 4 Go DDR3-1333 PC10600 Kingston;
=96 graphic card: MSI R4350-MD512H/D3 Radeon HD 4350 512MB;
=96 audio card: M-AUDIO Delta Audiophile 24/96 PCI;
=96 SSD unit: 120 Go SATA SSD Intel X25-M Postville MLC;
=96 hard-drive: 1.5 To SATA WD Green 64 Mo cache;
=96 CD/DVD/Blu-Ray drive: burner CD/DVD LG Black 10X BD-ROM 16X DVD-ROM=
=2E
-- Vous utilisez la version libre et gratuite d'OBM, d=E9velopp=E9e et
support=E9e par Linagora. Contribuez =E0 la R&D du produit en souscriva=
nt =E0
une offre entreprise. http://pro.obm.com/ - http://www.linagora.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
