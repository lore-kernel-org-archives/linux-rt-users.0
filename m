From: Clark Williams <williams@redhat.com>
Subject: Re: 2.6.23-rc9-rt1
Date: Tue, 02 Oct 2007 20:02:41 -0500
Message-ID: <4702EA31.4020102@redhat.com>
References: <1191341473.5642.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbXJCBDK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 21:03:10 -0400
In-Reply-To: <1191341473.5642.36.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
>   That last change (new Preempt RCU) is highly experimental!!!
>   We are currently testing it now, although it has been through some
>   minor tests already, we haven't declared it stable yet.
> 
>   This new implementation might shave your cat, eat your dog and
>   make your children miss the bus and be late for school.
>   You have been warned! As is said many times on this list
>   "If it breaks, you get to keep the pieces". So don't come crying
>   to us if something terrible happens, but please let us know
>   so that we can try to fix what broke.
> 
>   That said, please test it as much as possible. We are happy with
>   the new implementation, but it's still young, and we want to
>   shake out the problems so it can be pushed up into mainline.
> 

Luckily, I'm currently catless, dogless and childless, so no harm done :)

I'm running this kernel on a Thinkpad T60 (Core2 Duo, x86_64). When I suspended to
RAM and then resumed, my syslog window started scrolling the following:

Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac05>] cpu_idle+0xc7/0xee
Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:91
rcu_enter_nohz()
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: Call Trace:
Oct  2 19:45:46 localhost kernel:  [<ffffffff80254a0b>]
tick_nohz_stop_sched_tick+0x1c6/0x2aa
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
Oct  2 19:45:46 localhost gpm[2095]: *** err [gpm.c(529)]:
Oct  2 19:45:46 localhost gpm[2095]: select(): Interrupted system call
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ab80>] cpu_idle+0x42/0xee
Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:99
rcu_exit_nohz()
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: Call Trace:
Oct  2 19:45:46 localhost kernel:  [<ffffffff80254b71>]
tick_nohz_restart_sched_tick+0x82/0x17d
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac05>] cpu_idle+0xc7/0xee
Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:91
rcu_enter_nohz()
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: Call Trace:
Oct  2 19:45:46 localhost kernel:  [<ffffffff80254a0b>]
tick_nohz_stop_sched_tick+0x1c6/0x2aa
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ac90>] mwait_idle+0x0/0x5f
Oct  2 19:45:46 localhost kernel:  [<ffffffff8020ab80>] cpu_idle+0x42/0xee
Oct  2 19:45:46 localhost kernel:  [<ffffffff8021c6f3>] start_secondary+0x2e4/0x2f5
Oct  2 19:45:46 localhost kernel:
Oct  2 19:45:46 localhost kernel: WARNING: at include/linux/rcupreempt.h:99
rcu_exit_nohz()


Ad infinitum. Not sure what you're looking for to be cleared in the enter and exit
functions, but it doesn't look like it's happening after a resume. Didn't seem to
affect the behavior of the kernel, since the network came up and I was able to
function normally (or as normally as I can function).

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHAuoxHyuj/+TTEp0RAtwQAJ41+q49fJXmKB9+WKdphDFc/iUcyACeOgGF
5JV0gQb+fFuCf2MDjMuTyVA=
=pSNr
-----END PGP SIGNATURE-----
