From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG  RT] - rcupreempt.c:133 on 2.6.23-rc1-rt7
Date: Sun, 5 Aug 2007 08:59:48 +0200
Message-ID: <20070805065948.GB515@elte.hu>
References: <1186289484.636.5.camel@localhost.localdomain> <1186290332.636.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51979 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbXHEHAE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 03:00:04 -0400
Content-Disposition: inline
In-Reply-To: <1186290332.636.8.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > I don't have time to look further now, and it's something that isn't 
> > easily reproducible (Well, it happened once out of two boots). If 
> > you need me to look further, or need a config or dmesg (I have 
> > both), then just give me a holler.
> 
> Silly me. FYI, I was running with !PREEMPT_RT, but with Hard and 
> Softirqs as threads.  Must have copied the wrong config over :-/

it's still not supposed to happen ... rcu read lock nesting that deep?

	Ingo
