Return-Path: <SRS0=bcsC=YV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243AACA9EC0
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Oct 2019 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED156214B2
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Oct 2019 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403827AbfJ1SY0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:24:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730760AbfJ1SY0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Oct 2019 14:24:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BBE5AD22;
        Mon, 28 Oct 2019 18:24:22 +0000 (UTC)
Date:   Mon, 28 Oct 2019 11:22:58 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, bigeasy@linutronix.de
Subject: rcu stalls with pi_stress in latest rt
Message-ID: <20191028182258.76o6qnbgmzm525ff@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I've been running into rcu self-stalls as soon as I start running
the pi_stress program on a v5.2.21-rt13 kernel - I've seen it on
older rt 5.2 versions as well so it's not specific to 954ad80c23e
(futex: Make the futex_hash_bucket spinlock_t again and bring back
its old state), for example.

No other workload is running on the machine. The workload does not
crash, but incurs in very long response times.

I'm attaching two different splats I'm seeing for the futex wait
and wake paths. Does this ring any bells?

[  149.393135] 003: rcu: INFO: rcu_preempt self-detected stall on CPU
[  149.400034] 003: rcu:        3-....: (1 GPs behind) idle=026/1/0x4000000000000002 softirq=0/0 fqs=3929 
[  149.409939] 003:     (t=60016 jiffies g=8125 q=75)
[  149.414994] 003: rcu: rcu_preempt kthread starved for 9024 jiffies! g8125 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[  149.427032] 003: rcu: RCU grace-period kthread stack dump:
[  149.433153] 003:     0    11      2 0x80004000
[  149.438111] 003: Call Trace:
[  149.441325] 003:  ? __schedule+0x298/0x7a0
[  149.445901] 003:  schedule+0x36/0xd0
[  149.449891] 003:  schedule_timeout+0x1e3/0x390
[  149.454850] 003:  ? rcu_accelerate_cbs+0x22/0x190
[  149.460093] 003:  ? __next_timer_interrupt+0xc0/0xc0
[  149.465633] 003:  rcu_gp_kthread+0x724/0x1620
[  149.470497] 003:  ? __schedule+0x5a0/0x7a0
[  149.475069] 003:  ? note_gp_changes+0x60/0x60
[  149.479931] 003:  kthread+0x113/0x130
[  149.484020] 003:  ? kthread_park+0xa0/0xa0
[  149.488582] 003:  ret_from_fork+0x35/0x40
[  149.493058] 003: NMI backtrace for cpu 3
[  149.497436] 003: CPU: 3 PID: 5256 Comm: pi_stress Kdump: loaded Tainted: G            E     5.2.21-rt13-preempt-rt
[  149.511121] 003: Hardware name: Dell Inc. PowerEdge R230/0MFXTY, BIOS 1.4.5 08/09/2016
[  149.519958] 003: Call Trace:
[  149.523172] 003:  <IRQ>
[  149.525900] 003:  dump_stack+0x46/0x5b
[  149.530083] 003:  nmi_cpu_backtrace+0x89/0x90
[  149.534944] 003:  ? lapic_can_unplug_cpu+0xd0/0xd0
[  149.540292] 003:  nmi_trigger_cpumask_backtrace+0xfb/0x130
[  149.546416] 003:  rcu_dump_cpu_stacks+0x9c/0xcf
[  149.551470] 003:  rcu_sched_clock_irq+0x78e/0xa90
[  149.556722] 003:  ? trigger_load_balance+0x51/0x230
[  149.562167] 003:  ? tick_sched_do_timer+0x80/0x80
[  149.567409] 003:  update_process_times+0x28/0x50
[  149.572563] 003:  tick_sched_handle+0x21/0x70
[  149.577425] 003:  tick_sched_timer+0x37/0x70
[  149.582191] 003:  __hrtimer_run_queues+0x12b/0x3a0
[  149.587537] 003:  ? recalibrate_cpu_khz+0x10/0x10
[  149.592787] 003:  hrtimer_interrupt+0xe5/0x240
[  149.597746] 003:  smp_apic_timer_interrupt+0x6f/0x1d0
[  149.603385] 003:  apic_timer_interrupt+0xf/0x20
[  149.608440] 003:  </IRQ>
[  149.611265] 003: RIP: 0010:_raw_spin_unlock_irq+0x14/0x50
[  149.617292] 003: Code: 04 00 75 cf f3 c3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 fb 65 f5
[  149.638734] 003: RSP: 0018:ffffac5a05d97c30 EFLAGS: 00000282
[  149.645052] 003:  ORIG_RAX: ffffffffffffff13
[  149.649816] 003: RAX: 0000000000000000 RBX: ffff98b30fae7cc0 RCX: 0000000000000001
[  149.658264] 003: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98b30fae7cc0
[  149.666713] 003: RBP: ffffac5a05d97c60 R08: ffffffffa0e2e500 R09: ffff98abc7d701e8
[  149.675161] 003: R10: ffffac5a05d87c18 R11: 0000000000000000 R12: 0000000000000000
[  149.683610] 003: R13: ffff98abc2389100 R14: 0000000000000000 R15: ffff98b308bb0000
[  149.692060] 003:  finish_task_switch+0x92/0x2c0
[  149.697119] 003:  __schedule+0x2a0/0x7a0
[  149.701487] 003:  schedule+0x36/0xd0
[  149.705476] 003:  futex_wait_queue_me+0xbb/0x110
[  149.710627] 003:  futex_wait+0xe1/0x230
[  149.714907] 003:  ? apic_timer_interrupt+0xa/0x20
[  149.720159] 003:  do_futex+0x2f5/0x680
[  149.724342] 003:  ? do_futex+0x14/0x680
[  149.728623] 003:  __x64_sys_futex+0x134/0x180
[  149.733486] 003:  do_syscall_64+0x67/0x1f0
[  149.738060] 003:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  149.744175] 003: RIP: 0033:0x7fc9a014ba8a
[  149.748650] 003: Code: 00 00 eb 0d 0f 1f 40 00 44 8b 7d 00 45 39 f8 76 47 41 8b 71 0c 44 89 fa 45 31 d2 48 89 ef 44 89 e0 40 80 f6 89
[  149.770092] 003: RSP: 002b:00007fc99bd79e10 EFLAGS: 00000282
[  149.776408] 003:  ORIG_RAX: 00000000000000ca
[  149.781173] 003: RAX: ffffffffffffffda RBX: 000000007ffffffe RCX: 00007fc9a014ba8a
[  149.789620] 003: RDX: 00000000005d6f8e RSI: 0000000000000080 RDI: 00000000015e754c
[  149.798069] 003: RBP: 00000000015e754c R08: 00000000005d6f8f R09: 00000000015e7548
[  149.806519] 003: R10: 0000000000000000 R11: 0000000000000282 R12: 00000000000000ca
[  149.814968] 003: R13: 0000000000000001 R14: 0000000000000002 R15: 00000000005d6f8e
[  149.823421] 004: NMI backtrace for cpu 4
[  149.827797] 004: CPU: 4 PID: 5257 Comm: pi_stress Kdump: loaded Tainted: G            E     5.2.21-rt13-preempt-rt
[  149.841482] 004: Hardware name: Dell Inc. PowerEdge R230/0MFXTY, BIOS 1.4.5 08/09/2016
[  149.850316] 004: RIP: 0010:do_syscall_64+0xf8/0x1f0
[  149.855758] 004: Code: 00 75 57 48 8b 03 f6 c4 40 75 5f 8b 05 d9 8f 96 01 83 63 08 f9 85 c0 7f 64 8b 05 4b 37 88 01 85 c0 7e 07 0f 07
[  149.877197] 004: RSP: 0018:ffffac5a05d9ff40 EFLAGS: 00000042
[  149.883512] 004: 
[  149.885656] 004: RAX: 0000000000000001 RBX: ffff98b308bb1100 RCX: 0000000000000000
[  149.894105] 004: RDX: 00000000ffffffff RSI: 0000000000004000 RDI: ffff98b308bb1e40
[  149.902552] 004: RBP: ffffac5a05d9ff58 R08: ffffffffa0e2e500 R09: ffff98abc7d701c0
[  149.910998] 004: R10: ffffac5a05d9fd08 R11: 0000000000000000 R12: 0000000000000000
[  149.919446] 004: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  149.927892] 004: FS:  00007fc99b579700(0000) GS:ffff98b30fb00000(0000) knlGS:0000000000000000
[  149.937408] 004: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.944304] 004: CR2: 000055921900fb78 CR3: 000000083c9f0002 CR4: 00000000003606e0
[  149.952749] 004: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.961197] 004: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.969643] 004: Call Trace:
[  149.972854] 004:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  149.978976] 004: RIP: 0033:0x7fc9a014ba45
[  149.983449] 004: Code: 41 29 d7 f0 44 0f b1 7d 00 89 c1 75 d9 41 8b 71 0c 45 31 d2 ba ff ff ff 7f 48 89 ef b8 ca 00 00 00 40 80 f6 80
[  150.004889] 004: RSP: 002b:00007fc99b578e90 EFLAGS: 00000286
[  150.011204] 004:  ORIG_RAX: 00000000000000ca
[  150.015965] 004: RAX: 0000000000000002 RBX: 000000007ffffffe RCX: 00007fc9a014ba45
[  150.024414] 004: RDX: 000000007fffffff RSI: 0000000000000081 RDI: 00000000015e7664
[  150.032859] 004: RBP: 00000000015e7664 R08: 0000000000cad955 R09: 00000000015e7660
[  150.041306] 004: R10: 0000000000000000 R11: 0000000000000286 R12: 000000007fffffff
[  150.049752] 004: R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000cad955
[  150.058451] 006: NMI backtrace for cpu 6
[  150.062829] 006: CPU: 6 PID: 5263 Comm: pi_stress Kdump: loaded Tainted: G            E     5.2.21-rt13-preempt-rt
[  150.076516] 006: Hardware name: Dell Inc. PowerEdge R230/0MFXTY, BIOS 1.4.5 08/09/2016
[  150.085352] 006: RIP: 0010:entry_SYSCALL_64+0x20/0x38
[  150.090991] 006: Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 01 f8 65 48 89 24 25 14 80 00 00 66 90 0f 20 dc 48 0f ba ec 3f 48 81 e4 ff ea
[  150.112434] 006: RSP: 0018:800000083c9f0003 EFLAGS: 00000086
[  150.118749] 006: 
[  150.120897] 006: RAX: 00000000000000ca RBX: 000000007ffffffe RCX: 00007fc9a014ba45
[  150.129347] 006: RDX: 000000007fffffff RSI: 0000000000000081 RDI: 00000000015e7954
[  150.137794] 006: RBP: 00000000015e7954 R08: 00000000008d53dc R09: 00000000015e7950
[  150.146244] 006: R10: 0000000000000000 R11: 0000000000000286 R12: 000000007fffffff
[  150.154693] 006: R13: 0000000000000001 R14: 0000000000000003 R15: 00000000008d53dc
[  150.163141] 006: FS:  00007fc998573700(0000) GS:ffff98b30fb80000(0000) knlGS:0000000000000000
[  150.172655] 006: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.179551] 006: CR2: 00000000015e7008 CR3: 000000083c9f0003 CR4: 00000000003606e0
[  150.187999] 006: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  150.196447] 006: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

