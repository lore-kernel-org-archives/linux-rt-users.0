From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 3 Jan 2013 09:18:37 -0500
Message-ID: <20130103141837.GC16895@thunk.org>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
 <1357182583.10284.16.camel@gandalf.local.home>
 <20130103042224.GB16895@thunk.org>
 <1357219291.10284.21.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Staffan Tjernstrom <stjernstrom@eagleseven.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:41506 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3ACOSt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 09:18:49 -0500
Content-Disposition: inline
In-Reply-To: <1357219291.10284.21.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 03, 2013 at 08:21:31AM -0500, Steven Rostedt wrote:
> Anytime you have something that does the following in order to break
> lock ordering:
> 
> repeat:
> 	lock(A);
> 	<do something>
> 	if (!trylock(B)) {
> 		unlock(A);
> 		cpu_relax();
> 		goto repeat;
> 	}
> 
> 
> We can live lock, because spinlocks in -rt turn into a mutex. Thus, the
> holder of lock B may not be on another CPU but actually on the current
> CPU and is waiting for the process that is in this loop. If that process
> happens to be an RT task, then the system stops.

Good point, but I'm prety sure we don't have any kind of trylock loops
in either fs/ext4 or fs/jbd2, though.

					- Ted
