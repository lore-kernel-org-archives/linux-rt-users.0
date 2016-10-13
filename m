From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2] sc16is7xx: Drop bogus use of IRQF_ONESHOT
Date: Thu, 13 Oct 2016 10:44:33 -0500
Message-ID: <20161013154433.GU10625@jcartwri.amer.corp.natinst.com>
References: <20161003151432.17828-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Kicinski <kubakici@wp.pl>, linux-kernel@vger.kernel.org,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Josh Cartwright <joshc@ni.com>, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:50188 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755412AbcJMPoq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Oct 2016 11:44:46 -0400
In-Reply-To: <20161003151432.17828-1-julia@ni.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Josh Cartwright <joshc@ni.com>

The use of IRQF_ONESHOT when registering an interrupt handler with
request_irq() is non-sensical.

Not only that, it also prevents the handler from being threaded when it
otherwise should be w/ IRQ_FORCED_THREADING is enabled.  This causes the
following deadlock observed by Sean Nyekjaer on -rt:

Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[..]
   rt_spin_lock_slowlock from queue_kthread_work
   queue_kthread_work from sc16is7xx_irq
   sc16is7xx_irq [sc16is7xx] from handle_irq_event_percpu
   handle_irq_event_percpu from handle_irq_event
   handle_irq_event from handle_level_irq
   handle_level_irq from generic_handle_irq
   generic_handle_irq from mxc_gpio_irq_handler
   mxc_gpio_irq_handler from mx3_gpio_irq_handler
   mx3_gpio_irq_handler from generic_handle_irq
   generic_handle_irq from __handle_domain_irq
   __handle_domain_irq from gic_handle_irq
   gic_handle_irq from __irq_svc
   __irq_svc from rt_spin_unlock
   rt_spin_unlock from kthread_worker_fn
   kthread_worker_fn from kthread
   kthread from ret_from_fork

Fixes: 9e6f4ca3e567 ("sc16is7xx: use kthread_worker for tx_work and irq")
Reported-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Signed-off-by: Josh Cartwright <joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
Cc: Jakub Kicinski <moorray3@wp.pl>
Cc: stable@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
---
v1 -> v2:
 * Fixed up From:
 * Added Jakub's Acked-by.

This patch has been in -rt for a little while, but it isn't -rt specific.

See relevant bug report thread which starts here:

  http://www.spinics.net/lists/linux-rt-users/msg14620.html

 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a9d94f7..96a374d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1260,7 +1260,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	/* Setup interrupt */
 	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
-			       IRQF_ONESHOT | flags, dev_name(dev), s);
+			       flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
-- 
2.9.3

