From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Wed, 14 Oct 2015 11:08:38 +0200
Message-ID: <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35654 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbJNJIk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 05:08:40 -0400
Received: by lbwr8 with SMTP id r8so41254760lbw.2
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 02:08:38 -0700 (PDT)
In-Reply-To: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 13, 2015 at 5:35 PM, Christoph Mathys <eraserix@gmail.com> wrote:
> Can anyone reproduce this? Any ideas? dmesg does not contain any funny
> reports...

It is actually not true that there are no funny reports. After
enabling more debug options I now get the BUG below once per second.
There are other callpaths than the one below that trigger this
message, but they all go through the function
intel_pipe_update_start().

[   17.694307] BUG: sleeping function called from invalid context at
kernel/locking/rtmutex.c:917
[   17.694308] in_atomic(): 0, irqs_disabled(): 1, pid: 102, name: kworker/3:1
[   17.694309] 2 locks held by kworker/3:1/102:
[   17.694326]  #0:  ("events"){.+.+.+}, at: [<ffffffff81079e60>]
process_one_work+0x170/0x8b0
[   17.694328]  #1:  ((&intel_crtc->mmio_flip.work)){+.+...}, at:
[<ffffffff81079e60>] process_one_work+0x170/0x8b0
[   17.694329] irq event stamp: 21082
[   17.694330] hardirqs last  enabled at (21081): [<ffffffff810ed791>]
ktime_get_raw+0x61/0x100
[   17.694347] hardirqs last disabled at (21082): [<ffffffffa02fabf3>]
intel_pipe_update_start+0x113/0x640 [i915]
[   17.694349] softirqs last  enabled at (0): [<ffffffff81057591>]
copy_process.part.34+0x5e1/0x1d50
[   17.694350] softirqs last disabled at (0): [<          (null)>]
      (null)
[   17.694351] CPU: 3 PID: 102 Comm: kworker/3:1 Tainted: G
E   4.1.7-realtime-2-rt8 #2
[   17.694352] Hardware name: Komax AG, Dierikon Komax-PC/KMX-B75,
BIOS DD3-1-1D 08/21/2013
[   17.694364] Workqueue: events intel_mmio_flip_work_func [i915]
[   17.694365]  ffffffff81c84a33 ffff8803fbf4fb98 ffffffff817f961d
0000000000000002
[   17.694366]  ffff8803fbf60000 ffff8803fbf4fbc8 ffffffff8108785a
ffff8803fbf4fbc8
[   17.694367]  ffff880036510808 ffff880036510808 0000000000000002
ffff8803fbf4fbf8
[   17.694367] Call Trace:
[   17.694370]  [<ffffffff817f961d>] dump_stack+0x4a/0x61
[   17.694372]  [<ffffffff8108785a>] ___might_sleep+0x13a/0x200
[   17.694373]  [<ffffffff81800f24>] rt_spin_lock+0x24/0x60
[   17.694374]  [<ffffffff8108bbac>] ? migrate_disable+0x6c/0xe0
[   17.694375]  [<ffffffff810a9bab>] prepare_to_wait+0x2b/0xa0
[   17.694386]  [<ffffffffa02faca8>] intel_pipe_update_start+0x1c8/0x640 [i915]
[   17.694387]  [<ffffffff810aa070>] ? prepare_to_wait_event+0x130/0x130
[   17.694396]  [<ffffffffa02dcf04>] intel_mmio_flip_work_func+0x64/0x310 [i915]
[   17.694397]  [<ffffffff810b2d2f>] ? __lock_is_held+0x5f/0x90
[   17.694399]  [<ffffffff81079f0f>] process_one_work+0x21f/0x8b0
[   17.694400]  [<ffffffff81079e60>] ? process_one_work+0x170/0x8b0
[   17.694402]  [<ffffffff8107a709>] worker_thread+0x169/0x4e0
[   17.694404]  [<ffffffff8107a5a0>] ? process_one_work+0x8b0/0x8b0
[   17.694405]  [<ffffffff81081054>] kthread+0xe4/0x100
[   17.694406]  [<ffffffff810b5a4d>] ? trace_hardirqs_on+0xd/0x10
[   17.694407]  [<ffffffff81080f70>] ? kthread_create_on_node+0x240/0x240
[   17.694409]  [<ffffffff81801d62>] ret_from_fork+0x42/0x70
[   17.694410]  [<ffffffff81080f70>] ? kthread_create_on_node+0x240/0x240
