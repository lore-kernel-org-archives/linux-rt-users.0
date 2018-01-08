From: Tim Sander <tim@krieglstein.org>
Subject: problems with 4.14.6-rt7
Date: Mon, 08 Jan 2018 15:56:17 +0100
Message-ID: <2644174.vLadu3AOG5@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:56956 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756186AbeAHPGh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Jan 2018 10:06:37 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I am currently using 4.14.6-rt7 on an De0-Nano-Soc (intel/altera arm v7 dual core)
board. I have added a small driver which adds some functionality like iio. As soon
as i have some realtime load on one core i see messages like:

Showing busy workqueues and worker pools:
workqueue events_freezable: flags=0x4
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
    pending: mmc_rescan
workqueue events_power_efficient: flags=0x80
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256
    pending: phy_state_machine, neigh_periodic_work
workqueue mm_percpu_wq: flags=0x8
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
    pending: vmstat_update
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 68s!
Showing busy workqueues and worker pools:
workqueue mm_percpu_wq: flags=0x8
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
    pending: vmstat_update
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 98s!
Showing busy workqueues and worker pools:
workqueue mm_percpu_wq: flags=0x8
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
    pending: vmstat_update

In other occasions i have seen complete system lockups where the only message i get is:
INFO: task systemd:1 blocked for more than 120 seconds.
      Tainted: G           O    4.14.6-rt7 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
systemd         D    0     1      0 0x00001000
[<80793c70>] (__schedule) from [<80793f30>] (schedule+0x64/0xfc)
[<80793f30>] (schedule) from [<80796940>] (__write_rt_lock+0x13c/0x214)
[<80796940>] (__write_rt_lock) from [<80798464>] (rt_write_lock+0x24/0x28)
[<80798464>] (rt_write_lock) from [<8011f4b4>] (copy_process.part.5+0xfc4/0x17d8)
[<8011f4b4>] (copy_process.part.5) from [<8011fe58>] (_do_fork+0xc8/0x474)
[<8011fe58>] (_do_fork) from [<80120320>] (SyS_clone+0x30/0x38)
[<80120320>] (SyS_clone) from [<80107e60>] (ret_fast_syscall+0x0/0x28)
INFO: task systemd:1 blocked for more than 120 seconds.

I know that i am really using up all realtime budget on this system for one core 
but i would expect that rt-throttling kicks in and gets some time for these
starving processes?

Best regards
Tim

