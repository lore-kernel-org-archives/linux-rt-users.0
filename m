Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229CC34021
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D120725
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/luP5TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgBQQYM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:24:12 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40333 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgBQQYM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 11:24:12 -0500
Received: by mail-oi1-f177.google.com with SMTP id a142so17186204oii.7
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Feb 2020 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PegZ3ZkrfJAqUQjtpIDDkflSjoJmRINOPt9OdI3wau8=;
        b=a/luP5TZiwpYNKC4sYJi6V7sGX0H+GSpYaQUCES4NTb/OhWBpRS3vBhEHqiDi/Wgf5
         zjWvmLcb945OZ+xOP0x63j9oN5v6ERqiZeurTphIpDyQ+rP/mOmXqWEjBVDU8H/290ti
         fkPqTyyPwcauG6yj+aEg2hEK2T555v0QcjYOiUNfExKGjE9r+2oblramVvSMLEAPCETA
         htZ0bj43c9tqHJ/lWzeitQooA3wvTdc3UPtiwOzpVvKMWwwL0jx57E30BxYyZQZarzV4
         Mv3X6qnipgcCe/jnFtr/kwrjVQ4bEyvXJJu/blHTq+9N3ji8hn0vXL4j8MCtNX5uBAqs
         aUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PegZ3ZkrfJAqUQjtpIDDkflSjoJmRINOPt9OdI3wau8=;
        b=nI71/Xt2vPkgZmMyRCflo/YZN0KIXQ79+DpnKdf8k3bujgpyZd0ORgAju8KfVg7on3
         gwwcMrQzM4PL+3drkigrABMAi+VHpwzLk04q4lZyTUouF85B01XxOOYpnsqPgXDXoi5R
         U9HW+Qlk4rwxmLR3Oh5KzoJcPV3sW7BBJhFxyNgni1A8rVIaKmXRPnmSxvPowYrYjFDW
         gcK1IK7q4x9eLQBfI7WX+xMf4A81j3pYPtT8cAsZzkP87emYwmjZpSkVPUcE6tlPJBa5
         5qGjQ7Db+yK4YsD+PRQBHuJ5kkHb97p3/lhpuivhCkJMfvcAx+tyUQ0/sjF7dSv2tEIj
         dijg==
X-Gm-Message-State: APjAAAUOUCOrYREUEE6hGSCbetHQwQwTiVf2fqPuyxB8feN168YaeiPD
        uIrlezWpwkp9dw76zu6M3yYVvZ2JiqIl+lO99OT2zQ==
X-Google-Smtp-Source: APXvYqwKV46iafSOOp9yL2Ayq1w/cF8Zb4NEmdhfOI3EdcLKv1wiOAL9HkL68xxG2nTu42Pz3ESWfLoKWgA7q84CPqw=
X-Received: by 2002:aca:5254:: with SMTP id g81mr10698715oib.61.1581956650274;
 Mon, 17 Feb 2020 08:24:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:9489:0:0:0:0:0 with HTTP; Mon, 17 Feb 2020 08:24:09
 -0800 (PST)
From:   Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date:   Mon, 17 Feb 2020 18:24:09 +0200
Message-ID: <CAPm8-H5n0f3dAEa=vM++aUZTxu4H_zvNp-4bjzriByJDGSefnA@mail.gmail.com>
Subject: kernel panic in SPI rt driver interrupt
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello PREEMPT_RT community,

  I am an open source enthusiast and
  I have written a driver for Texas Instruments omap4 mcspi
  beaglebone black open source board, linux preempt_rt kernel 5.4.5-rt3.
  I have the following problem (if you want all the code
  I will post it, it is gpl open source):

- in the interrupt I do
	mcspi->interrupt_done = 1;
	wake_up_interruptible(&mcspi->wq);

- in the transfer function I do
	/* Enable interrupts last. */
	mcspi->interrupt_done = 0;
	l = OMAP2_MCSPI_IRQENABLE_TX0_EMPTY |
			OMAP2_MCSPI_IRQENABLE_RX0_FULL;
	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, l);

	/* TX_EMPTY will be raised only after SPI data is sent */
	mcspi_wr_fifo(mcspi);

	/* wait for transfer completion */
	wait_event_interruptible(mcspi->wq, (mcspi->interrupt_done > 0));

