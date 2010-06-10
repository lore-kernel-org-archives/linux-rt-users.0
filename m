From: Kim Christensen <kingudk@gmail.com>
Subject: Config_preempt_rt patch for 2.6.34 or newer kernels
Date: Thu, 10 Jun 2010 22:19:30 +0200
Message-ID: <AANLkTin4hTyfOLsdxZcT8GVFA4UvozJ9RaG4YSoddgEj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37216 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab0FJUmY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 16:42:24 -0400
Received: by gye5 with SMTP id 5so279728gye.19
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2010 13:42:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I'm attempting to get a CONFIG_PREEMPT_RT patched kernel to run with
the Embest Devkit8000 board. It seems that the 2.6.34 kernel series
(and later) vanilla kernels have support for the board and compiles
quite fine.
However the latest CONFIG_PREEMPT_RT patch available is for the 2.6.33 series.

I have found a 2.6.33-rc8 kernel (
http://gitorious.org/devkit8000/linux-omap-devkit8000/commits/4.3inch
) which supports the hardware, the patch for 2.6.33-rc8-rt2 applies
mostly without problems (patch complains about that it has already
been applied to one file). The kernel however panics when it is
configured with CONFIG_PREEMPT_RT=y, it boots fine otherwise.
Before the kernel panics the kernel complains about a null pointer
deref. And the kernel panics on a missing rootfilesystem, which seems
to be caused because it falls back from booting from a MMC card to
using NFS (if I'm not mistaken). Somehow I think that the deref and
the changed device for the rootfs is related, I just don't know how to
approach the issue.

So I was hoping that there would be a patch for the 2.6.34 series or
perhaps one for the one of the early 2.6.35-rcX kernels.

Is anyone able to tell me when or if such patches is available?
Alternatively is there anyone who is able to provide pointers to solve
the problems with the 2.6.33-rc8 kernel?

Any help will be greatly appreciated.

The best regards
Kim Christensen
