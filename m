From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix conversion of task state to char in latency tracer
Date: Fri, 11 Apr 2008 11:30:52 +0200
Message-ID: <20080411093052.GF10801@elte.hu>
References: <20080409181631.GB7764@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Ankita Garg <ankita@in.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57945 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758147AbYDKJbY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Apr 2008 05:31:24 -0400
Content-Disposition: inline
In-Reply-To: <20080409181631.GB7764@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Ankita Garg <ankita@in.ibm.com> wrote:

> Hi,
> 
> The conversion of task states to a character in the sched_switch 
> tracer (part of latency tracer infrastructure), seems to be incorrect. 
> We currently do it by indexing into the state_to_char array using the 
> state value. The state values do not map directly into the array index 
> and are thus incorrect. The following patch addresses this issue. This 
> is also what is being done even in the show_task() routine in 
> kernel/sched.c
> 
> The patch has been compile and run tested.
> 
> Signed-off-by: Ankita Garg <ankita@in.ibm.com>

thanks Ankita, good catch. I applied your patch to sched-devel/latest as 
well (which carries the ftrace patches, and which patches -rt is 
tracking). You can track this upstream tree via:

  http://people.redhat.com/mingo/sched-devel.git/README

	Ingo
