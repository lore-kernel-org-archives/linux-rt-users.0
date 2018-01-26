From: Tim Sander <tim@krieglstein.org>
Subject: Re: problems with 4.14.6-rt7
Date: Fri, 26 Jan 2018 17:01:09 +0100
Message-ID: <2627538.QZmOYvPzcF@dabox>
References: <2644174.vLadu3AOG5@dabox> <20180124141849.hsikgyqgymbd2qe5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:38102 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeAZQBM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Jan 2018 11:01:12 -0500
In-Reply-To: <20180124141849.hsikgyqgymbd2qe5@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian

Am Mittwoch, 24. Januar 2018, 15:18:50 CET schrieb Sebastian Andrzej Siewior:
> On 2018-01-08 15:56:17 [+0100], Tim Sander wrote:
> > I am currently using 4.14.6-rt7 on an De0-Nano-Soc (intel/altera arm v7
> > dual core) board. I have added a small driver which adds some
> > functionality like iio. As soon
> > as i have some realtime load on one core i see messages like:
> …
> 
> > I know that i am really using up all realtime budget on this system for
> > one core but i would expect that rt-throttling kicks in and gets some
> > time for these starving processes?
> 
> You should see something like
> 	sched: RT throttling activated
> 
> once the RT tasks are throttled. Do you?
I just double checked with your 4.14.15-rt12 release. I have not seen
any throtteling messages? (the double "cut here" line is no copy error of mine, but
verbatim kernel output)

Here is the dmesg output of a testrun:

BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 56s!
Showing busy workqueues and worker pools:
workqueue mm_percpu_wq: flags=0x8
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
    pending: vmstat_update
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: CPU: 1 PID: 215 at kernel/workqueue.c:1699 worker_thread+0x390/0x614
Modules linked in: serdes(O)
CPU: 1 PID: 215 Comm: kworker/0:2 Tainted: G           O    4.14.15-rt12 #1
Hardware name: Altera SOCFPGA
[<801116d0>] (unwind_backtrace) from [<8010cae4>] (show_stack+0x20/0x24)
[<8010cae4>] (show_stack) from [<8077ef10>] (dump_stack+0x90/0xa4)
[<8077ef10>] (dump_stack) from [<80120e9c>] (__warn+0xf8/0x110)
[<80120e9c>] (__warn) from [<80120f84>] (warn_slowpath_null+0x30/0x38)
[<80120f84>] (warn_slowpath_null) from [<8013d76c>] (worker_thread+0x390/0x614)
[<8013d76c>] (worker_thread) from [<801437fc>] (kthread+0x13c/0x16c)
[<801437fc>] (kthread) from [<80107f1c>] (ret_from_fork+0x14/0x38)
---[ end trace 0000000000000002 ]---
WARNING: CPU: 0 PID: 3 at kernel/kthread.c:370 __kthread_bind_mask+0x74/0x78
Modules linked in: serdes(O)
CPU: 0 PID: 3 Comm: kworker/0:0 Tainted: G        W  O    4.14.15-rt12 #1
Hardware name: Altera SOCFPGA
[<801116d0>] (unwind_backtrace) from [<8010cae4>] (show_stack+0x20/0x24)
[<8010cae4>] (show_stack) from [<8077ef10>] (dump_stack+0x90/0xa4)
[<8077ef10>] (dump_stack) from [<80120e9c>] (__warn+0xf8/0x110)
[<80120e9c>] (__warn) from [<80120f84>] (warn_slowpath_null+0x30/0x38)
[<80120f84>] (warn_slowpath_null) from [<80143ee4>] (__kthread_bind_mask+0x74/0x78)
[<80143ee4>] (__kthread_bind_mask) from [<80144680>] (kthread_bind_mask+0x1c/0x20)
[<80144680>] (kthread_bind_mask) from [<8013ac4c>] (create_worker+0xec/0x180)
[<8013ac4c>] (create_worker) from [<8013d7d0>] (worker_thread+0x3f4/0x614)
[<8013d7d0>] (worker_thread) from [<801437fc>] (kthread+0x13c/0x16c)
[<801437fc>] (kthread) from [<80107f1c>] (ret_from_fork+0x14/0x38)
---[ end trace 0000000000000003 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3 at kernel/workqueue.c:1657 worker_enter_idle+0x168/0x1d8
Modules linked in: serdes(O)
CPU: 0 PID: 3 Comm: kworker/0:0 Tainted: G        W  O    4.14.15-rt12 #1
Hardware name: Altera SOCFPGA
[<801116d0>] (unwind_backtrace) from [<8010cae4>] (show_stack+0x20/0x24)
[<8010cae4>] (show_stack) from [<8077ef10>] (dump_stack+0x90/0xa4)
[<8077ef10>] (dump_stack) from [<80120e9c>] (__warn+0xf8/0x110)
[<80120e9c>] (__warn) from [<80120f84>] (warn_slowpath_null+0x30/0x38)
[<80120f84>] (warn_slowpath_null) from [<80139964>] (worker_enter_idle+0x168/0x1d8)
[<80139964>] (worker_enter_idle) from [<8013ac78>] (create_worker+0x118/0x180)
[<8013ac78>] (create_worker) from [<8013d7d0>] (worker_thread+0x3f4/0x614)
[<8013d7d0>] (worker_thread) from [<801437fc>] (kthread+0x13c/0x16c)
[<801437fc>] (kthread) from [<80107f1c>] (ret_from_fork+0x14/0x38)
---[ end trace 0000000000000004 ]---

Best regards
Tim

