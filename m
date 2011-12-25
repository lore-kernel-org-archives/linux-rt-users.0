From: Manfred Gruber <m.gruber@unverspurt.at>
Subject: pca953x - warning on irq
Date: Sun, 25 Dec 2011 17:40:10 +0100
Message-ID: <201112251740.11066.m.gruber@unverspurt.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.hessware.de ([78.46.97.14]:41004 "EHLO mail.hessware.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab1LYQry (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Dec 2011 11:47:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hessware.de (Postfix) with ESMTP id 9AA92426F09
	for <linux-rt-users@vger.kernel.org>; Sun, 25 Dec 2011 16:42:39 +0000 (UTC)
Received: from mail.hessware.de ([127.0.0.1])
	by localhost (mail.jabbermail.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6XyjM5oSn2L for <linux-rt-users@vger.kernel.org>;
	Sun, 25 Dec 2011 16:42:36 +0000 (UTC)
Received: from grma-home2.localnet (chello212186029093.tirol.surfer.at [212.186.29.93])
	by mail.hessware.de (Postfix) with ESMTPSA id 0BC73426EF3
	for <linux-rt-users@vger.kernel.org>; Sun, 25 Dec 2011 16:42:36 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello RT developers!

Great work on Preempt RT!

I get a warning at 3.0.9-rt25+ in a i2c pca953x chip when using IRQs at the 
gpio lines. It appears only once when the first irq happens, after that the 
warning is away. On 3.2.0-rc7 the warning does not happen.

I do not know how to remove/solve the warning, has someone an idea what I do 
wrong?



[   28.616000] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   45.240000] ------------[ cut here ]------------
[   45.240000] WARNING: at kernel/irq/handle.c:130 
handle_irq_event_percpu+0x68/0x168()
[   45.240000] irq 130 handler irq_default_primary_handler+0x0/0x8 enabled 
interrupts
[   45.242000] Modules linked in:
[   45.242000] [<c0039cd8>] (unwind_backtrace+0x0/0xec) from [<c00473d4>] 
(warn_slowpath_common+0x4c/)
[   45.242000] [<c00473d4>] (warn_slowpath_common+0x4c/0x64) from [<c0047480>] 
(warn_slowpath_fmt+0x3)
[   45.242000] [<c0047480>] (warn_slowpath_fmt+0x30/0x40) from [<c0078264>] 
(handle_irq_event_percpu+)
[   45.242000] [<c0078264>] (handle_irq_event_percpu+0x68/0x168) from 
[<c00783b8>] (handle_irq_event+)
[   45.242000] [<c00783b8>] (handle_irq_event+0x54/0x78) from [<c007a828>] 
(handle_simple_irq+0x84/0x)
[   45.242000] [<c007a828>] (handle_simple_irq+0x84/0xac) from [<c0077eb0>] 
(generic_handle_irq+0x30/)
[   45.242000] [<c0077eb0>] (generic_handle_irq+0x30/0x48) from [<c0168508>] 
(pca953x_irq_handler+0x9)
[   45.242000] [<c0168508>] (pca953x_irq_handler+0x98/0xac) from [<c0078930>] 
(irq_thread_fn+0x1c/0x3)
[   45.242000] [<c0078930>] (irq_thread_fn+0x1c/0x38) from [<c00787ec>] 
(irq_thread+0xc8/0x1f0)
[   45.242000] [<c00787ec>] (irq_thread+0xc8/0x1f0) from [<c006082c>] 
(kthread+0x7c/0x84)
[   45.242000] [<c006082c>] (kthread+0x7c/0x84) from [<c00358dc>] 
(kernel_thread_exit+0x0/0x8)
[   45.242000] ---[ end trace 0000000000000002 ]---

# cat /proc/interrupts 
           CPU0       
  1:       8340       AIC  ttyS0
  7:          2       AIC  ttyS2
  9:        327       AIC  mmc0
 12:      22381       AIC  atmel_spi.0
 13:      74311       AIC  atmel_spi.1
 19:     245940       AIC  tc_clkevt
 20:        541       AIC  ohci_hcd:usb1
 21:          2       AIC  eth0
103:          5      GPIO  0-0070
128:          0   pca953x  gpiolib
129:          0   pca953x  gpiolib
130:          2   pca953x  gpiolib
131:          0   pca953x  gpiolib
132:          0   pca953x  gpiolib

thx, regards manfred gruber

-- 

