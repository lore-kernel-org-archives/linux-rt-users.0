From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Fix preempt-rt on AT91
Date: Sun, 17 Jan 2016 03:23:13 +0100
Message-ID: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: bigeasy@linutronix.de, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38394 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753252AbcAQCX1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Jan 2016 21:23:27 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian, Thomas,

Preemp-rt on at91 has multiple issues:
 1/ After apply the preempt-rt patch, the kernel doesn't build anymore,
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch is not correct
 anymore. Can you squash the following patch to solve this build issue?

 2/ This approach actually has more issues, in particular, request_irq() must
 not be calls from interrupt disabled context. That only works because
 might_sleep() is not active during early boot.
 For more information, see the following discussion:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357607.html

 However, we can't remove those patches now because else we would suffer from
 another issue:
 The timer interrupt is shared with other devices, in particular the debug tty,
 the rtc dans the pmc. When using preempt-rt, those interrupts become threaded
 interrupts. But, the pit interrupt is requested with IRQF_TIMER and so has
 IRQF_NO_THREAD. If the pit interrupt is not freed at early boot, all the other
 devices will fail requesting their interrupt, for example:

genirq: Flags mismatch irq 16. 00042080 (ttyS0) vs. 00015280 (at91_tick)
atmel_usart ffffee00.serial: atmel_startup - Can't get irq

 I'd say that the proper solution would still be to implement the virtual
 irqchip because this would still hit people not wanting to use the TCB as
 their clock source.

 3/ Finally, the kernel will crash when initializing the PMC driver. This is
 solved by this series that will hopefully land in the mainline:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390954.html


Alexandre Belloni (1):
  fix arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch

 drivers/clocksource/timer-atmel-pit.c | 68 +++++++++++++++++------------------
 drivers/clocksource/timer-atmel-st.c  |  8 ++---
 2 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.5.0

