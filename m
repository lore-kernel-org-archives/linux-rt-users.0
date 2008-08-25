From: robert <robje99@hotmail.com>
Subject: Availability rt patch for older linux kernel 2.6.11.3
Date: Mon, 25 Aug 2008 08:44:56 +0000 (UTC)
Message-ID: <loom.20080825T083613-13@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60958 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbYHYIuF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2008 04:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KXXly-00029k-Cm
	for linux-rt-users@vger.kernel.org; Mon, 25 Aug 2008 08:50:02 +0000
Received: from ip503d790e.speed.planet.nl ([80.61.121.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2008 08:50:02 +0000
Received: from robje99 by ip503d790e.speed.planet.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2008 08:50:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm currently working with a older linux kernel, 2.6.11.3, running on a 
powerpc.
Currently I'm running against realtime performance problems, the reaction time 
to interrupts is not good enough (sometimes 30 msec, while less then 8 msec is 
needed).
For this of course, are the realtime patches, but I can find them only for the 
newer kernels.
As our kernel is highly adopted to the hardware, I can't just move over to a 
newer kernel.

My question is:
- does anyone know a link for me were I can still find a patch for a 2.6.11.3 
kernel?
- if they can be found, are these patches mature enough to be used, 
particularly for a powerpc architecture?

Any help would be appreciated.

With kind regards,
Robert pot


