From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 20:45:40 -0700
Message-ID: <1196307940.4078.282.camel@hermosa.morrealenet>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
	 <Pine.LNX.4.58.0711281642170.2846@gandalf.stny.rr.com>
	 <1196292411.4078.253.camel@hermosa.morrealenet>
	 <Pine.LNX.4.58.0711282027380.12951@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:38719 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXK2Du6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 22:50:58 -0500
In-Reply-To: <Pine.LNX.4.58.0711282027380.12951@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 20:33 -0500, Steven Rostedt wrote:


> >
> > As an early experiment, I converted the dcache, inode, and vfsmount
> > spins to raw, and performance jumped by 4x.  (I realized later that
> > dbench does alot of record locking and was still hammered by the BKL,
> > otherwise I suspect it would have been significantly greater...)  This
> > also reduced the cs/s rate to below 100k/s (from the high of ~380k/s)
> 
> After converting those locks to spinlocks, have you tried running
> cyclictest and hackbench (or dbench) and see how cyclictest works?
> 
> I bet you'll see extremely large latencies.
> 
> Those locks are some of the biggest offenders of adding latencies.
> 

Nod.  To be expected.  A single lock desired by everybody touching any
filesystem.  Bummer.

Unfortunately I managed to hammer my mod'ed tree, Its easy enough to
recreate and will do so tomorrow.  

And yes, I've run all 3 above tests.  Concurrently. 

As I recall, the cyclictest spike for the average was 1-2us, and around
20us for the max.  But I really need to rerun the suite.  This is old,
non-ECC memory I work with.  Sometimes bits are twiddled.

I will rerun and post tomorrow. 

> >
> > It seems clear that a single point of contention (e.g: the dcache lock
> > in the above workload) greatly impacts the throughput of the hardware
> > platform.  There are similar points of contention with dev->_xmit_lock,
> > and queue_lock in the networking stack.
> >
> > Obviously, this is an issue for real-world apps.  Those pesky thingies
> > think they need data from various sources to do stuff.  That was humor.
> >
> > At the risk of being chastised, is (or has) this any discussion on this
> > been taking place?
> 
> Discussion of what?  Changing them to raw spinlocks?
> 

No.  But what about a preempable read/write spin lock?  Is such a thing
possible?   I suspect not since it was not implemented.  


Thx,
-PWM


> The real solution is to find better ways to handle the filesystem with
> less contention. This will take great knowledge of the VFS. But this is no
> trivial task.
> 
> Ideas are welcome.
> 
> -- Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
