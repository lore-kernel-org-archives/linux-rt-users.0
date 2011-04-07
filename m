From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: clocksource and clockevent confusion
Date: Thu, 07 Apr 2011 20:37:37 +0200
Message-ID: <4D9E0471.8080908@enseirb-matmeca.fr>
References: <1302194932.4d9deaf4033b9@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:52450 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab1DGShq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Apr 2011 14:37:46 -0400
Received: from [192.168.0.1] (unknown [82.64.251.87])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 835FCA6730
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Apr 2011 20:37:39 +0200 (CEST)
In-Reply-To: <1302194932.4d9deaf4033b9@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 07/04/2011 18:48, Johannes Bauer a =E9crit :
Hi again,

> Thank you for your help Pat!
>
> I figured out to write a driver, thats the code:
>
> static cycle_t read_pit_clk(struct clocksource *cs)
> {
>
> 	return T0TC;	// returns the actual timer count
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
>
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
With hrtimer implementation, you don't ahve to implement the traditiona=
l=20
titck timer. Once you have a clock event, the hrtimer use it. It tries=20
to program the clock event in one shot shot mode (case=20
CLOCK_EVT_MODE_ONESHOT) and you have the hrtimer support enabled. If it=
=20
cant, then the subsystem is programmed in periodic mode (case=20
CLOCK_EVT_MODE_PERIODIC) like in the traditional mode... no do_timer()=20
ar all...

Cheers,

Pat.
> 	//counts with 72MHz so compare interrupt every 10ms
> 	T0MR0 =3D 720000;
> 	T0PR =3D 0;	// prescaler =3D 0
> 	T0MCR |=3D 0x03;			/* generate interrupt when T0MR0 match T0TC and R=
eset Timer Count*/
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
> 	pit_clk.mask =3D 71999;				// mask is 71999 so the clk subsystem kno=
ws where it overruns (is that correct??)
> 	clocksource_register(&pit_clk);
>
> 	clockevents_calc_mult_shift(&pit_clkevt,Fcclk,4);	// minsecvalue =3D=
4 no idea why (seen in other codes)
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
> The problem is that after a minute or so the kernel freezes and hangs=
 in the cpu_idle() function in arch/arm/kernel/process.c
>
> the board stays in this whileloop in the else condition forever:
>
> while (!need_resched()) {
> #ifdef CONFIG_HOTPLUG_CPU
> 			if (cpu_is_offline(smp_processor_id()))
> 				cpu_die();
> #endif
>
> 			local_irq_disable();
> 			if (hlt_counter) {
> 				local_irq_enable();
> 				cpu_relax();
> 			} else {
> 				stop_critical_timings();
> 				pm_idle();
> 				start_critical_timings();
> 				/*
> 				 * This will eventually be removed - pm_idle
> 				 * functions should always return with IRQs
> 				 * enabled.
> 				 */
> 				WARN_ON(irqs_disabled());
> 				local_irq_enable();
> 			}
> 		}
>
> i dont know what exactly the problem is...
> Do i have to implement a sched_clock routine myself as is saw it in a=
 few implemetations.
> When i do a cat \"/proc/timer_list\" i can see folowing:
>
> cat timer_list
> Timer List Version: v0.5
> HRTIMER_MAX_CLOCK_BASES: 2
> now at 960971480 nsecs
>
> cpu: 0
>   clock 0:
>    .base:       a031c560
>    .index:      0
>    .resolution: 10000000 nsecs
>    .get_time:   ktime_get_real
>    .offset:     0 nsecs
> active timers:
>   clock 1:
>    .base:       a031c594
>    .index:      1
>    .resolution: 10000000 nsecs
>    .get_time:   ktime_get
>    .offset:     0 nsecs
> active timers:
>   #0: def_rt_bandwidth, sched_rt_period_timer, S:01, __enqueue_rt_ent=
ity, sirq-timer/0/4
>   # expires at 1000000000-1000000000 nsecs [in 39028520 to 39028520 n=
secs]
>   #1:<a12fda88>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, inetd/=
170
>   # expires at 1960997774-1961997798 nsecs [in 1000026294 to 10010263=
18 nsecs]
>    .expires_next   : 2147483646999999999 nsecs
>    .hres_active    : 0
>    .nr_events      : 0
>    .nr_retries     : 0
>    .nr_hangs       : 0
>    .max_hang_time  : 0 nsecs
>    .nohz_mode      : 0
>    .idle_tick      : 0 nsecs
>    .tick_stopped   : 0
>    .idle_jiffies   : 0
>    .idle_calls     : 0
>    .idle_sleeps    : 0
>    .idle_entrytime : 960913921 nsecs
>    .idle_waketime  : 0 nsecs
>    .idle_exittime  : 0 nsecs
>    .idle_sleeptime : 77532270 nsecs
>    .last_jiffies   : 0
>    .next_jiffies   : 0
>    .idle_expires   : 0 nsecs
> jiffies: 4294941108
>
>
> Tick Device: mode:     0
> Per CPU device: 0
> Clock Event Device: pit
>   max_delta_ns:   0
>   min_delta_ns:   0
>   mult:           309237645
>   shift:          32
>   mode:           2
>   next_event:     2147483646999999999 nsecs
>   set_next_event:<(null)>
>   set_mode:       pit_clkevt_mode
>   event_handler:  tick_handle_periodic
>
>
> I enabled some tracing and debuging in the kernel and then the follow=
ing message was printed when the processor froze:
>
> \"sched: RT throttling activated\"
>
> What does it mean? IS it a problem of my timer implementation or is s=
omething else wrong with the system?
>
> I hope somebody can help me on this.
>
> Kind regards
> Johannes Bauer
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
