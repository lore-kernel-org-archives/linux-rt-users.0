From: Matthias Luescher <m.luescher@vtxmail.ch>
Subject: Shutdown/poweroff fails with 2.6.24.7-rt27 and 2.6.26.8-rt16
Date: Mon, 23 Feb 2009 09:27:18 +0100
Message-ID: <29325.1235377638@vtxmail.ch>
Reply-To: m.luescher@vtxmail.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: <tglx@linutronix.de>, <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-02.datacomm.ch ([212.40.2.27]:42949 "EHLO
	smtp-02.datacomm.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZBWI1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 03:27:20 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear rt experts

With the latest 2.6.24 and 2.6.26 rt patches my PCs (Core Duo and Core 2 Duo) do not power off 
anymore when I shut them down. The last messages that appear are:
Disabling non-boot CPUs
CPU0 attaching NULL sched-domain
CPU1 attaching NULL sched-domain

In the kernel bugzilla I found the following helpful entry:
http://bugzilla.kernel.org/show_bug.cgi?id=11725
(clockevents: broadcast fixup possible waiters)

So I did some tests:

2.6.24
------
With rt20 the following two patches got added:
7300711e8c6824fcfbd42a126980ff50439d8dd0.patch
7300711e8c6824fcfbd42a126980ff50439d8dd0-fix.patch
I removed both of them and my PCs are powering off again.

2.6.26
------
With the stable kernel version 2.6.26.6 the following commit was added:
clockevents: broadcast fixup possible waiters: 92741d2d653769b582015c6a379e7b46e113435d
When I revert this commit my PCs are powering off again.

2.6.29
------
2.6.29-rc4-rt2 is ok!

So my question is:
Is it ok to remove the change "clockevents: broadcast fixup possible waiters" from the
2.6.24 and 2.6.26 kernel version?
(From the commit comment "Until the C1E patches arrived..." I guess that it could be ok since 
the C1E patches were -as far as I can guess - added to the kernel after 2.6.26.)

Best regards
Matthias




