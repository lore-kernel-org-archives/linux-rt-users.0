From: Jonathan Schmidt <j.schmidt@archlinux.us>
Subject: Re: Nvidia patches for 2.6.33-rt?
Date: Wed, 3 Mar 2010 12:16:17 +0000 (UTC)
Message-ID: <loom.20100303T130614-97@post.gmane.org>
References: <4ccf65461003020059h272bccfay1c9200906995a9e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49520 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0CCMUg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Mar 2010 07:20:36 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1NmnYZ-0001ar-LH
	for linux-rt-users@vger.kernel.org; Wed, 03 Mar 2010 13:20:03 +0100
Received: from tn-76-7-143-28.dhcp.embarqhsd.net ([76.7.143.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 13:20:03 +0100
Received: from j.schmidt by tn-76-7-143-28.dhcp.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 13:20:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ng Oon-Ee <ngoonee <at> gmail.com> writes:

> 
> Hi all, has anyone patched the nvidia binary installer for 2.6.33-rt?
> Would like to have a look. I use nvidia-beta myself, but from previous
> -rt kernels I know I can figure out the patch from that given the
> patch for any other nvidia installer.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


I have absolutely no idea if this is the best way to handle the semaphore_init
issue, I don't even know what a semaphore is, but I submitted a simple patch at
http://www.nvnews.net/vbulletin/showthread.php?t=148509 anyway. It builds and
appears to be working, but I'd like some verification that sema_init(mutex,1) is
a valid substitute for semaphore_init(mutex).

