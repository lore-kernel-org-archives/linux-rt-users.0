From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Thu, 31 Mar 2016 08:31:43 +0200
Message-ID: <1459405903.14336.64.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38265 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcCaGbq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Mar 2016 02:31:46 -0400
In-Reply-To: <alpine.DEB.2.11.1603241140510.3978@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:

> I really wonder what makes the change. The only thing which comes to my mind
> is the enforcement of running the online and down_prepare callbacks on the
> plugged cpu instead of doing it wherever the scheduler decides to run it.

It seems it's not the state machinery making a difference after all,
the only two deadlocks encountered in oodles of beating seem to boil
down to the grab_lock business being a pistol aimed at our own toes.

1. kernfs_mutex taken during hotplug: We don't pin across mutex
acquisition, so anyone grabbing it and then calling migrate_disable()
while grab_lock is set renders us dead.  Pin across acquisition of that
specific mutex fixes that specific grab_lock instigated deadlock.

2. notifier dependency upon RCU GP threads:  Telling same to always do
migrate_me() or hotplug can bloody well wait fixes that specific
grab_lock instigated deadlock.

With those two little hacks, all of my boxen including DL980 just keep
on chugging away in 4.[456]-rt, showing zero inclination to identify
any more hotplug bandits.

What I like much better than 1 + 2 is their sum, which would generate
minus signs, my favorite thing in patches, and fix the two above and
anything that resembles them in any way...

3. nuke irksome grab_lock: make everybody always try to get the hell
outta Dodge or hotplug can bloody well wait.

I haven't yet flogged my 64 core box doing that, but my local boxen
seem to be saying we don't really really need the grab_lock business.

Are my boxen fibbing, is that very attractive looking door #3 a trap?

	-Mike

