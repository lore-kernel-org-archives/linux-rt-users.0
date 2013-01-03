From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: RE: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 3 Jan 2013 08:36:39 -0600
Message-ID: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E59@clark>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
 <1357182583.10284.16.camel@gandalf.local.home>
 <20130103042224.GB16895@thunk.org>
 <1357219291.10284.21.camel@gandalf.local.home>
 <20130103141837.GC16895@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([38.98.183.218]:54510 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3ACOgo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 09:36:44 -0500
In-Reply-To: <20130103141837.GC16895@thunk.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This may be completely off-in-newbie land, but I figured I'd throw in what I think I've tracked down.

It looks as if there was a fairly recent patch to turn locks in parts of the code into atomic instructions (apologies - I don't have the patch id to hand atm) in do_get_write_access() amongst others.

Then in turn the C++ standard library loops around calls to write() whilst access isn't available, basically blocking on the atomic (which then in turn doesn't support priority inheritance), causing the wait loop.

Absolutely one of the first things we need to do in our "userland" is to get the file writes out of  the high priority code - that certainly makes every sense in the book.

-----Original Message-----
From: Theodore Ts'o [mailto:tytso@mit.edu] 
Sent: Thursday, January 03, 2013 8:19 AM
To: Steven Rostedt
Cc: Staffan Tjernstrom; linux-rt-users@vger.kernel.org; tglx@linutronix.de; C.Emde@osadl.org; jkacur@redhat.com
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50

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
> We can live lock, because spinlocks in -rt turn into a mutex. Thus, 
> the holder of lock B may not be on another CPU but actually on the 
> current CPU and is waiting for the process that is in this loop. If 
> that process happens to be an RT task, then the system stops.

Good point, but I'm prety sure we don't have any kind of trylock loops in either fs/ext4 or fs/jbd2, though.

					- Ted
