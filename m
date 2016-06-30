From: Roosen Henri <Henri.Roosen@ginzinger.com>
Subject: INFO: rcu_preempt detected stalls on CPUs/tasks
Date: Thu, 30 Jun 2016 16:05:09 +0000
Message-ID: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:47381 "EHLO
	mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcF3QMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 12:12:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.ginzinger.com (Postfix) with ESMTP id C7EDA4A3F
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 18:05:06 +0200 (CEST)
Received: from mail.ginzinger.com ([127.0.0.1])
	by localhost (mail.ginzinger.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agTRhte7X0tb for <linux-rt-users@vger.kernel.org>;
	Thu, 30 Jun 2016 18:05:06 +0200 (CEST)
Received: from exc2.buero.ginzinger.com (unknown [10.1.1.201])
	by mail.ginzinger.com (Postfix) with ESMTPS id 1924B4A40
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 18:05:06 +0200 (CEST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I just got an info-backtrace while running cyclictest on an iMX28 with kernel 4.1.27-rt30.
This resulted in a latency spike (i'm not sure whether caused by the trace dumping).
Can anyone share some info on this and what to do to prevent the cause of this info-trace?

[61760.622666] INFO: rcu_preempt detected stalls on CPUs/tasks: {} (detected by 0, t=2102 jiffies, g=69094, c=69093, q=40)
[61760.622691] All QSes seen, last rcu_preempt kthread activity 3 (6146061-6146058), jiffies_till_next_fqs=1, root ->qsmask 0x0
[61760.622721] hackbench       R running      0 22365  21953 0x00000002
[61760.622738] Backtrace:
[61760.622807] [<c0011ca8>] (dump_backtrace) from [<c0011eb4>] (show_stack+0x18/0x1c)
[61760.622843]  r6:00000028 r5:000055c1 r4:c5cd5ea0 r3:00404040
[61760.622879] [<c0011e9c>] (show_stack) from [<c003d57c>] (sched_show_task+0xc4/0xe4)
[61760.622922] [<c003d4b8>] (sched_show_task) from [<c00575c8>] (rcu_check_callbacks+0x52c/0x720)
[61760.622942]  r5:c05a82e4 r4:c05a84ec
[61760.622981] [<c005709c>] (rcu_check_callbacks) from [<c0059938>] (update_process_times+0x3c/0x64)
[61760.623024]  r10:c05a9120 r9:00000004 r8:00000000 r7:c5defc58 r6:c05a9120 r5:00000000
[61760.623037]  r4:c5cd5ea0
[61760.623077] [<c00598fc>] (update_process_times) from [<c0067b50>] (tick_sched_handle+0x50/0x54)
[61760.623097]  r5:0000382b r4:c3390059
[61760.623124] [<c0067b00>] (tick_sched_handle) from [<c0067ba4>] (tick_sched_timer+0x50/0x98)
[61760.623154] [<c0067b54>] (tick_sched_timer) from [<c005a3a0>] (__run_hrtimer+0x84/0x10c)
[61760.623187]  r7:00000002 r6:c0067b54 r5:c05a8970 r4:c05a9120
[61760.623213] [<c005a31c>] (__run_hrtimer) from [<c005ae7c>] (hrtimer_interrupt+0x110/0x2ec)
[61760.623246]  r6:c05a8918 r5:0000382b r4:c05a8980 r3:00000001
[61760.623289] [<c005ad6c>] (hrtimer_interrupt) from [<c0321a14>] (mxs_timer_interrupt+0x28/0x34)
[61760.623333]  r10:c05c88d8 r9:c5defc58 r8:c6805c00 r7:00000010 r6:00000000 r5:c05c0900
[61760.623347]  r4:c041a278
[61760.623394] [<c03219ec>] (mxs_timer_interrupt) from [<c004c71c>] (handle_irq_event_percpu+0x5c/0x160)
[61760.623429] [<c004c6c0>] (handle_irq_event_percpu) from [<c004c894>] (handle_irq_event+0x74/0x94)
[61760.623471]  r10:00000140 r9:c5defc58 r8:00000001 r7:c6808000 r6:00000000 r5:c05c0900
[61760.623483]  r4:c6805c00
[61760.623513] [<c004c820>] (handle_irq_event) from [<c004f898>] (handle_level_irq+0xd4/0x144)
[61760.623533]  r5:c05aebf8 r4:c6805c00
[61760.623562] [<c004f7c4>] (handle_level_irq) from [<c004bea0>] (generic_handle_irq+0x28/0x38)
[61760.623580]  r4:00000010 r3:c004f7c4
[61760.623611] [<c004be78>] (generic_handle_irq) from [<c004c134>] (__handle_domain_irq+0x98/0xd4)
[61760.623630]  r4:00000010 r3:000000e0
[61760.623659] [<c004c09c>] (__handle_domain_irq) from [<c00093f4>] (icoll_handle_irq+0x2c/0x34)
[61760.623705]  r9:c0380fe0 r8:c5dee028 r7:c5defc8c r6:ffffffff r5:60000013 r4:c041a278
[61760.623739] [<c00093c8>] (icoll_handle_irq) from [<c00129e0>] (__irq_svc+0x40/0x80)
[61760.623754] Exception stack(0xc5defc58 to 0xc5defca0)
[61760.623773] fc40:                                                       c6801c00 000106d0
[61760.623804] fc60: 01410c34 c6ed5080 c6801c00 00000000 01410c34 000106d0 c5dee028 c0380fe0
[61760.623837] fc80: 00000140 c5defd24 c5defd28 c5defca0 c009ea6c c041a278 60000013 ffffffff
[61760.623881] [<c041a268>] (__slab_alloc.constprop.1) from [<c009ea6c>] (__kmalloc_track_caller+0xc0/0x168)
[61760.623924]  r10:00000140 r9:c0380fe0 r8:c5dee028 r7:000106d0 r6:01410c34 r5:00000000
[61760.623939]  r4:c6801c00
[61760.623988] [<c009e9ac>] (__kmalloc_track_caller) from [<c0380e74>] (__alloc_skb+0x7c/0x188)
[61760.624029]  r8:00000000 r7:c6801d00 r6:00000000 r5:000004d0 r4:c35e73c0 r3:00000000
[61760.624065] [<c0380df8>] (__alloc_skb) from [<c0380fe0>] (alloc_skb_with_frags+0x60/0x18c)
[61760.624107]  r10:00000003 r9:00000064 r8:00000000 r7:000000d0 r6:00000000 r5:7fffffff
[61760.624128]  r4:c35d58c0 r3:ffffffff
[61760.624162] [<c0380f80>] (alloc_skb_with_frags) from [<c037954c>] (sock_alloc_send_pskb+0x1e4/0x29c)
[61760.624204]  r10:00000000 r9:00000064 r8:00000000 r7:c5defdd0 r6:c5defe28 r5:7fffffff
[61760.624218]  r4:c35d58c0
[61760.624261] [<c0379368>] (sock_alloc_send_pskb) from [<c03f02d4>] (unix_stream_sendmsg+0x148/0x2dc)
[61760.624304]  r10:00000000 r9:c35d58c0 r8:00000064 r7:c5defe84 r6:c35d5600 r5:c5defefc
[61760.624316]  r4:00000000
[61760.624346] [<c03f018c>] (unix_stream_sendmsg) from [<c0376598>] (sock_sendmsg+0x1c/0x2c)
[61760.624390]  r10:00000000 r9:c4f49540 r8:c2bef6c0 r7:c5defeec r6:c5deff00 r5:c5defefc
[61760.624404]  r4:c5defe8c
[61760.624429] [<c037657c>] (sock_sendmsg) from [<c0376634>] (sock_write_iter+0x8c/0xb8)
[61760.624465] [<c03765a8>] (sock_write_iter) from [<c00a2f34>] (__vfs_write+0xac/0xd8)
[61760.624507]  r9:be84ebc0 r8:00000064 r7:c5deff78 r6:c4f49540 r5:00000000 r4:00000000
[61760.624538] [<c00a2e88>] (__vfs_write) from [<c00a3674>] (vfs_write+0xb0/0x154)
[61760.624577]  r8:00000064 r7:00000064 r6:c5deff78 r5:be84ebc0 r4:c4f49540
[61760.624610] [<c00a35c4>] (vfs_write) from [<c00a3db0>] (SyS_write+0x44/0x84)
[61760.624651]  r9:be84ebc0 r8:00000064 r7:c4f49540 r6:c4f49540 r5:00000000 r4:00000000
[61760.624686] [<c00a3d6c>] (SyS_write) from [<c000ef40>] (ret_fast_syscall+0x0/0x38)
[61760.624729]  r9:c5dee000 r8:c000f0e4 r7:00000004 r6:be84ebc0 r5:006e011c r4:00000064

--
Thanks,
Henri


________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

