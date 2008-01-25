From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Fri, 25 Jan 2008 10:54:35 -0800
Message-ID: <871w85rb10.fsf@paris.hilman.org>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41052 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbYAYS5y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 13:57:54 -0500
In-Reply-To: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com> (Steven Rostedt's message of "Thu\, 24 Jan 2008 15\:36\:44 -0500 \(EST\)")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> writes:

> I'm about to gut the RT latency tracer with the version I'm pushing
> upstream. This will be some of the changes:

Might I request that you follow the mainline stabilization model and
wait until the 2.6.25-rcX-rtY series to make a significant change like
this?

I have nothing against your changes, but am not crazy about seeing
something like this happen in the "stable" part of the dev cycle.

Thanks,

Kevin
