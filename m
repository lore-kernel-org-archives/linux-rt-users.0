From: Julien Ciesla <jciesla@resologis.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Tue, 31 Mar 2015 13:47:10 +0000 (UTC)
Message-ID: <loom.20150331T153850-579@post.gmane.org>
References: <3671201425478878@web10j.yandex.ru>  <loom.20150306T043408-818@post.gmane.org>  <loom.20150309T025355-426@post.gmane.org> <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41474 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248AbbCaNrq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Mar 2015 09:47:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1YcwVt-0000OW-Is
	for linux-rt-users@vger.kernel.org; Tue, 31 Mar 2015 15:47:29 +0200
Received: from modemcable043.17-37-24.static.videotron.ca ([24.37.17.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Mar 2015 15:47:29 +0200
Received: from jciesla by modemcable043.17-37-24.static.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Mar 2015 15:47:29 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Mikhail,

With my own branch 3.18.9, I applyed your solution with "patch-3.18.9-
rt5" but my Pi2 was not able to boot anymore. So I synced to the latest 
3.18.y commit on raspberry linux 
(https://github.com/raspberrypi/linux/commit/2e529746b6de7633ffd02c27c1f
70a1df30fe243), which is on linux 3.18.10. I updated the "patch-3.18.9-
rt5" to fit on the latest kernel and now, All is working well. Let me 
know if you want the updated RT5 patch for kernel 3.18.10.

Regards,

Julien Ciesla

