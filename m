From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 15:54:20 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <200801132143.34889.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:53820 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYAMUyj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 15:54:39 -0500
In-Reply-To: <200801132143.34889.m.kozlowski@tuxland.pl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 13 Jan 2008, Mariusz Kozlowski wrote:
>
> But then there is also trace_hardirqs_on_caller() in kernel/latency_trace.c
> and both are not static.
>

Servers me right for releasing without testing more than one config. I
compiled for x86_64, i386 and PPC 32 and 64, but all without any tracing
on. And I should have since I modified that a bit.

OK, -rt2 will take a bit more beating from me before I release it, so it
might take some time to get it out (expect it out on Monday).

-- Steve
