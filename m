Return-Path: <SRS0=9jrs=A7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F4C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Jul 2020 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436332176B
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Jul 2020 09:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fEZ6/X55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGTJVJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:21:09 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:47115 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgGTJVI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Jul 2020 05:21:08 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id xRyqjXZodNPeYxRyrjmjeX; Mon, 20 Jul 2020 11:21:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1595236865; bh=qJmYEdDdC3tvboKr2gSE9/hZS7C6HYYM79PAPDhhh1g=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=fEZ6/X55U1AWtOBhBAioWgJzGR8uU/4aesTQzw+rjbTCLioGlTi8fKYoh/418fRE4
         /lo/GsbjKuC1RD9NHC8r8ueD0ToQRiFB478H/n9vX1VI49sPkUQ0/9WItCHNM000I1
         t843sQryao5vXGhv0cbe2VnZ7mGcOcpkLmQ5kqigvlRWQzXxwmBm5JRJ8IGfr+hOlw
         43sLdmB8B2gvYTkk4+0ofD7Jwik4V+6PiYoHKu8ISLICtXShK3QbaR89pa4ILZ+wD3
         hUoA94myNDM1cOSXp/3iSPgG8emTCWkSJoVCmCikPkEur5E/IGdevH4IddOIFyzxfQ
         pFWPsIw5/UoBQ==
Subject: Re: 5.4.13-rt7 stall on CPU?
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
References: <3ef1ba37-6b83-e12a-e493-9c45fa3bb3c1@xs4all.nl>
 <20200703194934.c5sdqwxwgzmgobtq@linutronix.de>
 <875822d3-6fcd-1ab0-4ede-ee5134e6211b@xs4all.nl>
 <20200707174746.qe5f6w5qju3vo3yr@linutronix.de>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <6ab03781-a9bc-5e92-7512-906f832ef262@xs4all.nl>
Date:   Mon, 20 Jul 2020 11:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707174746.qe5f6w5qju3vo3yr@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM5krwa7ukFZCRjR+yaWW3mBuk46MprFBSiE9PUi8YOQKJRm90rmt6f55k7cnuvGP2PCI6fdYiC0D8z/M+3Ntw8+Y31D1JGeTd1a1I4Tnyt5fJdyntH5
 V6BMSFGZN4k4asagMX6Oyy6LvxzJl3/Sc4wdjzqqpd0T8iDByuckAcyMW5nNtBuxkGfEuCWLY/ObJO/EmIjA5JEodbR4wrkTP0aRmlwbE345rHpsG/xK+b7t
 B2ILMp/sb+bpHsGPovqPPKShM3dlkqatTapUNvEidx0=
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Sebastian, all,

I found another one of these in my logs:

