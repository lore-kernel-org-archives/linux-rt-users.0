From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 3 Jan 2013 10:36:34 -0500
Message-ID: <20130103153634.GD16895@thunk.org>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
 <1357182583.10284.16.camel@gandalf.local.home>
 <20130103042224.GB16895@thunk.org>
 <1357219291.10284.21.camel@gandalf.local.home>
 <20130103141837.GC16895@thunk.org>
 <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E59@clark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:41520 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab3ACPgo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 10:36:44 -0500
Content-Disposition: inline
In-Reply-To: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E59@clark>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 03, 2013 at 08:36:39AM -0600, Staffan Tjernstrom wrote:
> This may be completely off-in-newbie land, but I figured I'd throw in what I think I've tracked down.
> 
> It looks as if there was a fairly recent patch to turn locks in
> parts of the code into atomic instructions (apologies - I don't have
> the patch id to hand atm) in do_get_write_access() amongst others.

In fs/jbd2/transaction.c?  Can you give me the code snippit and/or
function and line number that you're concerned about?

> Then in turn the C++ standard library loops around calls to write()
> whilst access isn't available, basically blocking on the atomic
> (which then in turn doesn't support priority inheritance), causing
> the wait loop.

Yeah, but do_get_write_access() blocks (usually waiting for the jbd2
kernel thread to complete, but possibly on a memory allocation); we
don't return EAGAIN or anything like that.  So I don't see how that
would cause a wait loop.

It's possible we could be returning -ENOMEM; are you looping for all
write failures, or just for EAGAIN/EINTR and partial writes?

	      	     	  	    - Ted
