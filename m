From: Carsten Emde <C.Emde@osadl.org>
Subject: [RESOLVED OSADL QA 3.18.7-rt2 #1] WARNING at kernel/time/tick-sched.c:167
 can_stop_full_tick+0x2d/0xcd()
Date: Sat, 07 Mar 2015 18:55:26 +0100
Message-ID: <54FB3B8E.5030302@osadl.org>
References: <54F7780F.50109@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:42661 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbbCGSCL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Mar 2015 13:02:11 -0500
In-Reply-To: <54F7780F.50109@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Some x86-based systems with
>
> CONFIG_NO_HZ_FULL=y
>
> run into this WARN_ON_ONCE during boot
>
> static bool can_stop_full_tick(void)
> {
>          WARN_ON_ONCE(!irqs_disabled());
This issue is resolved in 3.18.7-rt3.

Thanks,
	-Carsten.

