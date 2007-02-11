From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 12:29:33 +0100
Message-ID: <20070211112933.GN29553@pengutronix.de>
References: <45CEF997.3020101@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:48311 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180AbXBKL3g (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 06:29:36 -0500
Content-Disposition: inline
In-Reply-To: <45CEF997.3020101@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Wolfgang,

On Sun, Feb 11, 2007 at 12:10:15PM +0100, Wolfgang Grandegger wrote:
> what is the status of the Preemptive Kernel and the High Resolution 
> Timers for Linux 2.6.20 for PowerPC (arch/powerpc or arch/ppc)?
> 
> I realized build problems when trying to get it working for my Lite5200 
> (MPC5200) board with patch-2-6-20-rt5. The patch seems to contain 
> reminders of merge conflicts, e.g.:
> 
>   +++ linux/include/asm-powerpc/hw_irq.h
>   ...
>   +<<<<<<< delete extern unsigned long local_get_flags(void);
>   +<<<<<<< delete extern unsigned long local_irq_disable(void);
> 
> and the make fails in arch/powerpc/kernel/time.c as well (see attachment).

We have 2.6.20-rt3 running on the phyCORE-MPC5200B, so that one should
work and the merge problems did probably come in later (don't have the
time to look right now because of the Embedded World activities for next
week).

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
