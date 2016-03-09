From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: arm: at91: do not disable/enable clocks in a row
Date: Wed, 9 Mar 2016 10:58:24 +0100
Message-ID: <20160309095824.GC10517@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
 <20160305113553.GB21216@piout.net>
 <20160308110639.GC21842@linutronix.de>
 <20160308183910.GD5845@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160308183910.GD5845@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Alexandre Belloni | 2016-03-08 19:39:10 [+0100]:

>Hi,
Hi,

>Both are things to work on. In the mean time, I'm using the following
>patch:
>https://github.com/alexandrebelloni/linux/commit/3a2eae463fce18ae815b887a5c9ca1a657b180ac
>
>I understood from
>http://lkml.iu.edu/hypermail/linux/kernel/1601.2/00941.html that this
>was not your preferred course of action.

That was one thing.  What about this:

---

Currently the driver will disable the clock and enable it one line later
if it is switching from periodic mode into one shot.
This can be avoided and causes a needless warning on -RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/clocksource/tcb_clksrc.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -74,6 +74,7 @@ static struct clocksource clksrc = {
 struct tc_clkevt_device {
 	struct clock_event_device	clkevt;
 	struct clk			*clk;
+	bool				clk_enabled;
 	void __iomem			*regs;
 };
 
@@ -91,6 +92,24 @@ static struct tc_clkevt_device *to_tc_cl
  */
 static u32 timer_clock;
 
+static void tc_clk_disable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	clk_disable(tcd->clk);
+	tcd->clk_enabled = false;
+}
+
+static void tc_clk_enable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	if (tcd->clk_enabled)
+		return;
+	clk_enable(tcd->clk);
+	tcd->clk_enabled = true;
+}
+
 static int tc_shutdown(struct clock_event_device *d)
 {
 	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
@@ -98,8 +117,14 @@ static int tc_shutdown(struct clock_even
 
 	__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
 	__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+	return 0;
+}
+
+static int tc_shutdown_clk_off(struct clock_event_device *d)
+{
+	tc_shutdown(d);
 	if (!clockevent_state_detached(d))
-		clk_disable(tcd->clk);
+		tc_clk_disable(d);
 
 	return 0;
 }
@@ -112,7 +137,7 @@ static int tc_set_oneshot(struct clock_e
 	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
 		tc_shutdown(d);
 
-	clk_enable(tcd->clk);
+	tc_clk_enable(d);
 
 	/* slow clock, count up to RC, then irq and stop */
 	__raw_writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
@@ -134,7 +159,7 @@ static int tc_set_periodic(struct clock_
 	/* By not making the gentime core emulate periodic mode on top
 	 * of oneshot, we get lower overhead and improved accuracy.
 	 */
-	clk_enable(tcd->clk);
+	tc_clk_enable(d);
 
 	/* slow clock, count up to RC, then irq and restart */
 	__raw_writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
@@ -168,7 +193,7 @@ static struct tc_clkevt_device clkevt =
 		/* Should be lower than at91rm9200's system timer */
 		.rating			= 125,
 		.set_next_event		= tc_next_event,
-		.set_state_shutdown	= tc_shutdown,
+		.set_state_shutdown	= tc_shutdown_clk_off,
 		.set_state_periodic	= tc_set_periodic,
 		.set_state_oneshot	= tc_set_oneshot,
 	},

Sebastian
