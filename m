From: Michal Simek <michal.simek@petalogix.com>
Subject: Microblaze RT
Date: Wed, 19 May 2010 14:55:38 +0200
Message-ID: <4BF3DFCA.7010604@petalogix.com>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab0ESM4h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 May 2010 08:56:37 -0400
Received: by fxm10 with SMTP id 10so2300290fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2010 05:56:35 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I am trying to support Microblaze RT. I had to fix two issues to get it=
=20
work. I am running 2.6.31.12 but I think that won't be a problem to por=
t=20
it to latest version.

1. I am getting overruns on uartlite serial console that's why I think=20
that there is problem in driver. There is no problem to use uart16650.

2. I see that I have the problem with preemptirqsoff because there is=20
too big max latency.

Can you give me any hint how to debug it?

My point is to be able to proof that RT works as expected that's why I=20
would like to run several tests to get any sensible results. I saw=20
several tests in LTP but they are designed at least for glibc 2.5 which=
=20
I don't have (2.3.6).

Is there any git repo with rt patches or just single patch which I use?


The next my question are about low level kernel parts which I think=20
needs to be fixed. Kernel handles concurrect irqs which could be wrong.
I also added preempt support to entry.S which I need to verify. Is ther=
e=20
any way how to do it? Cyclictest shows any results but I would like to=20
be sure that they are correct.

Please take a look at logs below.

Thanks,
Michal



  find /debugfs/tracing/latency_hist/ -name "CPU0" | xargs head
=3D=3D> /debugfs/tracing/latency_hist/missed_timer_offsets/CPU0 <=3D=3D
#Minimum latency: <undef> microseconds
#Average latency: <undef> microseconds
#Maximum latency: <undef> microseconds
#Total samples: 0
#There are 0 samples lower than 0 microseconds.
#There are 0 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0

=3D=3D> /debugfs/tracing/latency_hist/wakeup/CPU0 <=3D=3D
#Minimum latency: 181 microseconds
#Average latency: 292 microseconds
#Maximum latency: 789 microseconds
#Total samples: 2184
#There are 0 samples lower than 0 microseconds.
#There are 0 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0

=3D=3D> /debugfs/tracing/latency_hist/wakeup/sharedprio/CPU0 <=3D=3D
#Minimum latency: 185 microseconds
#Average latency: 714 microseconds
#Maximum latency: 2661 microseconds
#Total samples: 200
#There are 0 samples lower than 0 microseconds.
#There are 0 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0

=3D=3D> /debugfs/tracing/latency_hist/preemptirqsoff/CPU0 <=3D=3D
#Minimum latency: 12 microseconds
#Average latency: 1991 microseconds
#Maximum latency: 4294954 microseconds
#Total samples: 76773
#There are 0 samples lower than 0 microseconds.
#There are 35 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0

=3D=3D> /debugfs/tracing/latency_hist/preemptoff/CPU0 <=3D=3D
#Minimum latency: 15 microseconds
#Average latency: 236 microseconds
#Maximum latency: 8961 microseconds
#Total samples: 62021
#There are 0 samples lower than 0 microseconds.
#There are 0 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0

=3D=3D> /debugfs/tracing/latency_hist/irqsoff/CPU0 <=3D=3D
#Minimum latency: 12 microseconds
#Average latency: 39 microseconds
#Maximum latency: 1005 microseconds
#Total samples: 100881
#There are 0 samples lower than 0 microseconds.
#There are 0 samples greater or equal than 10240 microseconds.
#usecs           samples
      0                 0
      1                 0
      2                 0
~ #



Cyclictest tests looks ok.

/rt #  ./cyclictest -a -t -n -p99
policy: fifo: loadavg: 0.79 0.37 0.14 1/33 86

T: 0 (   86) P:99 I:1000 C:  10038 Min:     87 Act:  284 Avg:  418 Max:=
=20
    1615


Kernel log:

