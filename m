From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Thu, 24 Mar 2016 11:07:04 +0100
Message-ID: <1458814024.23732.35.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35977 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbcCXKHI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 06:07:08 -0400
In-Reply-To: <1458463425.3908.5.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2016-03-20 at 09:43 +0100, Mike Galbraith wrote:
> On Sat, 2016-02-13 at 00:02 +0100, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > We currently disable migration across lock acquisition. That includes the part
> > where we block on the lock and schedule out. We cannot disable migration after
> > taking the lock as that would cause a possible lock inversion.
> > 
> > But we can be smart and enable migration when we block and schedule out. That
> > allows the scheduler to place the task freely at least if this is the first
> > migrate disable level. For nested locking this does not help at all.
> 
> I met a problem while testing shiny new hotplug machinery.
> 
> rt/locking: Fix rt_spin_lock_slowlock() vs hotplug migrate_disable() bug
> 
> migrate_disable() -> pin_current_cpu() -> hotplug_lock() leads to..
> 	> BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
> ..so let's call migrate_disable() after we acquire the lock instead.

Well crap, that wasn't very clever  A little voice kept nagging me, and
yesterday I realized what it was grumbling about, namely that doing
migrate_disable() after lock acquisition will resurrect a hotplug
deadlock that we fixed up a while back.

On the bright side, with the busted migrate enable business reverted,
plus one dinky change from me [1], master-rt.today has completed 100
iterations of Steven's hotplug stress script along side endless
futexstress, and is happily doing another 900 as I write this, so the
next -rt should finally be hotplug deadlock free.

Thomas's state machinery seems to work wonders.  'course this being
hotplug, the other shoe will likely apply itself to my backside soon.

	-Mike

1. nest module_mutex inside hotplug_lock to prevent bloody systemd
-udevd from blocking in migrate_disable() while holding kernfs_mutex
during module load, putting a quick end to hotplug stress testing.
