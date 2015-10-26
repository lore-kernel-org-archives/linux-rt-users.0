From: Javier Sanz <jsanza@gmail.com>
Subject: BUG: scheduling while atomic: swapper/0/0/0x00010002
Date: Mon, 26 Oct 2015 11:59:56 +0100
Message-ID: <CAOLSsAzRBCJN+sWuzm51fAF4XVkbhPvKTMtqXOVkw_nRV28ibg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33028 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbbJZLA0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Oct 2015 07:00:26 -0400
Received: by yknn9 with SMTP id n9so179002682ykn.0
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Oct 2015 04:00:25 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am testing linux 4.1.11 using patch rt10 and always on boot i got :

   15.963261] BUG: scheduling while atomic: swapper/0/0/0x00010002

The dmesg shows :

[   14.321208] logitech 0003:046D:C517.0002: fixing up Logitech
keyboard report descriptor
[   14.321699] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.1/0003:046D:C517.0002/input/input5
[   14.332052] floppy0: no floppy controllers found
[   14.352033] nouveau  [     DRM] allocated 1280x1024 fb: 0x60000, bo
ffff880213370800
[   14.352131] fbcon: nouveaufb (fb0) is primary device
[   14.352180] Console: switching to colour frame buffer device 160x64
[   14.352186] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[   14.352188] nouveau 0000:01:00.0: registered panic notifier
[   14.352203] [drm] Initialized nouveau 1.2.2 20120801 for
0000:01:00.0 on minor 0
[   14.373465] logitech 0003:046D:C517.0002: input,hiddev0,hidraw2:
USB HID v1.10 Mouse [Logitech USB Receiver] on
usb-0000:00:1a.0-1/input1
[   14.389578] EXT4-fs (sda3): barriers disabled
[   14.503642] EXT4-fs (sda3): mounted filesystem with writeback data
mode. Opts: data=writeback,errors=remount-ro,barrier=0,commit=60
[   14.657253] EXT4-fs (sda1): barriers disabled
[   14.660953] EXT4-fs (sda1): mounted filesystem with writeback data
mode. Opts: data=writeback,errors=remount-ro,barrier=0,commit=60
[   15.946325] vboxdrv: module verification failed: signature and/or
required key missing - tainting kernel
[   15.947514] vboxdrv: Found 4 processor cores
[   15.963261] BUG: scheduling while atomic: swapper/0/0/0x00010002
[   15.963275] Modules linked in: vboxdrv(OE+) hid_logitech ff_memless
nouveau wmi video i2c_algo_bit ttm r8169 drm_kms_helper drm gpio_ich
serio_raw ata_generic pata_acpi lpc_ich coretemp crc32c_intel i2c_i801
mii pata_jmicron mfd_core acpi_cpufreq
[   15.963278] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE
4.1.11-rt10 #1
[   15.963280] Hardware name: Gigabyte Technology Co., Ltd.
P55M-UD2/P55M-UD2, BIOS F11 06/23/2010
[   15.963284]  ffffffff81803480 ffff88021fc03d78 ffffffff8160f5c2
ffffffff819fb702
[   15.963286]  ffff88021fc15600 ffff88021fc03d88 ffffffff81095983
ffff88021fc03dd8
[   15.963288]  ffffffff81611005 ffff88021fc03df8 ffffffff810b20bb
ffff880036854d80
[   15.963289] Call Trace:
[   15.963297]  <IRQ>  [<ffffffff8160f5c2>] dump_stack+0x4a/0x61
[   15.963302]  [<ffffffff81095983>] __schedule_bug+0x43/0x60
[   15.963305]  [<ffffffff81611005>] __schedule+0x4a5/0x7f0
[   15.963309]  [<ffffffff810b20bb>] ? task_blocks_on_rt_mutex+0x19b/0x240
[   15.963312]  [<ffffffff8161138a>] schedule+0x3a/0xc0
[   15.963315]  [<ffffffff81612db5>] rt_spin_lock_slowlock+0xc5/0x260
[   15.963319]  [<ffffffff81614109>] rt_spin_lock+0x29/0x30
[   15.963338]  [<ffffffffa0290487>]
VBoxHost_RTSpinlockAcquire+0x57/0x70 [vboxdrv]
[   15.963349]  [<ffffffffa02822c4>]
supdrvGipMpEventOnlineOrInitOnCpu+0x64/0x2e0 [vboxdrv]
[   15.963361]  [<ffffffffa028e320>] ?
VBoxHost_RTMpGetOnlineSet+0x50/0x50 [vboxdrv]
[   15.963371]  [<ffffffffa0282550>] supdrvGipInitOnCpu+0x10/0x20 [vboxdrv]
[   15.963384]  [<ffffffffa028e355>] rtmpLinuxAllWrapper+0x35/0x40 [vboxdrv]
[   15.963387]  [<ffffffff810e2385>] flush_smp_call_function_queue+0x55/0x160
[   15.963390]  [<ffffffff810e2f2e>]
generic_smp_call_function_single_interrupt+0xe/0x50
[   15.963394]  [<ffffffff81033be2>]
smp_trace_call_function_single_interrupt+0x22/0x30
[   15.963396]  [<ffffffff81033c19>] smp_call_function_interrupt+0x9/0x10
[   15.963398]  [<ffffffff8161561b>] call_function_interrupt+0x6b/0x70
[   15.963403]  <EOI>  [<ffffffff814c0f0c>] ? cpuidle_enter_state+0xac/0x160
[   15.963405]  [<ffffffff814c0efe>] ? cpuidle_enter_state+0x9e/0x160
[   15.963407]  [<ffffffff814c0fe2>] cpuidle_enter+0x12/0x20
[   15.963409]  [<ffffffff810afb10>] cpu_startup_entry+0x240/0x330
[   15.963412]  [<ffffffff81607845>] rest_init+0x85/0x90
[   15.963414]  [<ffffffff818abed0>] start_kernel+0x41a/0x427
[   15.963416]  [<ffffffff818ab2fe>] x86_64_start_reservations+0x2a/0x2c
[   15.963418]  [<ffffffff818ab428>] x86_64_start_kernel+0x128/0x131
[   15.963520] vboxdrv: TSC mode is Invariant, tentative frequency 2798008179 Hz
[   15.963557] vboxdrv: Successfully loaded version 5.0.8 (interface 0x00240000)
[   16.270839] VBoxNetFlt: Successfully started.
[   16.294012] VBoxNetAdp: Successfully started.
[   16.305514] VBoxPciLinuxInit
[   16.305518] vboxpci: IOMMU not found (not compiled)
[   18.872890] ata1.00: configured for UDMA/133
[   18.872897] ata1: EH complete
[   21.990735] IPv6: ADDRCONF(NETDEV_UP): p21p1: link is not ready
[   22.089909] r8169 0000:04:00.0 p21p1: link down
[   22.089973] IPv6: ADDRCONF(NETDEV_UP): p21p1: link is not ready
[   23.776185] r8169 0000:04:00.0 p21p1: link up
[   23.776198] IPv6: ADDRCONF(NETDEV_CHANGE): p21p1: link becomes ready
[   23.834059] r8169 0000:04:00.0 p21p1: link down
[   23.834097] IPv6: ADDRCONF(NETDEV_UP): p21p1: link is not ready
[   23.834107] r8169 0000:04:00.0 p21p1: link down
[   25.394372] r8169 0000:04:00.0 p21p1: link up

Virtualbox is enable on boot :(

Thank you
