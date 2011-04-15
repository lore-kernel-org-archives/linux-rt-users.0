From: Johannes Bauer <hannes_bauer@aon.at>
Subject: preempt-rt amd uClibc
Date: Fri, 15 Apr 2011 18:39:44 +0200 (CEST)
Message-ID: <1302885584.4da874d08c74a@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout06.highway.telekom.at ([195.3.96.89]:26819 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752947Ab1DOQju (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Apr 2011 12:39:50 -0400
Received: from warsbl214-nfs.highway.telekom.at (HELO WARSBL214.highway.telekom.at) ([172.18.96.93])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub91.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 15 Apr 2011 16:39:45 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL214.highway.telekom.at (8.13.1/8.13.1) with SMTP id p3FGdiCZ025395
	for <linux-rt-users@vger.kernel.org>; Fri, 15 Apr 2011 18:39:44 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody!

I downloaded the newest uClinux dist a while ago and compiled it with 2.6.33 kernel and the 2.6.33.7.2-rt30 patch applied.
Then i by hand implemeted an old patch for arm lpc22xx machine (ARMv4T), since i am running a lpc2478 board from embedded artists.
I had to implement a clockevent/source timer to add hrtimer support. I compiled it all with uClibc since it as a NOMMU system.

Now i have some questions:
Is it possible to run the preempt-rt patch with the uClinux distribution and uClibc?
I read a few times that if doesnt support PI mutexes, but arent those RT mutexes part of the kernel?

I have the problem that my clockevent subsystem runs with a 72MHz timer, which is also the CPU clock speed.
I calculated my .shift and .mult with \"clockevents_calc_mult_shift\" and my /proc/timer_list tells me it shift =32
and mult = 309237645 (i have no idea what these values are good for):


cat timer_list
Timer List Version: v0.5
HRTIMER_MAX_CLOCK_BASES: 2
now at 1282856491072 nsecs

cpu: 0
 clock 0:
  .base:       a02e63fc
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     17704160842103256530 nsecs
active timers:
 clock 1:
  .base:       a02e6430
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: per_cpu__tick_cpu_sched, tick_sched_timer, S:01, hrtimer_start_range_ns, sirq-timer/0/4
 # expires at 1282860000000-1282860000000 nsecs [in 3508928 to 3508928 nsecs]
 #1: def_rt_bandwidth, sched_rt_period_timer, S:01, __enqueue_rt_entity, sirq-timer/0/4
 # expires at 1283000000000-1283000000000 nsecs [in 143508928 to 143508928 nsecs]
 #2: , hrtimer_wakeup, S:01, hrtimer_start_range_ns, inetd/170
 # expires at 1283031816781-1283032816699 nsecs [in 175325709 to 176325627 nsecs]
  .expires_next   : 1282870000000 nsecs
  .hres_active    : 1
  .nr_events      : 129341
  .nr_retries     : 1
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 0 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 0 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 98286


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: pit
 max_delta_ns:   59652323587
 min_delta_ns:   50000
 mult:           309237645
 shift:          32
 mode:           3
 next_event:     1282870000000 nsecs
 set_next_event: lpc22xx_next_event
 set_mode:       pit_clkevt_mode
 event_handler:  hrtimer_interrupt


However when i run \"cyclictest -t1 -p 80 -n -i 10000 -l 1000\"
i get following results
T: 0 (  254) P:80 I:10000 C:   1000 Min:    464 Act:  712 Avg:  568 Max:     881

for the interval timers (cyclictest -t1 -p 80 -i 10000 -l 1000) i am getting totally different horrible results,
which seem to widely defere from run to run (sleep_nanoseconds seem to be more or less constant) :
T: 0 (  257) P:80 I:10000 C:   1000 Min:   3658 Act: 3784 Avg: 4460 Max:   55211

and for multiple threads i can see no ordering after the priorities (cyclictest -t5 -p 80 -i 10000 -l 1000):
policy: fifo: loadavg: 0.18 0.06 0.01 1/48 270          0 Avg:  955 Max:    3747
T: 2 (  268) P:78 I:11000 C:    885 Min:    483 Act:  652 Avg:  838 Max:    2941
T: 0 (  266) P:80 I:10000 C:    985 Min:    473 Act:  525 Avg:  619 Max:    1549
T: 3 (  269) P:77 I:11500 C:    846 Min:    483 Act: 1176 Avg:  907 Max:    3079
T: 1 (  267) P:79 I:10500 C:    938 Min:    484 Act:  555 Avg:  746 Max:    2153

Anyone has an idea if it is due to a wrong clockevent/source implementation or has something to do with PI mutexes or my processor is two weak?
Please, any suggestions would be highly appreciated.

Kind Regards
Johannes Bauer

Heres my clocksource/event implementation:

/*
 *  linux/arch/arm/mach-lpc22xx/time.c
 *
 *  Copyright (C) 2004 Philips Semiconductors
 */

#include
#include
#include
#include
#include
#include
#include
#include

#include
#include
#include
#include
//#include
#include
#include


extern void    lpc22xx_unmask_irq(unsigned int);

/*
 * TODO: We should be using the clk.h interface instead.
 */

static unsigned int lpc2xxx_fcclk = 0;
static unsigned int lpc2xxx_fpclk = 0;

unsigned int lpc_get_fcclk(void)
{
    return lpc2xxx_fcclk;
}
EXPORT_SYMBOL(lpc_get_fcclk);

unsigned int lpc_get_fpclk(void)
{
    return lpc2xxx_fpclk;
}
EXPORT_SYMBOL(lpc_get_fpclk);

static int lpc22xx_next_event(unsigned long delta,
                    struct clock_event_device *dev)
{
   
    BUG_ON(delta == 0);

    T0TCR = 0;    //disabel timer0
    T0TCR = 0x02;    //reset timer0
    T0IR = 0x01;    //clear interrupt flag
    T0TCR = 0x01;    //enable timer0
    T0MR0 = delta;    //set match register to delta
   
    return 0;
}

static cycle_t read_pit_clk(struct clocksource *cs)
{
    unsigned long elapsed;
    unsigned long flags;

    elapsed = T1TC;            // return timer1 counter value

    return (cycle_t) elapsed;    // returns the actual timer count
}

static struct clocksource pit_clk = {
    .name        = \"pit\",
    .rating        = 175,
    .read        = read_pit_clk,
    .shift        = 28,    //is changed by init code
    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
};

static void
pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
{
    switch (mode) {
    case CLOCK_EVT_MODE_PERIODIC:
        /* update clocksource counter */
        printk(\"periodic\\n\");
        T0TCR = 0;        //disable timer0       
        T0TCR = 0x02;        //reset timer0
        T0MCR = 0x03;        //interrupt on compare match and counter reset on compare match
        T0PR = 0;        //no prescaler (72MHz)
        T0MR0 = 720000;        //fire interrupt after 10ms (100Hz)
        T0TCR = 1;        //enable timer
       
        break;
    case CLOCK_EVT_MODE_ONESHOT:
        printk(\"oneshot\\n\");
        T0TCR = 0;        //disabel timer0
        T0TCR = 0x02;        //reset timer0
        T0MCR = 0x03;        //interrupt on compare match and counter reset on compare match
        T0PR = 0;        //no prescaler (72MHz)
        T0MR0 = 0xFFFFFFFF;    //fire interrupts some time in the future (set_next_event should do it before)

        break;
        /* FALLTHROUGH */
    case CLOCK_EVT_MODE_SHUTDOWN:
        printk(\"shutdown\\n\");
        T0TCR &= ~0x01;        // disable timer
        break;
    case CLOCK_EVT_MODE_UNUSED:
        printk(\"unused\\n\");
        /* disable irq, leaving the clocksource active */
        T0MCR &= ~0x01;        //disable interrupt
        break;
    case CLOCK_EVT_MODE_RESUME:
        printk(\"resume\\n\");
        break;
    }
}

static struct clock_event_device pit_clkevt = {
    .name        = \"pit\",
    .features    = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
    .shift        = 20,    //is changed by init function
    .rating        = 100,    //dont know yet
    .set_mode    = pit_clkevt_mode,
    .set_next_event = lpc22xx_next_event,
};


static irqreturn_t
lpc2xxx_timer_interrupt(int irq, void *dev_id)
{

    pit_clkevt.event_handler(&pit_clkevt);    //handle_event   
    T0IR |= 0x01;    /* reset MR0 interrupt */
   
    return IRQ_HANDLED;
}

static struct irqaction lpc2xxx_timer_irq = {
        .name           = \"lpc2xxx-tick\",
    .flags        = IRQF_DISABLED | IRQF_TIMER,
        .handler        = lpc2xxx_timer_interrupt
};

/*
 * Set up timer interrupt, and return the current time in seconds.
 */
/*
 Timer0 used as periodic or oneshot clockevent
 Timer1 used as clocksource for reading continous time
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
    PCLKSEL0 &= ~(3 < <2);
    PCLKSEL0 |=  (1 < <2);
    PCLKSEL0 |=  (1 < <4);
    printk(\"Fcclk=%ld PCLKSEL=%08lx %08lx\\n\",
        Fcclk, PCLKSEL0, PCLKSEL1);
    /*
     * disable and clear timer 0, set to
     */
    T1TCR &= ~0x01;    //disable timer1
    T0TCR &= ~0x01;    //disable timer1
    /* initialize the timer period and prescaler */

    T0PR = 0;    //no prescaler (72Mhz)
    T1PR = 0;    //no prescaler (72Mhz)
    T1MCR = 0x0;    //no interrupt for timer1

    lpc2xxx_timer_irq.handler = lpc2xxx_timer_interrupt;

    /* set up the interrupt vevtor for timer 0 match */
    setup_irq(LPC2xxx_INTERRUPT_TIMER0, &lpc2xxx_timer_irq);
   
    /* enable the timer IRQ */
    lpc22xx_unmask_irq(LPC2xxx_INTERRUPT_TIMER0);

    clocksource_calc_mult_shift(&pit_clk,Fcclk,4);    // minsecvalue = 4 no idea why (seen in other codes)

    pit_clk.mask = CLOCKSOURCE_MASK(32);                // mask is 32 bit so the clk subsystem knows where it overruns
    clocksource_register(&pit_clk);

    clockevents_calc_mult_shift(&pit_clkevt,(Fcclk),4);    // minsecvalue = 4 no idea why (seen in other codes)
    pit_clkevt.max_delta_ns =
        clockevent_delta2ns((u32)0xfffffffe, &pit_clkevt);    //close to max (maybe not necessary
    printk(\"Max Delta: %llu\\n\",clockevent_delta2ns((u32)0xfffffffe, &pit_clkevt));   
    pit_clkevt.min_delta_ns =
        clockevent_delta2ns(0xE10, &pit_clkevt);        // min delta is 50us (i dont know what should be taken here???!!)
    printk(\"Min Delta: %llu\\n\",clockevent_delta2ns(0xE10, &pit_clkevt));    //50us?
    pit_clkevt.cpumask = cpumask_of(0);        // uniprocessro system
    clockevents_register_device(&pit_clkevt);

    T0MR0 = 720000;                   
    T1MR0 = 0xFFFFFFFF;               
    /* let timer 0 run... */
    T1IR = 0x01; /* reset MR0 interrupt*/
    T1TCR = 0x02;    /* Reset timer count and prescale counter */
    T1TCR = 0x01;    /* enable timer counter and prescale counter */
        /* let timer 0 run... */
    T0IR = 0x01; /* reset MR0 interrupt*/
    T0TCR = 0x02;    /* Reset timer count and prescale counter */
    T0TCR = 0x01;    /* enable timer counter and prescale counter */
}

struct sys_timer lpc22xx_timer = {
    .init        = lpc2xxx_time_init,
};



