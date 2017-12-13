From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Wed, 13 Dec 2017 18:53:39 +0100
Message-ID: <20171213175339.udcexwcmscotipwc@linutronix.de>
References: <20171212215818.GA18168@a.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: bert schulze <spambemyguest@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdLMRxl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Dec 2017 12:53:41 -0500
Content-Disposition: inline
In-Reply-To: <20171212215818.GA18168@a.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-12 22:58:18 [+0100], bert schulze wrote:
> Hi folks,
Hi,

> I'm having issues with v4.14-rt1 to v4.14.3-rt5 using NO_HZ_FULL_ALL=y
> with PREEMPT_RT_FULL=y and kernel.timer_migration enabled (which seems
> to be enabled by default).
> 
> Full config used: http://paste.debian.net/hidden/eb51a120/
> 
> The kernel either boots fine or may lock up on boot already (sysrq is
> working still and boot continues after some seconds upto minutes).
> 
> If any hang occurred on boot dmesg will contain:
> root@deb9:~# dmesg | grep hrtimer
> [    1.507207] hrtimer: interrupt took 28740 ns

this pops up because for some reason the system setup a lot of timers
and it takes time process them…

> If the system booted up fine (-> no "interrupt took #### ns" message)
> it behaves as expected as long as timer migration was disabled.
> 
> root@deb9:~# echo 0 > /proc/sys/kernel/timer_migration 
> 
> A simple sleep (or anything else using nanosleep() is sufficient to
> reproduce this.
> 
> 
> The expected behaviour with kernel.timer_migration = 0
> 
> root@deb9:~# grep LOC: /proc/interrupts 
> LOC:     91968       801       775       590   Local timer interrupts
> 
> root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
> real    0m0.104s  // CPU0 ok
> real    0m0.104s  // CPU1 ok
> real    0m0.104s  // CPU2 ok
> real    0m0.105s  // CPU3 ok
> 
> root@deb9:~# grep LOC: /proc/interrupts 
> LOC:    101069       824       782       599   Local timer interrupts
> 
> Roughly 10 seconds passed and the housekeeping cpu shows ~10.000 timer
> interrupts (which matches up with CONFIG_HZ=1000).
> 
> 
> Doing the same with kernel.timer_migration = 1
> 
> root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
> real    0m0.104s  // CPU0 ok
> [  125.282455] hrtimer: interrupt took 2230 ns  <-- 
> real    0m28.023s // CPU1 not ok
> real    0m9.129s  // CPU2 not ok
> real    0m10.000s // CPU3 not ok

your timer takes way longer. __hrtimer_init_sleeper() set your timer to
expire in softirq context and this does not happen for cross-base. If
you switch this to hard ctx then they will expire properly. The
interrupt storm remains…

…

> I've furthermore tested v4.13.13-rt5 and WIP.timers branch of tip.git
> and both of them are working as expected.

you have to take into account that you have almost no timers that will
expire in the softirq context. I will check that tomorrow and I expect
that the soft-timer in WIP.timers will also fail to expire in time.

> 
> Thanks,
> Bert

Sebastian
