From: Mark Knecht <markknecht@gmail.com>
Subject: 2.6.26.8-rt12 - No hwclock - works under 2.6.24-rt1
Date: Fri, 30 Jan 2009 16:00:27 -0800
Message-ID: <5bdc1c8b0901301600k13a06b0laf048293f037374c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:42839 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249AbZAaAA2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Jan 2009 19:00:28 -0500
Received: by wf-out-1314.google.com with SMTP id 27so755474wfd.4
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jan 2009 16:00:27 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm just getting around to trying 2.6.26.8-rt12 from the Gentoo
pro-audio overlay. I built the kernel using an older .config and make
oldconfig so maybe it didn't catch something correctly. Anyway, at
boot the system is complaining about all file times are in the future
and later on I see a message that it couldn't set the clock and I'll
have to do that by hand. The machine then finishes booting and I get
as far as X. Haven't tested anything more than that.

the issue seems to be that the system cannot find my hardware clock,
and frankly neither can I in make menuconfig so maybe someone can tell
me where is the hardware clock? I'm hoping it's just misconfiguration
and not something more devious.

Motherboard is an Asus A8N-E which is nVidia based. More info provided
if need be.

Thanks,
Mark

[NEW KERNEL]

lightning ~ # uname -a
Linux lightning 2.6.26.8-rt12 #1 PREEMPT RT Fri Jan 30 12:39:38 PST
2009 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ # hwclock -r
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
lightning ~ #


[OLD KERNEL]

lightning ~ # uname -a
Linux lightning 2.6.24-rt1 #1 PREEMPT RT Tue Feb 5 07:03:44 PST 2008
x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ # hwclock -r
Fri 30 Jan 2009 03:49:39 PM PST  -0.555966 seconds
lightning ~ #
