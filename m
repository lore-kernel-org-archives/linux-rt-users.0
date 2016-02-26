From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead of
 homegrow
Date: Fri, 26 Feb 2016 12:48:09 +0100
Message-ID: <20160226114809.GD8318@linutronix.de>
References: <56CDCCE6.5020801@prevas.dk>
 <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Jakub Kicinski <kubakici@wp.pl>
To: Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59218 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbcBZLsM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 06:48:12 -0500
Content-Disposition: inline
In-Reply-To: <20160226114340.GC8318@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This ONESHOT + workqueue combo is something that is not required because
we have infrastrucure for this kind of things: threaded interrupts.

This is compile tested only due to -ENODEV.
Now that we that sc16is7xx_irq() is an actual interrupt handler
sc16is7xx_port_irq() could be improved so the former can return IRQ_NONE
if nothing has been done.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

 drivers/tty/serial/sc16is7xx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index edb5305b9d4d..b53a13be5754 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -331,7 +331,6 @@ struct sc16is7xx_port {
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
-	struct kthread_work		irq_work;
 	struct sc16is7xx_one		p[0];
 };
 
@@ -688,20 +687,13 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	} while (1);
 }
 
-static void sc16is7xx_ist(struct kthread_work *ws)
+static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
-	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
+	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
 	int i;
 
 	for (i = 0; i < s->devtype->nr_uart; ++i)
 		sc16is7xx_port_irq(s, i);
-}
-
-static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
-{
-	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
-
-	queue_kthread_work(&s->kworker, &s->irq_work);
 
 	return IRQ_HANDLED;
 }
@@ -1167,7 +1159,6 @@ static int sc16is7xx_probe(struct device *dev,
 	dev_set_drvdata(dev, s);
 
 	init_kthread_worker(&s->kworker);
-	init_kthread_work(&s->irq_work, sc16is7xx_ist);
 	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
 				      "sc16is7xx");
 	if (IS_ERR(s->kworker_task)) {
@@ -1229,8 +1220,8 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 
 	/* Setup interrupt */
-	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
-			       IRQF_ONESHOT | flags, dev_name(dev), s);
+	ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_irq,
+			       flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
-- 
2.7.0

