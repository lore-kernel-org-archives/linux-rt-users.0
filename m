From: Johannes Bauer <hannes_bauer@aon.at>
Subject: 2.6.33 - source of latency?
Date: Sat, 21 May 2011 18:16:36 +0200 (CEST)
Message-ID: <33307415.3810.1305994596747.JavaMail.root@WARSBL113.highway.telekom.at>
References: <11390315.16830.1305842430762.JavaMail.root@WARSBL114.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout03.highway.telekom.at ([195.3.96.115]:2459 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752321Ab1EUQQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 May 2011 12:16:40 -0400
Received: from warsbl113-nfs.highway.telekom.at (HELO WARSBL113.highway.telekom.at) ([172.18.96.90])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub96.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 21 May 2011 16:16:37 -0000
Received: from WARSBL113.highway.telekom.at (localhost.localdomain [127.0.0.1])
	by WARSBL113.highway.telekom.at (8.13.1/8.13.1) with ESMTP id p4LGGadV001214
	for <linux-rt-users@vger.kernel.org>; Sat, 21 May 2011 18:16:36 +0200
In-Reply-To: <11390315.16830.1305842430762.JavaMail.root@WARSBL114.highway.telekom.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I dont really understand the irqsoff latency trace output of the 2.6.33=
 preempt-rt patched kernel.
Here are the first lines of the trace file:

# echo 1 > tracing_enabled; cyclictest -t1 -p 80 -n -i 10000 -l 1000; e=
cho 0 > tracing_enabled
policy: fifo: loadavg: 1.42 0.96 0.55 5/27 162         =20

T: 0 (  162) P:80 I:10000 C:    398 Min:   4517 Act: 7337 Avg: 8004 Max=
:   59068
policy: fifo: loadavg: 2.12 1.13 0.60 7/27 162         =20

T: 0 (  162) P:80 I:10000 C:   1000 Min:   4517 Act:52133 Avg: 8760 Max=
:   59980
# cat trace
# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 2.6.35-uc0
# --------------------------------------------------------------------
# latency: 276 us, #50091/421825, CPU#0 | (M:preempt VP:0, KP:0, SP:0 H=
P:0)
#    -----------------
#    | task: echo-163 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  =3D> started at: trace_hardirqs_off
#  =3D> ended at:   trace_hardirqs_on
#
#
#                  _------=3D> CPU#           =20
#                 / _-----=3D> irqs-off       =20
#                | / _----=3D> need-resched   =20
#                || / _---=3D> hardirq/softirq=20
#                ||| / _--=3D> preempt-depth  =20
#                |||| /_--=3D> lock-depth      =20
#                |||||/     delay            =20
#  cmd     pid   |||||| time  |   caller     =20
#     \   /      ||||||   \   |   /          =20
sirq-rcu-12      0dN... 39577425us!: <stack trace>
 =3D> trace_hardirqs_on
 =3D> check_for_new_grace_period
 =3D> __rcu_process_callbacks
 =3D> rcu_process_callbacks
 =3D> run_ksoftirqd
 =3D> kthread
 =3D> do_exit
sirq-rcu-12      0dN... 39578787us!: trace_hardirqs_on <-trace_hardirqs=
_on
sirq-rcu-12      0dN... 39578936us!: check_for_new_grace_period <-trace=
_hardirqs_off
sirq-rcu-12      0dN... 39579125us!: check_for_new_grace_period <-trace=
_hardirqs_on
sirq-rcu-12      0dN... 39579307us+: trace_hardirqs_on <-trace_hardirqs=
_on
sirq-rcu-12      0dN... 39579397us!: <stack trace>
 =3D> trace_hardirqs_on
 =3D> check_for_new_grace_period
 =3D> __rcu_process_callbacks
 =3D> rcu_process_callbacks
 =3D> run_ksoftirqd
 =3D> kthread
 =3D> do_exit
sirq-rcu-12      0dN... 39580680us!: trace_hardirqs_on <-trace_hardirqs=
_on
sirq-rcu-12      0dN... 39580829us!: check_for_new_grace_period <-trace=
_hardirqs_off
sirq-rcu-12      0dN... 39580957us!: check_for_new_grace_period <-trace=
_hardirqs_on
sirq-rcu-12      0dN... 39581140us+: trace_hardirqs_on <-trace_hardirqs=
_on
sirq-rcu-12      0dN... 39581231us!: <stack trace>
 =3D> trace_hardirqs_on
 =3D> check_for_new_grace_period
 =3D> __rcu_process_callbacks
 =3D> rcu_process_callbacks
 =3D> run_ksoftirqd
 =3D> kthread
 =3D> do_exit

