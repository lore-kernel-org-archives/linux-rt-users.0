From: Gregoire Gentil <gregoire@gentil.com>
Subject: Problem between rt-patches and OMAP SPI driver
Date: Wed, 22 Aug 2012 12:49:46 -0700
Message-ID: <503537DA.4070809@gentil.com>
References: <1345144963.3708.1.camel@gandalf.local.home> <10950377.h1F1h7Gs2a@dabox>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:52485 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab2HVTza (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Aug 2012 15:55:30 -0400
Received: from [192.168.10.5] (c-69-181-223-70.hsd1.ca.comcast.net [69.181.223.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id 0480314045563
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Aug 2012 21:49:47 +0200 (CEST)
In-Reply-To: <10950377.h1F1h7Gs2a@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

When applying the rt patches, the OMAP SPI driver referenced below=20
doesn't work well. It's working well without the rt patches.

http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=3Db=
lob;f=3Ddrivers/spi/omap2_mcspi.c;h=3D969cdd2fe124602d1e65c4218190ed3e7=
d78ccf6;hb=3D02f8c6aee8df3cdc935e9bdd4f2d020306035dbe

More precisely, I'm getting a lot of "TXS timed out" and "RXS timed out=
"=20
on line 485/495.

Q1. Has anyone made work OMAP SPI driver with rt patches?

Q2. How can I debug such problem? I have converted all the spin_lock_ir=
q=20
to raw_spin_lock_* without being sure if it's a good idea. But in any=20
case, the result is the same.

Q3. More generically, while considering a new driver, what needs to be=20
watched and patched from the rt point of view to play nicely with the=20
real-time architecture? All the mutex? Anything in the worker function?=
=20
I know that I won't become a RT expert overnight, but I'm trying to=20
understand.

Many thanks in advance for any help or pointer,

Gr=C3=A9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
