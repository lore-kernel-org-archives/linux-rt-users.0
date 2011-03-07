From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Regression nouveau driver on 2.6.33.7.2-rt30
Date: Mon, 07 Mar 2011 13:39:40 +0100
Message-ID: <4D74D20C.9060800@autostatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pony.ic.uva.nl ([145.18.40.181]:49907 "EHLO pony.ic.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab1CGNIe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 08:08:34 -0500
Received: from [146.50.80.232] (pch080232.hum.uva.nl [146.50.80.232])
	by pony.ic.uva.nl (8.13.1/8.13.1) with ESMTP id p27CdebP015713
	for <linux-rt-users@vger.kernel.org>; Mon, 7 Mar 2011 13:39:40 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear list,

With 2.6.33.7.2-rt29 I could use my dual screen set-up fine with nouveau
to span my desktop over the two screens but 2.6.33.7.2-rt30 only allows
me to mirror screens. xrandr only recognizes one screen also.

lspci | grep -i vga
01:00.0 VGA compatible controller: nVidia Corporation G86 [Quadro NVS
290] (rev a1)

Monitors: 2x Dell ST2410

I use kernels from the Tango Studio project:
http://tangostudio.tuxfamily.org/en
And have talked about it with the maintainer of that repository/distro
too and he actually found out about the regression and apparently he
also found a fix (patched 2.6.33.7.2-rt30 kernel packages are being
build and uploaded today so haven't tested those yet). I'm using Ubuntu
10.04 64bit.

Similar issue described here with possible fix:
http://forums.debian.net/viewtopic.php?f=6&t=59599

Best,

Jeremy