Can anyone explain to me where the irqs are enabled again? Is it always=
 after the <stack_trace> or am I wrong here?
Moreover was does "latency: 276 us" mean?
Alone here 1ms is observed (i think its that high because the tracer to=
tally breaks my 72MHz system)
echo-163     0d.... 1264342250us!: trace_hardirqs_on <-trace_hardirqs_o=
n
echo-163     0d.... 1264342400us!: __irq_svc <-trace_hardirqs_off
echo-163     0d..2. 1264343449us!: __schedule <-trace_hardirqs_on      =
       ##1264343449-1264342400=3D1049us!!!!
echo-163     0d..2. 1264343602us+: trace_hardirqs_on <-trace_hardirqs_o=
n
echo-163     0d..2. 1264343694us!: <stack trace>
 =3D> trace_hardirqs_on
 =3D> __schedule
 =3D> preempt_schedule_irq
 =3D> svc_preempt

So actually the tracer does not really help me to determine the sources=
 of latency for my system, or is that just my impression?

Thank you in advanve
JB


----- Urspr=C3=BCngliche Nachricht -----
Von: "Johannes Bauer"
Erhalten: 20.05.2011 00:00
An: hannes_bauer@aon.at

Does nobody have any hints here?

Could it be that the 2.6.33 has so many more features that makes it slo=
wer than 2.6.21. In 2.6.21 i dont see the rcu softirq, can it be that t=
he rcu is the problem here? OR that the system is uClibc built?

Test machine Embedded Artists LPC2478 board 72MHz arm7tdmi-s (armv4t)
My measurement results are following under load:

2.6.21 2.6.33-rt+IRQF_NODELAY 2.6.33-rt+IRQ-THREAD
minimal latency: 19us 36us 244us
max latency: 157us 462us 940us

Since I cannot count the occurences of the latencies (because i am meas=
suring with an oscilloscope) i cannot give an average value.

However these values are horrible. 2.6.33 preempt-rt has 3x max latency=
 then 2.6.21.
Of course tracing was not enabled on the DUTs. What could be the proble=
m here? Or is that an expected result?

I thought the reason may be that 2.6.33 uses GENERIC_CLOCKEVENTS and 2.=
6.21 not. So i testet a 2.6.35 standard kernel with the same Timer code=
 as in 2.6.21, but the latencies were about the same as 2.6.33 preempt-=
rt.=20

=46or user space latency test (cyclictest) everything runs as expected =
preempt-rt max latency abou 700us, preempt_none about 1400us under load=
=2E

Regards
Johannes Bauer


----- Urspr=C3=BCngliche Nachricht -----
Von: "Johannes Bauer"=20
Erhalten: 17.05.2011 19:41
An: "linux-rt-users"=20

Hello everybody!

I was doing some testing on my ARM lpc2478 board regarding the interrup=
t latency.
I did it for the preempt-rt 2.6.33-rt30 patch. I installed an interrupt=
 for a external port pin with _and_ without IRQF_NODELAY and applied a =
squarewave to the pin.
In the edge triggered interrupt handler i set another IO pin accordingl=
y to the square wave level, so i could measure the irq latency + jitter=
 with an oscilloscope.

I did the test with CONFIG_PREEMPT_RT, CONFIG_PREEMPT_NONE and CONFIG_P=
REEMPT_VOLUNTARY, and the results did not change for the irq latency. (=
cyclictest results are much better for CONFIG_PREEMPT_RT however)

Then i comapred the results to a 2.6.21 kernel without rt-patch and the=
 worst case latency and jitter were much better then with the preempt-r=
t patch with IRQF_NODELAY (much better then without IRQF_NODELAY).

(I dont know if thats important, but 2.6.21 does not use clocksource an=
d clock event managemnet, just timer_tick() with 100Hz timer.)

As the patch replaces spinlocks with mutexes that made no sense to me, =
so i instrumented the /arch/arm/include/asm/irqflags.h the following wa=
y

#ifndef __ASM_ARM_IRQFLAGS_H
#define __ASM_ARM_IRQFLAGS_H

#ifdef __KERNEL__

#include=20

