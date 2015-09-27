From: Oliver <lich000king@yahoo.de>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Sun, 27 Sep 2015 15:44:58 +0000 (UTC)
Message-ID: <loom.20150927T172648-968@post.gmane.org>
References: <3671201425478878@web10j.yandex.ru>  <loom.20150306T043408-818@post.gmane.org>  <loom.20150309T025355-426@post.gmane.org> <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru> <loom.20150331T153850-579@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49371 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbI0RFM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Sep 2015 13:05:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1ZgFNo-0001lO-Ne
	for linux-rt-users@vger.kernel.org; Sun, 27 Sep 2015 19:05:04 +0200
Received: from 80-218-108-93.dclient.hispeed.ch ([80.218.108.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Sep 2015 19:05:04 +0200
Received: from lich000king by 80-218-108-93.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Sep 2015 19:05:04 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Same issue in RPi 2 running linux 4.1.6 with PREEMPT_RT_FULL.

Kodi-video playback gives skipped frames and freezes after a few minutes
which does not happen when rt is disabled (with FIQ enabled or disabled, it
does not matter).

Turning off FIQ as suggested by Mikhail gives the expected behaviour for
cyclictest and also prevents the freezes in kodi which is great, so thanks
for that hint!

However, I still get skipped frames in kodi.

Is it possible there is another/related issue?

Oliver

