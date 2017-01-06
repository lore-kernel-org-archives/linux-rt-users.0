From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.8 54/96] sc16is7xx: Drop bogus use of IRQF_ONESHOT
Date: Fri,  6 Jan 2017 22:43:42 +0100
Message-ID: <20170106214229.903947950@linuxfoundation.org>
References: <20170106214227.601120243@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Josh Cartwright <joshc@ni.com>, linux-rt-users@vger.kernel.org,
        Jakub Kicinski <moorray3@wp.pl>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Jakub Kicinski <kubakici@wp.pl>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939119AbdAFVut (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Jan 2017 16:50:49 -0500
In-Reply-To: <20170106214227.601120243@linuxfoundation.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Cartwright <joshc@ni.com>

commit 04da73803c05dc1150ccc31cbf93e8cd56679c09 upstream.

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
Cc: linux-serial@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sc16is7xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1240,7 +1240,7 @@ static int sc16is7xx_probe(struct device
 
 	/* Setup interrupt */
 	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
-			       IRQF_ONESHOT | flags, dev_name(dev), s);
+			       flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
 


