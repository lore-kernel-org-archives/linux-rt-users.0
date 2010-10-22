From: Maxim Uvarov <muvarov@gmail.com>
Subject: !CONFIG_PREEMPT_RT + CONFIG_PREEMPT_HARDIRQ
Date: Fri, 22 Oct 2010 14:01:12 +0400
Message-ID: <AANLkTinAcEaJn=z8mJVC1Caq+-SDnrbUHO0AeAJb9d2s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mingo <mingo@elte.hu>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56585 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab0JVKBN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Oct 2010 06:01:13 -0400
Received: by gxk23 with SMTP id 23so240399gxk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Oct 2010 03:01:13 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everybody,

Can you please write few words about !CONFIG_PREEMPT_RT +
CONFIG_PREEMPT_HARDIRQ configuration.
Is it valid kernel configuration or supposed to be valid? Right now
there is hung up in network:

[    2.339582] Sending BOOTP requests .
[    3.049748] ------------[ cut here ]------------
[    3.050422] WARNING: at net/sched/sch_generic.c:259 dev_watchdog+0xb2/0x103()
[    3.050842] Hardware name:
[    3.051027] NETDEV WATCHDOG: eth0 (ne2k-pci): transmit queue 0 timed out
[    3.051423] Modules linked in:
[    3.051791] Pid: 4, comm: sirq-timer/0 Not tainted 2.6.33.7-rt29 #3
[    3.052169] Call Trace:
[    3.052557]  [<c1020e5a>] warn_slowpath_common+0x65/0x7c
[    3.052903]  [<c136d74c>] ? dev_watchdog+0xb2/0x103
[    3.053200]  [<c1020ea5>] warn_slowpath_fmt+0x24/0x27
[    3.053507]  [<c136d74c>] dev_watchdog+0xb2/0x103
[    3.053800]  [<c102ee63>] ? insert_work+0x41/0x49
[    3.054093]  [<c102ee0e>] ? spin_unlock_irqrestore+0xf/0x23
[    3.054424]  [<c102efb3>] ? __queue_work+0x2f/0x34
[    3.054715]  [<c10295d2>] run_timer_softirq+0x189/0x219
[    3.055034]  [<c136d69a>] ? dev_watchdog+0x0/0x103
[    3.055327]  [<c1025445>] run_ksoftirqd+0xfa/0x1c8
[    3.055619]  [<c102534b>] ? run_ksoftirqd+0x0/0x1c8
[    3.055913]  [<c1031995>] kthread+0x5e/0x63
[    3.056172]  [<c1031937>] ? kthread+0x0/0x63
[    3.056434]  [<c1002d76>] kernel_thread_helper+0x6/0x10
[    3.056800] ---[ end trace f1189a061379ccfb ]---
[    5.040078] .


If it's not valid why not to fix Kconfig?
-- 
Best regards,
Maxim Uvarov
