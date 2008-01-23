From: Daniel Walker <dwalker@mvista.com>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc
Date: Wed, 23 Jan 2008 07:50:19 -0800
Message-ID: <1201103419.13596.3.camel@imap.mvista.com>
References: <1200544050.318.18.camel@localhost.localdomain>
	 <478F2A46.5070506@grandegger.com>  <20080123145340.GE6200@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:10314 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYAWPvA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jan 2008 10:51:00 -0500
In-Reply-To: <20080123145340.GE6200@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-01-23 at 15:53 +0100, Luotao Fu wrote:

> I was doing some tests on my mpc5200b Board to reproduce the high latency as
> measured by wolfgang.
> 
> I ran some tests with 
> while [ 1 ]; do ls /bin;done
> as non-rt workload, as in Wolfgangs Scenario.
> 

Can you try enabling CRITICAL_PREEMPT_TIMING only, and not latency
tracing .. You won't get a trace, but you will get some indication of
the start/stop points of the latency if it's preempt latency, and a
measurement of the longest latency..

Daniel
