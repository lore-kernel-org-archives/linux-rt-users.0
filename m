From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: clocksource and clockevent confusion
Date: Fri, 08 Apr 2011 16:33:55 +0200
Message-ID: <4D9F1CD3.50409@enseirb-matmeca.fr>
References: <1302267680.4d9f072045590@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Johannes Bauer <hannes_bauer@aon.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:46946 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab1DHOeH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2011 10:34:07 -0400
In-Reply-To: <1302267680.4d9f072045590@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 08/04/2011 15:01, Johannes Bauer a =E9crit :
> Hi Pat!
Hi Johannes,
> Again thank you for your fast help!
>
> I tried to implement the oneshot functionality.
> However the system does not boot properly, and seems to be stuck in t=
he same while loop in process.c. I disabled the dynamic tick configurat=
ion and tried with PREEMPT_NONE and PREEMPT_VOLUNTARY and PREEMPT_RT, b=
ut it seems not to change a thing. The boot messages seem to tell that =
first the periodic timer is used and then it is switched to oneshot mod=
e and stops.
That is the correct behaviour: beginning with the periodic mode and the=
n=20
switching (if possible) in the one shot mode if a clock event source is=
=20
found by the hrtimer subsystem..
In the lpc2xxx_time_init(), you must just have general PIT configuratio=
n=20
if needed and clock source and clock event installation. No periodic=20
timer programmation.
Are you sure that the one shot interrupt of your timer is acknowledged?

Try:

lpc2xxx_timer_interrupt(int irq, void *dev_id)
{
  struct clock_event_device *evt =3D&pit_clkevt;

//	printk(\"Interrupt\\n\");
=09
      T0IR |=3D 0x01;	/* reset interrupt */
      evt->event_handler(evt);
      return IRQ_HANDLED;
}


>
> <6>Calibrating delay loop...<c>23.24 BogoMIPS (lpj=3D116224)
>
> Mount-cache hash table entries: 512
>
> <6>NET: Registered protocol family 16
>
> bio: create slab<bio-0>  at 0
>
> <5>SCSI subsystem initialized
>
> <6>usbcore: registered new interface driver usbfs
>
> <6>usbcore: registered new interface driver hub
>
> <6>usbcore: registered new device driver usb
>
> <6>Switching to clocksource pit
>
> oneshot
>
> NEXT_EVENT: 510789
>
> NEXT_EVENT: 1061342
>
> <6>NET: Registered protocol family 2
>
> <6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>
> <6>TCP established hash table entries: 1024 (order: 1, 8192 bytes)
>
> <6>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>
> <6>TCP: Hash tables configured (established 1024 bind 1024)
>
> <6>TCP reno registered
>
> <6>UDP hash table entries: 256 (order: 0, 4096 bytes)
>
> <6>UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>
> <6>NET: Registered protocol family 1
>
> <6>RPC: Registered udp transport module.
>
> <6>RPC: Registered tcp transport module.
>
> <6>RPC: Registered tcp NFSv4.1 backchannel transport module.
>
> <6>Trying to unpack rootfs image as initramfs...
>
> <6>rootfs image is not initramfs (junk in compressed archive); looks =
like an initrd
>
> <6>Freeing initrd memory: 4000K
>
> <4>NetWinder Floating Point Emulator V0.97 (double precision)
>
> <6>JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc=
=2E
>
> <6>ROMFS MTD (C) 2007 Red Hat, Inc.
>
> <6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 25=
3)
>
> <6>io scheduler noop registered (default)
>
> lpc2478fb: smem_len =3D 153600
>
> lpc2478fb: line_length =3D 480
>
>
>
> With periodic timer it runs a little bit further and lets me do some =
input.
>
> Is it possible that thats a problem due to the fact im running uClinu=
x (NOMMU CPU) with uClibc, which seems to have no support for PI mutexe=
s?
I don't know.
Are you sure of you oneshot implementation?
> Do you have any ideas on getting PREEMPT RT running for NOMMU systems=
?
I don't know if it is possible because the PREEMPT-RT patch if for MMU=20
processors at first. That's why I've ported it to NIOS 2 with MMU and=20
not NIOS without MMU.
> The timer code with oneshot looks the following way, for debugging pu=
rpose i entered some printks:
>
> static int lpc22xx_next_event(unsigned long delta,
> 					struct clock_event_device *dev)
> {
> //	pr_debug(\"%s: next event, delta %x\\n\", __func__, (u32)delta);
> 	printk(\"NEXT_EVENT: %u\\n\",delta);
> 	T0MR0 =3D delta;
Is is really delta that you must program here with your PIT? A number o=
f=20
CPU clock? you PIT doesn=E9t run at the same frequency than your CPU?

Pat.
> 	T0PR =3D 0;
> 	T0MCR |=3D 0x03;
> 	T0TCR |=3D 0x02;	//reset counter
> 	return 0;
> }
>
> static cycle_t read_pit_clk(struct clocksource *cs)
> {
>
> 	return (cycle_t) T0TC;	// returns the actual timer count
> }
>
> static struct clocksource pit_clk =3D {
> 	.name		=3D \"pit\",
> 	.rating		=3D 175,
> 	.read		=3D read_pit_clk,
> 	.shift		=3D 28,	//is changed by init code
> 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
> };
>
> /*
>   * Clockevent device:  interrupts every 1/HZ (=3D=3D pit_cycles * MC=
K/16)
>   */
> static void
> pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device=
 *dev)
