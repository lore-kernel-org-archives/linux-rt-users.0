From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2] drivers: i2c: exynos5: irq spinlock rt-safe
Date: Thu,  3 Sep 2015 23:06:03 +0200
Message-ID: <1441314363-9836-1-git-send-email-anders.roxell@linaro.org>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
Cc: ch.naveen@samsung.com, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, khilman@linaro.org,
	linux-rt-users@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: kgene@kernel.org, k.kozlowski@samsung.com, wsa@the-dreams.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current spin_lock_irqsave() protects the enabling of the device
interrupt.  In order to prevent recursion in the case of sleeping
spinlocks (e.g. with RT patch, stacktrace below), convert the spin lock
to a raw spin lock. No change for !RT kernels.

[   10.992238] kernel BUG at ../kernel/locking/rtmutex.c:998!
[   10.992243] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   10.992250] Modules linked in:
[   10.992258] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.5-rt5
[   10.992263] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   10.992268] task: ed880000 ti: ed888000 task.ti: ed888000
[   10.992281] PC is at rt_spin_lock_slowlock+0xa4/0x2ec
[   10.992288] LR is at rt_spin_lock_slowlock+0x54/0x2ec
[   10.992296] pc : [<c099e1bc>]    lr : [<c099e16c>]    psr: 60000193
[   10.992296] sp : ed889a28  ip : ed880001  fp : 00000089
[   10.992300] r10: ed889a28  r9 : c0f55654  r8 : 00000060
[   10.992305] r7 : ed880000  r6 : 00000000  r5 : 00000001  r4 : ed9f7288
[   10.992310] r3 : ed880000  r2 : 00000000  r1 : ed880000  r0 : 00000000
[   10.992316] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
...
...
[   10.992662] [<c099e1bc>] (rt_spin_lock_slowlock) from [<c07bc794>]
(exynos5_i2c_irq+0x20/0x2b0)
[   10.992678] [<c07bc794>] (exynos5_i2c_irq) from [<c028c8b4>]
(handle_irq_event_percpu+0x68/0x158)
[   10.992690] [<c028c8b4>] (handle_irq_event_percpu) from [<c028ca0c>]
(handle_irq_event+0x68/0xa8)
[   10.992702] [<c028ca0c>] (handle_irq_event) from [<c028f9c4>]
(handle_fasteoi_irq+0x11c/0x1d4)
[   10.992713] [<c028f9c4>] (handle_fasteoi_irq) from [<c028c17c>]
(generic_handle_irq+0x20/0x30)
[   10.992724] [<c028c17c>] (generic_handle_irq) from [<c028c290>]
(__handle_domain_irq+0x6c/0xe4)
[   10.992734] [<c028c290>] (__handle_domain_irq) from [<c020a71c>]
(gic_handle_irq+0x2c/0x68)
[   10.992744] [<c020a71c>] (gic_handle_irq) from [<c0214140>]
(__irq_svc+0x40/0x88)
[   10.992749] Exception stack(0xed889b28 to 0xed889b70)
...
...

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/busses/i2c-exynos5.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index b29c750..b12e77e 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -170,7 +170,7 @@ struct exynos5_i2c {
 	struct device		*dev;
 	int			state;
 
-	spinlock_t		lock;		/* IRQ synchronization */
+	raw_spinlock_t		lock;		/* IRQ synchronization */
 
 	/*
 	 * Since the TRANS_DONE bit is cleared on read, and we may read it
@@ -433,7 +433,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 
 	i2c->state = -EINVAL;
 
-	spin_lock(&i2c->lock);
+	raw_spin_lock(&i2c->lock);
 
 	int_status = readl(i2c->regs + HSI2C_INT_STATUS);
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
@@ -521,7 +521,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 		complete(&i2c->msg_complete);
 	}
 
-	spin_unlock(&i2c->lock);
+	raw_spin_unlock(&i2c->lock);
 
 	return IRQ_HANDLED;
 }
@@ -610,7 +610,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	 * Enable interrupts before starting the transfer so that we don't
 	 * miss any INT_I2C interrupts.
 	 */
-	spin_lock_irqsave(&i2c->lock, flags);
+	raw_spin_lock_irqsave(&i2c->lock, flags);
 	writel(int_en, i2c->regs + HSI2C_INT_ENABLE);
 
 	if (stop == 1)
@@ -618,7 +618,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	i2c_auto_conf |= i2c->msg->len;
 	i2c_auto_conf |= HSI2C_MASTER_RUN;
 	writel(i2c_auto_conf, i2c->regs + HSI2C_AUTO_CONF);
-	spin_unlock_irqrestore(&i2c->lock, flags);
+	raw_spin_unlock_irqrestore(&i2c->lock, flags);
 }
 
 static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
@@ -763,7 +763,7 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	/* Clear pending interrupts from u-boot or misc causes */
 	exynos5_i2c_clr_pend_irq(i2c);
 
-	spin_lock_init(&i2c->lock);
+	raw_spin_lock_init(&i2c->lock);
 	init_completion(&i2c->msg_complete);
 
 	i2c->irq = ret = platform_get_irq(pdev, 0);
-- 
2.1.4
