From: "Kaya, Sinan" <sinan.kaya@siemens.com>
Subject: periodic bursts
Date: Mon, 1 Oct 2007 09:51:18 +0300
Message-ID: <725A29F6B5035C45A40BDE230A5B92190F8DB322@TRISTK010MSX.tr001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.siemens.com.tr ([212.133.141.62]:53794 "EHLO
	karya.siemens.com.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXJAHAK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 03:00:10 -0400
Received: from tristk010msx.tr001.siemens.net (kapadokya.siemens.com.tr [141.29.16.101])
	by karya.siemens.com.tr (8.13.4/8.13.4/Debian-3) with ESMTP id l91712q2028387
	for <linux-rt-users@vger.kernel.org>; Mon, 1 Oct 2007 10:01:03 +0300
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello all,
My realtime system experiences periodic bursts every 4 hours. How can i=
 find the reason for this  ? I know the traceit tool but it dumps so mu=
ch data and it is useless under this case. I need to find what happened=
 at the exact time of burst.

I use rtai_smi module to disable SMI interrupts and set my network inte=
rface driver priorities to 99. So it should be something non maskable b=
ut what ?

Sinan.


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
