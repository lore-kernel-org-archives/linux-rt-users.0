From: bert schulze <spambemyguest@googlemail.com>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Thu, 14 Dec 2017 21:57:50 +0100
Message-ID: <20171214205750.GA6801@a.fritz.box>
References: <20171212215818.GA18168@a.fritz.box>
 <20171213175339.udcexwcmscotipwc@linutronix.de>
 <20171213191454.GA17027@a.fritz.box>
 <20171214162503.wjyko5jnisjgaq5e@linutronix.de>
 <20171214180150.GA18502@a.fritz.box>
 <20171214182736.b5d33naqsuaw5sz2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34155 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbdLNU6D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Dec 2017 15:58:03 -0500
Received: by mail-wm0-f42.google.com with SMTP id y82so27919039wmg.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2017 12:58:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171214182736.b5d33naqsuaw5sz2@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian Andrzej Siewior (Thu, Dec 14, 2017 at 07:27:36PM +0100):
> On 2017-12-14 19:01:50 [+0100], bert schulze wrote:
> > > It looks that if you set rcu_normal_after_boot to 0 in
> > > kernel/rcu/update.c then other problem should go away and everything is
> > > "normal" now, right?
> > 
> > System boots reliable with mentioned patch applied, and nanosleep is
> > working as well! I do not have to set rcu_normal_after_boot to 0 or what
> > is its purpose?
> 
> By default RT sets rcu_normal_after_boot to 1. And with it set to 1 the
> system seems to freeze somehow. After switching it back to 0 the system
> works more reliably.

Running disk I/O and cpu workloads alongside cyclictest, no freeze
observed at all so far.

> 
> > > Now I need to figure why that is broken…
> > 
> > Guess you already did :)
> no, not yet.
> 
> > root@deb9:~# bash test 
> > # uname -a
> > Linux deb9.virt 4.14.3-rt5-rt+ #5 SMP PREEMPT RT Thu Dec 14 18:39:27 CET 2017 x86_64 GNU/Linux
> > # cat /proc/sys/kernel/timer_migration
> > 1
> > # dmesg | grep hrtimer
> > # date
> > Thu Dec 14 18:41:21 CET 2017
> > # grep LOC /proc/interrupts
> > LOC:       8002        208        138         68   Local timer interrupts
> > # for cpu in {0..3} ;do time taskset -ac  sleep 0.1 ;done
> > real    0m0.103s
> > real    0m0.105s
> > real    0m0.105s
> > real    0m0.105s
> > # date
> > Thu Dec 14 18:41:22 CET 2017
> > # grep LOC /proc/interrupts
> > LOC:       8437        209        139         70   Local timer interrupts
> > 
> > Tested on bare hardware and QEMU, top and cyclictest are working as well
> > no more interrupt storms can be observed!
> 
> hmm. So just that patch and everything works for you? No hangups during
> boot, no "perf: interrupt took too long" every 30-60 secs?

Yes no perf messages. However this is my "production" config stripped
off debugging. I can confirm that these messages appear when I use a
debugging config.

Disabling CONFIG_HARDLOCKUP_DETECTOR -> no more perf messages logged!

> 
> > > 
> > Thank you!
> > Bert
> 
> Sebastian