+ #define FIO_BASE_ADDR 0x3FFFC000
+ #define FIO0SET (*(volatile unsigned long *)(FIO_BASE_ADDR + 0x18))
+ #define FIO0CLR (*(volatile unsigned long *)(FIO_BASE_ADDR + 0x1C))
/*
* CPU interrupt mask handling.
*/
#if __LINUX_ARM_ARCH__ >=3D 6

#define raw_local_irq_save(x) \
({ \
__asm__ __volatile__( \
"mrs %0, cpsr @ local_irq_save\n" \
"cpsid i" \
: "=3Dr" (x) : : "memory", "cc"); \
})

#define raw_local_irq_enable() __asm__("cpsie i @ __sti" : : : "memory"=
, "cc")
#define raw_local_irq_disable() __asm__("cpsid i @ __cli" : : : "memory=
", "cc")
#define local_fiq_enable() __asm__("cpsie f @ __stf" : : : "memory", "c=
c")
#define local_fiq_disable() __asm__("cpsid f @ __clf" : : : "memory", "=
cc")

#else

/*
* Save the current interrupt enable state & disable IRQs
*/
#define raw_local_irq_save(x) \
({ \
unsigned long temp; \
(void) (&temp =3D=3D &x); \
__asm__ __volatile__( \
"mrs %0, cpsr @ local_irq_save\n" \
" orr %1, %0, #128\n" \
" msr cpsr_c, %1" \
: "=3Dr" (x), "=3Dr" (temp) \
: \
: "memory", "cc"); \
+ FIO0SET =3D 0x00010000; \
})

/*
* Enable IRQs
*/
#define raw_local_irq_enable() \
({ \
unsigned long temp; \
=46IO0CLR =3D 0x00010000; \
__asm__ __volatile__( \
"mrs %0, cpsr @ local_irq_enable\n" \
" bic %0, %0, #128\n" \
" msr cpsr_c, %0" \
: "=3Dr" (temp) \
: \
: "memory", "cc"); \
})

/*
* Disable IRQs
*/
#define raw_local_irq_disable() \
({ \
unsigned long temp; \
__asm__ __volatile__( \
"mrs %0, cpsr @ local_irq_disable\n" \
" orr %0, %0, #128\n" \
" msr cpsr_c, %0" \
: "=3Dr" (temp) \
: \
: "memory", "cc"); \
+ FIO0SET =3D 0x00010000; \
})

/*
* Enable FIQs
*/
#define local_fiq_enable() \
({ \
unsigned long temp; \
__asm__ __volatile__( \
"mrs %0, cpsr @ stf\n" \
" bic %0, %0, #64\n" \
" msr cpsr_c, %0" \
: "=3Dr" (temp) \
: \
: "memory", "cc"); \
})

/*
* Disable FIQs
*/
#define local_fiq_disable() \
({ \
unsigned long temp; \
__asm__ __volatile__( \
"mrs %0, cpsr @ clf\n" \
" orr %0, %0, #64\n" \
" msr cpsr_c, %0" \
: "=3Dr" (temp) \
: \
: "memory", "cc"); \
})

#endif

/*
* Save the current interrupt enable state.
*/
#define raw_local_save_flags(x) \
({ \
__asm__ __volatile__( \
"mrs %0, cpsr @ local_save_flags" \
: "=3Dr" (x) : : "memory", "cc"); \
})

/*
* restore saved IRQ & FIQ state
*/
#define raw_local_irq_restore(x) \
({ \
+ if(x&128) \
+ FIO0SET =3D 0x00010000; \
__asm__ __volatile__( \
"msr cpsr_c, %0 @ local_irq_restore\n" \
: \
: "r" (x) \
: "memory", "cc"); \
+ if(!(x&128)) \
+ FIO0CLR =3D 0x00010000; \
})


#define raw_irqs_disabled_flags(flags) \
({ \
(int)((flags) & PSR_I_BIT); \
})

#endif
#endif


Actually just to set a pin high when irqs are disabled and low when the=
y are enabled.

The results were confusing to me, as the irqs where disabled about 50% =
(2us off/2us on) of the time for the 2.6.33-rt30 and only 25%(1us off/3=
us on) for 2.6.21 without preempt.
Does anyone have some hints, why this could be the case and where i cou=
ld investigate any further.
I could only do tracing on 2.6.33 because its not avialable for 2.6.21.=
 My irqsoff tracing showed that the sirq-rcu was disabling the interrup=
ts somehow often. However the timing did not match the scope result, as=
 my CPU only has 72Mhz and tracing totally breaks it.

Please help me out here...

Kind regards

Johannes Bauer
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
