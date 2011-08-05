From: Tracey Hytry <shakti@bayarea.net>
Subject: Unlucky 3.0-rt7
Date: Fri, 5 Aug 2011 05:40:17 -0700
Message-ID: <20110805054017.472bef0d.shakti@bayarea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: nando@ccrma.Stanford.EDU
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bayarea.net ([209.128.87.230]:49351 "EHLO mail.bayarea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125Ab1HEMxk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2011 08:53:40 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I managed to download the new build about an hour and a half after it finished.
Installed it on the fedora 15 partition and the kernel fell on it's face!

It hangs up right after the start of boot, with just a few(maybe 50) lines of text.
I wrote down the last few lines, but don't have much time for setting things up for a serial console(don't know if it would help much here(but I should have the capability if needed)).

Anyway, here's the end of the text.  I'll drop it off on the list this time.

Memory:8089012k/9437184k ...more mem stuff
Preemptible hierarchical RCU implementation
RCU lockdep checking enabled
Verbose stalled-CPUs detection is disabled
NR_IRQS:33024 nr_irqs:512 16
Extended CMOS year: 2000
Console: colour VGA+ 80x25

That's it, and the computer would sit there lost in it's own nightmare getting very warm.
I tried putting "nomodeset rdblacklist=nouveau" on the kernel boot line, but got the same hang/message.
This is the same computer that was mentioned in the message from Fernanado  a few back.

Tracey.
