From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG RT] WARNING: at kernel/sched.c:5071 2.6.23-rc1-rt7
Date: Sun, 5 Aug 2007 08:56:46 +0200
Message-ID: <20070805065646.GA515@elte.hu>
References: <1186290816.636.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:56244 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbXHEG5L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 02:57:11 -0400
Content-Disposition: inline
In-Reply-To: <1186290816.636.14.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> The below ifndef, shouldn't that be ifndef CONFIG_PREEMPT_SOFTIRQS ? I 
> hit that warning while I was running !PREEMPT_RT but with both hard 
> and softiqs as threads.

yeah, indeed - fixed.

> P.S. I really found out that the system becomes VERY non-responsive 
> when you run with both hard and softirqs as threads, but with 
> PREEMPT_NONE ;-)

hm. That's not supposed to happen. Could there be some wakeup or softirq 
processing problem?

	Ingo
