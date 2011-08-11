From: =?UTF-8?B?VG9iaWFzIFJpbmdzdHLDtm0=?= <tobias@ringis.se>
Subject: 3.0.1-rt8 BUG at kernel/rtmutex_common.h:75
Date: Thu, 11 Aug 2011 10:10:51 +0200
Message-ID: <4E438E8B.3020405@ringis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:32892 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1HKInv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Aug 2011 04:43:51 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 61040EB1B7
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2011 10:10:56 +0200 (CEST)
Received: from h109-225-111-194.static.se.alltele.net ([109.225.111.194] helo=tobiaspc.swedot.local)
	by ringis.se with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <tobias@ringis.se>)
	id 1QrQLr-0002qM-P9
	for linux-rt-users@vger.kernel.org; Thu, 11 Aug 2011 10:10:55 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm hitting the following BUG after a few minutes of application 
execution.  Is there anything I can do to help track this down?

/Tobias

> [ 1148.792450] ------------[ cut here ]------------
> [ 1148.792458] kernel BUG at kernel/rtmutex_common.h:75!
> [ 1148.792464] invalid opcode: 0000 [#1] PREEMPT SMP
> [ 1148.792469] Modules linked in:
> [ 1148.792474]
> [ 1148.792480] Pid: 2074, comm: fb-lbgui Not tainted 3.0.1-rt8 #17 ICP / iEi H570/E218
> [ 1148.792489] EIP: 0060:[<c106ff5c>] EFLAGS: 00010292 CPU: 1
> [ 1148.792501] EIP is at remove_waiter+0x14c/0x150
> [ 1148.792506] EAX: f5efc1c0 EBX: f5efc1c8 ECX: f5c65a90 EDX: f55afe8c
> [ 1148.792511] ESI: f55afe8c EDI: f55afe8c EBP: f60dde5c ESP: f60dde30
> [ 1148.792516]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [ 1148.792523] Process fb-lbgui (pid: 2074, ti=f60dc000 task=f6046030 task.ti=f60dc000)
> [ 1148.792527] Stack:
> [ 1148.792530]  c106dd37 f6046440 f60dde44 c103478b 00000001 f5efc1cc f5efc1c0 f6046031
> [ 1148.792540]  f5efc1c8 fffffff5 f55afe8c f60dde74 c1070349 00000001 f55afe54 c197a4ac
> [ 1148.792550]  00000001 f60ddedc c106e602 00000001 f5c65a90 00000000 00000000 00000000
> [ 1148.792559] Call Trace:
> [ 1148.792567]  [<c106dd37>] ? lookup_pi_state+0x177/0x240
> [ 1148.792576]  [<c103478b>] ? get_parent_ip+0xb/0x40
> [ 1148.792583]  [<c1070349>] rt_mutex_start_proxy_lock+0x59/0xa0
> [ 1148.792591]  [<c106e602>] futex_requeue+0x422/0x740
> [ 1148.792600]  [<c106edd8>] do_futex+0x78/0x910
> [ 1148.792607]  [<c10e9805>] ? fget_light+0x55/0xd0
> [ 1148.792616]  [<c14d0444>] ? sockfd_lookup_light+0x24/0x80
> [ 1148.792624]  [<c106f6d9>] sys_futex+0x69/0x120
> [ 1148.792632]  [<c123df1e>] ? copy_to_user+0x2e/0x50
> [ 1148.792639]  [<c105aad4>] ? sys_clock_gettime+0x54/0x90
> [ 1148.792648]  [<c1639d01>] syscall_call+0x7/0xb
> [ 1148.792656]  [<c1630000>] ? cache_add_dev+0x9e/0x2fb
> [ 1148.792660] Code: c1 89 4d dc e8 76 9a 5c 00 8b 4d dc e9 49 ff ff ff ba 56 02 00 00 b8 6b f9 79 c1 89 4d dc e8 cc d5 fc ff 8b 4d dc e9 3b ff ff ff <0f> 0b 66 90 55 89 e5 57 89 c7 56 89 ce 53 89 d3 83 ec 20 8b 40
> [ 1148.792708] EIP: [<c106ff5c>] remove_waiter+0x14c/0x150 SS:ESP 0068:f60dde30
> [ 1148.796388] ---[ end trace 0000000000000002 ]---
> [ 1148.796396] note: fb-lbgui[2074] exited with preempt_count 1
> [ 1148.796414] ------------[ cut here ]------------
> [ 1148.796419] kernel BUG at kernel/rtmutex.c:724!
> [ 1148.796423] invalid opcode: 0000 [#2] PREEMPT SMP
> [ 1148.796428] Modules linked in:
> [ 1148.796432]
> [ 1148.796437] Pid: 2074, comm: fb-lbgui Tainted: G      D     3.0.1-rt8 #17 ICP / iEi H570/E218
> [ 1148.796445] EIP: 0060:[<c16394e0>] EFLAGS: 00010246 CPU: 1
> [ 1148.796452] EIP is at rt_spin_lock_slowlock+0x150/0x170
> [ 1148.796457] EAX: f6046030 EBX: c19798e0 ECX: c19798ec EDX: f6046030
> [ 1148.796462] ESI: f6046030 EDI: f6046030 EBP: f60ddc3c ESP: f60ddbf0
> [ 1148.796468]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [ 1148.796474] Process fb-lbgui (pid: 2074, ti=f60dc000 task=f6046030 task.ti=f60dc000)
> [ 1148.796478] Stack:
> [ 1148.796480]  00000001 c1790006 00000006 f6046030 f6046030 f60ddc18 c1037c09 f6c40bc0
> [ 1148.796490]  f6c40bc8 00000005 f60ddc68 c10e4c64 00000003 00000000 f6046030 f60ddc01
> [ 1148.796500]  f5efc1c0 f6046030 c19798e0 f60ddc44 c16397a0 f60ddc6c c106e9a9 f60464e0
> [ 1148.796509] Call Trace:
> [ 1148.796518]  [<c1037c09>] ? migrate_enable+0xe9/0x120
> [ 1148.796526]  [<c10e4c64>] ? cache_alloc_refill+0x1c4/0x590
> [ 1148.796534]  [<c16397a0>] rt_spin_lock+0x20/0x30
> [ 1148.796541]  [<c106e9a9>] exit_pi_state_list+0x89/0x130
> [ 1148.796549]  [<c103b1b1>] mm_release+0xc1/0xe0
> [ 1148.796556]  [<c1037c09>] ? migrate_enable+0xe9/0x120
> [ 1148.796563]  [<c103f2d8>] exit_mm+0x18/0x120
> [ 1148.796570]  [<c1040caf>] do_exit+0x12f/0x840
> [ 1148.796578]  [<c103ed58>] ? kmsg_dump+0x98/0xc0
> [ 1148.796584]  [<c163753c>] ? printk+0x18/0x1a
> [ 1148.796592]  [<c1005c36>] oops_end+0x86/0xc0
> [ 1148.796599]  [<c1005dcf>] die+0x4f/0x70
> [ 1148.796605]  [<c1002d16>] do_trap+0x96/0xd0
> [ 1148.796611]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.796617]  [<c1003036>] do_invalid_op+0x86/0xa0
> [ 1148.796625]  [<c106ff5c>] ? remove_waiter+0x14c/0x150
> [ 1148.796632]  [<c1239d58>] ? timerqueue_del+0x28/0x70
> [ 1148.796639]  [<c103478b>] ? get_parent_ip+0xb/0x40
> [ 1148.796645]  [<c1034833>] ? sub_preempt_count+0x73/0xb0
> [ 1148.796652]  [<c16399c1>] ? _raw_spin_unlock_irqrestore+0x11/0x30
> [ 1148.796659]  [<c105f657>] ? hrtimer_try_to_cancel+0x37/0xe0
> [ 1148.796666]  [<c105fde6>] ? hrtimer_cancel+0x16/0x20
> [ 1148.796673]  [<c106d88d>] ? futex_wait_requeue_pi+0x24d/0x410
> [ 1148.796681]  [<c163a302>] error_code+0x5a/0x60
> [ 1148.796689]  [<c103007b>] ? select_task_rq_fair+0x5b/0x990
> [ 1148.796696]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.796702]  [<c106ff5c>] ? remove_waiter+0x14c/0x150
> [ 1148.796709]  [<c106dd37>] ? lookup_pi_state+0x177/0x240
> [ 1148.796715]  [<c103478b>] ? get_parent_ip+0xb/0x40
> [ 1148.796723]  [<c1070349>] rt_mutex_start_proxy_lock+0x59/0xa0
> [ 1148.796730]  [<c106e602>] futex_requeue+0x422/0x740
> [ 1148.796739]  [<c106edd8>] do_futex+0x78/0x910
> [ 1148.796746]  [<c10e9805>] ? fget_light+0x55/0xd0
> [ 1148.796754]  [<c14d0444>] ? sockfd_lookup_light+0x24/0x80
> [ 1148.796762]  [<c106f6d9>] sys_futex+0x69/0x120
> [ 1148.796769]  [<c123df1e>] ? copy_to_user+0x2e/0x50
> [ 1148.796776]  [<c105aad4>] ? sys_clock_gettime+0x54/0x90
> [ 1148.796783]  [<c1639d01>] syscall_call+0x7/0xb
> [ 1148.796791]  [<c1630000>] ? cache_add_dev+0x9e/0x2fb
> [ 1148.796795] Code: 45 cc 39 45 cc 75 34 89 d8 e8 1d 05 00 00 83 c4 40 5b 5e 5f 5d c3 90 8d 74 26 00 83 63 0c fe 8d 45 cc 39 45 cc 74 e0 eb 12 0f 0b <0f> 0b 8d 43 04 89 43 04 89 43 08 e9 cd fe ff ff 0f 0b 0f 0b 0f
> [ 1148.796844] EIP: [<c16394e0>] rt_spin_lock_slowlock+0x150/0x170 SS:ESP 0068:f60ddbf0
> [ 1148.978804] ---[ end trace 0000000000000003 ]---
> [ 1148.978809] Fixing recursive fault but reboot is needed!
> [ 1148.978815] BUG: scheduling while atomic: fb-lbgui/2074/0x00000003
> [ 1148.978819] Modules linked in:
> [ 1148.978825] Pid: 2074, comm: fb-lbgui Tainted: G      D     3.0.1-rt8 #17
> [ 1148.978830] Call Trace:
> [ 1148.978839]  [<c102e9f9>] __schedule_bug+0x59/0x60
> [ 1148.978847]  [<c1637c67>] __schedule+0x657/0x790
> [ 1148.978857]  [<c1037a90>] schedule+0x20/0x80
> [ 1148.978864]  [<c104138c>] do_exit+0x80c/0x840
> [ 1148.978871]  [<c103ed58>] ? kmsg_dump+0x98/0xc0
> [ 1148.978878]  [<c163753c>] ? printk+0x18/0x1a
> [ 1148.978885]  [<c1005c36>] oops_end+0x86/0xc0
> [ 1148.978891]  [<c1005dcf>] die+0x4f/0x70
> [ 1148.978898]  [<c1002d16>] do_trap+0x96/0xd0
> [ 1148.978904]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.978910]  [<c1003036>] do_invalid_op+0x86/0xa0
> [ 1148.978917]  [<c16394e0>] ? rt_spin_lock_slowlock+0x150/0x170
> [ 1148.978925]  [<c123a294>] ? put_dec+0x94/0xa0
> [ 1148.978932]  [<c123b3f6>] ? number.clone.1+0x2d6/0x2f0
> [ 1148.978941]  [<c1062083>] ? sched_clock_local+0xd3/0x1c0
> [ 1148.978949]  [<c163a302>] error_code+0x5a/0x60
> [ 1148.978956]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.978962]  [<c16394e0>] ? rt_spin_lock_slowlock+0x150/0x170
> [ 1148.978970]  [<c1037c09>] ? migrate_enable+0xe9/0x120
> [ 1148.978978]  [<c10e4c64>] ? cache_alloc_refill+0x1c4/0x590
> [ 1148.978985]  [<c16397a0>] rt_spin_lock+0x20/0x30
> [ 1148.978992]  [<c106e9a9>] exit_pi_state_list+0x89/0x130
> [ 1148.979000]  [<c103b1b1>] mm_release+0xc1/0xe0
> [ 1148.979025]  [<c1037c09>] ? migrate_enable+0xe9/0x120
> [ 1148.979036]  [<c103f2d8>] exit_mm+0x18/0x120
> [ 1148.979047]  [<c1040caf>] do_exit+0x12f/0x840
> [ 1148.979056]  [<c103ed58>] ? kmsg_dump+0x98/0xc0
> [ 1148.979062]  [<c163753c>] ? printk+0x18/0x1a
> [ 1148.979070]  [<c1005c36>] oops_end+0x86/0xc0
> [ 1148.979076]  [<c1005dcf>] die+0x4f/0x70
> [ 1148.979082]  [<c1002d16>] do_trap+0x96/0xd0
> [ 1148.979088]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.979094]  [<c1003036>] do_invalid_op+0x86/0xa0
> [ 1148.979102]  [<c106ff5c>] ? remove_waiter+0x14c/0x150
> [ 1148.979109]  [<c1239d58>] ? timerqueue_del+0x28/0x70
> [ 1148.979115]  [<c103478b>] ? get_parent_ip+0xb/0x40
> [ 1148.979121]  [<c1034833>] ? sub_preempt_count+0x73/0xb0
> [ 1148.979128]  [<c16399c1>] ? _raw_spin_unlock_irqrestore+0x11/0x30
> [ 1148.979135]  [<c105f657>] ? hrtimer_try_to_cancel+0x37/0xe0
> [ 1148.979142]  [<c105fde6>] ? hrtimer_cancel+0x16/0x20
> [ 1148.979149]  [<c106d88d>] ? futex_wait_requeue_pi+0x24d/0x410
> [ 1148.979156]  [<c163a302>] error_code+0x5a/0x60
> [ 1148.979163]  [<c103007b>] ? select_task_rq_fair+0x5b/0x990
> [ 1148.979170]  [<c1002fb0>] ? do_bounds+0x80/0x80
> [ 1148.979176]  [<c106ff5c>] ? remove_waiter+0x14c/0x150
> [ 1148.979183]  [<c106dd37>] ? lookup_pi_state+0x177/0x240
> [ 1148.979189]  [<c103478b>] ? get_parent_ip+0xb/0x40
> [ 1148.979197]  [<c1070349>] rt_mutex_start_proxy_lock+0x59/0xa0
> [ 1148.979204]  [<c106e602>] futex_requeue+0x422/0x740
> [ 1148.979213]  [<c106edd8>] do_futex+0x78/0x910
> [ 1148.979220]  [<c10e9805>] ? fget_light+0x55/0xd0
> [ 1148.979227]  [<c14d0444>] ? sockfd_lookup_light+0x24/0x80
> [ 1148.979236]  [<c106f6d9>] sys_futex+0x69/0x120
> [ 1148.979242]  [<c123df1e>] ? copy_to_user+0x2e/0x50
> [ 1148.979250]  [<c105aad4>] ? sys_clock_gettime+0x54/0x90
> [ 1148.979257]  [<c1639d01>] syscall_call+0x7/0xb
> [ 1148.979265]  [<c1630000>] ? cache_add_dev+0x9e/0x2fb
