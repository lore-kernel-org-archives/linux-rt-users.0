From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Fri, 22 Jan 2016 17:35:52 +0200
Message-ID: <56A24C58.8060209@ti.com>
References: <20151223225755.GA21121@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43694 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbcAVPgF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 10:36:05 -0500
In-Reply-To: <20151223225755.GA21121@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/24/2015 12:57 AM, Sebastian Andrzej Siewior wrote:
> Please don't continue reading before christmas eve (or morning,
> depending on your schedule). If you don't celebrate christmas,
> well go ahead.
>
> Dear RT folks!
>
> I'm pleased to announce the v4.4-rc6-rt1 patch set. I tested it on my
> AMD A10, 64bit. Nothing exploded so far, filesystem is still there.
> I haven't tested it on anything else. Before someone asks: this does not
> mean it does *not* work on ARM I simply did not try it.
>
> If you are brave then download it, install it and have fun. If something
> breaks, please report it. If your machine starts blinking like a
> christmas tree while using the patch then *please* send a photo.
>
> Changes since v4.1.15-rt17:
>    - rebase to v4.4-rc6
>
> Known issues (inherited from v4.1-RT):
>        - bcache stays disabled
>
>        - CPU hotplug is not better than before
>
>        - The netlink_release() OOPS, reported by Clark, is still on the
>          list, but unsolved due to lack of information
>
>        - Christoph Mathys reported a stall in cgroup locking code while using
>          Linux containers.
>
> You can get this release via the git tree at:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4-rc6-rt1
>
> The RT patch against 4.4-rc6 can be found here:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4-rc6-rt1.patch.xz
>
> The split quilt queue is available at:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4-rc6-rt1.tar.xz
>

Additional note: RCU_BOOST now depends on RCU_EXPERT, so commit
3da4cab "rcu: make RCU_BOOST default on RT" is nop now.

config RCU_BOOST
	bool "Enable RCU priority boosting"
	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
	default y if PREEMPT_RT_FULL

-- 
regards,
-grygorii