> {
> 	switch (mode) {
> 	case CLOCK_EVT_MODE_PERIODIC:
> 		/* update clocksource counter */
> 		printk(\"periodic\\n\");
> 		T0MR0 =3D 720000;
> 		T0PR =3D 0;
> 		T0MCR&=3D ~0x04;	//be sure timer does not stop on compare match
> 		T0MCR |=3D 0x03;
> 		break;
> 	case CLOCK_EVT_MODE_ONESHOT:
> //		T0MR0 =3D 720000;
> //		T0PR =3D 0;
> 	=09
> //		T0MCR |=3D 0x07;
> =09
> 		printk(\"oneshot\\n\");
>
> 		break;
> 		/* FALLTHROUGH */
> 	case CLOCK_EVT_MODE_SHUTDOWN:
> 		printk(\"shutdown\\n\");
> 		T0TCR&=3D ~0x01;
> 		break;
> 	case CLOCK_EVT_MODE_UNUSED:
> 		printk(\"unused\\n\");
> 		/* disable irq, leaving the clocksource active */
> 		T0MCR&=3D ~0x01;
> 		break;
> 	case CLOCK_EVT_MODE_RESUME:
> 		printk(\"resume\\n\");
> 		break;
> 	}
> }
>
> static struct clock_event_device pit_clkevt =3D {
> 	.name		=3D \"pit\",
> 	.features	=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> 	.shift		=3D 32,	//is changed by init function
> 	.rating		=3D 100,	//dont know yet
> 	.set_mode	=3D pit_clkevt_mode,
> 	.set_next_event =3D lpc22xx_next_event,
> };
>
>
> unsigned long lpc2xxx_gettimeoffset (void)
> {
> 	//CLOCKS_PER_USEC =3D LPC2xxx_Fpclk / 1000000;
> 	return (T0TC/(lpc2xxx_fcclk / 1000000));
> }
>
> static irqreturn_t
> lpc2xxx_timer_interrupt(int irq, void *dev_id)
> {
>      if (!(T0IR&  0x01)) return IRQ_NONE;
> /*    do_timer(regs);
>      do_profile(regs);
> */ //timer_tick();
> /* modified 20050608 for new version */
>
> 	pit_clkevt.event_handler(&pit_clkevt);	//handle_event
> 	printk(\"Interrupt\\n\");
> =09
>      T0IR |=3D 0x01;	/* reset interrupt */
>      return IRQ_HANDLED;
> }
>
> static struct irqaction lpc2xxx_timer_irq =3D {
>          .name           =3D \"lpc2xxx-tick\",
> 	.flags		=3D IRQF_DISABLED | IRQF_TIMER,
>          .handler        =3D lpc2xxx_timer_interrupt
> };
>
> /*
>   * Set up timer interrupt, and return the current time in seconds.
>   */
> /*
>   Setup PCLK_TIMER0 =3D Fcclk (01)
>   Setup T0MR0 =3D 10 (ms)
>   Setup T0PR0 =3D 0
> */
> void __init  lpc2xxx_time_init (void)
> {
> 	unsigned char clkSel =3D 0;
> 	unsigned long stat =3D PLLSTAT;
> 	unsigned long M =3D stat&  0x7FFFF;
> 	unsigned long N =3D (stat>>16)&  0xFF;
> 	unsigned long Fcco =3D (2 * (M+1) *CONFIG_LPC22xx_Fosc) / (N+1);
> 	unsigned long Fcclk =3D Fcco / ((CCLKCFG&0xFF)+1);
> 	lpc2xxx_fcclk =3D Fcclk;
> 	lpc2xxx_fpclk =3D Fcclk;
>
> 	/*
>    	 * Here we assume that the clock is the same for all peripherals
>   	 * which of course doesn\'t have to be the case.
> 	 * We should be using the clk.h interface instead.
> 	 */
> =09
> 	clkSel =3D (unsigned char)(PCLKSEL0&  0xff);
> 	if (clkSel =3D=3D 0x00)
> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 4;
> 	else if (clkSel =3D=3D 0x55)
> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk;
> 	else if (clkSel =3D=3D 0xAA)
> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 2;
> 	else if (clkSel =3D=3D 0xFF)
> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 8;
>
> 	printk(\"LPC2XXX Clocking Fin=3D%dHz Fcco=3D%ldHz M=3D%ld N=3D%ld\\n=
\",
> 		CONFIG_LPC22xx_Fosc,
> 		Fcco,
> 		M,
> 		N);
> 	PCLKSEL0&=3D ~(3<<2);
> 	PCLKSEL0 |=3D  (1<<2);
> 	printk(\"Fcclk=3D%ld PCLKSEL=3D%08lx %08lx\\n\",
> 		Fcclk, PCLKSEL0, PCLKSEL1);
> 	/*
> 	 * disable and clear timer 0, set to
> 	 */
> 	T0TCR&=3D ~0x01;
> 	/* initialize the timer period and prescaler */
>
> 	//counts with 72MHz so compare interrupt every 10ms
> //	T0MR0 =3D 720000;
> //	T0PR =3D 0;	// prescaler =3D 0
> //	T0MCR |=3D 0x03;			/* generate interrupt when T0MR0 match T0TC and=
 Reset Timer Count*/
>
> 	lpc2xxx_timer_irq.handler =3D lpc2xxx_timer_interrupt;
>
> 	/* set up the interrupt vevtor for timer 0 match */
> 	setup_irq(LPC2xxx_INTERRUPT_TIMER0,&lpc2xxx_timer_irq);
> =09
> 	/* enable the timer IRQ */
> 	lpc22xx_unmask_irq(LPC2xxx_INTERRUPT_TIMER0);
>
> 	clocksource_calc_mult_shift(&pit_clk,Fcclk,4);	// minsecvalue =3D4 n=
o idea why (seen in other codes)
>
> 	pit_clk.mask =3D CLOCKSOURCE_MASK(32);				// mask is 71999 so the cl=
k subsystem knows where it overruns (is that correct??)
> 	clocksource_register(&pit_clk);
>
> 	clockevents_calc_mult_shift(&pit_clkevt,Fcclk,4);	// minsecvalue =3D=
4 no idea why (seen in other codes)
> 	pit_clkevt.max_delta_ns =3D
> 		clockevent_delta2ns((u32)~0,&pit_clkevt);
> 	pit_clkevt.min_delta_ns =3D
> 		clockevent_delta2ns(1,&pit_clkevt);
> 	pit_clkevt.cpumask =3D cpumask_of(0);		// uniprocessro system
> 	clockevents_register_device(&pit_clkevt);
>
> 	/* let timer 0 run... */
> 	T0IR =3D 0x01; /* reset MR0 interrupt*/
> 	T0TCR =3D 0x02;	/* Reset timer count and prescale counter */
> 	T0TCR =3D 0x01;	/* enable timer counter and prescale counter */
> }
>
> struct sys_timer lpc22xx_timer =3D {
> 	.init		=3D lpc2xxx_time_init,
> };
>
>
>
>
> ----- Original von:  Patrice Kadionik
>
>> Le 07/04/2011 18:48, Johannes Bauer a =E9crit :
> Hi again,
>
>> Thank you for your help Pat!
>>
>> I figured out to write a driver, thats the code:
>>
>> static cycle_t read_pit_clk(struct clocksource *cs)
>> {
>>
>> 	return T0TC;	// returns the actual timer count
>> }
>>
>> static struct clocksource pit_clk =3D {
>> 	.name		=3D \\\"pit\\\",
>> 	.rating		=3D 175,
>> 	.read		=3D read_pit_clk,
>> 	.shift		=3D 28,	//is changed by init code
>> 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
>> };
>>
>>
>> void __init  lpc2xxx_time_init (void)
>> {
>> 	unsigned char clkSel =3D 0;
>> 	unsigned long stat =3D PLLSTAT;
>> 	unsigned long M =3D stat&   0x7FFFF;
>> 	unsigned long N =3D (stat>>16)&   0xFF;
>> 	unsigned long Fcco =3D (2 * (M+1) *CONFIG_LPC22xx_Fosc) / (N+1);
>> 	unsigned long Fcclk =3D Fcco / ((CCLKCFG&0xFF)+1);
>> 	lpc2xxx_fcclk =3D Fcclk;
>> 	lpc2xxx_fpclk =3D Fcclk;
>>
>> 	/*
>>     	 * Here we assume that the clock is the same for all peripheral=
s
>>    	 * which of course doesn\\\'t have to be the case.
>> 	 * We should be using the clk.h interface instead.
>> 	 */
>> =09
>> 	clkSel =3D (unsigned char)(PCLKSEL0&   0xff);
>> 	if (clkSel =3D=3D 0x00)
>> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 4;
>> 	else if (clkSel =3D=3D 0x55)
>> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk;
>> 	else if (clkSel =3D=3D 0xAA)
>> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 2;
>> 	else if (clkSel =3D=3D 0xFF)
>> 		lpc2xxx_fpclk =3D lpc2xxx_fcclk / 8;
>>
>> 	printk(\\\"LPC2XXX Clocking Fin=3D%dHz Fcco=3D%ldHz M=3D%ld N=3D%ld=
\\\\n\\\",
>> 		CONFIG_LPC22xx_Fosc,
>> 		Fcco,
>> 		M,
>> 		N);
>> 	PCLKSEL0&=3D ~(3<<2);
>> 	PCLKSEL0 |=3D  (1<<2);
>> 	printk(\\\"Fcclk=3D%ld PCLKSEL=3D%08lx %08lx\\\\n\\\",
>> 		Fcclk, PCLKSEL0, PCLKSEL1);
>> 	/*
>> 	 * disable and clear timer 0, set to
>> 	 */
>> 	T0TCR&=3D ~0x01;
>> 	/* initialize the timer period and prescaler */
> With hrtimer implementation, you don\'t ahve to implement the traditi=
onal
> titck timer. Once you have a clock event, the hrtimer use it. It trie=
s
> to program the clock event in one shot shot mode (case
> CLOCK_EVT_MODE_ONESHOT) and you have the hrtimer support enabled. If =
it
> cant, then the subsystem is programmed in periodic mode (case
> CLOCK_EVT_MODE_PERIODIC) like in the traditional mode... no do_timer(=
)
> ar all...
>
> Cheers,
>
> Pat.
>> 	//counts with 72MHz so compare interrupt every 10ms
>> 	T0MR0 =3D 720000;
>> 	T0PR =3D 0;	// prescaler =3D 0
>> 	T0MCR |=3D 0x03;			/* generate interrupt when T0MR0 match T0TC and =
Reset Timer Count*/
>>
>> 	lpc2xxx_timer_irq.handler =3D lpc2xxx_timer_interrupt;
>>
>> 	/* set up the interrupt vevtor for timer 0 match */
>> 	setup_irq(LPC2xxx_INTERRUPT_TIMER0,&lpc2xxx_timer_irq);
>> =09
>> 	/* enable the timer IRQ */
>> 	lpc22xx_unmask_irq(LPC2xxx_INTERRUPT_TIMER0);
>>
>> 	clocksource_calc_mult_shift(&pit_clk,Fcclk,4);	// minsecvalue =3D4 =
no idea why (seen in other codes)
>>
>> 	pit_clk.mask =3D 71999;				// mask is 71999 so the clk subsystem kn=
ows where it overruns (is that correct??)
>> 	clocksource_register(&pit_clk);
>>
>> 	clockevents_calc_mult_shift(&pit_clkevt,Fcclk,4);	// minsecvalue =3D=
4 no idea why (seen in other codes)
>> 	pit_clkevt.cpumask =3D cpumask_of(0);		// uniprocessro system
>> 	clockevents_register_device(&pit_clkevt);
>>
>> 	/* let timer 0 run... */
>> 	T0IR =3D 0x01; /* reset MR0 interrupt*/
>> 	T0TCR =3D 0x02;	/* Reset timer count and prescale counter */
>> 	T0TCR =3D 0x01;	/* enable timer counter and prescale counter */
>> }
>>
>> struct sys_timer lpc22xx_timer =3D {
>> 	.init		=3D lpc2xxx_time_init,
>> };
>>
>>
>>
>> The problem is that after a minute or so the kernel freezes and hang=
s in the cpu_idle() function in arch/arm/kernel/process.c
>>
>> the board stays in this whileloop in the else condition forever:
>>
>> while (!need_resched()) {
>> #ifdef CONFIG_HOTPLUG_CPU
>> 			if (cpu_is_offline(smp_processor_id()))
>> 				cpu_die();
>> #endif
>>
>> 			local_irq_disable();
>> 			if (hlt_counter) {
>> 				local_irq_enable();
>> 				cpu_relax();
>> 			} else {
>> 				stop_critical_timings();
>> 				pm_idle();
>> 				start_critical_timings();
>> 				/*
>> 				 * This will eventually be removed - pm_idle
>> 				 * functions should always return with IRQs
>> 				 * enabled.
>> 				 */
>> 				WARN_ON(irqs_disabled());
>> 				local_irq_enable();
>> 			}
>> 		}
>>
>> i dont know what exactly the problem is...
>> Do i have to implement a sched_clock routine myself as is saw it in =
a few implemetations.
>> When i do a cat \\\"/proc/timer_list\\\" i can see folowing:
>>
>> cat timer_list
>> Timer List Version: v0.5
>> HRTIMER_MAX_CLOCK_BASES: 2
>> now at 960971480 nsecs
>>
>> cpu: 0
>>    clock 0:
>>     .base:       a031c560
>>     .index:      0
>>     .resolution: 10000000 nsecs
>>     .get_time:   ktime_get_real
>>     .offset:     0 nsecs
>> active timers:
>>    clock 1:
>>     .base:       a031c594
>>     .index:      1
>>     .resolution: 10000000 nsecs
>>     .get_time:   ktime_get
>>     .offset:     0 nsecs
>> active timers:
>>    #0: def_rt_bandwidth, sched_rt_period_timer, S:01, __enqueue_rt_e=
ntity, sirq-timer/0/4
>>    # expires at 1000000000-1000000000 nsecs [in 39028520 to 39028520=
 nsecs]
>>    #1:<a12fda88>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, inet=
d/170
>>    # expires at 1960997774-1961997798 nsecs [in 1000026294 to 100102=
6318 nsecs]
>>     .expires_next   : 2147483646999999999 nsecs
>>     .hres_active    : 0
>>     .nr_events      : 0
>>     .nr_retries     : 0
>>     .nr_hangs       : 0
>>     .max_hang_time  : 0 nsecs
>>     .nohz_mode      : 0
>>     .idle_tick      : 0 nsecs
>>     .tick_stopped   : 0
>>     .idle_jiffies   : 0
>>     .idle_calls     : 0
>>     .idle_sleeps    : 0
>>     .idle_entrytime : 960913921 nsecs
>>     .idle_waketime  : 0 nsecs
>>     .idle_exittime  : 0 nsecs
>>     .idle_sleeptime : 77532270 nsecs
>>     .last_jiffies   : 0
>>     .next_jiffies   : 0
>>     .idle_expires   : 0 nsecs
>> jiffies: 4294941108
>>
>>
>> Tick Device: mode:     0
>> Per CPU device: 0
>> Clock Event Device: pit
>>    max_delta_ns:   0
>>    min_delta_ns:   0
>>    mult:           309237645
>>    shift:          32
>>    mode:           2
>>    next_event:     2147483646999999999 nsecs
>>    set_next_event:<(null)>
>>    set_mode:       pit_clkevt_mode
>>    event_handler:  tick_handle_periodic
>>
>>
>> I enabled some tracing and debuging in the kernel and then the follo=
wing message was printed when the processor froze:
>>
>> \\\"sched: RT throttling activated\\\"
>>
>> What does it mean? IS it a problem of my timer implementation or is =
something else wrong with the system?
>>
>> I hope somebody can help me on this.
>>
>> Kind regards
>> Johannes Bauer
>>
>> --
>> To unsubscribe from this list: send the line \"unsubscribe linux-rt-=
users\" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------=
+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" =
+
+----------------------------------------------------------------------=
+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik =
+
+ IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           =
+
+ PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
+ FRANCE                       mailto:patrice.kadionik@ims-bordeaux.fr =
+
+----------------------------------------------------------------------=
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
