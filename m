From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: RFC: methods of sched event tracing and my assumptions
Date: Wed, 02 Sep 2009 14:09:10 -0700
Message-ID: <4A9EDEF6.2000002@us.ibm.com>
References: <4A9C1371.6050101@us.ibm.com> <4A9C5600.8060007@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	"lkml, " <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:47013 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbZIBVJL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2009 17:09:11 -0400
In-Reply-To: <4A9C5600.8060007@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darren Hart wrote:
> 
> After some gentle resistance to CVS and non-single-file testcases, I 
> prepared a standalone prio-wake-min.c.  It ran to completion on linus 
> with slightly fewer wakeups than the LTP version (I removed a number of 
> things that weren't strictly necessary for this specific exercise), png 
> attached.  It's hung part way through the scripts on rt though.  I'll be 
> looking into that, but in case you prefer to look at this version, it is 
> available here:
> 
> http://dvhart.com/darren/linux/prio-wake-min.c

I have just now updated this test to fix a possible race when using a 
requeue PI enabled glibc (likely a bug in glibc) which also reduces the 
tests runtime from 1s to about 15ms (yeah, the sleep loops were rather 
stupid in the original version :/).

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
