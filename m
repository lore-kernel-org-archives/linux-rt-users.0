From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/20] usb: gadget: atmel: access the PMC using regmap
Date: Tue, 12 Jul 2016 10:24:10 -0400
Message-ID: <20160712142418.093829390@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Felipe Balbi <balbi@ti.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-usb-gadget-atmel-access-the-PMC-using-regmap.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Use regmap to access the PMC to avoid using at91_pmc_read and
at91_pmc_write.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 20 ++++++++++----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index d6ca3697d3c8..ee6bc64f9656 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -17,7 +17,9 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
@@ -1889,20 +1891,15 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 #ifdef CONFIG_OF
 static void at91sam9rl_toggle_bias(struct usba_udc *udc, int is_on)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	if (is_on)
-		at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
-	else
-		at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   is_on ? AT91_PMC_BIASEN : 0);
 }
 
 static void at91sam9g45_pulse_bias(struct usba_udc *udc)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
-	at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN, 0);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   AT91_PMC_BIASEN);
 }
 
 static const struct usba_udc_errata at91sam9rl_errata = {
@@ -1939,6 +1936,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 
 	udc->errata = match->data;
+	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (udc->errata && IS_ERR(udc->pmc))
+		return ERR_CAST(udc->pmc);
 
 	udc->num_ep = 0;
 
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index ea448a344767..3e1c9d589dfa 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -354,6 +354,8 @@ struct usba_udc {
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_regs;
 #endif
+
+	struct regmap *pmc;
 };
 
 static inline struct usba_ep *to_usba_ep(struct usb_ep *ep)
-- 
2.8.1