Jul 19 05:33:05 vuurmuur named[2363288]: dispatch 0x7f1e3d7fa6c0:
shutting down due to TCP receive error: 2001:500:200::b#53: connection reset
Jul 20 02:20:24 vuurmuur kernel: 002: rcu: INFO: rcu_preempt
self-detected stall on CPU
Jul 20 02:20:24 vuurmuur kernel: 002: rcu:      2-....: (5250 ticks this
GP) idle=5c6/1/0x4000000000000002 softirq=401431806/401431806 fqs=2372
Jul 20 02:20:24 vuurmuur kernel: 002:   (t=5250 jiffies g=701989125 q=336)
Jul 20 02:20:24 vuurmuur kernel: 002: NMI backtrace for cpu 2
Jul 20 02:20:24 vuurmuur kernel: 002: CPU: 2 PID: 3468730 Comm: ntpd
Tainted: G           O      5.4.13-rt7 #9
Jul 20 02:20:24 vuurmuur kernel: 002: Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Jul 20 02:20:24 vuurmuur kernel: 002: Call Trace:
Jul 20 02:20:24 vuurmuur kernel: 002:  <IRQ>
Jul 20 02:20:24 vuurmuur kernel: 002:  dump_stack+0x50/0x70
Jul 20 02:20:24 vuurmuur kernel: 002:  nmi_cpu_backtrace.cold+0x14/0x53
Jul 20 02:20:24 vuurmuur kernel: 002:  ? lapic_can_unplug_cpu.cold+0x3b/0x3b
Jul 20 02:20:24 vuurmuur kernel: 002:
nmi_trigger_cpumask_backtrace+0x8e/0xa2
Jul 20 02:20:24 vuurmuur kernel: 002:  rcu_dump_cpu_stacks+0x8b/0xb9
Jul 20 02:20:24 vuurmuur kernel: 002:  rcu_sched_clock_irq.cold+0x17e/0x4fd
Jul 20 02:20:24 vuurmuur kernel: 002:  ? account_system_index_time+0xa6/0xd0
Jul 20 02:20:24 vuurmuur kernel: 002:  update_process_times+0x1f/0x50
Jul 20 02:20:24 vuurmuur kernel: 002:  tick_sched_timer+0x5a/0x1c0
Jul 20 02:20:24 vuurmuur kernel: 002:  ?
tick_switch_to_oneshot.cold+0x74/0x74
Jul 20 02:20:24 vuurmuur kernel: 002:  __hrtimer_run_queues+0xba/0x1b0
Jul 20 02:20:24 vuurmuur kernel: 002:  hrtimer_interrupt+0x108/0x230
Jul 20 02:20:24 vuurmuur kernel: 002:  smp_apic_timer_interrupt+0x61/0xa0
Jul 20 02:20:24 vuurmuur kernel: 002:  apic_timer_interrupt+0xf/0x20
Jul 20 02:20:24 vuurmuur kernel: 002:  </IRQ>
Jul 20 02:20:24 vuurmuur kernel: 002: RIP: 0010:lock_release+0x114/0x1a0
Jul 20 02:20:24 vuurmuur kernel: 002: Code: 0a 50 6e 01 75 0e 44 2b 7c
24 08 44 39 bd a8 07 00 00 75 54 65 48 8b 04 25 00 5e 01 00 c7 80 ac 07
00 00 00 00 00 00 41 56 9d <48> 8b 44 24 10 65 48 33 04 25 28 00 00 00
75 73 48 8b 6c 24 18 4c
Jul 20 02:20:24 vuurmuur kernel: 002: RSP: 0018:ffffc90001ebb8f0 EFLAGS:
00000246 ORIG_RAX: ffffffffffffff13
Jul 20 02:20:24 vuurmuur kernel: 002: RAX: ffff888054294140 RBX:
000000000000001f RCX: ffffc90001ebb8fc
Jul 20 02:20:24 vuurmuur kernel: 002: RDX: 0000000000000000 RSI:
ffffffff8203bee0 RDI: ffff8880542948f0
Jul 20 02:20:24 vuurmuur kernel: 002: RBP: ffff888054294140 R08:
0000000000020019 R09: 0000000000000000
Jul 20 02:20:24 vuurmuur kernel: 002: R10: 0000000000000001 R11:
0000000000000000 R12: ffffffff8203bee0
Jul 20 02:20:24 vuurmuur kernel: 002: R13: ffffffff8117b0a2 R14:
0000000000000246 R15: 0000000000000001
Jul 20 02:20:24 vuurmuur kernel: 002:  ? do_select+0x132/0x7a0
Jul 20 02:20:24 vuurmuur kernel: 002:  do_select+0x14f/0x7a0
Jul 20 02:20:24 vuurmuur kernel: 002:  ?
select_estimate_accuracy+0x100/0x100
Jul 20 02:20:24 vuurmuur kernel: 002:  ? poll_select_finish+0x1d0/0x1d0
Jul 20 02:20:24 vuurmuur kernel: 002:  ? poll_select_finish+0x1d0/0x1d0
Jul 20 02:20:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: 002:  ? put_prev_task_rt+0x22/0x140
Jul 20 02:20:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: 002:  ? __schedule+0x435/0x4f0
Jul 20 02:20:24 vuurmuur kernel: 002:  ? _raw_spin_unlock_irq+0x1f/0x40
Jul 20 02:20:24 vuurmuur kernel: 002:  ? __schedule+0x435/0x4f0
Jul 20 02:20:24 vuurmuur kernel: 002:  ? preempt_schedule_irq+0x31/0x50
Jul 20 02:20:24 vuurmuur kernel: 002:  ? retint_kernel+0x1b/0x1b
Jul 20 02:20:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: 002:  ? core_sys_select+0x5c/0x380
Jul 20 02:20:24 vuurmuur kernel: 002:  core_sys_select+0x1d0/0x380
Jul 20 02:20:24 vuurmuur kernel: 002:  ? core_sys_select+0x5c/0x380
Jul 20 02:20:24 vuurmuur kernel: 002:  ? tty_ldisc_ref_wait+0x27/0x70
Jul 20 02:20:24 vuurmuur kernel: 002:  ? __ldsem_down_read_nested+0x5e/0x240
Jul 20 02:20:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: 002:  ? set_user_sigmask+0x62/0x90
Jul 20 02:20:24 vuurmuur kernel: 002:  __x64_sys_pselect6+0x141/0x190
Jul 20 02:20:24 vuurmuur kernel: 002:  ? _raw_spin_unlock_irq+0x1f/0x40
Jul 20 02:20:24 vuurmuur kernel: 002:  ? sigprocmask+0x6d/0x90
Jul 20 02:20:24 vuurmuur kernel: 002:  do_syscall_64+0x77/0x440
Jul 20 02:20:24 vuurmuur kernel: 002:  ? nmi_handle+0xc1/0xe0
Jul 20 02:20:24 vuurmuur kernel: 002:  ? unregister_nmi_handler+0xb0/0xb0
Jul 20 02:20:24 vuurmuur kernel: 002:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 20 02:20:24 vuurmuur kernel: 002: RIP: 0033:0x7fba5ae5a096
Jul 20 02:20:24 vuurmuur kernel: 002: Code: e8 9f dd f8 ff 4c 8b 0c 24
4c 8b 44 24 08 89 c5 4c 8b 54 24 28 48 8b 54 24 20 b8 0e 01 00 00 48 8b
74 24 18 8b 7c 24 14 0f 05 <48> 3d 00 f0 ff ff 77 28 89 ef 89 04 24 e8
c8 dd f8 ff 8b 04 24 eb
Jul 20 02:20:24 vuurmuur kernel: 002: RSP: 002b:00007ffcff164a10 EFLAGS:
00000293 ORIG_RAX: 000000000000010e
Jul 20 02:20:24 vuurmuur kernel: 002: RAX: ffffffffffffffda RBX:
00005613a62cde78 RCX: 00007fba5ae5a096
Jul 20 02:20:24 vuurmuur kernel: 002: RDX: 0000000000000000 RSI:
00007ffcff164b00 RDI: 000000000000001f
Jul 20 02:20:24 vuurmuur kernel: 002: RBP: 0000000000000000 R08:
0000000000000000 R09: 00007ffcff164a50
Jul 20 02:20:24 vuurmuur kernel: 002: R10: 0000000000000000 R11:
0000000000000293 R12: 00005613a62a9c43
Jul 20 02:20:24 vuurmuur kernel: 002: R13: 0000000000000009 R14:
ffffffffffffffff R15: 00005613a62a9e1c
Jul 20 02:20:24 vuurmuur kernel: rcu: INFO: rcu_preempt self-detected
stall on CPU
Jul 20 02:20:24 vuurmuur kernel: rcu: #0112-....: (5250 ticks this GP)
idle=5c6/1/0x4000000000000002 softirq=401431806/401431806 fqs=2372
Jul 20 02:20:24 vuurmuur kernel: #011(t=5250 jiffies g=701989125 q=336)
Jul 20 02:20:24 vuurmuur kernel: NMI backtrace for cpu 2
Jul 20 02:20:24 vuurmuur kernel: CPU: 2 PID: 3468730 Comm: ntpd Tainted:
G           O      5.4.13-rt7 #9

