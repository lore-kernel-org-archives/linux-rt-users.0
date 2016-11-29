From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: question about irq_enter()/irq_exit() calling policy
Date: Tue, 29 Nov 2016 17:47:12 -0600
Message-ID: <22d0d991-bbe2-ce10-5202-3cdf97a9ecf2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:38218 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750754AbcK2Xrl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Nov 2016 18:47:41 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

Sorry for the may be dumb question, but what is the calling policy for irq_enter()/irq_exit()?

1) Should these function be called each time system enter/exit IRQ context?

HW IRQ:
 switch (IRQ mode)
  ...
  irq_enter()
	handle irq - execute hw_irq_hadler
  irq_exit()
  ...
 switch

2) Should these function be called for each processed irq?


HW IRQ:
 switch (IRQ mode)
  ...
  while (irq = get_pending_irq()) {
  	...
  	irq_enter()
		handle(irq) - execute hw_irq_hadler
  	irq_exit()
 }
 ...
 switch

-- 
regards,
-grygorii