For the wake side:

[ 2503.774266] 003: rcu: INFO: rcu_preempt self-detected stall on CPU
[ 2503.781355] 003: rcu:        3-....: (1 GPs behind) idle=0ea/1/0x4000000000000002 softirq=0/0 fqs=8815 
[ 2503.791451] 003:     (t=60011 jiffies g=8141 q=1713)
[ 2503.796890] 003: NMI backtrace for cpu 3
[ 2503.801456] 003: CPU: 3 PID: 5254 Comm: pi_stress Kdump: loaded Tainted: G            E     5.2.21-rt13-preempt-rt
[ 2503.815330] 003: Hardware name: Dell Inc. PowerEdge R230/0MFXTY, BIOS 1.4.5 08/09/2016
[ 2503.824356] 003: Call Trace:
[ 2503.827759] 003:  <IRQ>
[ 2503.830677] 003:  dump_stack+0x46/0x5b
[ 2503.835052] 003:  nmi_cpu_backtrace+0x89/0x90
[ 2503.840106] 003:  ? lapic_can_unplug_cpu+0xd0/0xd0
[ 2503.845643] 003:  nmi_trigger_cpumask_backtrace+0xfb/0x130
[ 2503.851957] 003:  rcu_dump_cpu_stacks+0x9c/0xcf
[ 2503.857202] 003:  rcu_sched_clock_irq+0x78e/0xa90
[ 2503.862644] 003:  ? trigger_load_balance+0x51/0x230
[ 2503.868277] 003:  ? tick_sched_do_timer+0x80/0x80
[ 2503.873718] 003:  update_process_times+0x28/0x50
[ 2503.879062] 003:  tick_sched_handle+0x21/0x70
[ 2503.884114] 003:  tick_sched_timer+0x37/0x70
[ 2503.889069] 003:  __hrtimer_run_queues+0x12b/0x3a0
[ 2503.894604] 003:  ? recalibrate_cpu_khz+0x10/0x10
[ 2503.900046] 003:  hrtimer_interrupt+0xe5/0x240
[ 2503.905195] 003:  smp_apic_timer_interrupt+0x6f/0x1d0
[ 2503.911023] 003:  apic_timer_interrupt+0xf/0x20
[ 2503.916269] 003:  </IRQ>
[ 2503.919284] 003: RIP: 0010:_raw_spin_unlock_irq+0x14/0x50
[ 2503.925500] 003: Code: 04 00 75 cf f3 c3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 fb 65 f5
[ 2503.947130] 003: RSP: 0018:ffffac5a05d87c30 EFLAGS: 00000282
[ 2503.953635] 003:  ORIG_RAX: ffffffffffffff13
[ 2503.958588] 003: RAX: 0000000000000000 RBX: ffff98b30fae7cc0 RCX: 0000000000000001
[ 2503.967228] 003: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98b30fae7cc0
[ 2503.975866] 003: RBP: ffffac5a05d87c60 R08: ffff98abc261bc6c R09: ffff98abc7d70198
[ 2503.984504] 003: R10: ffffac5a05d8fc18 R11: 0000000000000000 R12: 0000000000000000
[ 2503.993141] 003: R13: ffff98b308bb3300 R14: 0000000000000001 R15: ffff98abc2389100
[ 2504.001780] 003:  finish_task_switch+0x92/0x2c0
[ 2504.007027] 003:  __schedule+0x2a0/0x7a0
[ 2504.011595] 003:  preempt_schedule_common+0x11/0x40
[ 2504.017229] 003:  ___preempt_schedule+0x16/0x18
[ 2504.022475] 003:  _raw_spin_unlock_irqrestore+0x1c/0x50
[ 2504.028498] 003:  try_to_wake_up+0x23d/0x610
[ 2504.033453] 003:  ? put_task_stack+0x170/0x170
[ 2504.038603] 003:  __wake_up_q+0x99/0xb0
[ 2504.043072] 003:  futex_wake+0x159/0x180
[ 2504.047638] 003:  do_futex+0x105/0x680
[ 2504.052012] 003:  __x64_sys_futex+0x134/0x180
[ 2504.057063] 003:  do_syscall_64+0x67/0x1f0
[ 2504.061823] 003:  entry_SYSCALL_64_after_hwframe+0x44/0xa9

