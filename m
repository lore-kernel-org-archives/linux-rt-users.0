From: GeHao Kang <kanghao0928@gmail.com>
Subject: CPU Isolation with PREEMPT_RT
Date: Fri, 1 Jul 2016 14:37:12 +0800
Message-ID: <CANv7uPRJjawJOHx2ZnKz+iZK3u_PXuDBjCkXefP4kuzeLLpeZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37354 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbcGAGhN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Jul 2016 02:37:13 -0400
Received: by mail-it0-f49.google.com with SMTP id f6so10097519ith.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 23:37:13 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,

When the kernel built with CONFIG_PREEMPT_RT_FULL and boot up with some
specific isolcpus, e.g. 'isolcpus=1,3', the system cannot enter the
user space and be blocked with the message,  "random: nonblocking pool
is initialized". Not all combinations of CPU isolation can cause this
issue. In my test on i.MX6Q, this might happen when isolcpus is set as
'1, 3', or '2, 3'.

I have tested CPU isolation on various kernels, 4.1.15-rt17,
4.4.12-rt19, 4.1.15,  and 4.4.0. This issue does not happen on
4.1.15 and 4.4.0. The following is the detail about the test
environment and kernel message for system blocking.

Test environment:
=============
Hardware: i.MX6Q
Kernel version: 4.1.15-rt17, 4.1.15, 4.4.12-rt19, 4.4.0
Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk0p2
rootwait rw nohz_full=3 isolcpus=1,3 nohz=on

Kernel message (fail to enter the user space):
=================================
Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 4.1.15-rt17-00056-g363236e (georgekang@georgekang-PC)
(gcc version 4.9.2 (Ubuntu/Linaro 4.9.2-10ubuntu10) ) #42 SMP PREEMPT
RT Tue Jun 21 18:57:00 CST 2016
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Freescale i.MX6 Quad SABRE Smart Device Board
Memory policy: Data cache writealloc
PERCPU: Embedded 33 pages/cpu @bf751000 s103296 r8192 d23680 u135168
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk0p2
rootwait rw nohz_full=3 isolcpus=1,3 nohz=on
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032976K/1048576K available (3366K kernel code, 270K rwdata,
1028K rodata, 340K init, 358K bss, 15600K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80452c6c   (4396 kB)
      .init : 0x80453000 - 0x804a8000   ( 340 kB)
      .data : 0x804a8000 - 0x804ebbc0   ( 271 kB)
       .bss : 0x804ebbc0 - 0x805455d4   ( 359 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Preemptible hierarchical RCU implementation.
RCU kthread priority: 1.
NR_IRQS:16 nr_irqs:16 16
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
NO_HZ: Full dynticks CPUs: 3.
Offload RCU callbacks from all CPUs
Offload RCU callbacks from CPUs: 0-3.
Switching to timer-based delay loop, resolution 333ns
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
clocksource mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 637086815595 ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer
frequency.. 6.00 BogoMIPS (lpj=12000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x10008200 - 0x10008234
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
Brought up 4 CPUs
SMP: Total of 4 processors activated (24.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
CPU identified as i.MX6Q, silicon rev 1.2
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
mxs-dma 110000.dma-apbh: initialized
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c i2c-0: IMX I2C adapter registered
i2c i2c-0: can't use DMA
i2c i2c-1: IMX I2C adapter registered
i2c i2c-1: can't use DMA
i2c i2c-2: IMX I2C adapter registered
i2c i2c-2: can't use DMA
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
Switched to clocksource mxc_timer1
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 3, 32768 bytes)
UDP-Lite hash table entries: 512 (order: 3, 32768 bytes)
NET: Registered protocol family 1
CPU PMU: Failed to parse /soc/pmu/interrupt-affinity[0]
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
futex hash table entries: 1024 (order: 4, 65536 bytes)
io scheduler noop registered
io scheduler deadline registered (default)
imx-weim 21b8000.weim: Driver registered.
imx-sdma 20ec000.sdma: failed to get firmware from device tree
imx-sdma 20ec000.sdma: initialized
2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 24, base_baud =
5000000) is a IMX
console [ttymxc0] enabled
random: nonblocking pool is initialized
===== end of kernel message  =================

Any suggestion about this issue?
Thanks,
-Kang
