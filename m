From: "Oleg Galimov" <Galimov@gmx.de>
Subject: cyclictest - trouble explaning results
Date: Wed, 11 Jun 2008 17:14:37 +0200
Message-ID: <20080611151437.234900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751117AbYFKPOj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jun 2008 11:14:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

I use cyclictest as a benchmark for my diploma thesis. I have a strange behavior however, which I can't explain:

I have a dual-core cpu. When I run cyclictest on both cores and then start a time hog (like cp /dev/zero /dev/null), then the average latency on the core where it runs goes down significantly (on my machine it is like 30us before and 10us after, when using rt-patch). It returns to the original values, when I kill the cp process.

I have a similar behavior but less clearly visible with interbench.

The results appeared so far on 2.6.22, 2.6.22+rt, 2.6.25 and 2.6.25+rt.

I hope someone can help me explaining this.

Thank you,

Oleg Galimov
