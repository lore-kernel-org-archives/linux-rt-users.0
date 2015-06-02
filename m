From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH V2 0/1] Add sched_clock to Atmel TCB clock source
Date: Tue, 02 Jun 2015 23:46:17 +0200
Message-ID: <20150602214617.585540231@osadl.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55686 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbFBVwi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:52:38 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

here comes V2 of the patch to add sched_clock to the Atmel TCB clock source.
It provides the sched_clock:
32 bits at 16MHz, resolution 60ns, wraps every 260301047747ns 

It is not yet clear, why interrupts are enabled when this code is running.

Thanks,
	-Carsten.

