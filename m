From: Michael Haberler <ml1234@mah.priv.at>
Subject: synchronize RT thread to external IRQ - suggestions?
Date: Sun, 1 Sep 2013 19:40:14 +0200
Message-ID: <C5F241C8-47AB-4EA5-83D2-C067EA7F3E7B@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jon Elson <elson@pico-systems.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mah2.mah.priv.at ([86.59.12.251]:37193 "EHLO mah.priv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903Ab3IARrs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Sep 2013 13:47:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've hardware at hand which would best be serviced by an RT-hardened thread after the hardware interrupts the host - in the simplest form it could be say a parport IRQ

squeezing out latency as far as possible is a must

I'm looking for suggestions how to best achieve that - just wait-for-irq in a normal device driver? any alternative schemes I should consider? (in the Xenomai setup an RTDM driver seems the way to go).

thanks in advance

Michael



