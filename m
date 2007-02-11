From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 12:10:15 +0100
Message-ID: <45CEF997.3020101@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:49731 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbXBKLJ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 06:09:57 -0500
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 7033D9B039
	for <linux-rt-users@vger.kernel.org>; Sun, 11 Feb 2007 12:09:56 +0100 (CET)
Received: from [172.16.0.100] (p5497CD4E.dip.t-dialin.net [84.151.205.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 53007BACF0
	for <linux-rt-users@vger.kernel.org>; Sun, 11 Feb 2007 12:09:56 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

what is the status of the Preemptive Kernel and the High Resolution 
Timers for Linux 2.6.20 for PowerPC (arch/powerpc or arch/ppc)?

I realized build problems when trying to get it working for my Lite5200 
(MPC5200) board with patch-2-6-20-rt5. The patch seems to contain 
reminders of merge conflicts, e.g.:

   +++ linux/include/asm-powerpc/hw_irq.h
   ...
   +<<<<<<< delete extern unsigned long local_get_flags(void);
   +<<<<<<< delete extern unsigned long local_irq_disable(void);

and the make fails in arch/powerpc/kernel/time.c as well (see attachment).

Thanks for help.

Wolfgang.