There are also constant workqueue lockup messages, some of which I am seeing
in non-rt kernels as well when running pi_stress...

[ 2379.273993] 000: BUG: workqueue lockup - pool
[ 2379.291995] 000: Showing busy workqueues and worker pools:
[ 2379.291995] 000: workqueue events: flags=0x0
[ 2379.291997] 000:   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[ 2379.304850] 000:     pending: vmstat_shepherd
[ 2379.310698] 000: workqueue events_unbound: flags=0x2
[ 2379.310699] 000:   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/512
[ 2379.320919] 000:     pending: flush_to_ldisc
[ 2379.326669] 000: workqueue events_power_efficient: flags=0x80
[ 2379.326671] 000:   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256
[ 2379.339525] 000:     in-flight: 5294:fb_flashcursor
[ 2379.345761] 000:   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=2/256
[ 2379.358611] 000:     in-flight: 181:neigh_periodic_work, 470:neigh_periodic_work
[ 2379.369804] 000: workqueue mm_percpu_wq: flags=0x8
[ 2379.369805] 000:   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256
[ 2379.382654] 000:     pending: vmstat_update
[ 2379.388308] 000:   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[ 2379.401162] 000:     pending: vmstat_update
[ 2379.406814] 000: workqueue writeback: flags=0x4e
[ 2379.406815] 000:   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/256
[ 2379.417037] 000:     pending: wb_workfn
[ 2379.422301] 000: workqueue kblockd: flags=0x18
[ 2379.422303] 000:   pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=1/256
[ 2379.435346] 000:     pending: blk_mq_timeout_work
[ 2379.441582] 000: workqueue edac-poller: flags=0xa000a
[ 2379.441583] 000:   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/1
[ 2379.451610] 000:     pending: edac_mc_workq_function
[ 2379.458137] 000: workqueue poll_megasas0_status: flags=0xe000a
[ 2379.458138] 000:   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/1
[ 2379.468167] 000:     pending: megasas_fault_detect_work [megaraid_sas]
[ 2379.476442] 000: pool 8: cpus=4 node=0 flags=0x0 nice=0 hung=223s workers=3 idle: 5309
[ 2379.495333] 000: pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 197 257
[ 2409.566039] 000: Showing busy workqueues and worker pools:
[ 2409.566040] 000: workqueue events_power_efficient: flags=0x80
[ 2409.566042] 000:   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=2/256
[ 2409.579651] 000:     in-flight: 181:neigh_periodic_work, 470:neigh_periodic_work
[ 2409.591413] 000: workqueue events_freezable_power_: flags=0x84
[ 2409.591414] 000:   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256
[ 2409.605025] 000:     in-flight: 5294:disk_events_workfn
[ 2409.612028] 000: workqueue mm_percpu_wq: flags=0x8
[ 2409.612029] 000:   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[ 2409.625635] 000:     pending: vmstat_update
[ 2409.631672] 000: pool 8: cpus=4 node=0 flags=0x0 nice=0 hung=253s workers=3 idle: 5309
[ 2482.025326] 004: INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 272.296 msecs
[ 2409.651690] 000: pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=1s workers=3 idle: 197 257

Thanks,
Davidlohr