- I try to make one million small SPI transfers (8 bytes per transfer),
but after about 10000 transfers I get kernel oops and then panic


[  166.956088] 000: Internal error: Oops - undefined instruction: 0
[#1] PREEMPT_RT SMP ARM
[  166.964260] 000: Modules linked in:
[  166.967761] 000:  rt_gpio_driver(O)
[  166.971260] 000:  spidev(O)
[  166.974060] 000:  spi_omap2_mcspi
[  166.977384] 000:
[  166.979316] 000: CPU: 0 PID: 161 Comm: lat-preempt_rt. Tainted: G
     W  O      5.4.5-rt3 #7
[  166.988055] 000: Hardware name: Generic AM33XX (Flattened Device Tree)
[  166.994607] 000: PC is at rt_spin_lock_slowlock_locked+0x268/0x304
[  167.000828] 000: LR is at 0xdd2ec448
[  167.004417] 000: pc : [<c0909e40>]    lr : [<dd2ec448>]    psr: 600f0193
[  167.011144] 000: sp : dd497b48  ip : dd490800  fp : a00f0193
[  167.016823] 000: r10: dd496000  r9 : 00000000  r8 : dd497b78
[  167.022503] 000: r7 : 00000000  r6 : dd490800  r5 : ffffe000  r4 : dd2ec43c
[  167.029491] 000: r3 : dd490800  r2 : 00000000  r1 : dd490800  r0 : 00000000
[  167.036480] 000: Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA
ARM  Segment none
[  167.044169] 000: Control: 10c5387d  Table: 9d4a4019  DAC: 00000051
[  167.050371] 000: Process lat-preempt_rt. (pid: 161, stack limit = 0x04c02f3c)
[  167.057541] 000: Stack: (0xdd497b48 to 0xdd498000)
[  167.062356] 000: 7b40:                   dd490800 df942800 00000000
dd496000 dd2ec43c a00f0193
[  167.071006] 000: 7b60: 00000000 00000003 00000000 dd496000 c0eb6180
c0909f30 dd497b78 00000009
[  167.079657] 000: 7b80: df942840 dd497b84 dd2ec43c dd497bc8 00000000
c01682e4 ffffe001 dd2ec43c
[  167.088306] 000: 7ba0: dd497bc8 00000000 c0eb6180 4daed0d6 dd2ec43c
00000001 dd497bc8 c01891bc
[  167.096956] 000: 7bc0: dd497c8c 00000000 00000000 00000000 00000000
dd497bd4 dd497bd4 4daed0d6
[  167.105605] 000: 7be0: dd2ec400 00000004 00000000 dd497c58 0000002f
c0eb6194 0000002f c0189220
[  167.114255] 000: 7c00: 00000000 00000001 dd490880 bf00056c dd293b40
dd496000 00000000 c019dfa0
[  167.122904] 000: 7c20: c0a04bb8 df942800 de424c00 c0d87800 00000000
c090c1dc dd496000 00000000
[  167.131555] 000: 7c40: de424c00 c0e07d8c 00000000 dd497cd0 00000001
c019e280 00000000 4daed0d6
[  167.140205] 000: 7c60: de424c00 de424c70 c0e07d8c 0000002f c0e07d8c
c019e344 de424c00 dd496000
[  167.148855] 000: 7c80: c0e07d8c c01a28b0 c0d87390 c0d87390 dd496000
c019d0dc c0d87390 c019d6f4
[  167.157505] 000: 7ca0: c0e07d8c de01e000 00000010 c090c1dc 600f0013
ffffffff dd497d04 00000000
[  167.166155] 000: 7cc0: dd496000 00000008 00000001 c0101aac 00000000
dd490800 00000000 dd2ec448
[  167.174805] 000: 7ce0: dd496000 dd2ec43c dd497d50 dd2ec43c 00000000
dd2ec000 00000008 00000001
[  167.183454] 000: 7d00: 00000000 dd497d20 c01682e4 c090c1dc 600f0013
ffffffff 00000051 bf000000
[  167.192104] 000: 7d20: dd496000 00000002 dd497d50 c0189520 00000000
4daed0d6 dd2ec000 dd2ec400
[  167.200754] 000: 7d40: dd2ec43c dd2ec400 00000000 bf0007ec 00000000
dd490800 c01898b0 dd497d5c
[  167.209404] 000: 7d60: dd497d5c 4daed0d6 dd2ec400 dd2e6c00 dd3de080
bf000b94 00000003 dd3de080
[  167.218055] 000: 7d80: dd3de080 dd3de080 dd497eac dd2ec000 c0eb8e08
00000000 dd2e6e60 dd2ec348
[  167.226704] 000: 7da0: 00000001 c06c47a0 00000000 dd2e6c00 dd2ec000
dd2ec000 dd497e68 dd497ed0
[  167.235353] 000: 7dc0: dd497eac de445410 de445410 c06c14d4 00000001
c06c4e84 00000001 4daed0d6
[  167.244002] 000: 7de0: dd497dfc dd2ec23c dd496000 dd496000 dd2e6c00
dd497eac dd2ec000 dd2e6e60
[  167.252652] 000: 7e00: dd2ec348 c06c14d4 dd2ec250 c06c54ac dd497e6c
00000000 00000000 00000000
[  167.261301] 000: 7e20: 00000000 dd497e24 dd497e24 4daed0d6 00000001
dd2e6c00 dd497eac dd497eac
[  167.269950] 000: 7e40: dd2e6c00 00000008 dd38bc28 00000008 00000008
c06c55a4 dd38bc04 dd2e6c00
[  167.278599] 000: 7e60: dd497eac bf006350 dd3de0cc dd3db980 dd38bc00
bf006db4 dd3b6008 c01682e4
[  167.287247] 000: 7e80: ffffe000 00000008 dd3db980 00000051 dd38bc00
dd3db940 dd3de080 dd2e6c00
[  167.295897] 000: 7ea0: dd38bc28 00000020 00000002 dd3de0c4 dd3de0c4
dd2e6c00 00000000 c06c1440
[  167.304547] 000: 7ec0: dd497e1c 00000008 00000000 ffffff8d dd497ed0
dd497ed0 00000000 dd497edc
[  167.313196] 000: 7ee0: dd497edc 4daed0d6 dd2e1808 be8d3bb0 dd2fcfb0
00000000 40206b00 dd496000
[  167.321845] 000: 7f00: dd2e1a00 00000036 00000000 c02e82fc 00000000
dd496000 00000000 00000000
[  167.330494] 000: 7f20: 00000000 00000000 00000000 4daed0d6 00000000
dd2fd410 dd2e1800 00000002
[  167.339142] 000: 7f40: dd2e1808 00000002 dd496000 00000000 00000000
c02d405c 00000000 00000000
[  167.347791] 000: 7f60: dd496000 4daed0d6 dd2e1a00 dd2e1a00 00000000
40206b00 be8d3bb0 00000004
[  167.356441] 000: 7f80: 00000036 c02e8c0c 00000000 00000000 000106f1
00000036 c01011e4 dd496000
[  167.365090] 000: 7fa0: 00000036 c0101000 00000000 00000000 00000004
40206b00 be8d3bb0 00000004
[  167.373739] 000: 7fc0: 00000000 00000000 000106f1 00000036 00000000
00000000 b6f30000 00000000
[  167.382388] 000: 7fe0: 00022024 be8d3ba4 00010bc5 b6e8cc8c 000f0010
00000004 00000000 00000000
[  167.391044] 000: [<c0909e40>] (rt_spin_lock_slowlock_locked) from
[<c0909f30>] (rt_spin_lock_slowlock+0x54/0x7c)
[  167.401265] 000: [<c0909f30>] (rt_spin_lock_slowlock) from
[<c01891bc>] (__wake_up_common_lock+0x58/0xa8)
[  167.410882] 000: [<c01891bc>] (__wake_up_common_lock) from
[<c0189220>] (__wake_up+0x14/0x1c)
[  167.419445] 000: [<c0189220>] (__wake_up) from [<bf00056c>]
(omap2_mcspi_irq_handler_rt+0xa4/0x118 [spi_omap2_mcspi])
[  167.430114] 000: [<bf00056c>] (omap2_mcspi_irq_handler_rt
[spi_omap2_mcspi]) from [<c019dfa0>]
(__handle_irq_event_percpu+0x50/0x2c4)
[  167.442181] 000: [<c019dfa0>] (__handle_irq_event_percpu) from
[<c019e280>] (handle_irq_event_percpu+0x6c/0xc4)
[  167.452315] 000: [<c019e280>] (handle_irq_event_percpu) from
[<c019e344>] (handle_irq_event+0x6c/0xb0)
[  167.461663] 000: [<c019e344>] (handle_irq_event) from [<c01a28b0>]
(handle_level_irq+0xdc/0x1bc)
[  167.470491] 000: [<c01a28b0>] (handle_level_irq) from [<c019d0dc>]
(generic_handle_irq+0x20/0x34)
[  167.479403] 000: [<c019d0dc>] (generic_handle_irq) from
[<c019d6f4>] (__handle_domain_irq+0x8c/0x128)
[  167.488664] 000: [<c019d6f4>] (__handle_domain_irq) from
[<c0101aac>] (__irq_svc+0x6c/0xbc)
[  167.497055] 000: Exception stack(0xdd497cd0 to 0xdd497d18)
[  167.502563] 000: 7cc0:                                     00000000
dd490800 00000000 dd2ec448
[  167.511211] 000: 7ce0: dd496000 dd2ec43c dd497d50 dd2ec43c 00000000
dd2ec000 00000008 00000001
[  167.519859] 000: 7d00: 00000000 dd497d20 c01682e4 c090c1dc 600f0013 ffffffff
[  167.526936] 000: [<c0101aac>] (__irq_svc) from [<c090c1dc>]
(rt_spin_lock+0x5c/0x74)
[  167.534715] 000: [<c090c1dc>] (rt_spin_lock) from [<c0189520>]
(prepare_to_wait_event+0x2c/0x144)
[  167.543627] 000: [<c0189520>] (prepare_to_wait_event) from
[<bf0007ec>] (do_transfer_irq_bh+0x12c/0x17c [spi_omap2_mcspi])
[  167.554722] 000: [<bf0007ec>] (do_transfer_irq_bh
[spi_omap2_mcspi]) from [<bf000b94>]
(omap2_mcspi_transfer_one+0x358/0x408 [spi_omap2_mcspi])
[  167.567650] 000: [<bf000b94>] (omap2_mcspi_transfer_one
[spi_omap2_mcspi]) from [<c06c47a0>]
(spi_transfer_one_message+0xd4/0x4dc)
[  167.579454] 000: [<c06c47a0>] (spi_transfer_one_message) from
[<c06c4e84>] (__spi_pump_messages+0x2dc/0x76c)
[  167.589326] 000: [<c06c4e84>] (__spi_pump_messages) from
[<c06c54ac>] (__spi_sync+0x18c/0x260)
[  167.597976] 000: [<c06c54ac>] (__spi_sync) from [<c06c55a4>]
(spi_sync+0x24/0x3c)
[  167.605493] 000: [<c06c55a4>] (spi_sync) from [<bf006350>]
(spidev_sync+0x38/0x4c [spidev])
[  167.613886] 000: [<bf006350>] (spidev_sync [spidev]) from
[<bf006db4>] (spidev_ioctl+0x770/0x850 [spidev])
[  167.623585] 000: [<bf006db4>] (spidev_ioctl [spidev]) from
[<c02e82fc>] (do_vfs_ioctl+0xa0/0x94c)
[  167.632503] 000: [<c02e82fc>] (do_vfs_ioctl) from [<c02e8c0c>]
(ksys_ioctl+0x64/0x74)
[  167.640366] 000: [<c02e8c0c>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[  167.648491] 000: Exception stack(0xdd497fa8 to 0xdd497ff0)
[  167.654000] 000: 7fa0:                   00000000 00000000 00000004
40206b00 be8d3bb0 00000004
[  167.662648] 000: 7fc0: 00000000 00000000 000106f1 00000036 00000000
00000000 b6f30000 00000000
[  167.671295] 000: 7fe0: 00022024 be8d3ba4 00010bc5 b6e8cc8c
[  167.676807] 000: Code: e1580003 1a000001 e28dd00c e8bd8ff0 (e7f001f2)
[  167.683362] 000: ------------[ cut here ]------------
[  167.688431] 000: WARNING: CPU: 0 PID: 161 at
kernel/locking/rtmutex.c:2142 __rt_mutex_trylock+0x100/0x110
[  167.698041] 000: Modules linked in:
[  167.701538] 000:  rt_gpio_driver(O)
[  167.705035] 000:  spidev(O)
[  167.707833] 000:  spi_omap2_mcspi
[  167.711156] 000:
[  167.713084] 000: CPU: 0 PID: 161 Comm: lat-preempt_rt. Tainted: G
     W  O      5.4.5-rt3 #7
[  167.721818] 000: Hardware name: Generic AM33XX (Flattened Device Tree)
[  167.728371] 000: [<c0113054>] (unwind_backtrace) from [<c010ce30>]
(show_stack+0x10/0x14)
[  167.736596] 000: [<c010ce30>] (show_stack) from [<c08eda4c>]
(dump_stack+0xb4/0xd0)
[  167.744289] 000: [<c08eda4c>] (dump_stack) from [<c013b3e4>]
(__warn+0xd0/0xf8)
[  167.751640] 000: [<c013b3e4>] (__warn) from [<c013b4bc>]
(warn_slowpath_fmt+0xb0/0xbc)
[  167.759593] 000: [<c013b4bc>] (warn_slowpath_fmt) from [<c090a38c>]
(__rt_mutex_trylock+0x100/0x110)
[  167.768765] 000: [<c090a38c>] (__rt_mutex_trylock) from
[<c01ebc08>] (__crash_kexec+0x2c/0xc0)
[  167.777425] 000: [<c01ebc08>] (__crash_kexec) from [<c01ebcec>]
(crash_kexec+0x50/0x5c)
[  167.785464] 000: [<c01ebcec>] (crash_kexec) from [<c010d064>]
(die+0x230/0x360)
[  167.792805] 000: [<c010d064>] (die) from [<c010d288>]
(do_undefinstr+0x9c/0x1d4)
[  167.800232] 000: [<c010d288>] (do_undefinstr) from [<c0101bb8>]
(__und_svc_finish+0x0/0x48)
[  167.808620] 000: Exception stack(0xdd497ab8 to 0xdd497b00)
[  167.814127] 000: 7aa0:
         00000000 dd490800
[  167.822776] 000: 7ac0: 00000000 dd490800 dd2ec43c ffffe000 dd490800
00000000 dd497b78 00000000
[  167.831425] 000: 7ae0: dd496000 a00f0193 dd490800 dd497b48 dd2ec448
c0909e40 600f0193 ffffffff
[  167.840070] 000: [<c0101bb8>] (__und_svc_finish) from [<c0909e40>]
(rt_spin_lock_slowlock_locked+0x268/0x304)
[  167.850027] 000: [<c0909e40>] (rt_spin_lock_slowlock_locked) from
[<c0909f30>] (rt_spin_lock_slowlock+0x54/0x7c)
[  167.860245] 000: [<c0909f30>] (rt_spin_lock_slowlock) from
[<c01891bc>] (__wake_up_common_lock+0x58/0xa8)
[  167.869853] 000: [<c01891bc>] (__wake_up_common_lock) from
[<c0189220>] (__wake_up+0x14/0x1c)
[  167.878414] 000: [<c0189220>] (__wake_up) from [<bf00056c>]
(omap2_mcspi_irq_handler_rt+0xa4/0x118 [spi_omap2_mcspi])
[  167.889073] 000: [<bf00056c>] (omap2_mcspi_irq_handler_rt
[spi_omap2_mcspi]) from [<c019dfa0>]
(__handle_irq_event_percpu+0x50/0x2c4)
[  167.901129] 000: [<c019dfa0>] (__handle_irq_event_percpu) from
[<c019e280>] (handle_irq_event_percpu+0x6c/0xc4)
[  167.911262] 000: [<c019e280>] (handle_irq_event_percpu) from
[<c019e344>] (handle_irq_event+0x6c/0xb0)
[  167.920609] 000: [<c019e344>] (handle_irq_event) from [<c01a28b0>]
(handle_level_irq+0xdc/0x1bc)
[  167.929433] 000: [<c01a28b0>] (handle_level_irq) from [<c019d0dc>]
(generic_handle_irq+0x20/0x34)
[  167.938345] 000: [<c019d0dc>] (generic_handle_irq) from
[<c019d6f4>] (__handle_domain_irq+0x8c/0x128)
[  167.947605] 000: [<c019d6f4>] (__handle_domain_irq) from
[<c0101aac>] (__irq_svc+0x6c/0xbc)
[  167.955993] 000: Exception stack(0xdd497cd0 to 0xdd497d18)
[  167.961500] 000: 7cc0:                                     00000000
dd490800 00000000 dd2ec448
[  167.970149] 000: 7ce0: dd496000 dd2ec43c dd497d50 dd2ec43c 00000000
dd2ec000 00000008 00000001
[  167.978797] 000: 7d00: 00000000 dd497d20 c01682e4 c090c1dc 600f0013 ffffffff
[  167.985872] 000: [<c0101aac>] (__irq_svc) from [<c090c1dc>]
(rt_spin_lock+0x5c/0x74)
[  167.993649] 000: [<c090c1dc>] (rt_spin_lock) from [<c0189520>]
(prepare_to_wait_event+0x2c/0x144)
[  168.002560] 000: [<c0189520>] (prepare_to_wait_event) from
[<bf0007ec>] (do_transfer_irq_bh+0x12c/0x17c [spi_omap2_mcspi])
[  168.013654] 000: [<bf0007ec>] (do_transfer_irq_bh
[spi_omap2_mcspi]) from [<bf000b94>]
(omap2_mcspi_transfer_one+0x358/0x408 [spi_omap2_mcspi])
[  168.026582] 000: [<bf000b94>] (omap2_mcspi_transfer_one
[spi_omap2_mcspi]) from [<c06c47a0>]
(spi_transfer_one_message+0xd4/0x4dc)
[  168.038375] 000: [<c06c47a0>] (spi_transfer_one_message) from
[<c06c4e84>] (__spi_pump_messages+0x2dc/0x76c)
[  168.048247] 000: [<c06c4e84>] (__spi_pump_messages) from
[<c06c54ac>] (__spi_sync+0x18c/0x260)
[  168.056897] 000: [<c06c54ac>] (__spi_sync) from [<c06c55a4>]
(spi_sync+0x24/0x3c)
[  168.064413] 000: [<c06c55a4>] (spi_sync) from [<bf006350>]
(spidev_sync+0x38/0x4c [spidev])
[  168.072802] 000: [<bf006350>] (spidev_sync [spidev]) from
[<bf006db4>] (spidev_ioctl+0x770/0x850 [spidev])
[  168.082502] 000: [<bf006db4>] (spidev_ioctl [spidev]) from
[<c02e82fc>] (do_vfs_ioctl+0xa0/0x94c)
[  168.091413] 000: [<c02e82fc>] (do_vfs_ioctl) from [<c02e8c0c>]
(ksys_ioctl+0x64/0x74)
[  168.099276] 000: [<c02e8c0c>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[  168.107400] 000: Exception stack(0xdd497fa8 to 0xdd497ff0)
[  168.112910] 000: 7fa0:                   00000000 00000000 00000004
40206b00 be8d3bb0 00000004
[  168.121558] 000: 7fc0: 00000000 00000000 000106f1 00000036 00000000
00000000 b6f30000 00000000
[  168.130205] 000: 7fe0: 00022024 be8d3ba4 00010bc5 b6e8cc8c
[  168.135710] 000: ---[ end trace 0000000000000005 ]---
[  168.140792] 000: Kernel panic - not syncing: Fatal exception in interrupt
[  168.147612] 000: ---[ end Kernel panic - not syncing: Fatal
exception in interrupt ]---
