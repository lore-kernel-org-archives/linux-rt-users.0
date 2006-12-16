From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: ARM 920T build problems for patch-2.6.19-rt1 - the second try
Date: Sat, 16 Dec 2006 22:07:13 +0100
Message-ID: <200612162207.14454.pisa@cmp.felk.cvut.cz>
References: <200612152153.45910.pisa@cmp.felk.cvut.cz> <1166261139.29505.230.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from av1.karneval.cz ([81.27.192.123]:13096 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161495AbWLPVLF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 16:11:05 -0500
To: tglx@linutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <1166261139.29505.230.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas and Sascha,

On Saturday 16 December 2006 10:25, Thomas Gleixner wrote:
> On Fri, 2006-12-15 at 21:53 +0100, Pavel Pisa wrote:
> > Index: linux-2.6.19-rt/include/asm-arm/atomic.h
> > ===================================================================
> > --- linux-2.6.19-rt.orig/include/asm-arm/atomic.h
> > +++ linux-2.6.19-rt/include/asm-arm/atomic.h
> > @@ -188,10 +188,10 @@ static inline unsigned long __cmpxchg(vo
> >  	volatile unsigned long *p = ptr;
> >
> >  	if (size == 4) {
> > -		local_irq_save(flags);
> > +		raw_local_irq_save(flags);
......
>
> Ok

Thanks.

> > ===================================================================
> > --- linux-2.6.19-rt.orig/arch/arm/Kconfig
> > +++ linux-2.6.19-rt/arch/arm/Kconfig
> > @@ -19,7 +19,11 @@ config ARM
> >
> >  config GENERIC_TIME
> >  	bool
> > -	default n
> > +	default y
> > +
> > +config GENERIC_CLOCKEVENTS
> > +	bool
> > +	default y
>
> No. Both have to be set to default n and selected when the mach has the
> support for it.

OK

As for high resolution timers on i.MX, I have compared
Sascha's an my patch version and there are slight differences.

My version honors original define for selection of timer (TIMER_BASE).
You use directly IMX_TIM1_BASE.
On the other hand imx_timer_init() hardcodes IRQ to TIM1_INT
	setup_irq(TIM1_INT, &imx_timer_irq);

I have tried to keep file such way, that inclusion of clock event
is optional. I used CONFIG_HIGH_RES_TIMERS to conditionalize it,
may it be, that CONFIG_GENERIC_CLOCKEVENTS should be used instead ???

Clock events init is separated from hardware timer init in my version.

But all these are minor things to choose and not important so much.

The actual copy from my Linux patch stack is attached bellow.

I have run more tests and when I used intervals, which are not
aligned to power oft two, the worst cases has extended up to 550 usec
on our board. What are experiences with other ARM based machines?

Best wishes

            Pavel Pisa

PS: Thomas, please, can you send me pointer to the Profibus card driver
    you have recommended to me. I have tried to contact you more times
    about that, because my university colleagues ask for that
    urgently, but it seems that all my e-mails have been discarded
    somewhere on the way.

===================================================================
Subject: arm: i.MX/MX1 high resolution time events

Support for POSIX high resolution times.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>


 arch/arm/mach-imx/time.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

Index: linux-2.6.19-rt/arch/arm/mach-imx/time.c
===================================================================
--- linux-2.6.19-rt.orig/arch/arm/mach-imx/time.c
+++ linux-2.6.19-rt/arch/arm/mach-imx/time.c
@@ -15,6 +15,9 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/clocksource.h>
+#ifdef CONFIG_HIGH_RES_TIMERS
+#include <linux/clockchips.h>
+#endif
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -25,6 +28,11 @@
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+static struct clock_event_device clockevent_imx;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_PERIODIC;
+#endif
+
 static unsigned long evt_diff;
 
 /*
@@ -42,9 +50,16 @@ imx_timer_interrupt(int irq, void *dev_i
 	if (tstat & TSTAT_COMP) {
 		do {
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+			if (clockevent_imx.event_handler)
+				clockevent_imx.event_handler();
+			if  (likely(clockevent_mode != CLOCK_EVT_PERIODIC))
+				break;
+#else
 			write_seqlock(&xtime_lock);
 			timer_tick();
 			write_sequnlock(&xtime_lock);
+#endif
 			IMX_TCMP(TIMER_BASE) += evt_diff;
 
 		} while (unlikely((int32_t)(IMX_TCMP(TIMER_BASE)
@@ -99,11 +114,53 @@ static int __init imx_clocksource_init(v
 	return 0;
 }
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+static void imx_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	evt_diff = evt;
+	IMX_TCMP(TIMER_BASE) = IMX_TCN(TIMER_BASE) + evt;
+}
+
+static void imx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_imx = {
+	.name		= "imx_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= imx_set_mode,
+	.set_next_event	= imx_set_next_event,
+};
+
+static int __init imx_clockevent_init(void)
+{
+	clockevent_imx.mult = div_sc(imx_get_perclk1(), NSEC_PER_SEC,
+					clockevent_imx.shift);
+	clockevent_imx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_imx);
+	clockevent_imx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_imx);
+	register_local_clockevent(&clockevent_imx);
+
+	return 0;
+}
+#endif
+
+
 static void __init imx_timer_init(void)
 {
 	imx_timer_hardware_init();
 	imx_clocksource_init();
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+	imx_clockevent_init();
+#endif
+
 	/*
 	 * Make irqs happen for the system timer
 	 */
