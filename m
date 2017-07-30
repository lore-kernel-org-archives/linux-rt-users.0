From: Jacek Konieczny <jajcus@jajcus.net>
Subject: System hung for a few minutes on rt kernel
Date: Sun, 30 Jul 2017 19:37:41 +0200
Message-ID: <b9015e55-85fa-9e1c-736a-746c439e635d@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:46398 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbdG3Rhs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Jul 2017 13:37:48 -0400
Received: from [10.253.0.123] (unknown [31.179.132.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id 6AC565002
        for <linux-rt-users@vger.kernel.org>; Sun, 30 Jul 2017 19:37:46 +0200 (CEST)
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have tried yet another RT kernel on my Acer laptop. This time it is
4.4.75 patched with the -rt88 patch.

The system hung again when I started a few applications I would normally
use with RT. This time I have not tried to reboot it immediately and the
system came back to life after a couple of minutes.

>From the kernel logs:

Some time before the hung:

Jul 30 19:01:54 lolek kernel: NOHZ: local_softirq_pending 80

The system locked up around 19:10

Next thing I got in the logs was:

Jul 30 19:12:09 lolek kernel: INFO: task jbd2/dm-4-8:1407 blocked for
more than 120 seconds.
Jul 30 19:12:09 lolek kernel:       Tainted: G        W
4.4.75-rt88-1 #1
Jul 30 19:12:09 lolek kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 30 19:12:09 lolek kernel: jbd2/dm-4-8     D ffff880036a0bac0     0
1407      2 0x00000080
Jul 30 19:12:09 lolek kernel:  ffff880036a0bac0 00ff88008fcb58a0
ffff880243ab0f80 ffff880243978000
Jul 30 19:12:09 lolek kernel:  ffff880036a0c000 ffff880243978000
7fffffffffffffff ffffffff81658de0
Jul 30 19:12:09 lolek kernel:  ffff880036a0bc28 ffff880036a0bae0
ffffffff8165838b 0000000000000000
Jul 30 19:12:09 lolek kernel: Call Trace:
Jul 30 19:12:09 lolek kernel:  [<ffffffff81658de0>] ? bit_wait+0x60/0x60
Jul 30 19:12:09 lolek kernel:  [<ffffffff8165838b>] schedule+0x4b/0xe0
Jul 30 19:12:09 lolek kernel:  [<ffffffff8165a660>]
schedule_timeout+0x1e0/0x290
Jul 30 19:12:09 lolek kernel:  [<ffffffff8135a4f7>] ?
debug_smp_processor_id+0x17/0x20
Jul 30 19:12:09 lolek kernel:  [<ffffffff81081387>] ?
pin_current_cpu+0x87/0x1f0
Jul 30 19:12:09 lolek kernel:  [<ffffffff81658de0>] ? bit_wait+0x60/0x60
Jul 30 19:12:09 lolek kernel:  [<ffffffff81657934>]
io_schedule_timeout+0xa4/0x110
Jul 30 19:12:09 lolek kernel:  [<ffffffff8165b4f7>] ?
rt_spin_unlock+0x27/0x40
Jul 30 19:12:09 lolek kernel:  [<ffffffff81658dfb>] bit_wait_io+0x1b/0x70
Jul 30 19:12:09 lolek kernel:  [<ffffffff816589db>] __wait_on_bit+0x5b/0x90
Jul 30 19:12:09 lolek kernel:  [<ffffffff81658de0>] ? bit_wait+0x60/0x60
Jul 30 19:12:09 lolek kernel:  [<ffffffff81658a92>]
out_of_line_wait_on_bit+0x82/0xb0
Jul 30 19:12:09 lolek kernel:  [<ffffffff810c7070>] ?
autoremove_wake_function+0x40/0x40
Jul 30 19:12:09 lolek kernel:  [<ffffffff812400f7>]
__wait_on_buffer+0x27/0x30
Jul 30 19:12:09 lolek kernel:  [<ffffffffc05ed54e>]
jbd2_journal_commit_transaction+0x113e/0x1ad0 [jbd2]
Jul 30 19:12:09 lolek kernel:  [<ffffffff810efe8a>] ?
try_to_del_timer_sync+0x5a/0x80
Jul 30 19:12:09 lolek kernel:  [<ffffffff8135a4f7>] ?
debug_smp_processor_id+0x17/0x20
Jul 30 19:12:09 lolek kernel:  [<ffffffff81081506>] ?
unpin_current_cpu+0x16/0x70
Jul 30 19:12:09 lolek kernel:  [<ffffffffc05f37aa>]
kjournald2+0xca/0x270 [jbd2]
Jul 30 19:12:09 lolek kernel:  [<ffffffff810c7030>] ?
wake_atomic_t_function+0x60/0x60
Jul 30 19:12:09 lolek kernel:  [<ffffffffc05f36e0>] ?
commit_timeout+0x10/0x10 [jbd2]
Jul 30 19:12:09 lolek kernel:  [<ffffffff810a13d5>] kthread+0xe5/0x100
Jul 30 19:12:09 lolek kernel:  [<ffffffff810a12f0>] ?
kthread_worker_fn+0x170/0x170
Jul 30 19:12:09 lolek kernel:  [<ffffffff8165bc8f>] ret_from_fork+0x3f/0x70
Jul 30 19:12:09 lolek kernel:  [<ffffffff810a12f0>] ?
kthread_worker_fn+0x170/0x170

and few other tasks hung in 'bit_wait' under jbd/ext4.

Then problems from i915 drm driver were reported:

Jul 30 19:12:22 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
Atomic update failure on pipe A (start=40468 end=40469) time 173 us, min
1073, max 1079, scanline start 1068, end 1081
[...]
Jul 30 19:18:46 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
Atomic update failure on pipe A (start=63501 end=63502) time 249 us, min
1073, max 1079, scanline start 1065, end 1081
Jul 30 19:19:58 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
Atomic update failure on pipe A (start=67818 end=67819) time 100 us, min
1073, max 1079, scanline start 1072, end 1080
Jul 30 19:21:33 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
Atomic update failure on pipe A (start=73522 end=73523) time 127 us, min
1073, max 1079, scanline start 1071, end 1080

System seems to be working correctly after the lockup.

Any ideas what is going on?


Jacek
