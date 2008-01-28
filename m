From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc
Date: Mon, 28 Jan 2008 16:11:29 +0100
Message-ID: <479DF0A1.3000906@pengutronix.de>
References: <1200544050.318.18.camel@localhost.localdomain> <478F2A46.5070506@grandegger.com> <20080123145340.GE6200@pengutronix.de> <47976D06.1010900@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luotao Fu <l.fu@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56831 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753605AbYA1PLd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jan 2008 10:11:33 -0500
In-Reply-To: <47976D06.1010900@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I took some time today and went through Wolfgangs scenarios partly. Now 
some results from my side. I ran my tests on a 2.6.24-rt1

Wolfgang Grandegger wrote:
  > I also did some more measurements and made, by chance, interesting
> observations. I will summarize in more detail later on. Here are some
> preliminary results. My high latencies of up to 570us (without latency
> tracer) seem to be caused mainly by the following setting:
> 
>   CONFIG_RCU_TRACE=m
> 

I also got high latencies without CONFIG_RCU_TRACE set at all. setting 
CONFIG_RCU_TRACE to y or m causes also high latency though in my test 
runs. Hence I doubt the rcu Tracer is really the problem.

As I mentioned in my last mail. Only thing I could reproduce reliably is 
that the measurement results depend heavily on kind of the non-rt 
Workload. For with hackbench or cache calibrator I couldn't produce 
abnormal high latencies. Nor could I produce the hight latencies on a 
system booted via flash. Hence my suspects stays on the fec irq thread 
and filesystem access routines.

> With CONFIG_NO_HZ=y or CONFIG_PPC_BESTCOMM_GEN_BD=y the latency
> increases by approx. 100..150us, each.
> 

Since I was producing high latencies independently from the rcu 
settings. I didn't spend a lot of time playing around with the GEN_BD 
and dynamic clock. All I can say is that disabling them also cause high 
latency. ;-) The average results don't differ significantly in my test runs.

cheers
Luotao Fu
-- 
    Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
