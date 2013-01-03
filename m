From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 03 Jan 2013 10:35:22 -0500
Message-ID: <1357227322.10284.34.camel@gandalf.local.home>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
	 <1357182583.10284.16.camel@gandalf.local.home>
	 <20130103042224.GB16895@thunk.org>
	 <1357219291.10284.21.camel@gandalf.local.home>
	 <20130103141837.GC16895@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Staffan Tjernstrom <stjernstrom@eagleseven.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19746 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab3ACPfX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 10:35:23 -0500
In-Reply-To: <20130103141837.GC16895@thunk.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-01-03 at 09:18 -0500, Theodore Ts'o wrote:
> On Thu, Jan 03, 2013 at 08:21:31AM -0500, Steven Rostedt wrote:
> > Anytime you have something that does the following in order to break
> > lock ordering:
> > 
> > repeat:
> > 	lock(A);
> > 	<do something>
> > 	if (!trylock(B)) {
> > 		unlock(A);
> > 		cpu_relax();
> > 		goto repeat;
> > 	}
> > 
> > 
> > We can live lock, because spinlocks in -rt turn into a mutex. Thus, the
> > holder of lock B may not be on another CPU but actually on the current
> > CPU and is waiting for the process that is in this loop. If that process
> > happens to be an RT task, then the system stops.
> 
> Good point, but I'm prety sure we don't have any kind of trylock loops
> in either fs/ext4 or fs/jbd2, though.
> 

We found a few in the underlining block layer. Those were fixed in
recent versions. Although, 3.2 didn't have that specific problem so I'm
not sure what the original posters issues are, and wont be sure without
a full task dump of all tasks.

-- Steve


