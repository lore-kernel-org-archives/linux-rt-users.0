From: bert schulze <spambemyguest@googlemail.com>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Thu, 14 Dec 2017 19:01:50 +0100
Message-ID: <20171214180150.GA18502@a.fritz.box>
References: <20171212215818.GA18168@a.fritz.box>
 <20171213175339.udcexwcmscotipwc@linutronix.de>
 <20171213191454.GA17027@a.fritz.box>
 <20171214162503.wjyko5jnisjgaq5e@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42455 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbdLNSCE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Dec 2017 13:02:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id b199so13094686wme.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2017 10:02:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171214162503.wjyko5jnisjgaq5e@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian Andrzej Siewior (Thu, Dec 14, 2017 at 05:25:03PM +0100):
> On 2017-12-13 20:14:54 [+0100], bert schulze wrote:
> > Yes as timer migration kicked in on boot causing the interrupt storm.
> > Disabling it all together there are no more hangs on boot.
> 
> and with the patch I Cced you one we have fix for that but there is
> more…
> 
> > This is sleep from coreutils, I'm not setting up anything here.
> > top, cyclictest whatever using nanosleep is broken.
> 
> that sleep should be also affected.
> 
> > Tried that as mentioned, no interrupt storm and nothing fails to expire.
> > (Add mainline 4.14 upto 4.14.5 to the list of working versions).
> …
> 
> > Do you need anything else that would be helpful?
> 
> bisect with RT is an exercise of its own.
> It looks that if you set rcu_normal_after_boot to 0 in
> kernel/rcu/update.c then other problem should go away and everything is
> "normal" now, right?

System boots reliable with mentioned patch applied, and nanosleep is
working as well! I do not have to set rcu_normal_after_boot to 0 or what
is its purpose?

> Now I need to figure why that is broken…

Guess you already did :)

root@deb9:~# bash test 
# uname -a
Linux deb9.virt 4.14.3-rt5-rt+ #5 SMP PREEMPT RT Thu Dec 14 18:39:27 CET 2017 x86_64 GNU/Linux
# cat /proc/sys/kernel/timer_migration
1
# dmesg | grep hrtimer
# date
Thu Dec 14 18:41:21 CET 2017
# grep LOC /proc/interrupts
LOC:       8002        208        138         68   Local timer interrupts
# for cpu in {0..3} ;do time taskset -ac  sleep 0.1 ;done
real    0m0.103s
real    0m0.105s
real    0m0.105s
real    0m0.105s
# date
Thu Dec 14 18:41:22 CET 2017
# grep LOC /proc/interrupts
LOC:       8437        209        139         70   Local timer interrupts

Tested on bare hardware and QEMU, top and cyclictest are working as well
no more interrupt storms can be observed!

> 
> Sebastian
Thank you!
Bert
