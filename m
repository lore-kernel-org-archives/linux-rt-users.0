From: "Kaya, Sinan" <sinan.kaya@siemens.com>
Subject: Kexec and rt kernel
Date: Wed, 31 Oct 2007 09:41:02 +0200
Message-ID: <725A29F6B5035C45A40BDE230A5B9219104B7EC6@TRISTK010MSX.tr001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.siemens.com.tr ([212.133.141.62]:58437 "EHLO
	karya.siemens.com.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbXJaHlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 03:41:11 -0400
Received: from tristk010msx.tr001.siemens.net (kapadokya.siemens.com.tr [141.29.16.101])
	by karya.siemens.com.tr (8.13.4/8.13.4/Debian-3) with ESMTP id l9V7qIGO020259
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Oct 2007 09:52:22 +0200
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,
Although it does not have an upmost priority for me, there is an issue =
that i would like to report.=20
=20
Last week, I tried to use kexec with RT kernel (2.6.23 - rt3) but i was=
 not successful. The problem is that RT kernel does not boot up from th=
e host kernel. It loads successfully but it freezes during boot up at s=
ome point.=20
=20
After seeing this behavior, i made the following tests.=20
=20
- I used 2.6.19 vanilla kernel as host kernel and was able to boot up t=
he same 2.6.19 kernel with kexec.
- I used 2.6.19 vanilla kernel as host kernel and was able to boot up 2=
=2E6.23-rt3 with kexec
=20
with 2.6.23-rt3 as host kernel both 2.6.19 and 2.6.23-rt3 does not star=
t up.
=20
for your information,
=20
=D6mer Sinan Kaya (M.Sc.)
SIEMENS A.S. - SIS SWP TR=20
Software Engineer
 =20
Tel : +90 (216) 459 3720=20
Mobile : +90 (533) 356 6041
=46ax : +90 (216) 459 20 42
Address : Yakac=FDk Yolu No:111, 34870 Kartal, =DDstanbul , Turkey=20
Email :sinan.kaya@siemens.com <blocked::mailto:e@siemens.com> =20
