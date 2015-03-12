From: Carsten Emde <C.Emde@osadl.org>
Subject: [OSADL QA 3.18.9-rt4 #1] Radeon driver hangs
Date: Fri, 13 Mar 2015 00:23:42 +0100
Message-ID: <55021FFE.904@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:34980 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbbCLXbL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 19:31:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(About 30 OSADL QA Farm systems are now running 3.18.9-rt4. BTW: To 
check out what kernels are under test you may sort the kernel list 
(https://www.osadl.org/?id=933) by kernel version 
(https://www.osadl.org/?id=1001) and scroll down the page.)

The most striking problem of kernel 3.18.9-rt4 affects all systems that 
are equipped with Radeon graphics (irrespective whether PCIe cards or 
APUs with on-chip graphics). They suffer from a hanging radeon driver. 
The block occurs when accelerated graphics load is created by x11perf or 
gltestperf. Sometimes only the graphics are frozen while ssh login still 
is possible, somtimes the entire box is no longer accessible at all. In 
any case, a reboot is needed to recover from this situation.

Here is a selection of kernel messages:

Rack #0/Slot #3 [AMD/ATI] RV730 XT [Radeon HD 4670]:
[16081.272035] INFO: task kworker/u24:4:268 blocked for more than 120 
seconds.
[16081.285776]       Not tainted 3.18.9-rt4 #26
[16081.294286] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[16081.309901] kworker/u24:4   D ffff88081ed8b340     0   268      2 
0x10000000
[16081.309938] Workqueue: radeon-crtc radeon_flip_work_func [radeon]
[16081.309960]  ffff880805ccfbe8 0000000000000046 ffff88081ed0c700 
0000000000000000
[16081.309962]  0000000000009000 000000000000c920 ffff8808112fb420 
ffff880805cc1a10
[16081.309963]  ffff880805ccfbf8 000001008108a0da ffff880805ccfc98 
ffff880805cc1a10
[16081.309966] Call Trace:
[16081.309972]  [<ffffffff81721ce4>] schedule+0x34/0xa0
[16081.309974]  [<ffffffff8172425c>] schedule_timeout+0x22c/0x2d0
[16081.309984]  [<ffffffffa046ca86>] ? radeon_fence_process+0x16/0x40 
[radeon]
[16081.309993]  [<ffffffffa046caf4>] ? 
radeon_fence_any_seq_signaled+0x44/0x90 [radeon]
[16081.310001]  [<ffffffffa046ce27>] 
radeon_fence_wait_seq_timeout.constprop.8+0x2e7/0x340 [radeon]
[16081.310004]  [<ffffffff81098be0>] ? __wake_up_sync+0x20/0x20
[16081.310013]  [<ffffffffa046d186>] radeon_fence_wait+0x86/0xc0 [radeon]
[16081.310023]  [<ffffffffa047af6c>] radeon_flip_work_func+0x15c/0x190 
[radeon]
[16081.310025]  [<ffffffff810709c4>] process_one_work+0x154/0x450
[16081.310026]  [<ffffffff81070fbb>] worker_thread+0x6b/0x4d0
[16081.310028]  [<ffffffff81070f50>] ? rescuer_thread+0x290/0x290
[16081.310029]  [<ffffffff81075fed>] kthread+0xcd/0xf0
[16081.310031]  [<ffffffff81075f20>] ? kthread_worker_fn+0x1d0/0x1d0
[16081.310034]  [<ffffffff81725aec>] ret_from_fork+0x7c/0xb0
[16081.310035]  [<ffffffff81075f20>] ? kthread_worker_fn+0x1d0/0x1d0


Rack #0/Slot #7 [AMD/ATI] Cayman XT [Radeon HD 6970]:
INFO: task Xorg:10038 blocked for more than 120 seconds.
      Not tainted 3.18.9-rt4 #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Xorg            D ffffffff816b7f88     0 10038  10032 0x10400004
ffff8800c5ad78e8 0000000000000002 ffff88041e80c460 000000000000c5c8
ffff88041e80c5c8 0000000000000002 000000000000c5a8 000000000000c5c8
ffff880417728000 ffff880414010000 000000000000000c ffff880414010000
Call Trace:
[<ffffffff816b50f4>] schedule+0x34/0xa0
[<ffffffff816b72f4>] schedule_timeout+0x204/0x270
[<ffffffffa00cd8e6>] ? radeon_fence_process+0x16/0x40 [radeon]
[<ffffffffa00cd954>] ? radeon_fence_any_seq_signaled+0x44/0x90 [radeon]
[<ffffffffa00cdbc7>] 
radeon_fence_wait_seq_timeout.constprop.7+0x227/0x330 [radeon]
[<ffffffff810ac310>] ? prepare_to_wait_event+0x110/0x110
[<ffffffffa00ce027>] radeon_fence_wait_any+0x57/0x70 [radeon]
[<ffffffffa014334f>] radeon_sa_bo_new+0x2cf/0x4e0 [radeon]
[<ffffffff8133c2a7>] ? debug_smp_processor_id+0x17/0x20
[<ffffffffa019d477>] radeon_ib_get+0x37/0xf0 [radeon]
[<ffffffffa00e9a3d>] radeon_cs_ioctl+0x22d/0x820 [radeon]
[<ffffffffa001bc04>] drm_ioctl+0x1a4/0x630 [drm]
[<ffffffff8133c2a7>] ? debug_smp_processor_id+0x17/0x20
[<ffffffff8106e8da>] ? unpin_current_cpu+0x1a/0x70
[<ffffffff81097440>] ? migrate_enable+0xb0/0x1b0
[<ffffffffa00b004b>] radeon_drm_ioctl+0x4b/0x80 [radeon]
[<ffffffff811c7040>] do_vfs_ioctl+0x2e0/0x4d0
[<ffffffff811d1aa2>] ? __fget+0x72/0xa0
[<ffffffff811c72b1>] SyS_ioctl+0x81/0xa0
[<ffffffff816b8cb2>] tracesys_phase2+0xd4/0xd9


Rack #4/Slot #1 Chipset: "KAVERI" (ChipID = 0x130c)
[  600.266245] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  600.281856] Xorg            D 0000000000000002     0  3821   3812 
0x00400080
[  600.281865]  ffff880223ddf908 0000000000000082 000000000000c1c0 
000000000000c328
[  600.281867]  ffff88023720c328 0000000000000002 000000000000c308 
000000000000c328
[  600.281869]  ffffffff81c1b480 ffff880036cfcb60 000000000000000c 
ffff880036cfcb60
[  600.281873] Call Trace:
[  600.281882]  [<ffffffff81736a14>] schedule+0x34/0xa0
[  600.281885]  [<ffffffff81738a44>] schedule_timeout+0x204/0x270
[  600.281929]  [<ffffffffa00b8756>] ? radeon_fence_process+0x16/0x40 
[radeon]
[  600.281949]  [<ffffffffa00b87c4>] ? 
radeon_fence_any_seq_signaled+0x44/0x90 [radeon]
[  600.281968]  [<ffffffffa00b8a37>] 
radeon_fence_wait_seq_timeout.constprop.7+0x227/0x330 [radeon]
[  600.281972]  [<ffffffff810815c0>] ? prepare_to_wait_event+0x110/0x110
[  600.281992]  [<ffffffffa00b8e97>] radeon_fence_wait_any+0x57/0x70 
[radeon]
[  600.282023]  [<ffffffffa012df5f>] radeon_sa_bo_new+0x2cf/0x4e0 [radeon]
[  600.282027]  [<ffffffff81077a1e>] ? dequeue_task_fair+0x43e/0x650
[  600.282055]  [<ffffffffa0188087>] radeon_ib_get+0x37/0xf0 [radeon]
[  600.282078]  [<ffffffffa00d46bd>] radeon_cs_ioctl+0x22d/0x820 [radeon]
[  600.282098]  [<ffffffffa000ec04>] drm_ioctl+0x1a4/0x630 [drm]
[  600.282104]  [<ffffffff810b2489>] ? do_futex+0x109/0xb20
[  600.282106]  [<ffffffff810787c6>] ? put_prev_entity+0x96/0x3f0
[  600.282122]  [<ffffffffa009b00e>] radeon_drm_ioctl+0xe/0x10 [radeon]
[  600.282125]  [<ffffffff81190db0>] do_vfs_ioctl+0x2e0/0x4d0
[  600.282128]  [<ffffffff8119b792>] ? __fget+0x72/0xa0
[  600.282131]  [<ffffffff81191021>] SyS_ioctl+0x81/0xa0
[  600.282134]  [<ffffffff810d45c6>] ? __audit_syscall_exit+0x236/0x2e0
[  600.282137]  [<ffffffff8173a1d6>] system_call_fastpath+0x16/0x1b
