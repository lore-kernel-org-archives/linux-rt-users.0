From: Vikram <vikram186@gmail.com>
Subject: Kernel module crashed in 2.6.33.7-rt30
Date: Tue, 25 Jan 2011 13:09:20 +0530
Message-ID: <1295941160.4853.0.camel@vikram-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43949 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab1AYHjq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Jan 2011 02:39:46 -0500
Received: by yib18 with SMTP id 18so1594540yib.19
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jan 2011 23:39:45 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,
I am using linux 2.6.33.7.2-rt30 for running my kernel module.
The kernel module is an Ethernet based protocol stack. 
I am setting the following priorities before loading the module

81 for sirq-hrtimer/1
81 for sirq-hrtimer/1
80 for the Ethernet Interrupt
using the command 'chrt -f -p 81'

The module runs fine for some time, but stops after an hour or so.
This is what I got from the dmesg

START TRACE 

[ 3353.564157] BUG: unable to handle kernel NULL pointer dereference at
(null)
[ 3353.564167] IP: [<c015d6dc>] exit_creds+0xc/0x80
[ 3353.564178] *pde = 00000000 
[ 3353.564183] Oops: 0000 [#1] PREEMPT SMP 
[ 3353.564190] last sysfs
file: /sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:1/3:0:1:0/block/sda/sda5/uevent
[ 3353.564195] Modules linked in: binfmt_misc snd_hda_codec_idt
snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss fbcon
tileblit font bitblit softcursor snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq i915 snd_timer
snd_seq_device drm_kms_helper ppdev snd intel_agp drm i2c_algo_bit lp
soundcore video parport_pc snd_page_alloc agpgart output parport usbhid
8139too 8139cp mii [last unloaded: epl]
[ 3353.564251] 
[ 3353.564256] Pid: 28, comm: sirq-rcu/1 Not tainted 2.6.33.7.2-rt30 #1
D945GCL/        
[ 3353.564261] EIP: 0060:[<c015d6dc>] EFLAGS: 00010287 CPU: 1
[ 3353.564266] EIP is at exit_creds+0xc/0x80
[ 3353.564269] EAX: 00000000 EBX: f321e030 ECX: f70b8370 EDX: f321e558
[ 3353.564273] ESI: 00000000 EDI: 00000003 EBP: f70bff24 ESP: f70bff20
[ 3353.564278]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
preempt:00000000
[ 3353.564283] Process sirq-rcu/1 (pid: 28, ti=f70be000 task=f70b8370
task.ti=f70be000)
[ 3353.564286] Stack:
[ 3353.564289]  f321e030 f70bff30 c013f088 c45038a0 f70bff38 c013f0dd
f70bff5c c019067c
[ 3353.564300] <0> 00000292 c0701d40 c45038b8 f321e558 c45034f0 00000001
00000200 f70bff64
[ 3353.564311] <0> c01908a0 f70bffa4 c0146e90 0000001c 00000001 f70bff94
f70b8370 f70b8370
[ 3353.564324] Call Trace:
[ 3353.564331]  [<c013f088>] ? __put_task_struct+0x28/0x70
[ 3353.564337]  [<c013f0dd>] ? __put_task_struct_cb+0xd/0x10
[ 3353.564343]  [<c019067c>] ? __rcu_process_callbacks+0xfc/0x2d0
[ 3353.564349]  [<c01908a0>] ? rcu_process_callbacks+0x50/0x60
[ 3353.564355]  [<c0146e90>] ? run_ksoftirqd+0x160/0x2b0
[ 3353.564361]  [<c0146d30>] ? run_ksoftirqd+0x0/0x2b0
[ 3353.564367]  [<c01566dc>] ? kthread+0x6c/0x80
[ 3353.564373]  [<c0156670>] ? kthread+0x0/0x80
[ 3353.564379]  [<c0103586>] ? kernel_thread_helper+0x6/0x10
[ 3353.564382] Code: ff 89 c8 f7 d0 85 d0 0f 84 04 ff ff ff e9 c2 fe ff
ff 0f 0b eb fe 0f 0b eb fe 90 8d 74 26 00 55 89 e5 53 89 c3 8b 80 04 03
00 00 <8b> 00 8b 83 00 03 00 00 c7 83 00 03 00 00 00 00 00 00 f0 ff 08 
[ 3353.564449] EIP: [<c015d6dc>] exit_creds+0xc/0x80 SS:ESP
0068:f70bff20
[ 3353.564457] CR2: 0000000000000000
[ 3353.564461] ---[ end trace d828fbbe13057d5e ]---
[ 3353.565145] NOHZ: local_softirq_pending 200
[ 3353.566142] NOHZ: local_softirq_pending 200
[ 3353.567141] NOHZ: local_softirq_pending 200
[ 3353.568452] NOHZ: local_softirq_pending 200
[ 3353.568600] NOHZ: local_softirq_pending 200
[ 3353.568713] NOHZ: local_softirq_pending 200
[ 3353.568967] NOHZ: local_softirq_pending 200
[ 3353.571204] NOHZ: local_softirq_pending 200
[ 3353.572146] NOHZ: local_softirq_pending 200
[ 3353.573142] NOHZ: local_softirq_pending 200
[ 3354.060112] BUG: unable to handle kernel paging request at fff2f2f8
[ 3354.060121] IP: [<c0523e80>] rt_spin_lock_slowlock+0xc0/0x250
[ 3354.060126] *pde = 007c6067 *pte = 00000000 
[ 3354.060126] Oops: 0002 [#2] PREEMPT SMP 
[ 3354.060126] last sysfs
file: /sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:1/3:0:1:0/block/sda/sda5/uevent
[ 3354.060126] Modules linked in: binfmt_misc snd_hda_codec_idt
snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss fbcon
tileblit font bitblit softcursor snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq i915 snd_timer
snd_seq_device drm_kms_helper ppdev snd intel_agp drm i2c_algo_bit lp
soundcore video parport_pc snd_page_alloc agpgart output parport usbhid
8139too 8139cp mii [last unloaded: epl]
[ 3354.060126] 
[ 3354.060126] Pid: 27, comm: sirq-hrtimer/1 Tainted: G      D
2.6.33.7.2-rt30 #1 D945GCL/        
[ 3354.060126] EIP: 0060:[<c0523e80>] EFLAGS: 00010086 CPU: 1
[ 3354.060126] EIP is at rt_spin_lock_slowlock+0xc0/0x250
[ 3354.060126] EAX: f70b9060 EBX: f95fb500 ECX: f70b9060 EDX: 00000000
[ 3354.060126] ESI: fff2f2f0 EDI: 00000000 EBP: f70bbed8 ESP: f70bbe74
[ 3354.060126]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
preempt:00000001
[ 3354.060126] Process sirq-hrtimer/1 (pid: 27, ti=f70ba000
task=f70b9060 task.ti=f70ba000)
[ 3354.060126] Stack:
[ 3354.060126]  00000000 00000286 f95fb50c f70b9060 f70b9060 f70b9060
f70b9060 ffffffff
[ 3354.060126] <0> 00000286 00000012 f95fb504 f95fb504 f95fb50c f95fb50c
00000012 f321e488
[ 3354.060126] <0> f321e488 f321e490 f321e490 f70b9060 f95fb500 00000000
f95ff578 fffffff4
[ 3354.060126] Call Trace:
[ 3354.060126]  [<c0524820>] ? rt_spin_lock+0x30/0x50
[ 3354.060126]  [<c0130c3a>] ? __wake_up+0x3a/0x50
[ 3354.060126]  [<c015a64c>] ? run_hrtimer_softirq+0x8c/0x190
[ 3354.060126]  [<c0146e90>] ? run_ksoftirqd+0x160/0x2b0
[ 3354.060126]  [<c0146d30>] ? run_ksoftirqd+0x0/0x2b0
[ 3354.060126]  [<c01566dc>] ? kthread+0x6c/0x80
[ 3354.060126]  [<c0156670>] ? kthread+0x0/0x80
[ 3354.060126]  [<c0103586>] ? kernel_thread_helper+0x6/0x10
[ 3354.060126] Code: b8 89 d8 e8 33 6a c4 ff 85 c0 0f 85 3b 01 00 00 8b
4d e8 85 c9 0f 84 00 01 00 00 8b 45 b0 c7 40 18 ff ff ff ff 8b 73 14 83
e6 fc <f0> ff 46 08 8b 55 bc 89 d8 e8 72 0c 00 00 8b 45 e8 85 c0 74 38 
[ 3354.060126] EIP: [<c0523e80>] rt_spin_lock_slowlock+0xc0/0x250 SS:ESP
0068:f70bbe74
[ 3354.060126] CR2: 00000000fff2f2f8
[ 3354.060126] ---[ end trace d828fbbe13057d5f ]---
[ 3354.060126] note: sirq-hrtimer/1[27] exited with preempt_count 1

END TRACE

I would like to know 
i) What is wrong ?
ii) Is there something to do with my priority setting?
iii) How to solve this bug?

Regards
Vikram

