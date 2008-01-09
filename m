From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Wed, 09 Jan 2008 10:50:21 +0100
Message-ID: <478498DD.8030003@grandegger.com>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53050 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYAIJuY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jan 2008 04:50:24 -0500
In-Reply-To: <20080109090345.GG3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> On Tue, Jan 08, 2008 at 04:49:47PM +0100, Robert Schwebel wrote:
>> This is on an idle system:
> 
> I've quickly ported the patch stack to 2.6.24-rc5-rt1, and it doesn't
> really work:
> 
> ----------8<----------
> root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 1000
> 0.44 0.35 0.15 1/44 483
> 
> T: 0 (  483) P:80 I:   10000 C:     992 Min: -490034 Act: -410032 Avg: -243020 Max:     -10
> ----------8<----------
> 
> Even on an idle system I get negative values and a "running" Act value.
> 
> I'll have to clean up the patch stack and check what's going on.

Are the high-res timers enabled? I also need the patch for the serial
driver posted in a previous mail.

Wolfgang.
