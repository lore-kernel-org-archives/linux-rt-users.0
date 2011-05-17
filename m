From: Johannes Bauer <hannes_bauer@aon.at>
Subject: 2.6.33 preempt-rt worse irq latency then 2.6.21
Date: Tue, 17 May 2011 19:41:29 +0200 (CEST)
Message-ID: <2833138.16881.1305654089043.JavaMail.root@WARSBL213.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout05.highway.telekom.at ([195.3.96.77]:18738 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754976Ab1EQRlb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 May 2011 13:41:31 -0400
Received: from warsbl213-nfs.highway.telekom.at (HELO WARSBL213.highway.telekom.at) ([172.18.96.92])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub91.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 17 May 2011 17:41:29 -0000
Received: from WARSBL213.highway.telekom.at (localhost.localdomain [127.0.0.1])
	by WARSBL213.highway.telekom.at (8.13.1/8.13.1) with ESMTP id p4HHfTp2004280
	for <linux-rt-users@vger.kernel.org>; Tue, 17 May 2011 19:41:29 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello everybody!

I was doing some testing on my ARM lpc2478 board regarding the interrupt latency.
I did it for the preempt-rt 2.6.33-rt30 patch. I installed an interrupt for a external port pin with _and_ without IRQF_NODELAY and applied a squarewave to the pin.
In the edge triggered interrupt handler i set another IO pin accordingly to the square wave level, so i could measure the irq latency + jitter with an oscilloscope.

I did the test with CONFIG_PREEMPT_RT, CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY, and the results did not change for the irq latency. (cyclictest results are much better for CONFIG_PREEMPT_RT however)

Then i comapred the results to a 2.6.21 kernel without rt-patch and the worst case latency and jitter were much better then with the preempt-rt patch with IRQF_NODELAY (much better then without IRQF_NODELAY).

(I dont know if thats important, but 2.6.21 does not use clocksource and clock event managemnet, just timer_tick() with 100Hz timer.)

As the patch replaces spinlocks with mutexes that made no sense to me, so i instrumented the /arch/arm/include/asm/irqflags.h the following way

#ifndef __ASM_ARM_IRQFLAGS_H
#define __ASM_ARM_IRQFLAGS_H

#ifdef __KERNEL__

#include <asm/ptrace.h>

+ #define FIO_BASE_ADDR		0x3FFFC000
+ #define FIO0SET        (*(volatile unsigned long *)(FIO_BASE_ADDR + 0x18))
+ #define FIO0CLR        (*(volatile unsigned long *)(FIO_BASE_ADDR + 0x1C))
/*
 * CPU interrupt mask handling.
 */
#if __LINUX_ARM_ARCH__ >= 6

#define raw_local_irq_save(x)					\
	({							\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ local_irq_save\n"	\
	"cpsid	i"						\
	: "=r" (x) : : "memory", "cc");				\
	})

#define raw_local_irq_enable()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
#define raw_local_irq_disable() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
#define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
#define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")

#else

/*
 * Save the current interrupt enable state & disable IRQs
 */
#define raw_local_irq_save(x)					\
	({							\
		unsigned long temp;				\
		(void) (&temp == &x);				\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ local_irq_save\n"	\
"	orr	%1, %0, #128\n"					\
"	msr	cpsr_c, %1"					\
	: "=r" (x), "=r" (temp)					\
	:							\
	: "memory", "cc");					\
+	FIO0SET = 0x00010000;					\
	})
	
/*
 * Enable IRQs
 */
#define raw_local_irq_enable()					\
	({							\
		unsigned long temp;				\
	FIO0CLR = 0x00010000;					\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ local_irq_enable\n"	\
"	bic	%0, %0, #128\n"					\
"	msr	cpsr_c, %0"					\
	: "=r" (temp)						\
	:							\
	: "memory", "cc");					\
	})

/*
 * Disable IRQs
 */
#define raw_local_irq_disable()					\
	({							\
		unsigned long temp;				\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ local_irq_disable\n"	\
"	orr	%0, %0, #128\n"					\
"	msr	cpsr_c, %0"					\
	: "=r" (temp)						\
	:							\
	: "memory", "cc");					\
+	FIO0SET = 0x00010000;					\
	})

/*
 * Enable FIQs
 */
#define local_fiq_enable()					\
	({							\
		unsigned long temp;				\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ stf\n"		\
"	bic	%0, %0, #64\n"					\
"	msr	cpsr_c, %0"					\
	: "=r" (temp)						\
	:							\
	: "memory", "cc");					\
	})

/*
 * Disable FIQs
 */
#define local_fiq_disable()					\
	({							\
		unsigned long temp;				\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ clf\n"		\
"	orr	%0, %0, #64\n"					\
"	msr	cpsr_c, %0"					\
	: "=r" (temp)						\
	:							\
	: "memory", "cc");					\
	})

#endif

/*
 * Save the current interrupt enable state.
 */
#define raw_local_save_flags(x)					\
	({							\
	__asm__ __volatile__(					\
	"mrs	%0, cpsr		@ local_save_flags"	\
	: "=r" (x) : : "memory", "cc");				\
	})

/*
 * restore saved IRQ & FIQ state
 */
#define raw_local_irq_restore(x)				\
	({							\
+	if(x&128)						\
+		FIO0SET = 0x00010000;				\
	__asm__ __volatile__(					\
	"msr	cpsr_c, %0		@ local_irq_restore\n"	\
	:							\
	: "r" (x)						\
	: "memory", "cc");					\
+	if(!(x&128))						\
+		FIO0CLR = 0x00010000;				\
	})
		

#define raw_irqs_disabled_flags(flags)	\
({					\
	(int)((flags) & PSR_I_BIT);	\
})

#endif
#endif


Actually just to set a pin high when irqs are disabled and low when they are enabled.

The results were confusing to me, as the irqs where disabled about 50% (2us off/2us on) of the time for the 2.6.33-rt30 and only 25%(1us off/3us on) for 2.6.21 without preempt.
Does anyone have some hints, why this could be the case and where i could investigate any further.
I could only do tracing on 2.6.33 because its not avialable for 2.6.21. My irqsoff tracing showed that the sirq-rcu was disabling the interrupts somehow often. However the timing did not match the scope result, as my CPU only has 72Mhz and tracing totally breaks it.

Please help me out here...

Kind regards

Johannes Bauer
