From: Mike Galbraith <efault@gmx.de>
Subject: how does one set IRQ_NO_SOFTIRQ_CALL
Date: Tue, 14 Aug 2012 15:39:56 +0200
Message-ID: <1344951596.14924.57.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:48606 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751119Ab2HNNkB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Aug 2012 09:40:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

I see there's this nifty flag to immunize specific irq threads from
softirq processing duties.  How does one go about setting it for say a
specific NIC?  Can do at runtime?

Also, is it possible to turn NAPI off at runtime for specific NICs?  I
can imagine interrupt mitigation induced latencies, and google seems to
agree that can indeed be an issue.

I can also imagine processing softirqs being a cross-talk issue between
NICs, ie traffic on one NIC affecting performance of another, but that
may well be high grade horse pookey, me knowing spit about NAPI, or any
of the zillion other network stack acronyms for that matter ;-)

-Mike

