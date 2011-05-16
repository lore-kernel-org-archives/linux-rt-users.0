From: David Kastrup <dak@gnu.org>
Subject: Re: How to establish a priority to an interrupt handler
Date: Mon, 16 May 2011 12:51:13 +0200
Message-ID: <87liy6or4u.fsf@fencepost.gnu.org>
References: <4DD0FBC1.9050708@unican.es>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40353 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab1EPKv1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 May 2011 06:51:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1QLvOX-0002EB-BX
	for linux-rt-users@vger.kernel.org; Mon, 16 May 2011 12:51:25 +0200
Received: from p508ed4d8.dip.t-dialin.net ([80.142.212.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2011 12:51:25 +0200
Received: from dak by p508ed4d8.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2011 12:51:25 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Monica Puig-Pey <puigpeym@unican.es> writes:

> Hi,
>
> I'm using Ubuntu 10.04 with the 2.6.31-11-rt patch installed. I'm
> developing a PCI device driver using hardware interrupts.
> As I read at the RT wiki
> (https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch )
> interrupts are moved to kernel threads called Threaded Interrupts in
> the RT patch.
>
> I would like to give a priority chosen by me to my IRQ handler, but I
> don't know how to do it, or if it is possible (it seems it is).

This may not answer your question, but

apt-get install rtirq-init

might be all you need to do in order to get the interrupt priorities set
and sorted out for your purposes (well, for sound
recording/processing/playback it usually works reasonably well).

Even if not, taking a look at what the rtirq service script does might
give you good ideas.

-- 
David Kastrup

