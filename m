From: Tim Sander <tim@krieglstein.org>
Subject: Re: AW: Large latencies with 4.4.1-rt6
Date: Thu, 25 Feb 2016 13:52:21 +0100
Message-ID: <7328385.lupKz22AGa@dabox>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de> <2742233.B1dMNehWr7@dabox> <1A2AF5F768264E479963C4D8C015EB691B6973E6@dlrexmbx03.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:51920 "EHLO
	lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279AbcBYMwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 07:52:23 -0500
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B6973E6@dlrexmbx03.intra.dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Martin
Am Donnerstag, 25. Februar 2016, 12:47:31 schrieb Martin.Wirth@dlr.de:
> > I have also seen a latency increase with 4.4.1-rtX releases. I have=
 the
> > impression that some stable kernel updates made it worse. Care to t=
est
> > 4.4-
> > rt3 or 4.4-rt4? Had not the chance to pin them down by now.
>=20
> The worst case cyclictest latencies (running over serveral hours) wit=
h pre
> 4.4.x-rt versions were below 10 =B5s for an idle system and below 23 =
=B5s for a
> kernel compile with make -j4. Since this is a machine with is in lab-=
use
> during the day I hesitate a bit to try too early 4.4.x version which =
might
> be instable enough to eat my disk.
Well the 4.4 releases have been pretty stable for me on ARM but your mi=
lage=20
may by different...

Best regards
Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
