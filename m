From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Thu, 24 Jan 2008 19:17:01 -0800
Message-ID: <1201231021.18044.10.camel@imap.mvista.com>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
	 <1201229483.18044.1.camel@imap.mvista.com>
	 <Pine.LNX.4.58.0801242201100.20902@gandalf.stny.rr.com>
	 <Pine.LNX.4.58.0801242212020.21002@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:3077 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYAYDR7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 22:17:59 -0500
In-Reply-To: <Pine.LNX.4.58.0801242212020.21002@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2008-01-24 at 22:13 -0500, Steven Rostedt wrote:
> On Thu, 24 Jan 2008, Steven Rostedt wrote:
> >
> > Let me know if you use all the histograms and I'll see if I can get them
> > in tomorrow.
> >
> 
> I just took a look at the code, and it shouldn't be too hard to implement.
> In fact, the nice thing with the new code is that we can turn on and off
> the historgram and do the normal tracing.

That would be nice .. I always hated the fact that it basically shut off
all the other usual tracing behavior ..

Daniel
