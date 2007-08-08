From: Juergen Beisert <jbe@pengutronix.de>
Subject: How to control IRQ thread priority from inside the driver
Date: Wed, 8 Aug 2007 15:14:31 +0200
Message-ID: <200708081514.31864.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:35611 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751825AbXHHN6t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 09:58:49 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1IIlMu-0002r7-00
	for <linux-rt-users@vger.kernel.org>; Wed, 08 Aug 2007 15:14:32 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

with the rt-preempt patch the IRQs are all kernelthreads started with priority 
50. Is there a way to change this priority from inside the driver, after I 
did the request_irq() call? I need a higher priority for one interrupt source 
but I do not want to change it with chrt from userspace. It should be done 
inside the driver.

Juergen
