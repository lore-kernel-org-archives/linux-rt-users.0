From: John Sigler <linux.kernel@free.fr>
Subject: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 11:06:41 +0200
Message-ID: <470B44A1.7080007@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000600070103080407090401"
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:47682 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXJIJGn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:06:43 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------000600070103080407090401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm using a -rt kernel with high resolution timer support.
http://rt.wiki.kernel.org/index.php/Main_Page
Linux version 2.6.22.1-rt9 (root@venus) (gcc version 3.4.6) #1 PREEMPT 
RT Tue Oct 9 10:02:45 CEST 2007

I enabled high resolution timer support and disabled ACPI support.

CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_SMP is not set
...
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_TRACE is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
...
CONFIG_MTRR=y
CONFIG_REGPARM=y
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100

High resolution timers do not work in this configuration.

Consider the following app where I request a 2 ms sleep
(where the time quantum is 10 ms).

#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <sched.h>

static void set_SCHED_RR(int priority)
{
   struct sched_param param = { 0 };
   param.sched_priority = priority;
   int err = sched_setscheduler(0, SCHED_RR, &param);
   if (err) perror("sched_setscheduler");
}

int main(void)
{
   struct timespec t0, t1, ms = { 0, 2000000 };
   set_SCHED_RR(20);
   while ( 1 )
   {
     clock_gettime(CLOCK_REALTIME, &t0);
     nanosleep(&ms, NULL);
     clock_gettime(CLOCK_REALTIME, &t1);

     long diff = (t1.tv_sec-t0.tv_sec)*1000000000 + (t1.tv_nsec-t0.tv_nsec);
     printf("delta = %ld\n", diff);
   }

   return 0;
}

# ./test
delta = 6026911
delta = 9926038
delta = 9989993
delta = 9995600
delta = 9993176
delta = 9994805
delta = 9994822
delta = 9994978
delta = 9994912
delta = 9994998
delta = 9994878
delta = 9994513

Any idea why?

# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
tsc pit jiffies

# cat /sys/devices/system/clocksource/clocksource0/current_clocksource
tsc

My timestamp counter is good. Why do I need ACPI for hrt?

I've attached dmesg output.

Regards.

--------------000600070103080407090401
Content-Type: text/plain;
 name="dmesg.no.acpi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.no.acpi.txt"

Linux version 2.6.22.1-rt9 (root@venus) (gcc version 3.4.6) #1 PREEMPT RT Tue Oct 9 10:02:45 CEST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
 BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
254MB LOWMEM available.
found SMP MP-table at 000f4fa0
Entering add_active_range(0, 0, 65264) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    65264
early_node_map[1] active PFN ranges
    0:        0 ->    65264
On node 0 totalpages: 65264
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 477 pages used for memmap
  Normal zone: 60691 pages, LIFO batch:15
DMI 2.2 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 10000000 (gap: 0ff00000:eed00000)
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 64755
Kernel command line: ro root=/dev/hdc1 console=ttyS0,57600n8 console=tty0 panic=3 apic=debug nmi_watchdog=0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 2400.000 MHz processor.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256308k/261056k available (1274k kernel code, 4252k reserved, 451k data, 128k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffbc000 - 0xfffff000   ( 268 kB)
    vmalloc : 0xd0800000 - 0xfffba000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xcfef0000   ( 254 MB)
      .init : 0xc02b2000 - 0xc02d2000   ( 128 kB)
      .data : 0xc023e9ef - 0xc02af92c   ( 451 kB)
      .text : 0xc0100000 - 0xc023e9ef   (1274 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4802.76 BogoMIPS (lpj=24013820)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
Getting VERSION: 50014
Getting VERSION: 50014
Getting ID: 0
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-7, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22 not connected.
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  0    0    0   0   0    1    1    59
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    61
 0d 001 01  0    0    0   0   0    1    1    69
 0e 001 01  0    0    0   0   0    1    1    71
 0f 001 01  0    0    0   0   0    1    1    79
 10 001 01  1    1    0   1   0    1    1    81
 11 001 01  1    1    0   1   0    1    1    89
 12 001 01  1    1    0   1   0    1    1    91
 13 001 01  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
... lapic delta = 833376
... PM timer delta = 0
..... delta 833376
..... mult: 35793226
..... calibration result: 1333401
..... CPU clock speed is 2400.1228 MHz.
..... host bus clock speed is 133.3401 MHz.
... verify APIC timer
... jiffies delta = 10
... jiffies result ok
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
querying PCI -> IRQ mapping bus:0, slot:2, pin:0.
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 16
querying PCI -> IRQ mapping bus:0, slot:31, pin:0.
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 16
querying PCI -> IRQ mapping bus:0, slot:31, pin:1.
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
querying PCI -> IRQ mapping bus:1, slot:2, pin:0.
PCI->APIC IRQ transform: 0000:01:02.0[A] -> IRQ 16
querying PCI -> IRQ mapping bus:1, slot:3, pin:0.
PCI->APIC IRQ transform: 0000:01:03.0[A] -> IRQ 17
querying PCI -> IRQ mapping bus:1, slot:4, pin:0.
PCI->APIC IRQ transform: 0000:01:04.0[A] -> IRQ 18
querying PCI -> IRQ mapping bus:1, slot:5, pin:0.
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 19
querying PCI -> IRQ mapping bus:1, slot:15, pin:0.
PCI->APIC IRQ transform: 0000:01:0f.0[A] -> IRQ 23
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: ec000000-edffffff
  PREFETCH window: 10000000-100fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 6, 294912 bytes)
TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered (default)
Boot video device is 0000:00:02.0
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:01:02.0: e1000_probe: (PCI:33MHz:32-bit) 00:0b:ab:14:32:31
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:01:03.0: e1000_probe: (PCI:33MHz:32-bit) 00:0b:ab:14:32:32
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:01:04.0: e1000_probe: (PCI:33MHz:32-bit) 00:0b:ab:14:32:33
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:01:05.0: e1000_probe: (PCI:33MHz:32-bit) 00:0b:ab:14:32:34
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: PQI IDE DiskOnModule, ATA DISK drive
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0x04 { DriveStatusError }
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 256000 sectors (131 MB) w/1KiB Cache, CHS=500/16/32
 hdc: hdc1 hdc2 hdc3 hdc4
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 128k freed
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX

--------------000600070103080407090401--
