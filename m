From: Luis Henriques <henrix@sapo.pt>
Subject: Re: 2.6.26.6-rt10
Date: Mon, 13 Oct 2008 22:15:11 +0100
Message-ID: <48F3BA5F.2000107@sapo.pt>
References: <1223839814.19319.5.camel@localhost.localdomain> <48F29310.1030206@sapo.pt> <alpine.DEB.1.10.0810131550540.522@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:52605 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1759420AbYJMVPZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Oct 2008 17:15:25 -0400
In-Reply-To: <alpine.DEB.1.10.0810131550540.522@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Mon, 13 Oct 2008, Luis Henriques wrote:
>> I found a compilation error while compiling this new version of the rt
>> pach.  I guess the following line is enough for you to trace the problem:
>>
>> kernel/trace/trace_events.c:49: error: ?function_trace_stop? undeclared
>> (first use in this function)
>>
>> It seems that an 'extern int function_trace_stop' is missing somewhere...
>>
> 
> Luis, I just released a -rt11 that should fix this for you. Can you 
> download it and give it a try.


Hi Steve,

just recompiled it and, although I did not really tested it (just booted
the new kernel), it seems to works like a charm ;)

Regards,
--
Luis Henriques
