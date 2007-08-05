From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] put in a relatively high number for rcu read lock
	upper limit.
Date: Sun, 5 Aug 2007 19:53:10 +0200
Message-ID: <20070805175310.GB3244@elte.hu>
References: <1186289484.636.5.camel@localhost.localdomain> <1186290332.636.8.camel@localhost.localdomain> <20070805065948.GB515@elte.hu> <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com> <20070805150449.GA19418@linux.vnet.ibm.com> <1186328100.636.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36813 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbXHERxg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 13:53:36 -0400
Content-Disposition: inline
In-Reply-To: <1186328100.636.19.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Paul and Ingo,
> 
> Should we just remove the upper limit check, or is something like this 
> patch sound?

i've changed the limit to 30 (the same depth limit is used by lockdep).

beyond that we could get stack overflow, etc.

	Ingo
