From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH RT 8/6] [ARM, WATCHDOG] davinci: include mach/timex.h in davinci_wdt.c
Date: Mon, 10 Aug 2009 09:48:07 -0700
Message-ID: <87iqgvk43c.fsf@deeprootsystems.com>
References: <20090807203939.GA19374@pengutronix.de>
	<1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1249810600-21946-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20090809094306.GA26591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:2602 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932205AbZHJQsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2009 12:48:10 -0400
In-Reply-To: <20090809094306.GA26591@n2100.arm.linux.org.uk> (Russell King's message of "Sun\, 9 Aug 2009 10\:43\:06 +0100")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sun, Aug 09, 2009 at 11:36:39AM +0200, Uwe Kleine-K=F6nig wrote:
>> This fixes a a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm,
>> davinci_all_defconfig):
>>=20
>> 	drivers/watchdog/davinci_wdt.c: In function 'wdt_enable':
>> 	drivers/watchdog/davinci_wdt.c:102: error: 'CLOCK_TICK_RATE' undecl=
ared (first use in this function)
>> 	drivers/watchdog/davinci_wdt.c:102: error: (Each undeclared identif=
ier is reported only once
>> 	drivers/watchdog/davinci_wdt.c:102: error: for each function it app=
ears in.)
>
> It should not be using CLOCK_TICK_RATE - there was a move to clean
> up the use of that symbol and restrict it just to the i8253 PIT.
> Please create something else like DAVINCI_TICK_RATE instead.

Actually, I have an alternate fix for this which I was planning to
submit for 2.6.32.  This one drops CLOCK_TICK_RATE and uses the clock
framework to get the right tick frequency.

Here it is.

Kevin

=46rom 6eea62609126739ce03e447c5fca49269ad5d12a Mon Sep 17 00:00:00 200=
1
=46rom: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 10 Feb 2009 20:30:37 -0800
Subject: [PATCH] watchdog: davinci: use clock framework for timer frequ=
ency

Remove use of CLOCK_TICK_RATE in favor of using clock framework
for getting timer frequency.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/watchdog/davinci_wdt.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_=
wdt.c
index 83e22e7..5ed89e4 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/device.h>
+#include <linux/clk.h>
=20
 #define MODULE_NAME "DAVINCI-WDT: "
=20
@@ -69,6 +70,7 @@ static unsigned long wdt_status;
=20
 static struct resource	*wdt_mem;
 static void __iomem	*wdt_base;
+struct clk              *wdt_clk;
=20
 static void wdt_service(void)
 {
@@ -86,6 +88,10 @@ static void wdt_enable(void)
 {
 	u32 tgcr;
 	u32 timer_margin;
+	u32 wdt_freq;
+
+	BUG_ON(!wdt_clk);
+	wdt_freq =3D clk_get_rate(wdt_clk);
=20
 	spin_lock(&io_lock);
=20
@@ -99,9 +105,9 @@ static void wdt_enable(void)
 	iowrite32(0, wdt_base + TIM12);
 	iowrite32(0, wdt_base + TIM34);
 	/* set timeout period */
-	timer_margin =3D (((u64)heartbeat * CLOCK_TICK_RATE) & 0xffffffff);
+	timer_margin =3D (((u64)heartbeat * wdt_freq) & 0xffffffff);
 	iowrite32(timer_margin, wdt_base + PRD12);
-	timer_margin =3D (((u64)heartbeat * CLOCK_TICK_RATE) >> 32);
+	timer_margin =3D (((u64)heartbeat * wdt_freq) >> 32);
 	iowrite32(timer_margin, wdt_base + PRD34);
 	/* enable run continuously */
 	iowrite32(ENAMODE12_PERIODIC, wdt_base + TCR);
@@ -199,6 +205,11 @@ static int __devinit davinci_wdt_probe(struct plat=
form_device *pdev)
 	struct resource *res;
 	struct device *dev =3D &pdev->dev;
=20
+	wdt_clk =3D clk_get(dev, NULL);
+	if (WARN_ON(!wdt_clk))
+		return -ENODEV;
+	clk_enable(wdt_clk);
+
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat =3D DEFAULT_HEARTBEAT;
=20
@@ -245,6 +256,12 @@ static int __devexit davinci_wdt_remove(struct pla=
tform_device *pdev)
 		kfree(wdt_mem);
 		wdt_mem =3D NULL;
 	}
+
+	if (wdt_clk) {
+		clk_disable(wdt_clk);
+		clk_put(wdt_clk);
+	}
+
 	return 0;
 }
=20
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
