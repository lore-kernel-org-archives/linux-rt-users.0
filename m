From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Oops during Init IRQ
Date: Mon, 18 Jun 2012 15:53:33 +0200
Message-ID: <4FDF32DD.3010800@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:12970 "EHLO mailhub1.si.c-s.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab2FROag (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jun 2012 10:30:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id E9B2C1C8347
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Jun 2012 14:53:32 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIWXJ5dwPrZE for <linux-rt-users@vger.kernel.org>;
	Mon, 18 Jun 2012 14:53:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id CA66A1C8346
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Jun 2012 14:53:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17ED4C73C8
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Jun 2012 15:53:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id whvZKfub2hGo for <linux-rt-users@vger.kernel.org>;
	Mon, 18 Jun 2012 15:53:34 +0200 (CEST)
Received: from [127.0.0.1] (unknown [172.25.231.6])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DC8C4C73C5
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Jun 2012 15:53:33 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to use the rt10 patch on a 3.4.2 kernel on a powerpc (MPC8xx) 
system, and I'm having the following Oops during Irq initialisation. 
This happens with CONFIG_PREEMPT_RT_FULL.
It doesn't happen with CONFIG_PREEMPT__LL

May someone help ?

[    0.000000] Memory: 125676k/131072k available (3680k kernel code, 
5396k reserved, 160k data, 193k bss, 140k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
[    0.000000]   * 0xfde00000..0xfe000000  : consistent mem
[    0.000000]   * 0xfddf6000..0xfde00000  : early ioremap
[    0.000000]   * 0xc9000000..0xfddf6000  : vmalloc & ioremap
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] Unable to handle kernel paging request for data at 
address 0x00000418
[    0.000000] Faulting instruction address: 0xc0163398
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] PREEMPT CMPC885
[    0.000000] Modules linked in:
[    0.000000] NIP: c0163398 LR: c02ae398 CTR: 00000000
[    0.000000] REGS: c03b3d60 TRAP: 0300   Not tainted 
(3.4.2-rt10-s3k-3.7.4+-svn2547)
[    0.000000] MSR: 00001032 <ME,IR,DR,RI>  CR: 22444482  XER: 20005208
[    0.000000] DAR: 00000418, DSISR: c0000000
[    0.000000] TASK = c039a3e8[0] 'swapper' THREAD: c03b2000
[    0.000000] GPR00: c02ae398 c03b3e10 c039a3e8 00000414 0000000f 
00000000 c032f744 00000011
[    0.000000] GPR08: c039a3e8 c03b2000 00000000 00000001 22444482 
10029aec 00000000 07ff9550
[    0.000000] GPR16: 00000000 07bb6de8 00000000 07ff825c 07ff825c 
07ff825c 00000000 00000000
[    0.000000] GPR24: 07ffb3a0 ffffffed 00000001 00000000 c039d6d4 
0000000f 00000414 00000414
[    0.000000] NIP [c0163398] do_raw_spin_lock+0x34/0x174
[    0.000000] LR [c02ae398] _raw_spin_lock_irqsave+0x30/0x48
[    0.000000] Call Trace:
[    0.000000] [c03b3e10] [07fe7f50] 0x7fe7f50 (unreliable)
[    0.000000] [c03b3e40] [c02ae398] _raw_spin_lock_irqsave+0x30/0x48
[    0.000000] [c03b3e50] [c0043050] try_to_wake_up+0x38/0x1a0
[    0.000000] [c03b3e70] [c0036c58] kthread_create_on_node+0x9c/0x124
[    0.000000] [c03b3f00] [c005c780] __setup_irq+0x2ac/0x464
[    0.000000] [c03b3f30] [c005cdec] setup_irq+0x64/0xb8
[    0.000000] [c03b3f50] [c0013e80] cpm_pic_init+0x14c/0x1f0
[    0.000000] [c03b3f90] [c03798f0] mpc8xx_pics_init+0x2c/0x58
[    0.000000] [c03b3fa0] [c0379cd4] cmpc885_pics_init+0x14/0xcc
[    0.000000] [c03b3fb0] [c0377478] init_IRQ+0x24/0x34
[    0.000000] [c03b3fc0] [c0375830] start_kernel+0x1cc/0x300
[    0.000000] [c03b3ff0] [c0002218] start_here+0x38/0x9c
[    0.000000] Instruction dump:
[    0.000000] 9421ffd0 7d800026 93e1002c 90010034 93210014 93410018 
9361001c 93810020
[    0.000000] 93a10024 93c10028 91810010 7c7f1b78 <81230004> 6d20dead 
2f804ead 409e0074


Best regards
C. Leroy
