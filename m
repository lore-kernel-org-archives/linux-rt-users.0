From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Wed, 9 Jan 2008 23:51:07 +0100
Message-ID: <20080109225107.GV3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56452 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752635AbYAIWvK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jan 2008 17:51:10 -0500
Content-Disposition: inline
In-Reply-To: <20080109090345.GG3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 09, 2008 at 10:03:45AM +0100, Robert Schwebel wrote:
> ----------8<----------
> root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 1000
> 0.44 0.35 0.15 1/44 483
> 
> T: 0 (  483) P:80 I:   10000 C:     992 Min: -490034 Act: -410032 Avg: -243020 Max:     -10
> ----------8<----------

Mainline without -rt doesn't show the effect; I narrowed it down by
disabling patches, starting from the end of the series. Unfortunately,
not all patches can be disabled without breaking the build.

The latencies look normal when I disable these two patches:

	rt-time-starvation-fix.patch
	rt-time-starvation-fix-update.patch

Throwing in the versions from 2.6.23.3-rt5 doesn't help, the effect
stays the same. So I assume it is a side effect.

Robert	
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
