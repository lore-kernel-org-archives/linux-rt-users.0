From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 1/2] remove recursive call to migrate_disable in
	read_lock_bh
Date: Sat, 30 Nov 2013 02:58:55 +0100
Message-ID: <20131130015855.GA8114@opentech.at>
References: <20131120102107.GA12022@opentech.at> <20131122161234.GG8698@linutronix.de> <20131122233925.GA25921@opentech.at> <20131129145443.GC31099@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:53443 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab3K3B64 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 20:58:56 -0500
Content-Disposition: inline
In-Reply-To: <20131129145443.GC31099@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 Nov 2013, Sebastian Andrzej Siewior wrote:

> * Nicholas Mc Guire | 2013-11-23 00:39:25 [+0100]:
> 
> >hmmm. am I looking at the wrong code path ?
> No, it was me, sorry for the confusion.
> So this patch should work. What I am concerned is what Peter mentioned.
> It seems that we have no user of this "alternative" unlock path right
> now but it could become a ticking time bomb.
>
yes that is a concern. I scaned the kernel source tree with some cocci scripts 
to find these problems. And actually I only found 3 (1 with write_lock_bh, 2 
with spin_lock_bh ), all 3 in net/core/*, but the maintainer does not seem 
willing to include these cleanups so those cleanups do not seem doable.

the found locations are:
file:linux-stable-rt4/net/core/sock.c lock split at lines 2382 2392 2397
file:linux-stable-rt4/net/ipv4/inet_hashtables.c lock split at lines 571 577 581
file:linux-stable-rt4/net/core/neighbour.c lock split at lines 969 1024 1025

The basic model of the scanner is like below, might be useful for other 
problems as well. you need a whole set of the possible variations and 
then simply brute force iterate over the kernel with 
 find . -name "*.c" -exec spatch -sp_file read_lock.cocci {} \; 

@r1@
identifier f;
expression E;
position p1,p2,p3;
@@
f(...) {
<...
(
read_lock_bh(E)@p1;
...
read_unlock(E)@p2;
...
local_bh_enable()@p3;
|
local_bh_disable()@p1;
...
read_lock(E)@p2;
...
read_unlock_bh(E)@p3;
)
...>
}

@script:python@
p1 << r1.p1;
p2 << r1.p2;
p3 << r1.p3;
@@
print "file:%s lock split at lines %s %s %s" % (p1[0].file,p1[0].line, p2[0].line, p3[0].line)

so there are ways to defuse these timebombs 
the problem is more the reluctance of net/core to accept such patches
as David Miller considers the lock splitting to be a valid locking idiom
so its probably not woth pushing this further.

thx!
hofrat
