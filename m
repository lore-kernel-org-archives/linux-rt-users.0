From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG  RT] - rcupreempt.c:133 on 2.6.23-rc1-rt7
Date: Sun, 5 Aug 2007 17:26:27 +0200
Message-ID: <20070805152627.GA14029@elte.hu>
References: <1186289484.636.5.camel@localhost.localdomain> <1186290332.636.8.camel@localhost.localdomain> <20070805065948.GB515@elte.hu> <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35691 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbXHEP0y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 11:26:54 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The code on line 133 is:
> 
> 	WARN_ON_ONCE(current->rcu_read_lock_nesting > NR_CPUS);
> 
> I have NR_CPUS set to 2 since the box I'm running this on only has 2 
> cpus and I see no reason to waste more data structures.
> 
> Is rcu read lock nesting deeper than 2?

ah, silly me - that should indeed be something fixed like 128.

	Ingo
