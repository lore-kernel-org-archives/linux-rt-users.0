From: Thomas <gimpel@sonnenkinder.org>
Subject: uvesafb + 2.6.24-rt
Date: Wed, 30 Jan 2008 22:25:22 +0000 (UTC)
Message-ID: <loom.20080130T221839-89@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60963 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656AbYA3WaG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2008 17:30:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JKLRS-0004uu-UF
	for linux-rt-users@vger.kernel.org; Wed, 30 Jan 2008 22:30:02 +0000
Received: from ppp-82-135-15-177.dynamic.mnet-online.de ([82.135.15.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2008 22:30:02 +0000
Received: from gimpel by ppp-82-135-15-177.dynamic.mnet-online.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2008 22:30:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have been using the new uvesafb on non-rt kernels successfully for a while
already, but I cannot get it to work on -rt.

The kernel stops right after GRUB with the message:
"Console: switching to color framebuffer device 128x48"
And there it keeps hanging.

I wonder where the problem could be, and if anyone has already managed to use
uvesafb on -rt. There must be something going wrong on the way from uvesafb <->
unified kernel userspace linker <-> v86d

Regards,
Thomas
