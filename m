From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 22:49:58 +0100
Message-ID: <47869306.8000308@grandegger.com>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com> <20080110143527.GI3177@pengutronix.de> <20080110162351.GN3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39568 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYAJVuD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 16:50:03 -0500
In-Reply-To: <20080110162351.GN3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> On Thu, Jan 10, 2008 at 03:35:27PM +0100, Robert Schwebel wrote:
>>> Could you run your cyclictest much longer?
>> I'll re-test with your parameters.
> 
> Done, here are the results (data and histogram):
> 
> http://www.pengutronix.de/software/realtime-preempt/20080110-1-cyclictest/20080110-1-phyCORE-MPC5200B-tiny-data.png
> http://www.pengutronix.de/software/realtime-preempt/20080110-1-cyclictest/20080110-1-phyCORE-MPC5200B-tiny-histo.png
> 
> Especially the data plot is interesting: it shows that most of the shots
> are below 80 us, but there are regular peaks. If you look carefully, you
> also see that the peaks are "growing", which usually means that there is
> some interference.

A latency peak every 16.6 second, hm, interesting.

> Time to activate latency hunting...

Unfortunately, the latency tracer of the -rt kernel is not available for
PowerPC.

Wolfgang.
