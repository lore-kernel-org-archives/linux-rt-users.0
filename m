From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 01:01:24 +0100
Message-ID: <20080110000124.GW3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45551 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757340AbYAJABa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jan 2008 19:01:30 -0500
Content-Disposition: inline
In-Reply-To: <20080109225107.GV3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Wolfgang,

On Wed, Jan 09, 2008 at 11:51:07PM +0100, Robert Schwebel wrote:
> Throwing in the versions from 2.6.23.3-rt5 doesn't help, the effect
> stays the same. So I assume it is a side effect.

Can you test the following patch by John Stulz (thanks to John for the quick
help on irc!), which fixes the issues on my board:

----------8<----------
Index: linux-2.6.24-rc5/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.24-rc5.orig/arch/powerpc/kernel/time.c
+++ linux-2.6.24-rc5/arch/powerpc/kernel/time.c
@@ -773,7 +773,7 @@ void update_vsyscall(struct timespec *wa
 	stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
 	do_div(stamp_xsec, 1000000000);
 	stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
-	update_gtod(clock->cycle_last, stamp_xsec, t2x);
+	update_gtod(clock->cycle_last-clock->cycle_accumulated, stamp_xsec, t2x);
 }
 
 void update_vsyscall_tz(void)
----------8<----------

With this patch ontop of 2.6.24-rc5-rt1 plus the board support patches
for the phyCORE-MPC5200B-tiny, I get this result from cyclictest, again
under "(while true; do hackbench 10; done) &" load:

T: 0 (  867) P:80 I:   10000 C:  105002 Min:      31 Act:      48 Avg:      51 Max:      92

Robert
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
