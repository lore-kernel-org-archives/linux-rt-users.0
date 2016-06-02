From: Pratyush Patel <pratyushpatel.1995@gmail.com>
Subject: PREEMPT_RT git tree
Date: Thu, 2 Jun 2016 18:05:18 +0200
Message-ID: <CAAnMKKY+FsZQSK9-qF7f2wL6pjAnywj89wmFGOR7gkNeyMaFGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35391 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbcFBQFU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jun 2016 12:05:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id e3so16978863wme.2
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jun 2016 09:05:18 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I want to use the CONFIG_PREEMPT_RT git tree for development and
testing instead of patching a Linux kernel. Could anyone please let me
know where I can find the current stable/development trees?

Note that I already tried cloning linux-stable-rt:

$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/

However, I noticed that this is based on the 3.x kernel version and
the latest commit as per 'git log' was in 2011, whereas the current rt
patch is for Linux 4.4. I have been unable to find any newer git tree
version.

Thanks,
Pratyush
