From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Debugging kernel lockups
Date: Mon, 25 Jun 2012 09:52:44 -0700
Message-ID: <02869F28-2BE9-42FB-9F87-14A922F3B7FA@thebigcorporation.com>
References: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42454 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab2FYQwk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2012 12:52:40 -0400
Received: by dady13 with SMTP id y13so5569656dad.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2012 09:52:39 -0700 (PDT)
In-Reply-To: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Jun 25, 2012, at 8:17 AM, Tom Cook wrote:

> Hi,
> 
> Sorry for asking newbie questions here, but I'm, well, a newbie at
> this.  I'm trying to get the 3.2.20-rt32 patch to boot on a Raspberry
> Pi, but it seems the patch breaks the SD/MMC card driver and so the
> root filesystem can't be mounted.  I've built a 3.2.20 source tree and
> it boots fine, then I apply 3.2.20-rt32 patch and the boot halts
> trying to find the SD card for the root FS.
> 
> I'm not too worried about trying to debug / fix this, but I don't
> really know where to start.  Can someone give me some pointers towards
> how to track this sort of thing down?  Is kdb the right tool for the
> job?


Can you capture a serial console log of the boot process?

Thanks

Sven
