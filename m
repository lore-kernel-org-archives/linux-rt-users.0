From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: preempt_max_latency_us undeclared for latency tracer
Date: Sat, 12 Jan 2008 01:03:14 +0100
Message-ID: <20080112000314.GP3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56040 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754001AbYALADQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jan 2008 19:03:16 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

Something seems to be missing in 2.6.24-pre7-rt1-pre1; when I switch on the
latency tracer in a powerpc32 project, I get this:

kernel/sysctl.c:425: error: 'preempt_max_latency_us' undeclared here (not in a function)
kernel/sysctl.c:433: error: 'preempt_thresh_us' undeclared here (not in a function)

rsc@octopus:linux-2.6.24-rc7> g preempt_max_latency_us
./kernel/sysctl.c:              .data           = &preempt_max_latency_us,
./kernel/sysctl.c:              .maxlen         = sizeof(preempt_max_latency_us),
./kernel/latency_trace.c:               __preempt_max_latency = usecs_to_cycles(preempt_max_latency_us);

Any patch missign?

Robert
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
