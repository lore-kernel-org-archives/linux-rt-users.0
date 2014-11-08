From: Marc =?UTF-8?B?TWFyw60=?= <marc.mari.barcelo@gmail.com>
Subject: Solving WARNING: Enabled interrupts issues
Date: Sat, 8 Nov 2014 23:56:47 +0100
Message-ID: <20141108235647.68a2a00f@crunchbang>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:46201 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaKHW4x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Nov 2014 17:56:53 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so6188107wgh.28
        for <linux-rt-users@vger.kernel.org>; Sat, 08 Nov 2014 14:56:51 -0800 (PST)
Received: from crunchbang ([80.31.85.60])
        by mx.google.com with ESMTPSA id lp14sm5254688wic.20.2014.11.08.14.56.50
        for <linux-rt-users@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 08 Nov 2014 14:56:51 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone

I'm working in the porting of a platform-specific linux kernel to RT. I
think I'm in the right way, but I'm looking on the best approach to
solve issues with IRQS in drivers.

At this moment I have this warning:
[    5.079524] WARNING: at kernel/irq/handle.c:146
handle_irq_event_percpu+0x2d8/0x2fc()
[    5.087378] irq 305 handler
irq_default_primary_handler+0x0/0x1c enabled interrupts
[    5.095008]
[<c010dc4c>] (unwind_backtrace+0x0/0x144) from [<c0a4e8e0>]
(dump_stack+0x20/0x24)
[    5.103600] [<c0a4e8e0>]
(dump_stack+0x20/0x24) from [<c01939e8>]
(warn_slowpath_common+0x58/0x70)
[    5.112548] [<c01939e8>]
(warn_slowpath_common+0x58/0x70) from [<c0193a7c>]
(warn_slowpath_fmt+0x40/0x48)
[    5.122100] [<c0193a7c>]
(warn_slowpath_fmt+0x40/0x48) from [<c01fa66c>]
(handle_irq_event_percpu+0x2d8/0x2fc)
[    5.132077] [<c01fa66c>]
(handle_irq_event_percpu+0x2d8/0x2fc) from [<c01fa718>]
(handle_irq_event+0x88/0xb0)
[    5.141975] [<c01fa718>]
(handle_irq_event+0x88/0xb0) from [<c01fd50c>]
(handle_level_irq+0xbc/0x15c)
[    5.151144] [<c01fd50c>]
(handle_level_irq+0xbc/0x15c) from [<c01f9ce4>]
(generic_handle_irq+0x30/0x40
[    5.160553] [<c01f9ce4>]
(generic_handle_irq+0x30/0x40) from [<c0552d68>]
(qpnpint_handle_irq+0x6c/0xd8)
[    5.170012] [<c0552d68>]
(qpnpint_handle_irq+0x6c/0xd8) from [<c0551f38>]
(pmic_arb_periph_irq+0x174/0x21c)
[    5.179733] [<c0551f38>]
(pmic_arb_periph_irq+0x174/0x21c) from [<c01face0>]
(irq_forced_thread_fn+0x30/0x74)
[    5.189629] [<c01face0>]
(irq_forced_thread_fn+0x30/0x74) from [<c01fab44>]
(irq_thread+0x124/0x164)
[    5.198744] [<c01fab44>]
(irq_thread+0x124/0x164) from [<c01b4e48>] (kthread+0x98/0xa4)
[    5.206701] [<c01b4e48>] (kthread+0x98/0xa4) from [<c0107c90>]
(kernel_thread_exit+0x0/0x8)

I can see, that the driver that is causing issues is the one that
contains the pmic_arb_periph_irq handler. This is the requester:
ret = devm_request_irq(&pdev->dev, pmic_arb->pic_irq,
     pmic_arb_periph_irq, IRQF_TRIGGER_HIGH, pdev->name, pmic_arb);

And the handler is a bit long, so I won't post it here. Just say that
it does its own tasks without any lock, just a memory barrier (mb()),
and then it calls generic_handle_irq(irq); I also know that irqs are
enabled even when the handler is called (and, as far as I understand,
this is due to threaded interrupts) because I printed the value of
irqs_disabled();

I can solve the warning by adding the flag IRQF_NO_THREAD to the
requester, or adding local_irq_save - restore in the handler. The
device also has spin locks, that are not used in the IRQ context. But I
would like to know what is the best approach to disable irqs
(IRQF_NO_THREAD, local_irq_save for the whole handler, local_irq_save
just for the generic_handle_irq call, spin_locks for the whole
hander or just for the generic_handle_irq call...)

(Sorry for my ignorance. I'm learning as fast as I can, but there are
points where I'm lacking examples).

Thanks in advance
Marc
