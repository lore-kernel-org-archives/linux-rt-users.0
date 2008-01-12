From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt_max_latency_us undeclared for latency tracer
Date: Fri, 11 Jan 2008 21:01:10 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801112058510.9717@gandalf.stny.rr.com>
References: <20080112000314.GP3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:54409 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762809AbYALCBZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jan 2008 21:01:25 -0500
In-Reply-To: <20080112000314.GP3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sat, 12 Jan 2008, Robert Schwebel wrote:

>
> rsc@octopus:linux-2.6.24-rc7> g preempt_max_latency_us
> ../kernel/sysctl.c:              .data           = &preempt_max_latency_us,
> ../kernel/sysctl.c:              .maxlen         = sizeof(preempt_max_latency_us),
> ../kernel/latency_trace.c:               __preempt_max_latency = usecs_to_cycles(preempt_max_latency_us);
>
> Any patch missign?

Crap, no, that was simply me. I'm only to the point of testing my default
config (no latency tracer). That's why it was a pre release and not an
official one. I've monkeyed with Daniel's patch to get rid of the "_us"
variants and have all user space only see those in microsec units. But as
you can see, I haven't even tried compiling my changes.

-- Steve
