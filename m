From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23-rc9-rt1
Date: Tue, 2 Oct 2007 21:58:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710022134430.16284@gandalf.stny.rr.com>
References: <1191341473.5642.36.camel@localhost.localdomain>
 <4702EA31.4020102@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:46674 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXJCB6f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 21:58:35 -0400
In-Reply-To: <4702EA31.4020102@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 2 Oct 2007, Clark Williams wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Steven Rostedt wrote:
> >   That last change (new Preempt RCU) is highly experimental!!!
> >   We are currently testing it now, although it has been through some
> >   minor tests already, we haven't declared it stable yet.
> >
> >   This new implementation might shave your cat, eat your dog and
> >   make your children miss the bus and be late for school.
> >   You have been warned! As is said many times on this list
> >   "If it breaks, you get to keep the pieces". So don't come crying
> >   to us if something terrible happens, but please let us know
> >   so that we can try to fix what broke.
> >
> >   That said, please test it as much as possible. We are happy with
> >   the new implementation, but it's still young, and we want to
> >   shake out the problems so it can be pushed up into mainline.
> >
>
> Luckily, I'm currently catless, dogless and childless, so no harm done :)

Great! So you are the perfect tester for us!

>
> I'm running this kernel on a Thinkpad T60 (Core2 Duo, x86_64). When I suspended to
> RAM and then resumed, my syslog window started scrolling the following:
>
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac05>] cpu_idle+0xc7/0xee
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
> Oct  2 19:45:46 localhost kernel:
> Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:91
> rcu_enter_nohz()
> Oct  2 19:45:46 localhost kernel:
> Oct  2 19:45:46 localhost kernel: Call Trace:
> Oct  2 19:45:46 localhost kernel:  [<ffffffff80254a0b>]
> tick_nohz_stop_sched_tick+0x1c6/0x2aa
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
> Oct  2 19:45:46 localhost gpm[2095]: *** err [gpm.c(529)]:
> Oct  2 19:45:46 localhost gpm[2095]: select(): Interrupted system call
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ab80>] cpu_idle+0x42/0xee
> Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
> Oct  2 19:45:46 localhost kernel:
> Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:99
> rcu_exit_nohz()

grmbl grmbl!!!

We are missing a match somewhere. Most likely in the suspend or resume
code.  It's expected that if a CPU is idle with no ticks then the
dynticks_progress_counter is even, otherwise it is odd. This check tells
us that, in your case, this isn't the case. Which _is_ bad, and I wouldn't
run it too long that way. It means that you can be getting false RCU grace
period ends, which is not a good thing.

I could put a hack in that fixes the issue when detected, and still prints
out a warning. I'll do that for now, until we find the problem area. I
think the first warning probably had the want that corrupted us, and then
we got flooded with warnings because we never fixed the situation.

Patch coming soon.

-- Steve
>
> Ad infinitum. Not sure what you're looking for to be cleared in the enter and exit
> functions, but it doesn't look like it's happening after a resume. Didn't seem to
> affect the behavior of the kernel, since the network came up and I was able to
> function normally (or as normally as I can function).

I'd reboot if I were you ;-)

-- Steve
