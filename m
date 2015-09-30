From: Oliver <lich000king@yahoo.de>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Wed, 30 Sep 2015 09:13:34 +0000 (UTC)
Message-ID: <loom.20150930T110905-205@post.gmane.org>
References: <3671201425478878@web10j.yandex.ru> <loom.20150306T043408-818@post.gmane.org> <loom.20150309T025355-426@post.gmane.org> <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru> <loom.20150331T153850-579@post.gmane.org> <loom.20150927T172648-968@post.gmane.org> <560B9543.1020106@autostatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52205 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbbI3JNo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2015 05:13:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1ZhDSH-00034E-Kh
	for linux-rt-users@vger.kernel.org; Wed, 30 Sep 2015 11:13:41 +0200
Received: from 80-218-108-93.dclient.hispeed.ch ([80.218.108.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2015 11:13:41 +0200
Received: from lich000king by 80-218-108-93.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2015 11:13:41 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jeremy

> Try removing all FIQ related stuff from your cmdline.txt and just use
> the defaults. Works fine for me with 4.1.7-rt8.

Well I only ended up disabled FIQ because with it enabled I get the freezes
described by Mikhail (and kodi video playback freezes as well). With FIQ
disabled I non longer have the freezes, but the skipped frames (that I don't
get when rt-preempt is disabled) remain.

I will try 4.1.7.rt-8 though.

Oliver

