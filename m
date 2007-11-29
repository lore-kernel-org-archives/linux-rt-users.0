From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 20:33:20 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711282027380.12951@gandalf.stny.rr.com>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
 <Pine.LNX.4.58.0711281642170.2846@gandalf.stny.rr.com>
 <1196292411.4078.253.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Peter W. Morreale" <pmorreale@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50565 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758142AbXK2BdX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 20:33:23 -0500
In-Reply-To: <1196292411.4078.253.camel@hermosa.morrealenet>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 28 Nov 2007, Peter W. Morreale wrote:
>
> Will do.  didn't want to flood your mailbox, if that was the case... :-)

No prob with my Inbox ;-)

> >
> > Well, make does do a lot af IO and syscalls. Accessing the hard drive.
> > This in turn will kick off interrupts and softirqs. Which will all contend
> > for spinlocks, and since they are all working together, expect a lot of
> > contention.
> >
> > -- Steve
> >
>
> It does, and that was the point.
>
> Switching gears here a little bit...
>
> The real problem I see is under a moderate 'dbench' load (No laughing,
> you want VFS contention, use dbench :-) I can easily bump the cs/s
> (context-switch/sec) rate to 380k/s.

Right, and this has nothing to do with priority boosting. It has to do
with lock contention.

>
> This on a ramfs (no disk involved) partition.  The bad part is that
> top(1) reports 50-60% idle CPU time.  Which implies that 2 of my 4
> x86_64 intels are spinning while there is work to do.
>
> As an early experiment, I converted the dcache, inode, and vfsmount
> spins to raw, and performance jumped by 4x.  (I realized later that
> dbench does alot of record locking and was still hammered by the BKL,
> otherwise I suspect it would have been significantly greater...)  This
> also reduced the cs/s rate to below 100k/s (from the high of ~380k/s)

After converting those locks to spinlocks, have you tried running
cyclictest and hackbench (or dbench) and see how cyclictest works?

I bet you'll see extremely large latencies.

Those locks are some of the biggest offenders of adding latencies.

>
> It seems clear that a single point of contention (e.g: the dcache lock
> in the above workload) greatly impacts the throughput of the hardware
> platform.  There are similar points of contention with dev->_xmit_lock,
> and queue_lock in the networking stack.
>
> Obviously, this is an issue for real-world apps.  Those pesky thingies
> think they need data from various sources to do stuff.  That was humor.
>
> At the risk of being chastised, is (or has) this any discussion on this
> been taking place?

Discussion of what?  Changing them to raw spinlocks?

The real solution is to find better ways to handle the filesystem with
less contention. This will take great knowledge of the VFS. But this is no
trivial task.

Ideas are welcome.

-- Steve
