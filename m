From: Thomas <gimpel@sonnenkinder.org>
Subject: Re: uvesafb + 2.6.24-rt
Date: Thu, 31 Jan 2008 01:07:26 +0000 (UTC)
Message-ID: <loom.20080131T010542-222@post.gmane.org>
References: <loom.20080130T221839-89@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39717 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbYAaBHi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2008 20:07:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JKNtv-00033e-Re
	for linux-rt-users@vger.kernel.org; Thu, 31 Jan 2008 01:07:35 +0000
Received: from ppp-82-135-15-177.dynamic.mnet-online.de ([82.135.15.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Jan 2008 01:07:35 +0000
Received: from gimpel by ppp-82-135-15-177.dynamic.mnet-online.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Jan 2008 01:07:35 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas <gimpel <at> sonnenkinder.org> writes:

> 
> Hi,
> 
> I have been using the new uvesafb on non-rt kernels successfully for a while
> already, but I cannot get it to work on -rt.
> 
> The kernel stops right after GRUB with the message:
> "Console: switching to color framebuffer device 128x48"
> And there it keeps hanging.
> 
> I wonder where the problem could be, and if anyone has already managed to use
> uvesafb on -rt. There must be something going wrong on the way from uvesafb <->
> unified kernel userspace linker <-> v86d
> 
> Regards,
> Thomas
> 
> 

PS: I tried with uvesafb as module using
---
options uvesafb mode=1024x768-32 mtrr=3 scroll=ywrap
---

Same effect, it just locks up as soon the module gets loaded.
The system is 64bit, card is anvidia pci-e - not sure if any of it matters.
