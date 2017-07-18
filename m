From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: [BUG] x86/mm: Found insecure W+X mapping at address
 ffff88000005f000/0xffff88000005f000
Date: Tue, 18 Jul 2017 09:50:35 +0100
Message-ID: <20170718085034.GA6388@piotrpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34623 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdGRIus (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jul 2017 04:50:48 -0400
Received: by mail-wr0-f172.google.com with SMTP id 12so18894590wrb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jul 2017 01:50:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Dmesg reports insecure W+X mapping found at address
ffff88000005f000/0xffff88000005f000

on 4.4.70 kernel patched with -rt83 patch:

# uname -a
Linux piotrpc 4.4.70-rt83 #1 SMP PREEMPT RT Thu Jul 13 08:42:02 BST 2017 x86_64 GNU/Linux

[    4.888146] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.909507] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.931377] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    4.933500] serial 0000:04:00.0: enabling device (0000 -> 0003)
[    4.958689] 0000:04:00.0: ttyS2 at I/O 0xe010 (irq = 18, base_baud = 115200) is a ST16650V2
[    4.959402] serial 0000:04:00.1: enabling device (0000 -> 0003)
[    4.982118] 0000:04:00.1: ttyS3 at I/O 0xe000 (irq = 19, base_baud = 115200) is a ST16650V2
[    4.983587] Linux agpgart interface v0.103
[    4.984757] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    4.984758] AMD IOMMUv2 functionality not available on this system
[    4.991048] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    4.995120] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.995228] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.997121] mousedev: PS/2 mouse device common for all mice
[    4.997633] rtc_cmos 00:06: RTC can wake from S4
[    4.998756] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    4.999328] rtc_cmos 00:06: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    4.999420] Intel P-state driver initializing.
[    4.999429] intel_pstate: HWP enabled
[    5.011424] NET: Registered protocol family 10
[    5.013542] mip6: Mobile IPv6
[    5.013581] NET: Registered protocol family 17
[    5.013595] mpls_gso: MPLS GSO support
[    5.016288] microcode: CPU0 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016308] microcode: CPU1 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016362] microcode: CPU2 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016416] microcode: CPU3 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016475] microcode: CPU4 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016503] microcode: CPU5 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016585] microcode: CPU6 sig=0x506e3, pf=0x2, revision=0xa0
[    5.016642] microcode: CPU7 sig=0x506e3, pf=0x2, revision=0xa0
[    5.017158] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    5.018455] registered taskstats version 1
[    5.018595] zswap: loaded using pool lzo/zbud
[    5.019280] ima: No TPM chip found, activating TPM-bypass!
[    5.025017] rtc_cmos 00:06: setting system clock to 2017-07-18 07:39:01 UTC (1500363541)
[    5.025669] PM: Hibernation image not present or could not be loaded.
[    5.031098] Freeing unused kernel memory: 3484K (ffffffff81d55000 - ffffffff820bc000)
[    5.031100] Write protecting the kernel read-only data: 12288k
[    5.036397] Freeing unused kernel memory: 1436K (ffff880002899000 - ffff880002a00000)
[    5.039665] Freeing unused kernel memory: 976K (ffff880002d0c000 - ffff880002e00000)
[    5.039669] ------------[ cut here ]------------
[    5.039672] WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:225 note_page+0x61e/0x7e0()
[    5.039673] x86/mm: Found insecure W+X mapping at address ffff88000005f000/0xffff88000005f000
[    5.039674] Modules linked in:
[    5.039677] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.4.70-rt83 #1
[    5.039679] Hardware name: NOVATECH LTD PC-XB04472/H110M-C, BIOS 3019 01/06/2017
[    5.039681]  0000000000000000 ffff880226a97d60 ffffffff81387160 ffff880226a97da8
[    5.039682]  0000000000000009 ffff880226a97d98 ffffffff81089766 ffff880004145308
[    5.039683]  0000000000000004 8000000000000163 ffff880226a97e98 0000000000000000
[    5.039683] Call Trace:
[    5.039692]  [<ffffffff81387160>] dump_stack+0x85/0xc5
[    5.039694]  [<ffffffff81089766>] warn_slowpath_common+0x86/0xe0
[    5.039696]  [<ffffffff8108980c>] warn_slowpath_fmt+0x4c/0x50
[    5.039698]  [<ffffffff8107a45e>] note_page+0x61e/0x7e0
[    5.039699]  [<ffffffff8107a991>] ptdump_walk_pgd_level_core+0x371/0x420
[    5.039703]  [<ffffffff8107aa77>] ptdump_walk_pgd_level_checkwx+0x17/0x20
[    5.039704]  [<ffffffff8107000e>] mark_rodata_ro+0xee/0x100
[    5.039706]  [<ffffffff81683fe0>] ? rest_init+0x140/0x140
[    5.039707]  [<ffffffff81683ffd>] kernel_init+0x1d/0xe0
[    5.039709]  [<ffffffff81691c2f>] ret_from_fork+0x3f/0x70
[    5.039710]  [<ffffffff81683fe0>] ? rest_init+0x140/0x140
[    5.039712] ---[ end trace 0000000000000002 ]---
[    5.044120] x86/mm: Checked W+X mappings: FAILED, 55997 W+X pages found.
[    5.085104] systemd-udevd[134]: starting version 215
[    5.086349] random: systemd-udevd: uninitialized urandom read (16 bytes read, 6 bits of entropy available)
[    5.173659] FUJITSU Extended Socket Network Device Driver - version 1.0 - Copyright (c) 2015 FUJITSU LIMITED
[    5.265179] hidraw: raw HID events driver (C) Jiri Kosina
[    5.698741] thermal LNXTHERM:00: registered as thermal_zone0
[    5.698745] ACPI: Thermal Zone [TZ00] (28 C)
[    5.707387] pps_core: LinuxPPS API ver. 1 registered
[    5.707389] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    5.718091] thermal LNXTHERM:01: registered as thermal_zone1
[    5.718095] ACPI: Thermal Zone [TZ01] (30 C)
[    5.742162] ACPI: bus type USB registered
[    5.743514] PTP clock support registered
[    5.749182] usbcore: registered new interface driver usbfs
[    5.754191] usbcore: registered new interface driver hub
[    5.757681] usbcore: registered new device driver usb
[    5.830580] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    5.831771] tg3.c:v3.137 (May 11, 2014)
[    5.831786] tg3 0000:01:00.0: enabling device (0000 -> 0002)
[    5.836078] tsc: Refined TSC clocksource calibration: 3407.991 MHz
[    5.836081] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcb8dbdf, max_idle_ns: 440795301826 ns
[    5.848627] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded

cheers,
Piotr
