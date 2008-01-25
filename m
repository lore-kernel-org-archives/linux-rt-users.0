From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Thu, 24 Jan 2008 22:13:35 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801242212020.21002@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
 <1201229483.18044.1.camel@imap.mvista.com> <Pine.LNX.4.58.0801242201100.20902@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36566 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYAYDOH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 22:14:07 -0500
In-Reply-To: <Pine.LNX.4.58.0801242201100.20902@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 24 Jan 2008, Steven Rostedt wrote:
>
> Let me know if you use all the histograms and I'll see if I can get them
> in tomorrow.
>

I just took a look at the code, and it shouldn't be too hard to implement.
In fact, the nice thing with the new code is that we can turn on and off
the historgram and do the normal tracing.

-- Steve
