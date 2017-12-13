From: bert schulze <spambemyguest@googlemail.com>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Wed, 13 Dec 2017 20:14:54 +0100
Message-ID: <20171213191454.GA17027@a.fritz.box>
References: <20171212215818.GA18168@a.fritz.box>
 <20171213175339.udcexwcmscotipwc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:46185 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753818AbdLMTPH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Dec 2017 14:15:07 -0500
Received: by mail-wm0-f46.google.com with SMTP id r78so7087955wme.5
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2017 11:15:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213175339.udcexwcmscotipwc@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian Andrzej Siewior (Wed, Dec 13, 2017 at 06:53:39PM +0100):
> On 2017-12-12 22:58:18 [+0100], bert schulze wrote:
> > Hi folks,
> Hi,
> 
> > I'm having issues with v4.14-rt1 to v4.14.3-rt5 using NO_HZ_FULL_ALL=y
> > with PREEMPT_RT_FULL=y and kernel.timer_migration enabled (which seems
> > to be enabled by default).
> > 
> > Full config used: http://paste.debian.net/hidden/eb51a120/
> > 
> > The kernel either boots fine or may lock up on boot already (sysrq is
> > working still and boot continues after some seconds upto minutes).
> > 
> > If any hang occurred on boot dmesg will contain:
> > root@deb9:~# dmesg | grep hrtimer
> > [    1.507207] hrtimer: interrupt took 28740 ns
> 
> this pops up because for some reason the system setup a lot of timers
> and it takes time process them…

Yes as timer migration kicked in on boot causing the interrupt storm.
Disabling it all together there are no more hangs on boot.

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 40ac38728b7a..77acc35c8749 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -220,7 +220,11 @@ static DEFINE_MUTEX(timer_keys_mutex);
 static struct swork_event timer_update_swork;
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_NO_HZ_FULL_ALL
+unsigned int sysctl_timer_migration = 0;
+#else
 unsigned int sysctl_timer_migration = 1;
+#endif
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);

--
> 
> > If the system booted up fine (-> no "interrupt took #### ns" message)
> > it behaves as expected as long as timer migration was disabled.
> > 
> > root@deb9:~# echo 0 > /proc/sys/kernel/timer_migration 
> > 
> > A simple sleep (or anything else using nanosleep() is sufficient to
> > reproduce this.
> > 
> > 
> > The expected behaviour with kernel.timer_migration = 0
> > 
> > root@deb9:~# grep LOC: /proc/interrupts 
> > LOC:     91968       801       775       590   Local timer interrupts
> > 
> > root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
> > real    0m0.104s  // CPU0 ok
> > real    0m0.104s  // CPU1 ok
> > real    0m0.104s  // CPU2 ok
> > real    0m0.105s  // CPU3 ok
> > 
> > root@deb9:~# grep LOC: /proc/interrupts 
> > LOC:    101069       824       782       599   Local timer interrupts
> > 
> > Roughly 10 seconds passed and the housekeeping cpu shows ~10.000 timer
> > interrupts (which matches up with CONFIG_HZ=1000).
> > 
> > 
> > Doing the same with kernel.timer_migration = 1
> > 
> > root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
> > real    0m0.104s  // CPU0 ok
> > [  125.282455] hrtimer: interrupt took 2230 ns  <-- 
> > real    0m28.023s // CPU1 not ok
> > real    0m9.129s  // CPU2 not ok
> > real    0m10.000s // CPU3 not ok
> 
> your timer takes way longer. __hrtimer_init_sleeper() set your timer to
> expire in softirq context and this does not happen for cross-base. If
> you switch this to hard ctx then they will expire properly. The
> interrupt storm remains…

This is sleep from coreutils, I'm not setting up anything here.
top, cyclictest whatever using nanosleep is broken.

> > I've furthermore tested v4.13.13-rt5 and WIP.timers branch of tip.git
> > and both of them are working as expected.
> 
> you have to take into account that you have almost no timers that will
> expire in the softirq context. I will check that tomorrow and I expect
> that the soft-timer in WIP.timers will also fail to expire in time.

Tried that as mentioned, no interrupt storm and nothing fails to expire.
(Add mainline 4.14 upto 4.14.5 to the list of working versions).

$ git log -1 | head -n1
commit fae02a10ca4b00ca614f8b3ea996cb419629d315 (HEAD -> WIP.timers, origin/WIP.timers)

root@deb9:~# bash test 
# uname -a
Linux deb9.virt 4.15.0-rc1-rt+ #2 SMP PREEMPT Wed Dec 13 19:10:01 CET 2017 x86_64 GNU/Linux
# cat /proc/sys/kernel/timer_migration
1
# dmesg | grep hrtimer
# date
Wed Dec 13 19:26:21 CET 2017
# grep LOC /proc/interrupts
LOC:      10409        651        495        404   Local timer interrupts
# for cpu in {0..3} ;do time taskset -ac  sleep 0.1 ;done
real    0m0.101s
real    0m0.101s
real    0m0.103s
real    0m0.103s
# date
Wed Dec 13 19:26:21 CET 2017
# grep LOC /proc/interrupts
LOC:      10825        704        500        405   Local timer interrupts


Bisect against linux-4.14.y-rt-rebase branch

--> last commit which is working 
git bisect good 3f2facf61992f4bb7a31463f6364e9a7cf1b9fcd

--> first commit which compiles but shows the expired timers
git bisect bad 33dc6fcdc040d1325b452cf7d6dbbd771931ad5b

# possible first bad commit: [33dc6fcdc040d1325b452cf7d6dbbd771931ad5b]
rtmutex: add ww_mutex addon for mutex-rt
# possible first bad commit: [82cf595179fb5d33c347ba1ce444e7db005abb3a]
rtmutex: wire up RT's locking
# possible first bad commit: [115407b319f59cdf2aac6723e3b007c9c22f64b7]
rtmutex: add rwlock implementation based on rtmutex
# possible first bad commit: [2d31dae80012b69945ec724060c9fc0ec13c8c6e]
rtmutex: add rwsem implementation based on rtmutex
# possible first bad commit: [2bee01da12a21f1b47f1c9e9044f7d923fce22cc]
rtmutex: add mutex implementation based on rtmutex
# possible first bad commit: [99f780e45d62cfb49eb9331fae5dc99757d8e3a1]
rtmutex: add sleeping lock implementation
# possible first bad commit: [71967ab31b3538fdfb801c44127f7ffc9bbc1e72]
rtmutex: export lockdep-less version of rt_mutex's lock, trylock and unlock

Do you need anything else that would be helpful?

> > 
> > Thanks,
> > Bert
> 
> Sebastian
