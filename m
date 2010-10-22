From: "B, Ravi" <ravibabu@ti.com>
Subject: OHCI issue with RT patch
Date: Fri, 22 Oct 2010 19:36:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023461A852@dbde02.ent.ti.com>
References: <S1756980Ab0JVN4w/20101022135653Z+208@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915Ab0JVOGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Oct 2010 10:06:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9ME6GLp024975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 22 Oct 2010 09:06:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9ME6Fo8014325
	for <linux-rt-users@vger.kernel.org>; Fri, 22 Oct 2010 19:36:15 +0530 (IST)
In-Reply-To: <S1756980Ab0JVN4w/20101022135653Z+208@vger.kernel.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear All,

I am using Linux 2.6.33.7 stable kernel + patch-2.6.33.7-rt29 to test OHCI interface on TI OMAPL138 platform.
We observed that during bootup and OHCI init sequence the kernel hangs. If we use plane Linux 2.6.33.7 stable kernel
Without RT patch then OHCI works fine.

-------------Hang log --------------
console [ttyS2] enabled
brd: module loaded
console [netcon0] enabled
netconsole: network logging started
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ioremap ohci-regs=fee25000
ohci ohci.0: DA8xx OHCI
ohci ohci.0: new USB bus registered, assigned bus number 2
ohci ohci.0: irq 59, io mem 0x01e25000
======> Hangs here <=========
--------------------------------------

Further debugging shows that the hang occurs within ohci_run() in
drivers/usb/host/ohci-hcd.c file at below line,

ohci_writel (ohci, val, &ohci->regs->roothub.a);

Is is a known issue and someone has faced it before?

Regards,
Ravi
