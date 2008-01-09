From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Wed, 9 Jan 2008 15:08:01 +0100
Message-ID: <20080109140801.GM3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <478498DD.8030003@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:55231 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271AbYAIOIF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jan 2008 09:08:05 -0500
Content-Disposition: inline
In-Reply-To: <478498DD.8030003@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 09, 2008 at 10:50:21AM +0100, Wolfgang Grandegger wrote:
> Robert Schwebel wrote:
> > On Tue, Jan 08, 2008 at 04:49:47PM +0100, Robert Schwebel wrote:
> >> This is on an idle system:
> > 
> > I've quickly ported the patch stack to 2.6.24-rc5-rt1, and it doesn't
> > really work:
> > 
> > ----------8<----------
> > root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 1000
> > 0.44 0.35 0.15 1/44 483
> > 
> > T: 0 (  483) P:80 I:   10000 C:     992 Min: -490034 Act: -410032 Avg: -243020 Max:     -10
> > ----------8<----------
> > 
> > Even on an idle system I get negative values and a "running" Act value.
> > 
> > I'll have to clean up the patch stack and check what's going on.
> 
> Are the high-res timers enabled? I also need the patch for the serial
> driver posted in a previous mail.

Nope, I have

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_HZ_100=y
CONFIG_HZ=100
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
CONFIG_PREEMPT_RCU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ASM_SEMAPHORES=y

and your patch was already in, it was proposed by tglx here:

http://marc.info/?l=linux-rt-users&m=118539051805065&w=2

Thomas, can you apply the patch?

Robert
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
