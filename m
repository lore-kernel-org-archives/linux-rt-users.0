From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re: clocksource and clockevent confusion
Date: Thu, 07 Apr 2011 18:48:52 +0200 (CEST)
Message-ID: <1302194932.4d9deaf4033b9@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout04.highway.telekom.at ([195.3.96.117]:41078 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755526Ab1DGQs4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Apr 2011 12:48:56 -0400
Received: from warsbl114-nfs.highway.telekom.at (HELO WARSBL114.highway.telekom.at) ([172.18.96.91])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub93.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 7 Apr 2011 16:48:53 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL114.highway.telekom.at (8.13.1/8.13.1) with SMTP id p37Gmqjf011116
	for <linux-rt-users@vger.kernel.org>; Thu, 7 Apr 2011 18:48:52 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for your help Pat!

I figured out to write a driver, thats the code:

static cycle_t read_pit_clk(struct clocksource *cs)
{

	return T0TC;	// returns the actual timer count 
}

static struct clocksource pit_clk = {
	.name		= \"pit\",
	.rating		= 175,
	.read		= read_pit_clk,
	.shift		= 28,	//is changed by init code
	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
};

/*
 * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
 */
static void
pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
{
	switch (mode) {
	case CLOCK_EVT_MODE_PERIODIC:
		/* update clocksource counter */
		T0MR0 = 720000;
		T0PR = 0;
		T0MCR &= ~0x04;	//be sure timer does not stop on compare match
		T0MCR |= 0x03;
		break;
	case CLOCK_EVT_MODE_ONESHOT:
		T0MR0 = 720000;
		T0PR = 0;
		
		T0MCR |= 0x07;
		break;
		/* FALLTHROUGH */
	case CLOCK_EVT_MODE_SHUTDOWN:
		T0MCR &= ~0x01;
		break;
	case CLOCK_EVT_MODE_UNUSED:
		/* disable irq, leaving the clocksource active */
		T0MCR &= ~0x01;
		break;
	case CLOCK_EVT_MODE_RESUME:
		break;
	}
}

static struct clock_event_device pit_clkevt = {
	.name		= \"pit\",
	.features	= CLOCK_EVT_FEAT_PERIODIC,
	.shift		= 32,	//is changed by init function
	.rating		= 100,	//dont know yet
	.set_mode	= pit_clkevt_mode,
};


unsigned long lpc2xxx_gettimeoffset (void)
{
	//CLOCKS_PER_USEC = LPC2xxx_Fpclk / 1000000;
	return (T0TC/(lpc2xxx_fcclk / 1000000));
}

static irqreturn_t
lpc2xxx_timer_interrupt(int irq, void *dev_id)
{
    if (!(T0IR & 0x01)) return IRQ_NONE;
/*    do_timer(regs);
    do_profile(regs);
*/ //timer_tick(); 
/* modified 20050608 for new version */

	pit_clkevt.event_handler(&pit_clkevt);	//handle_event
//	printk(\"Interrupt\\n\");
	
    T0IR |= 0x01;	/* reset interrupt */
    return IRQ_HANDLED;
}

static struct irqaction lpc2xxx_timer_irq = {
        .name           = \"lpc2xxx-tick\",
	.flags		= IRQF_DISABLED | IRQF_TIMER,
        .handler        = lpc2xxx_timer_interrupt
};

/*
 * Set up timer interrupt, and return the current time in seconds.
 */
/*
 Setup PCLK_TIMER0 = Fcclk (01)
 Setup T0MR0 = 10 (ms)
 Setup T0PR0 = 0
*/
void __init  lpc2xxx_time_init (void)
{
	unsigned char clkSel = 0;
	unsigned long stat = PLLSTAT;
	unsigned long M = stat & 0x7FFFF;
	unsigned long N = (stat>>16) & 0xFF;
	unsigned long Fcco = (2 * (M+1) *CONFIG_LPC22xx_Fosc) / (N+1);
	unsigned long Fcclk = Fcco / ((CCLKCFG&0xFF)+1);
	lpc2xxx_fcclk = Fcclk;
	lpc2xxx_fpclk = Fcclk;

	/* 
  	 * Here we assume that the clock is the same for all peripherals
 	 * which of course doesn\'t have to be the case.
	 * We should be using the clk.h interface instead.
	 */
	
	clkSel = (unsigned char)(PCLKSEL0 & 0xff);
	if (clkSel == 0x00)
		lpc2xxx_fpclk = lpc2xxx_fcclk / 4;
	else if (clkSel == 0x55)
		lpc2xxx_fpclk = lpc2xxx_fcclk;
	else if (clkSel == 0xAA)
		lpc2xxx_fpclk = lpc2xxx_fcclk / 2;
	else if (clkSel == 0xFF)
		lpc2xxx_fpclk = lpc2xxx_fcclk / 8;

	printk(\"LPC2XXX Clocking Fin=%dHz Fcco=%ldHz M=%ld N=%ld\\n\",
		CONFIG_LPC22xx_Fosc,
		Fcco,
		M,
		N);
	PCLKSEL0 &= ~(3<<2);
	PCLKSEL0 |=  (1<<2);
	printk(\"Fcclk=%ld PCLKSEL=%08lx %08lx\\n\",
		Fcclk, PCLKSEL0, PCLKSEL1);
	/*
	 * disable and clear timer 0, set to
	 */
	T0TCR &= ~0x01;
	/* initialize the timer period and prescaler */

	//counts with 72MHz so compare interrupt every 10ms
	T0MR0 = 720000;
	T0PR = 0;	// prescaler = 0
	T0MCR |= 0x03;			/* generate interrupt when T0MR0 match T0TC and Reset Timer Count*/

	lpc2xxx_timer_irq.handler = lpc2xxx_timer_interrupt;

	/* set up the interrupt vevtor for timer 0 match */
	setup_irq(LPC2xxx_INTERRUPT_TIMER0, &lpc2xxx_timer_irq);
	
	/* enable the timer IRQ */
	lpc22xx_unmask_irq(LPC2xxx_INTERRUPT_TIMER0);

	clocksource_calc_mult_shift(&pit_clk,Fcclk,4);	// minsecvalue =4 no idea why (seen in other codes)

	pit_clk.mask = 71999;				// mask is 71999 so the clk subsystem knows where it overruns (is that correct??)
	clocksource_register(&pit_clk);

	clockevents_calc_mult_shift(&pit_clkevt,Fcclk,4);	// minsecvalue =4 no idea why (seen in other codes)
	pit_clkevt.cpumask = cpumask_of(0);		// uniprocessro system
	clockevents_register_device(&pit_clkevt);

	/* let timer 0 run... */
	T0IR = 0x01; /* reset MR0 interrupt*/
	T0TCR = 0x02;	/* Reset timer count and prescale counter */
	T0TCR = 0x01;	/* enable timer counter and prescale counter */
}

struct sys_timer lpc22xx_timer = {
	.init		= lpc2xxx_time_init,
};



The problem is that after a minute or so the kernel freezes and hangs in the cpu_idle() function in arch/arm/kernel/process.c

the board stays in this whileloop in the else condition forever:

while (!need_resched()) {
#ifdef CONFIG_HOTPLUG_CPU
			if (cpu_is_offline(smp_processor_id()))
				cpu_die();
#endif

			local_irq_disable();
			if (hlt_counter) {
				local_irq_enable();
				cpu_relax();
			} else {
				stop_critical_timings();
				pm_idle();
				start_critical_timings();
				/*
				 * This will eventually be removed - pm_idle
				 * functions should always return with IRQs
				 * enabled.
				 */
				WARN_ON(irqs_disabled());
				local_irq_enable();
			}
		}

i dont know what exactly the problem is...
Do i have to implement a sched_clock routine myself as is saw it in a few implemetations.
When i do a cat \"/proc/timer_list\" i can see folowing:

cat timer_list
Timer List Version: v0.5
HRTIMER_MAX_CLOCK_BASES: 2
now at 960971480 nsecs

cpu: 0
 clock 0:
  .base:       a031c560
  .index:      0
  .resolution: 10000000 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       a031c594
  .index:      1
  .resolution: 10000000 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: def_rt_bandwidth, sched_rt_period_timer, S:01, __enqueue_rt_entity, sirq-timer/0/4
 # expires at 1000000000-1000000000 nsecs [in 39028520 to 39028520 nsecs]
 #1: <a12fda88>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, inetd/170
 # expires at 1960997774-1961997798 nsecs [in 1000026294 to 1001026318 nsecs]
  .expires_next   : 2147483646999999999 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 960913921 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 77532270 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294941108


Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: pit
 max_delta_ns:   0
 min_delta_ns:   0
 mult:           309237645
 shift:          32
 mode:           2
 next_event:     2147483646999999999 nsecs
 set_next_event: <(null)>
 set_mode:       pit_clkevt_mode
 event_handler:  tick_handle_periodic


I enabled some tracing and debuging in the kernel and then the following message was printed when the processor froze:

\"sched: RT throttling activated\"

What does it mean? IS it a problem of my timer implementation or is something else wrong with the system?

I hope somebody can help me on this.

Kind regards
Johannes Bauer

