From: Oliver <lich000king@yahoo.de>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Sun, 11 Oct 2015 12:28:41 +0000 (UTC)
Message-ID: <loom.20151011T141552-925@post.gmane.org>
References: <3671201425478878@web10j.yandex.ru> <loom.20150306T043408-818@post.gmane.org> <loom.20150309T025355-426@post.gmane.org> <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru> <loom.20150331T153850-579@post.gmane.org> <loom.20150927T172648-968@post.gmane.org> <560B9543.1020106@autostatic.com> <loom.20150930T110905-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40574 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbbJKM3H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Oct 2015 08:29:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1ZlFkM-0000pg-Oa
	for linux-rt-users@vger.kernel.org; Sun, 11 Oct 2015 14:29:02 +0200
Received: from 80-218-108-93.dclient.hispeed.ch ([80.218.108.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 11 Oct 2015 14:29:02 +0200
Received: from lich000king by 80-218-108-93.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 11 Oct 2015 14:29:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi there

Tested again. I still get the behaviour described by Mikhail in Linux 4.1.10
using the 4.1.7-rt-8 patch (I am runningn OpenADK, http://www.openadk.org )

I.e.
$ cyclictest --smp -p51 -m
makes the rpi 2 freeze after a few minutes at most.

Adding dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0 dwc_otg.nak_holdoff=0
to cmdline fixes this (the patch mentioned by Mikhail is already in place).

@ Jeremy,
If this does no longer happen to you in 4.1.7-rt-8, it must have been fixed
somewhere else. Any idea where?

In addition, as already mentioned:
While the freezes are fixed, I still get trouble with kodi video playback
with rt enabled. I found out that this only happens when playing over lan,
not when playing directly from the sd!
This may be due to the non-FIQ driver giving poorer network performance. But
it still only happens with rt enabled.

Any chance the incomnpatibility with the rt patch will be fixed in the FIQ
driver?

Oliver

