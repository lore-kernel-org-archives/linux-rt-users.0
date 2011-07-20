From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Wed, 20 Jul 2011 11:02:40 +0200
Message-ID: <87hb6hpbnz.fsf@fencepost.gnu.org>
References: <alpine.LFD.2.02.1107200153070.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41446 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab1GTJC5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jul 2011 05:02:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1QjSgB-0006Dv-Dp
	for linux-rt-users@vger.kernel.org; Wed, 20 Jul 2011 11:02:55 +0200
Received: from p508e97c0.dip.t-dialin.net ([80.142.151.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jul 2011 11:02:55 +0200
Received: from dak by p508e97c0.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jul 2011 11:02:55 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner <tglx@linutronix.de> writes:

> The overall patch size has shrunk significantly and the readability
> (except for the missing changelogs in various patches) is at an
> acceptable level.

Well, thanks for all the work.  I am actually already using per-irq
threads and priorities on a 3.0-rc kernel (there is some boot option to
enable them), and that helps for audio operation.

It would be really great if realtime can move upstream completely
eventually, and it looks like the current approach is a better match to
the existing kernel, partly due to upstream improvements, partly through
rewritten realtime code.

The ongoing work seems very promising and seems to involve fewer
compromises, boding well not just for the chances of getting merged
upstream, but also of minimizing regressions compared to the
non-realtime kernel.

Thanks!

-- 
David Kastrup

