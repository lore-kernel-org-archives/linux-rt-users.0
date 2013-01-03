From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: RE: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 3 Jan 2013 08:29:44 -0600
Message-ID: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E52@clark>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
	 <1357182583.10284.16.camel@gandalf.local.home>
	 <20130103042224.GB16895@thunk.org>
 <1357219291.10284.21.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Theodore Ts'o <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([38.98.183.218]:52195 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3ACO3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 09:29:46 -0500
In-Reply-To: <1357219291.10284.21.camel@gandalf.local.home>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for all the prompt responses, very much appreciated.

Since this is occurring on production boxes, we're somewhat constrained in troubleshooting (for now we've re-initialized the disks to ext2 in order to get around the journal commits, although that may not be the actual solution as you suggest).

I'll certainly keep my eyes open and if we see something similar I will see if we can get the extra debug info that Steven suggested in his earlier e-mail.

In the example I caught the process in get_write_access last ran on cpu 0 at SCHED_RR prio 70, the other three (all in jbd2_log_wait_commit) last ran on cpu 6 (the hyperthread opposite cpu 0) at regular prio 0.

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Thursday, January 03, 2013 7:22 AM
To: Theodore Ts'o
Cc: Staffan Tjernstrom; linux-rt-users@vger.kernel.org; tglx@linutronix.de; C.Emde@osadl.org; jkacur@redhat.com
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50

On Wed, 2013-01-02 at 23:22 -0500, Theodore Ts'o wrote:
> On Wed, Jan 02, 2013 at 10:09:43PM -0500, Steven Rostedt wrote:
> > -- Steve
> > 
> > > Trace 1:
> > > [<ffffffffa01a085d>] jbd2_log_wait_commit+0xcd/0x150 
> > > [<ffffffffa01b74a5>] ext4_sync_file+0x1e5/0x480 
> > > [<ffffffff8117a42b>] vfs_fsync_range+0x2b/0x30 
> > > [<ffffffff8117a44c>] vfs_fsync+0x1c/0x20 [<ffffffff8117a68a>] 
> > > do_fsync+0x3a/0x60 [<ffffffff8117a6c3>] sys_fdatasync+0x13/0x20 
> > > [<ffffffff814e7feb>] system_call_fastpath+0x16/0x1b
> 
> Is this process running at a real-time priority?  If so, it looks like 
> a classic priority inversion problem.  fsync() triggers a journal 
> commit, and then waits for the jbd2 process to do the work.  If you 
> have real-time threads/processes which prevent the jbd2 process from 
> scheduling, that would explain what's going on.
> 
> In general, real-time processes/threads should *not* be doing file 
> system I/O, but if you must, you need to make sure that you've 
> adjusted the jbd2 kernel threads to run at the same or slightly higher 
> priority than the highest priority process which will be writing to 
> the file system.

With -rt things can get worse too. Even caused by kjournald being upped in priority.

Anytime you have something that does the following in order to break lock ordering:

repeat:
	lock(A);
	<do something>
	if (!trylock(B)) {
		unlock(A);
		cpu_relax();
		goto repeat;
	}


We can live lock, because spinlocks in -rt turn into a mutex. Thus, the holder of lock B may not be on another CPU but actually on the current CPU and is waiting for the process that is in this loop. If that process happens to be an RT task, then the system stops.

-- Steve


