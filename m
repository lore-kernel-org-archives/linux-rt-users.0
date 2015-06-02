From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] Add sched_clock to Atmel TCB clock source
Date: Tue, 02 Jun 2015 15:42:33 +0200
Message-ID: <20150602134233.433159376@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:54852 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758889AbbFBNrG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 09:47:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

the SAMA5D3 Xplained board lacks a high-resolution sched_clock. After
applying this patch
  sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836480000000ns
is followed by
  sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 260301047747ns 

Thanks,
	-Carsten.