Ramdisk addr 0x00000003, Compiled-in FDT at 0xc0270550
Linux version 2.6.31.12-rt21 (monstr@monstr.eu) (gcc version 4.1.2) #64=
=20
PREEMPT RT Wed May 19 14:31:53 CEST 2010
setup_cpuinfo: initialising
setup_cpuinfo: Using full CPU PVR support
ERROR: Microblaze DCACHE WB-different for PVR and DTS
cache: wt_msr_noirq
setup_memory: max_mapnr: 0x8000
setup_memory: min_low_pfn: 0x48000
setup_memory: max_low_pfn: 0x50000
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c03360b0, node_mem_map c09df000
   Normal zone: 256 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32=
512
Kernel command line:  console=3DttyS0,115200
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 119552k/131072k available
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Preemptible RCU implementation.
NR_IRQS:32
xlnx,xps-intc-1.00.a #0 at 0xc8000000, num_irq=3D7, edge=3D0x13
xlnx,xps-timer-1.00.a #0 at 0xc8004000, irq=3D4
microblaze_timer_set_mode: shutdown
microblaze_timer_set_mode: periodic
Calibrating delay loop... 44.44 BogoMIPS (lpj=3D222208)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
microblaze_timer_set_mode: oneshot
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 4, 114688 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 233
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq =3D 6) is a 16550A
console [ttyS0] enabled
Device Tree Probing 'ethernet'
xilinx_lltemac 82a80000.ethernet: MAC address is now  0: a:35: 0:22: 1
xilinx_lltemac 82a80000.ethernet: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600080, virt: 0xc8060080
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc
XLlTemac: (buffer_descriptor_init) phy: 0x4ed40000, virt: 0xc6d40000,=20
size: 0x8000
XTemac: PHY detected at address 7.
eth0: Dropping NETIF_F_SG since no checksum feature.
xilinx_lltemac 82a80000.ethernet: eth0: Xilinx TEMAC at 0x82A80000=20
mapped to 0xC805C000, irq=3D5
86000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=3D0x0,size=3D0x20000,blocks=3D255
erase region 1: offset=3D0x1fe0000,size=3D0x8000,blocks=3D4
RedBoot partition parsing not available
Creating 6 MTD partitions on "86000000.flash":
0x000000000000-0x000000100000 : "fpga"
0x000000100000-0x000000140000 : "boot"
0x000000140000-0x000000160000 : "bootenv"
0x000000160000-0x000000180000 : "config"
0x000000180000-0x000000b80000 : "image"
0x000000b80000-0x000002000000 : "spare"
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
***********************************************************************=
******
*     *
*  REMINDER, the following debugging options are turned on in your=20
=2Econfig: *
*     *
*        CONFIG_IRQSOFF_TRACER     *
*        CONFIG_PREEMPT_TRACER     *
*        CONFIG_FTRACE     *
*        CONFIG_INTERRUPT_OFF_HIST     *
*        CONFIG_PREEMPT_OFF_HIST     *
*        CONFIG_WAKEUP_LATENCY_HIST     *
*        CONFIG_MISSED_TIMER_OFFSETS_HIST     *
*     *
*  they may increase runtime overhead and latencies.     *
*     *
***********************************************************************=
******
=46reeing unused kernel memory: 6570k freed
Mounting proc:
Mounting var:
Populating /var:
Running local start scripts.
Mounting debugfs:
Mounting devpts:
Mounting /etc/config:
Populating /etc/config:
flatfsd: Created 4 configuration files (167 bytes)
Mounting sysfs:
Setting hostname:
Bringing up network interfaces:
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 2 for dma mode tx.
eth0: XLlTemac: allocating interrupt 3 for dma mode rx.
eth0: XLlTemac: speed set to 100Mb/s
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
udhcpc (v1.14.3) started
Sending discover...
Sending select for 192.168.0.105...
Lease of 192.168.0.105 obtained, lease time 86400
adding dns 192.168.0.1
Starting portmap:

Welcome to
  _____       _           _      _
| ___ \     | |         | |    (_)
| |_/ / ___ | |_   __ _ | |     _  _ __   _   _ __  __
|  __/ / _ \| __| / _` || |    | || '_ \ | | | |\ \/ /
| |   |  __/| |_ | (_| || |____| || | | || |_| | >  <
\_|    \___| \__| \__,_|\_____/|_||_| |_| \__,_|/_/\_\

on Xilinx-SP605-LTP-basic


Xilinx-SP605-net-csum login: root
Password:
~ #



--=20
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-3009066=
3

--=20
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-3009066=
3
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