Jul 20 02:20:24 vuurmuur kernel: Hardware name: To Be Filled By O.E.M.
To Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Jul 20 02:20:24 vuurmuur kernel: Call Trace:
Jul 20 02:20:24 vuurmuur kernel: <IRQ>
Jul 20 02:20:24 vuurmuur kernel: dump_stack+0x50/0x70
Jul 20 02:20:24 vuurmuur kernel: nmi_cpu_backtrace.cold+0x14/0x53
Jul 20 02:20:24 vuurmuur kernel: ? lapic_can_unplug_cpu.cold+0x3b/0x3b
Jul 20 02:20:24 vuurmuur kernel: nmi_trigger_cpumask_backtrace+0x8e/0xa2
Jul 20 02:20:24 vuurmuur kernel: rcu_dump_cpu_stacks+0x8b/0xb9
Jul 20 02:20:24 vuurmuur kernel: rcu_sched_clock_irq.cold+0x17e/0x4fd
Jul 20 02:20:24 vuurmuur kernel: ? account_system_index_time+0xa6/0xd0
Jul 20 02:20:24 vuurmuur kernel: update_process_times+0x1f/0x50
Jul 20 02:20:24 vuurmuur kernel: tick_sched_timer+0x5a/0x1c0
Jul 20 02:20:24 vuurmuur kernel: ? tick_switch_to_oneshot.cold+0x74/0x74
Jul 20 02:20:24 vuurmuur kernel: __hrtimer_run_queues+0xba/0x1b0
Jul 20 02:20:24 vuurmuur kernel: hrtimer_interrupt+0x108/0x230
Jul 20 02:20:24 vuurmuur kernel: smp_apic_timer_interrupt+0x61/0xa0
Jul 20 02:20:24 vuurmuur kernel: apic_timer_interrupt+0xf/0x20
Jul 20 02:20:24 vuurmuur kernel: </IRQ>
Jul 20 02:20:24 vuurmuur kernel: RIP: 0010:lock_release+0x114/0x1a0
Jul 20 02:20:24 vuurmuur kernel: Code: 0a 50 6e 01 75 0e 44 2b 7c 24 08
44 39 bd a8 07 00 00 75 54 65 48 8b 04 25 00 5e 01 00 c7 80 ac 07 00 00
00 00 00 00 41 56 9d <48> 8b 44 24 10 65 48 33 04 25 28 00 00 00 75 73
48 8b 6c 24 18 4c
Jul 20 02:20:24 vuurmuur kernel: RSP: 0018:ffffc90001ebb8f0 EFLAGS:
00000246 ORIG_RAX: ffffffffffffff13
Jul 20 02:20:24 vuurmuur kernel: RAX: ffff888054294140 RBX:
000000000000001f RCX: ffffc90001ebb8fc
Jul 20 02:20:24 vuurmuur kernel: RDX: 0000000000000000 RSI:
ffffffff8203bee0 RDI: ffff8880542948f0
Jul 20 02:20:24 vuurmuur kernel: RBP: ffff888054294140 R08:
0000000000020019 R09: 0000000000000000
Jul 20 02:20:24 vuurmuur kernel: R10: 0000000000000001 R11:
0000000000000000 R12: ffffffff8203bee0
Jul 20 02:20:24 vuurmuur kernel: R13: ffffffff8117b0a2 R14:
0000000000000246 R15: 0000000000000001
Jul 20 02:20:24 vuurmuur kernel: ? do_select+0x132/0x7a0
Jul 20 02:20:24 vuurmuur kernel: do_select+0x14f/0x7a0
Jul 20 02:20:24 vuurmuur kernel: ? select_estimate_accuracy+0x100/0x100
Jul 20 02:20:24 vuurmuur kernel: ? poll_select_finish+0x1d0/0x1d0
Jul 20 02:20:24 vuurmuur kernel: ? poll_select_finish+0x1d0/0x1d0
Jul 20 02:20:24 vuurmuur kernel: ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: ? put_prev_task_rt+0x22/0x140
Jul 20 02:20:24 vuurmuur kernel: ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: ? __schedule+0x435/0x4f0
Jul 20 02:20:24 vuurmuur kernel: ? _raw_spin_unlock_irq+0x1f/0x40
Jul 20 02:20:24 vuurmuur kernel: ? __schedule+0x435/0x4f0
Jul 20 02:20:24 vuurmuur kernel: ? preempt_schedule_irq+0x31/0x50
Jul 20 02:20:24 vuurmuur kernel: ? retint_kernel+0x1b/0x1b
Jul 20 02:20:24 vuurmuur kernel: ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: ? core_sys_select+0x5c/0x380
Jul 20 02:20:24 vuurmuur kernel: core_sys_select+0x1d0/0x380
Jul 20 02:20:24 vuurmuur kernel: ? core_sys_select+0x5c/0x380
Jul 20 02:20:24 vuurmuur kernel: ? tty_ldisc_ref_wait+0x27/0x70
Jul 20 02:20:24 vuurmuur kernel: ? __ldsem_down_read_nested+0x5e/0x240
Jul 20 02:20:24 vuurmuur kernel: ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: ? find_held_lock+0x2b/0x80
Jul 20 02:20:24 vuurmuur kernel: ? set_user_sigmask+0x62/0x90
Jul 20 02:20:24 vuurmuur kernel: __x64_sys_pselect6+0x141/0x190
Jul 20 02:20:24 vuurmuur kernel: ? _raw_spin_unlock_irq+0x1f/0x40
Jul 20 02:20:24 vuurmuur kernel: ? sigprocmask+0x6d/0x90
Jul 20 02:20:24 vuurmuur kernel: do_syscall_64+0x77/0x440
Jul 20 02:20:24 vuurmuur kernel: ? nmi_handle+0xc1/0xe0
Jul 20 02:20:24 vuurmuur kernel: ? unregister_nmi_handler+0xb0/0xb0
Jul 20 02:20:24 vuurmuur kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 20 02:20:24 vuurmuur kernel: RIP: 0033:0x7fba5ae5a096
Jul 20 02:20:24 vuurmuur kernel: Code: e8 9f dd f8 ff 4c 8b 0c 24 4c 8b
44 24 08 89 c5 4c 8b 54 24 28 48 8b 54 24 20 b8 0e 01 00 00 48 8b 74 24
18 8b 7c 24 14 0f 05 <48> 3d 00 f0 ff ff 77 28 89 ef 89 04 24 e8 c8 dd
f8 ff 8b 04 24 eb
Jul 20 02:20:24 vuurmuur kernel: RSP: 002b:00007ffcff164a10 EFLAGS:
00000293 ORIG_RAX: 000000000000010e
Jul 20 02:20:24 vuurmuur kernel: RAX: ffffffffffffffda RBX:
00005613a62cde78 RCX: 00007fba5ae5a096
Jul 20 02:20:24 vuurmuur kernel: RDX: 0000000000000000 RSI:
00007ffcff164b00 RDI: 000000000000001f
Jul 20 02:20:24 vuurmuur kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: 00007ffcff164a50
Jul 20 02:20:24 vuurmuur kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 00005613a62a9c43
Jul 20 02:20:24 vuurmuur kernel: R13: 0000000000000009 R14:
ffffffffffffffff R15: 00005613a62a9e1c
Jul 20 05:03:01 vuurmuur named[2363288]: received control channel
command 'flush'

Again it appears to concern ntpd.
Still on 5.4.13-rt7.

Should I boot into a newer kernel to verify the issue is still there?

Kind regards,
Udo


On 07-07-2020 19:47, Sebastian Andrzej Siewior wrote:
> On 2020-07-04 05:43:32 [+0200], Udo van den Heuvel wrote:
>>> I *think* this happened within the loop in __fget_files(). This function
>>> is inlined by __fget_light() and the loop has a RCU-section so it would
>>> make sense.
>>> Do you run something at an elevated priority in the system? 
>>
>> ntpd (ntpsec) elevates itself.
> 
> To the highest possible. Wonderful.
> 
>>> I don't know
>>> what the other part was doing but somehow one of the file descriptors
>>> (network sockets probably) was about to be closed while the other side
>>> tried to poll() on it.
>>
>> Thanks for explaining.
> 
> I'm puzzled. On dup() and otherwise on replacement / closing the file
> pointer is replaced (with an incremented reference count or NULL ) and
> then the reference count of the old file pointer is decremented. So the
> zero count could be observed once and then the new pointer should be
> seen. So it should not loop for seconds. And then, dup2() is only used
> at startup.

