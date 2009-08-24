Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from sovereign.computergmbh.de ([85.214.69.204]:51480 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZHXKwP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Aug 2009 06:52:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id EF2384179336
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2009 12:52:14 +0200 (CEST)
Date: Mon, 24 Aug 2009 12:52:14 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
Subject: might_sleep warnings 'temporary hack'
Message-ID: <alpine.LSU.2.00.0908241230240.2296@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi,


in kernel/rtmutex.c near line 685 in function rt_spin_lock_fastlock I do 
see:

	/* temporary hack! */
	if (likely(!current->in_printk))
		might_sleep();

and Virtualbox constantly trips on this. Can I assume this is a problem 
in the virtualbox 3.0.4 host modules?


BUG: sleeping function called from invalid context at kernel/rtmutex.c:685
in_atomic(): 1, irqs_disabled(): 0, pid: 11724, name: VirtualBox
Pid: 11724, comm: VirtualBox Tainted: G          N  2.6.29.6-jen82-rt #1
Call Trace:
 [<ffffffff802388e6>] __might_sleep+0x10a/0x10c
 [<ffffffff804c6edf>] rt_spin_lock+0x2f/0x78
 [<ffffffffa05cb89f>] RTSpinlockAcquire+0xd/0xf [vboxdrv]
 [<ffffffffa05ceb13>] RTHandleTableLookupWithCtx+0x79/0x102 [vboxdrv]

(To note that their RT* functions have nothing to do with realtime—sigh)
