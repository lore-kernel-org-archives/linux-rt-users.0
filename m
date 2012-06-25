From: Tom Cook <tom.k.cook@gmail.com>
Subject: Debugging kernel lockups
Date: Mon, 25 Jun 2012 16:17:38 +0100
Message-ID: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63124 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab2FYPRi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2012 11:17:38 -0400
Received: by pbbrp8 with SMTP id rp8so6682794pbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2012 08:17:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Sorry for asking newbie questions here, but I'm, well, a newbie at
this.  I'm trying to get the 3.2.20-rt32 patch to boot on a Raspberry
Pi, but it seems the patch breaks the SD/MMC card driver and so the
root filesystem can't be mounted.  I've built a 3.2.20 source tree and
it boots fine, then I apply 3.2.20-rt32 patch and the boot halts
trying to find the SD card for the root FS.

I'm not too worried about trying to debug / fix this, but I don't
really know where to start.  Can someone give me some pointers towards
how to track this sort of thing down?  Is kdb the right tool for the
job?

Thanks,
Tom
