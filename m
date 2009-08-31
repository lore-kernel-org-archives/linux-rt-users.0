From: Cliff Brake <cliff.brake@gmail.com>
Subject: RT tests on OMAP3
Date: Mon, 31 Aug 2009 16:50:53 -0400
Message-ID: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: rt-users <linux-rt-users@vger.kernel.org>,
	Linux OMAP Users <linux-omap@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:60533 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZHaU57 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2009 16:57:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to run 2.6.31-rc8-rt9-omap1 on a OMAP3 cpu.  So far, it
seems fairly unstable:

http://www.bec-systems.com/omap-rt-tests/

2.6.31-rc8-rt9 boots and runs well on a PXA270.

The following mail also references udev failures:
http://lkml.org/lkml/2009/8/11/250

Any suggestions on how to debug this?  I'd be glad to do testing, etc.

The OMAP3 is superscaler where the PXA270 is not.

Thanks,
Cliff
