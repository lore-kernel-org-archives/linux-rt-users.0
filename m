From: Daniel Vidal <danielvidalchornet@gmail.com>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Sun, 26 Feb 2017 12:55:01 +0100
Message-ID: <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com> <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-rt-users@vger.kernel.org
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33232 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbdBZLzE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Feb 2017 06:55:04 -0500
Received: by mail-wr0-f174.google.com with SMTP id m5so16992902wrm.0
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Feb 2017 03:55:03 -0800 (PST)
In-Reply-To: <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

The radeon driver hangs from 3.16 kernel.

RT patch for radeon driver only disable ( preempt_disable_rt() ) and
reenable ( preempt_enable_rt() ) the whole RT in file radeon_display.c

Obviously this is not enough.

I think the radeon developers should make some modification in the
driver but I do not know which is the right place to indicate it

Here my backtrace.

(sorry for my english)


Feb 25 22:24:34 musix64-v3 kernel: [31679.556374] chromium        D
0000000000000002     0  1487   1466 0x00000000
Feb 25 22:24:34 musix64-v3 kernel: [31679.556379]  ffff88008c0e7a20
ffff88004ff55780 ffff8800cfb1e400 00000000000000fd
Feb 25 22:24:34 musix64-v3 kernel: [31679.556382]  0000000000000001
ffff88008c0e8000 0000000000000000 0000000000000002
Feb 25 22:24:34 musix64-v3 kernel: [31679.556384]  ffff88008c0e7ac0
0000000000000002 ffff8800cfb1e400 ffffffff814dc07e
Feb 25 22:24:34 musix64-v3 kernel: [31679.556387] Call Trace:
Feb 25 22:24:34 musix64-v3 kernel: [31679.556393]
[<ffffffff814dc07e>] ? schedule+0x3e/0xc0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556396]
[<ffffffff814dd825>] ? __rt_mutex_slowlock+0x95/0x160
Feb 25 22:24:34 musix64-v3 kernel: [31679.556399]
[<ffffffff814ddde3>] ? rt_mutex_slowlock+0xf3/0x260
Feb 25 22:24:34 musix64-v3 kernel: [31679.556401]
[<ffffffff810584dd>] ? unpin_current_cpu+0xd/0x60
Feb 25 22:24:34 musix64-v3 kernel: [31679.556405]
[<ffffffff8109b01f>] ? rt__down_read+0x1f/0x30
Feb 25 22:24:34 musix64-v3 kernel: [31679.556426]
[<ffffffffa035be37>] ? radeon_cs_ioctl+0x27/0x780 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556429]
[<ffffffff81003427>] ? __switch_to+0x27/0x580
Feb 25 22:24:34 musix64-v3 kernel: [31679.556431]
[<ffffffff814def2e>] ? _raw_spin_unlock_irq+0xe/0x50
Feb 25 22:24:34 musix64-v3 kernel: [31679.556434]
[<ffffffff8107cd98>] ? finish_task_switch+0x88/0x220
Feb 25 22:24:34 musix64-v3 kernel: [31679.556436]
[<ffffffff814db91d>] ? __schedule+0x2bd/0x9e0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556438]
[<ffffffff814dc088>] ? schedule+0x48/0xc0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556440]
[<ffffffff810ccca7>] ? futex_wait_queue_me+0xc7/0x130
Feb 25 22:24:34 musix64-v3 kernel: [31679.556442]
[<ffffffff810ce080>] ? futex_wait+0x210/0x230
Feb 25 22:24:34 musix64-v3 kernel: [31679.556445]
[<ffffffff810cca71>] ? get_futex_key+0x201/0x230
Feb 25 22:24:34 musix64-v3 kernel: [31679.556447]
[<ffffffff8107f574>] ? check_preempt_curr+0x74/0x80
Feb 25 22:24:34 musix64-v3 kernel: [31679.556454]
[<ffffffffa02cf2fe>] ? drm_ioctl+0x10e/0x460 [drm]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556467]
[<ffffffffa035be10>] ? radeon_cs_parser_init+0x480/0x480 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556471]
[<ffffffff810584dd>] ? unpin_current_cpu+0xd/0x60
Feb 25 22:24:34 musix64-v3 kernel: [31679.556481]
[<ffffffffa0328041>] ? radeon_drm_ioctl+0x41/0x70 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556484]
[<ffffffff811a8d4f>] ? do_vfs_ioctl+0x2bf/0x4a0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556487]
[<ffffffff811b24cb>] ? __fget+0x6b/0xb0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556489]
[<ffffffff811a8fa1>] ? SyS_ioctl+0x71/0x80
Feb 25 22:24:34 musix64-v3 kernel: [31679.556491]
[<ffffffff814df597>] ? entry_SYSCALL_64_fastpath+0x12/0x6a
Feb 25 22:24:34 musix64-v3 kernel: [31679.556501] INFO: task
kworker/u12:0:7008 blocked for more than 120 seconds.
Feb 25 22:24:34 musix64-v3 kernel: [31679.556503]       Not tainted
4.4.47-rt59 #1
Feb 25 22:24:34 musix64-v3 kernel: [31679.556504] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 25 22:24:34 musix64-v3 kernel: [31679.556505] kworker/u12:0   D
ffff88011b6e5980     0  7008      2 0x00000000
Feb 25 22:24:34 musix64-v3 kernel: [31679.556520] Workqueue:
radeon-crtc radeon_flip_work_func [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556522]  ffff8800a92dbc38
ffff8800a5f72580 ffff88004ff55780 0000000000000000
Feb 25 22:24:34 musix64-v3 kernel: [31679.556524]  ffff88000011cfc8
ffff8800a92dc000 ffff88000011c000 ffff88000011d6d8
Feb 25 22:24:34 musix64-v3 kernel: [31679.556527]  ffff8800a92dbd18
0000000000000008 ffff88004ff55780 ffffffff814dc07e
Feb 25 22:24:34 musix64-v3 kernel: [31679.556529] Call Trace:
Feb 25 22:24:34 musix64-v3 kernel: [31679.556531]
[<ffffffff814dc07e>] ? schedule+0x3e/0xc0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556534]
[<ffffffff814de417>] ? schedule_timeout+0x177/0x320
Feb 25 22:24:34 musix64-v3 kernel: [31679.556545]
[<ffffffffa0342925>] ? radeon_fence_activity+0xf5/0x160 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556547]
[<ffffffff81058364>] ? pin_current_cpu+0x84/0x1f0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556558]
[<ffffffffa0342f69>] ? radeon_fence_process+0x9/0x30 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556570]
[<ffffffffa03432a8>] ?
radeon_fence_wait_seq_timeout.constprop.8+0x2a8/0x380 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556572]
[<ffffffff81095220>] ? wait_woken+0x80/0x80
Feb 25 22:24:34 musix64-v3 kernel: [31679.556584]
[<ffffffffa0343624>] ? radeon_fence_wait+0x74/0xb0 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556596]
[<ffffffffa0353b55>] ? radeon_flip_work_func+0x255/0x310 [radeon]
Feb 25 22:24:34 musix64-v3 kernel: [31679.556598]
[<ffffffff8107cd98>] ? finish_task_switch+0x88/0x220
Feb 25 22:24:34 musix64-v3 kernel: [31679.556601]
[<ffffffff8107027f>] ? process_one_work+0x14f/0x480
Feb 25 22:24:34 musix64-v3 kernel: [31679.556603]
[<ffffffff81070610>] ? worker_thread+0x60/0x4b0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556605]
[<ffffffff810705b0>] ? process_one_work+0x480/0x480
Feb 25 22:24:34 musix64-v3 kernel: [31679.556608]
[<ffffffff810759ca>] ? kthread+0xca/0xe0
Feb 25 22:24:34 musix64-v3 kernel: [31679.556610]
[<ffffffff81075900>] ? kthread_worker_fn+0x190/0x190
Feb 25 22:24:34 musix64-v3 kernel: [31679.556613]
[<ffffffff814df8df>] ? ret_from_fork+0x3f/0x70
Feb 25 22:24:34 musix64-v3 kernel: [31679.556615]
[<ffffffff81075900>] ? kthread_worker_fn+0x190/0x190

2017-02-24 23:09 GMT+01:00 Wargreen <wargreen@lebib.org>:
> Thank you for your reply.
>> It looks like some other task holding the mutex resulting
>> these tasks to sleep and hung the system.
>>
>> One step to debug this is to find out which task is holding
>> the mutex and for how long? Taking crash of hung system
>> and see whats going on is one way but a harsh one
> Because my bad english and my light technical background, i don't
> understand how can i find this task.
> Can you guide me ?
>
>> Another step is start with version where it was working before?
>> and try to bisect or narrow down.
> From memory, it's happen with 4.0.4, 4.1.3 and 4.9.0, on two computers
> (both with intel CPU). So i don't know if it was worked one day.
>
>> Others might have better ideas.
> I take all ideas !
> It's my workstation (as well as my all-day computer) for real time audio
> processing so i'm open to alls test who can fix this problem.
>
> Is it the best place, or i should also post on the radeon mailing ?
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
