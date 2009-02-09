From: wuzj@lemote.com
Subject: the current status of RT_PREEMPT for mips
Date: Mon, 9 Feb 2009 08:07:12 +0800 (CST)
Message-ID: <20955.222.92.8.142.1234138032.squirrel@mail.lemote.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [222.92.8.141] ([222.92.8.141]:42879 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752930AbZBIAbQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Feb 2009 19:31:16 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

HI!

I'm planning to port RE_PREEMPT to loongson2f(a mipsel compatible
processor), the "FAQ" web page of RTWiKi(rt.wiki.kernel.org) shows that
"There are systems representing the x86, x86_64, ARM, MIPS, and Power
architectures using the CONFIG_PREEMPT_RT patch.", does it means that
RT_PREEMPT support  MIPS architecture? because i can not find any more
information about it, I tried to use the latest RT_PREEMPT on qemu
0.9.1/mipssim, it can not boot, so I come to get your help, could you give
any current status of RT_PREEMPT for mips? such as:

1. does the latest RT_PREEMPT(for linux 2.6.26.8) support MIPS
architecture? or any older one support it?
2. if Yes, which MIPS processors have been successfully running RT_PREEMPT?

looking forward to your reply, thanks!

Best Regards,
falcon

