From: bert schulze <spambemyguest@googlemail.com>
Subject: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Tue, 12 Dec 2017 22:58:18 +0100
Message-ID: <20171212215818.GA18168@a.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46435 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdLLV6b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Dec 2017 16:58:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so1401513wme.5
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2017 13:58:31 -0800 (PST)
Received: from a.fritz.box (i59F743C9.versanet.de. [89.247.67.201])
        by smtp.gmail.com with ESMTPSA id 38sm283581wry.34.2017.12.12.13.58.28
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 13:58:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

I'm having issues with v4.14-rt1 to v4.14.3-rt5 using NO_HZ_FULL_ALL=y
with PREEMPT_RT_FULL=y and kernel.timer_migration enabled (which seems
to be enabled by default).

Full config used: http://paste.debian.net/hidden/eb51a120/

The kernel either boots fine or may lock up on boot already (sysrq is
working still and boot continues after some seconds upto minutes).

If any hang occurred on boot dmesg will contain:
root@deb9:~# dmesg | grep hrtimer
[    1.507207] hrtimer: interrupt took 28740 ns

If the system booted up fine (-> no "interrupt took #### ns" message)
it behaves as expected as long as timer migration was disabled.

root@deb9:~# echo 0 > /proc/sys/kernel/timer_migration 

A simple sleep (or anything else using nanosleep() is sufficient to
reproduce this.


The expected behaviour with kernel.timer_migration = 0

root@deb9:~# grep LOC: /proc/interrupts 
LOC:     91968       801       775       590   Local timer interrupts

root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
real    0m0.104s  // CPU0 ok
real    0m0.104s  // CPU1 ok
real    0m0.104s  // CPU2 ok
real    0m0.105s  // CPU3 ok

root@deb9:~# grep LOC: /proc/interrupts 
LOC:    101069       824       782       599   Local timer interrupts

Roughly 10 seconds passed and the housekeeping cpu shows ~10.000 timer
interrupts (which matches up with CONFIG_HZ=1000).


Doing the same with kernel.timer_migration = 1

root@deb9:~# for cpu in {0..3} ;do time taskset -ac $cpu sleep 0.1 ;done 
real    0m0.104s  // CPU0 ok
[  125.282455] hrtimer: interrupt took 2230 ns  <-- 
real    0m28.023s // CPU1 not ok
real    0m9.129s  // CPU2 not ok
real    0m10.000s // CPU3 not ok

The hrtimer: "interrupt took #### ns" message appeared any sleep on the
adaptive-tick cpu are completely off and …

root@deb9:~# grep LOC: /proc/interrupts 
LOC:  12544410       874       828       638   Local timer interrupts

… timer interrupts on the housekeeping cpu advanced by ~12400000 after
roughly 60 seconds even though the system is up for 2 minutes.

root@deb9:~# uptime 
 21:37:14 up 2 min,  1 user,  load average: 0.17, 0.15, 0.06


To rule out my hardware I've successfully reproduced this on i7-6700,
i7-3517u, i7-2xxxHQ hardware as well as in QEMU itself.

Everything is back to normal by passing "nohz_full=" to the kernel to
disable adaptive-tick cpus.

I've furthermore tested v4.13.13-rt5 and WIP.timers branch of tip.git
and both of them are working as expected.


Thanks,
Bert
