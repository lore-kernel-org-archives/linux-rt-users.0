Return-Path: <SRS0=jf0u=5Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D6C43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 08:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4AC20578
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 08:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCaIOT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:14:19 -0400
Received: from krieglstein.org ([188.68.35.71]:60938 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaIOT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Mar 2020 04:14:19 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 04:14:16 EDT
Received: from dabox.localnet (gateway.hbm.com [213.157.30.2])
        by krieglstein.org (Postfix) with ESMTPSA id 732DA401DE;
        Tue, 31 Mar 2020 10:08:55 +0200 (CEST)
From:   Tim Sander <tim@krieglstein.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Bugsplat with 5.4.10-rt5
Date:   Tue, 31 Mar 2020 10:08:55 +0200
Message-ID: <51153360.nHRbzzT6yM@dabox>
Organization: Sander and Lightning
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

I just saw a buglsplat with unfortunately a little dated 5.4.10-rt5 so i don't know 
if that's still relevant on Intel/Altera Cyclone V SOC hardware. This is triggered
by driver code which is unfortunately out of tree. But i have been running this 
code with  4.18.7-rt5 for days without a problem.

The irq is requested with IRQF_NO_THREAD and the interrupt handler in question
looks like that:

static irqreturn_t sigif_irq_handler(int irq, void *data)
{
        struct sigif_priv *priv = (struct sigif_priv *)data;
        volatile FPGA *reg = priv->fpga_regs;
        int overrun;
        if (priv->irq != irq) {
                return IRQ_NONE;
        }
        overrun = reg->page_count - priv->lastPage;
        if (overrun > 1) {
                pr_err("page overrun!\n");
        }
        priv->lastPage = reg->page_count;
        priv->currentPage = reg->page_count;
#ifdef CONFIG_PREEMPT_RT_FULL
        if (priv->wakeupTask)
                wake_up_process(priv->wakeupTask);
#else
        wake_up_interruptible(&priv->wait);
#endif
        uint32_t regval = ioread32(&reg->rx_config);
        iowrite32(regval | 2, &reg->rx_config);
        iowrite32(regval & 0xfffffffd , &reg->rx_config);
        return IRQ_HANDLED;
}

I will try v5.4.28-rt19 later and see how that goes.

So here's the bugsplat:
000: ------------[ cut here ]------------
000: kernel BUG at kernel/locking/rtmutex.c:1047!
000: Internal error: Oops - BUG: 0 [#1] PREEMPT_RT SMP ARM
000: Modules linked in:
000:  i2c_altera
000:  compensation(O)
000:  pcorr(O)
000:  sigif(O)
000:  errorcnt(O)
000:  serdes(O)
000: 
000: CPU: 0 PID: 171 Comm: RawMeasThread Tainted: G        W  O      5.4.10-rt5 #1
000: Hardware name: Altera SOCFPGA
000: PC is at rt_spin_lock_slowlock_locked+0x280/0x2ec
000: LR is at 0x9d89a880
000: pc : [<8088f61c>]    lr : [<9d89a880>]    psr: 60080193
000: sp : 9d855bd8  ip : 9d89a881  fp : 9d855c04
000: r10: 80c80fa0  r9 : ffffe000  r8 : 9d89a880
000: r7 : 9d855c08  r6 : 00000000  r5 : a0080193  r4 : 9e808858
000: r3 : 9d89a880  r2 : 9d89a880  r1 : 9e808864  r0 : 00000000
000: Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
000: Control: 10c5387d  Table: 1d8e804a  DAC: 00000051
000: Process RawMeasThread (pid: 171, stack limit = 0xc262f786)
000: Stack: (0x9d855bd8 to 0x9d856000)
000: 5bc0:                                                       00010001 9e808858
000: 5be0: a0080193 00000000 00000001 9d855c78 00000000 80c80fa0 9d855c54 9d855c08
000: 5c00: 8088f6f0 8088f3a8 9d855c08 80891a2c 00000000 9d855c14 00000000 80c8c198
000: 5c20: 00000000 80151bd4 9e808801 00000000 9d855c54 9d855c40 80151bd4 80c07648
000: 5c40: 9d854000 9e808858 9d855c6c 9d855c58 80891bb4 8088f694 00000001 9e808858
000: 5c60: 9d855cb4 9d855c70 8016af70 80891b40 9f6d23c0 9f0e4a40 00000000 00000000
000: 5c80: 00000000 9d855c84 9d855c84 80c07648 9e808840 c089a038 00000000 0000002c
000: 5ca0: 9d855d38 9f080800 9d855ccc 9d855cb8 8016aff0 8016af14 00000000 8015336c
000: 5cc0: 9d855ce4 9d855cd0 7f0100c4 8016afd4 9ebc5640 80891d64 9d855d34 9d855ce8
000: 5ce0: 8017edc8 7f010070 50000000 80c07648 80c809c9 80c07668 9f19c000 9d854000
000: 5d00: 80c80fa0 80c80fb4 9d855d3c 9f19c000 80891d64 00000000 00000001 00000000
000: 5d20: 9f080800 9d855e00 9d855d5c 9d855d38 8017f09c 8017ed40 00000000 80c07648
000: 5d40: 9f19c000 80c07e24 9f19c070 00000001 9d855d7c 9d855d60 8017f16c 8017f038
000: 5d60: 9f19c000 80c07e24 00000000 00000001 9d855d94 9d855d80 801842ec 8017f100
000: 5d80: 80b81f40 0000002c 9d855da4 9d855d98 8017dd54 80184220 9d855dd4 9d855da8
000: 5da0: 8017e468 8017dd2c 9d855e00 80c07e24 80c5503c c080210c c0802100 c0803100
000: 5dc0: 9d855e00 00000003 9d855dfc 9d855dd8 8010238c 8017e3e8 80891d64 60080013
000: 5de0: ffffffff 9d855e34 00000004 9d854000 9d855e6c 9d855e00 80101a8c 8010233c
000: 5e00: 9e808858 00000000 9e808870 9e808870 9d855e70 9e808858 9d855e7c 9e808840
000: 5e20: 00000004 9e808858 00000003 9d855e6c 9d855e20 9d855e50 8016acfc 80891d64
000: 5e40: 60080013 ffffffff 00000051 7f000000 76300968 00000000 ffffe000 9e808840
000: 5e60: 9d855eac 9d855e70 7f010810 8016acbc 00000000 9d89a880 8015453c 9e808870
000: 5e80: 9e808870 80c07648 9d8d5e00 9d855f60 7f010744 9d855f60 00000004 00000000
000: 5ea0: 9d855f2c 9d855eb0 80299510 7f010750 9d855edc 802997a8 80153550 80299784
000: 5ec0: 9d855edc 80153ce8 80891924 00000000 00000001 9d8d5e08 9e060f08 00000001
000: 5ee0: 9f09d900 802baea4 9d8d5e00 00000011 00000001 00004000 9d837a00 80299714
000: 5f00: 9d855f34 80c07648 00000004 9d8d5e00 76300968 9d855f60 00000001 00000000
000: 5f20: 9d855f5c 9d855f30 80299748 802994cc 802baf84 802bae04 9d8d5e01 9d8d5e00
000: 5f40: 00000000 00000000 76300968 00000004 9d855f94 9d855f60 80299a6c 802996b0
000: 5f60: 00000000 00000000 c0802100 80c07648 00000004 00000011 7630d890 00000003
000: 5f80: 801011e4 9d854000 9d855fa4 9d855f98 80299b0c 80299a04 00000000 9d855fa8
000: 5fa0: 80101000 80299b00 00000004 00000011 00000011 76300968 00000004 00000000
000: 5fc0: 00000004 00000011 7630d890 00000003 7630d3d0 7ea57c30 00000000 ffffffec
000: 5fe0: 00000003 76300940 768c00e5 768c22b6 80080030 00000011 00000000 00000000
000: Backtrace: 
000: 
000: [<8088f39c>] (rt_spin_lock_slowlock_locked) from [<8088f6f0>] (rt_spin_lock_slowlock+0x68/0x98)
000:  r10:80c80fa0 r9:00000000 r8:9d855c78 r7:00000001 r6:00000000 r5:a0080193
000:  r4:9e808858 r3:00010001
000: [<8088f688>] (rt_spin_lock_slowlock) from [<80891bb4>] (rt_spin_lock+0x80/0x84)
000:  r5:9e808858 r4:9d854000
000: [<80891b34>] (rt_spin_lock) from [<8016af70>] (__wake_up_common_lock+0x68/0xc0)
000:  r5:9e808858 r4:00000001
000: [<8016af08>] (__wake_up_common_lock) from [<8016aff0>] (__wake_up+0x28/0x30)
000:  r9:9f080800 r8:9d855d38 r7:0000002c r6:00000000 r5:c089a038 r4:9e808840
000: [<8016afc8>] (__wake_up) from [<7f0100c4>] (sigif_irq_handler+0x60/0x9c [sigif])
000: [<7f010064>] (sigif_irq_handler [sigif]) from [<8017edc8>] (__handle_irq_event_percpu+0x94/0x2f8)
000:  r5:80891d64 r4:9ebc5640
000: [<8017ed34>] (__handle_irq_event_percpu) from [<8017f09c>] (handle_irq_event_percpu+0x70/0xc8)
000:  r10:9d855e00 r9:9f080800 r8:00000000 r7:00000001 r6:00000000 r5:80891d64
000:  r4:9f19c000
000: [<8017f02c>] (handle_irq_event_percpu) from [<8017f16c>] (handle_irq_event+0x78/0xbc)
000:  r7:00000001 r6:9f19c070 r5:80c07e24 r4:9f19c000
000: [<8017f0f4>] (handle_irq_event) from [<801842ec>] (handle_fasteoi_irq+0xd8/0x1cc)
000:  r7:00000001 r6:00000000 r5:80c07e24 r4:9f19c000
000: [<80184214>] (handle_fasteoi_irq) from [<8017dd54>] (generic_handle_irq+0x34/0x44)
000:  r5:0000002c r4:80b81f40
000: [<8017dd20>] (generic_handle_irq) from [<8017e468>] (__handle_domain_irq+0x8c/0xf8)
000: [<8017e3dc>] (__handle_domain_irq) from [<8010238c>] (gic_handle_irq+0x5c/0xa0)
000:  r10:00000003 r9:9d855e00 r8:c0803100 r7:c0802100 r6:c080210c r5:80c5503c
000:  r4:80c07e24 r3:9d855e00
001: dw_mmc ff704000.dwmmc0: Unexpected interrupt latency
000: [<80102330>] (gic_handle_irq) from [<80101a8c>] (__irq_svc+0x6c/0xbc)
000: Exception stack(0x9d855e00 to 0x9d855e48)
000: 5e00: 9e808858 00000000 9e808870 9e808870 9d855e70 9e808858 9d855e7c 9e808840
000: 5e20: 00000004 9e808858 00000003 9d855e6c 9d855e20 9d855e50 8016acfc 80891d64
000: 5e40: 60080013 ffffffff
000:  r9:9d854000 r8:00000004 r7:9d855e34 r6:ffffffff r5:60080013 r4:80891d64
000: [<8016acb0>] (add_wait_queue) from [<7f010810>] (sigif_read+0xcc/0x1b8 [sigif])
000:  r7:9e808840 r6:ffffe000 r5:00000000 r4:76300968
000: [<7f010744>] (sigif_read [sigif]) from [<80299510>] (__vfs_read+0x50/0x1e4)
000:  r9:00000000 r8:00000004 r7:9d855f60 r6:7f010744 r5:9d855f60 r4:9d8d5e00
000: [<802994c0>] (__vfs_read) from [<80299748>] (vfs_read+0xa4/0x120)
000:  r9:00000000 r8:00000001 r7:9d855f60 r6:76300968 r5:9d8d5e00 r4:00000004
000: [<802996a4>] (vfs_read) from [<80299a6c>] (ksys_read+0x74/0xfc)
000:  r9:00000004 r8:76300968 r7:00000000 r6:00000000 r5:9d8d5e00 r4:9d8d5e01
000: [<802999f8>] (ksys_read) from [<80299b0c>] (sys_read+0x18/0x1c)
000:  r9:9d854000 r8:801011e4 r7:00000003 r6:7630d890 r5:00000011 r4:00000004
000: [<80299af4>] (sys_read) from [<80101000>] (ret_fast_syscall+0x0/0x28)
000: Exception stack(0x9d855fa8 to 0x9d855ff0)
000: 5fa0:                   00000004 00000011 00000011 76300968 00000004 00000000
000: 5fc0: 00000004 00000011 7630d890 00000003 7630d3d0 7ea57c30 00000000 ffffffec
000: 5fe0: 00000003 76300940 768c00e5 768c22b6
000: Code: e5973000 e1570003 089daff8 e7f001f2 (e7f001f2) 
000: Kernel panic - not syncing: Fatal exception in interrupt
001: CPU1: stopping
001: CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W  O      5.4.10-rt5 #1
001: Hardware name: Altera SOCFPGA
001: Backtrace: 
001: 
001: [<8010e9f0>] (dump_backtrace) from [<8010ec78>] (show_stack+0x20/0x24)
001:  r7:60010193 r6:80c7c060 r5:00000000 r4:80c7c060
001: [<8010ec58>] (show_stack) from [<80872c08>] (dump_stack+0x8c/0xa0)
001: [<80872b7c>] (dump_stack) from [<80110e0c>] (handle_IPI+0x430/0x4a0)
001:  r7:00000004 r6:80c07be4 r5:80c80ec4 r4:80c8a578
001: [<801109dc>] (handle_IPI) from [<801023cc>] (gic_handle_irq+0x9c/0xa0)
001:  r10:00000000 r9:9f115f38 r8:c0803100 r7:c0802100 r6:c080210c r5:80c5503c
001:  r4:80c07e24
001: [<80102330>] (gic_handle_irq) from [<80101a8c>] (__irq_svc+0x6c/0xbc)
001: Exception stack(0x9f115f38 to 0x9f115f80)
001: 5f20:                                                       00000001 001d8620
001: 5f40: 00000000 8011bd80 9f114000 00000001 80c07668 80c076a4 80c809a7 413fc090
001: 5f60: 00000000 9f115f94 9f115f98 9f115f88 80109ed0 80109ed4 60010013 ffffffff
001:  r9:9f114000 r8:80c809a7 r7:9f115f6c r6:ffffffff r5:60010013 r4:80109ed4
001: [<80109e8c>] (arch_cpu_idle) from [<80891764>] (default_idle_call+0x3c/0x48)
001: [<80891728>] (default_idle_call) from [<8015a4a8>] (do_idle+0xf4/0x168)
001: [<8015a3b4>] (do_idle) from [<8015a848>] (cpu_startup_entry+0x28/0x2c)
001:  r9:413fc090 r8:0000406a r7:80c8a580 r6:10c0387d r5:00000001 r4:00000089
001: [<8015a820>] (cpu_startup_entry) from [<80110074>] (secondary_start_kernel+0x164/0x16c)
001: [<8010ff10>] (secondary_start_kernel) from [<001028cc>] (0x1028cc)
001:  r5:00000051 r4:1f10006a
000: ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Best regards
Tim


