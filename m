From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.26.6-rt10
Date: Mon, 13 Oct 2008 15:51:39 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0810131550540.522@gandalf.stny.rr.com>
References: <1223839814.19319.5.camel@localhost.localdomain> <48F29310.1030206@sapo.pt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Luis Henriques <henrix@sapo.pt>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:39459 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYJMTvl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Oct 2008 15:51:41 -0400
In-Reply-To: <48F29310.1030206@sapo.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 13 Oct 2008, Luis Henriques wrote:
> 
> I found a compilation error while compiling this new version of the rt
> pach.  I guess the following line is enough for you to trace the problem:
> 
> kernel/trace/trace_events.c:49: error: ?function_trace_stop? undeclared
> (first use in this function)
> 
> It seems that an 'extern int function_trace_stop' is missing somewhere...
> 

Luis, I just released a -rt11 that should fix this for you. Can you 
download it and give it a try.

Thanks,

-- Steve

