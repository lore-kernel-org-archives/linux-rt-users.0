From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Wed, 2 Jan 2013 23:22:24 -0500
Message-ID: <20130103042224.GB16895@thunk.org>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
 <1357182583.10284.16.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Staffan Tjernstrom <stjernstrom@eagleseven.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:41426 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab3ACEWg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jan 2013 23:22:36 -0500
Content-Disposition: inline
In-Reply-To: <1357182583.10284.16.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 02, 2013 at 10:09:43PM -0500, Steven Rostedt wrote:
> -- Steve
> 
> > Trace 1:
> > [<ffffffffa01a085d>] jbd2_log_wait_commit+0xcd/0x150
> > [<ffffffffa01b74a5>] ext4_sync_file+0x1e5/0x480
> > [<ffffffff8117a42b>] vfs_fsync_range+0x2b/0x30
> > [<ffffffff8117a44c>] vfs_fsync+0x1c/0x20
> > [<ffffffff8117a68a>] do_fsync+0x3a/0x60
> > [<ffffffff8117a6c3>] sys_fdatasync+0x13/0x20
> > [<ffffffff814e7feb>] system_call_fastpath+0x16/0x1b

Is this process running at a real-time priority?  If so, it looks like
a classic priority inversion problem.  fsync() triggers a journal
commit, and then waits for the jbd2 process to do the work.  If you
have real-time threads/processes which prevent the jbd2 process from
scheduling, that would explain what's going on.

In general, real-time processes/threads should *not* be doing file
system I/O, but if you must, you need to make sure that you've
adjusted the jbd2 kernel threads to run at the same or slightly higher
priority than the highest priority process which will be writing to
the file system.

Cheers,

					- Ted
