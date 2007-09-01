From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Sat, 01 Sep 2007 09:27:18 +0200
Message-ID: <1188631638.17941.11.camel@chaos>
References: <1188593944.9647.15.camel@chaos>
	 <1188604887.26038.110.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:50349 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750991AbXIAH1W (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Sep 2007 03:27:22 -0400
In-Reply-To: <1188604887.26038.110.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-31 at 17:01 -0700, Daniel Walker wrote:
> > - UP compile fixes back merged (Kevin Hilman / Steven Rostedt)
> > - various latency tracer fixes (Steven Rostedt)
> 
> I'm not sure which latency tracing fixes these are, but Steven's
> get_monotonic_cycles() changes are racy .. It might be a little
> premature to include them .. It at least fouls latency tracing on my
> test machine.

Worked fine here, but I take it out again when it causes problems on
your box. Steven ???

> > - simple_irq change (Kevin Hilman): needs more thought
> > - RCU updates (Paul McKenney): needs proper integration
> > - latency tracer changes (Daniel Walker): needs review
> > - PICK_OP changes (Daniel Walker): needs review
> 
> The PICK_OP changes got reviewed by Ingo , as of,
> 
> http://marc.info/?l=linux-rt-users&m=118638506125380&w=2

Yeah, I know. Still I wanted to go through it myself.

> They do need one small fix tho .. Below ..

Sigh.

	tglx
