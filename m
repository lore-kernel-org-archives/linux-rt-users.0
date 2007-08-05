From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] put in a relatively high number for rcu read lock
 upper limit.
Date: Sun, 5 Aug 2007 13:58:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708051358430.10919@gandalf.stny.rr.com>
References: <1186289484.636.5.camel@localhost.localdomain>
 <1186290332.636.8.camel@localhost.localdomain> <20070805065948.GB515@elte.hu>
 <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com>
 <20070805150449.GA19418@linux.vnet.ibm.com> <1186328100.636.19.camel@localhost.localdomain>
 <20070805175310.GB3244@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64744 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbXHER7t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 13:59:49 -0400
In-Reply-To: <20070805175310.GB3244@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sun, 5 Aug 2007, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Paul and Ingo,
> >
> > Should we just remove the upper limit check, or is something like this
> > patch sound?
>
> i've changed the limit to 30 (the same depth limit is used by lockdep).
>
> beyond that we could get stack overflow, etc.

Great!

Thanks Ingo,

-- Steve
