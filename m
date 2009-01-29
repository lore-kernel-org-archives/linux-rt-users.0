From: Jose Angel Martinez Conde <joseangel@taller-id.com>
Subject: bug 2.6.28-rt git
Date: Thu, 29 Jan 2009 15:05:34 +0100 (CET)
Message-ID: <19216537.15711233237934920.JavaMail.root@zimbra.taller-id.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:64786 "EHLO
	zimbra.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752386AbZA2N4k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 08:56:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.taller-id.com (Postfix) with ESMTP id 809BD8D014A
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2009 15:05:39 +0100 (CET)
Received: from zimbra.taller-id.com ([127.0.0.1])
	by localhost (zimbra.taller-id.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ok9uLtK7jcK9 for <linux-rt-users@vger.kernel.org>;
	Thu, 29 Jan 2009 15:05:36 +0100 (CET)
Received: from zimbra.taller-id.com (zimbra.taller-id.com [127.0.0.2])
	by zimbra.taller-id.com (Postfix) with ESMTP id D98CC8D0009
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2009 15:05:35 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi

I get the following message when there is a heavy network activity:

Jan 29 14:07:50 tid31 kernel: BIOS EBDA/lowmem at: 0009f000/0009f000
Jan 29 14:07:50 tid31 kernel: Initializing cgroup subsys cpuset
Jan 29 14:07:50 tid31 kernel: Linux version 2.6.28-rt-tidRT (joseangel@tid31.taller-id.com) (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP PREEMPT RT Thu Jan 29 13:07:01 CET 2009
Jan 29 14:07:50 tid31 kernel: Command line: ro root=UUID=8ed334a2-d5a4-4f36-967f-85ce34f00f36 
Jan 29 14:07:50 tid31 kernel: KERNEL supported cpus:
Jan 29 14:07:50 tid31 kernel:  Intel GenuineIntel
Jan 29 14:07:50 tid31 kernel:  AMD AuthenticAMD
Jan 29 14:07:50 tid31 kernel:  Centaur CentaurHauls
Jan 29 14:07:50 tid31 kernel: BIOS-provided physical RAM map:
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 000000007fef0000 - 000000007fef3000 (ACPI NVS)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 000000007fef3000 - 000000007ff00000 (ACPI data)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
Jan 29 14:07:50 tid31 kernel: BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan 29 14:07:50 tid31 kernel: DMI 2.4 present.
Jan 29 14:07:50 tid31 kernel: Phoenix BIOS detected: BIOS may corrupt low RAM, working it around.
Jan 29 14:07:50 tid31 kernel: last_pfn = 0x7fef0 max_arch_pfn = 0x3ffffffff
Jan 29 14:07:50 tid31 kernel: x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan 29 14:07:50 tid31 kernel: init_memory_mapping: 0000000000000000-000000007fef0000
Jan 29 14:07:50 tid31 kernel: last_map_addr: 7fef0000 end: 7fef0000
Jan 29 14:07:50 tid31 kernel: RAMDISK: 37cf9000 - 37fefdcd
Jan 29 14:07:50 tid31 kernel: ACPI: RSDP 000F7910, 0024 (r2 Nvidia)
Jan 29 14:07:50 tid31 kernel: ACPI: XSDT 7FEF30C0, 004C (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
Jan 29 14:07:50 tid31 kernel: ACPI: FACP 7FEF9880, 00F4 (r3 Nvidia ASUSACPI 42302E31 AWRD        0)
Jan 29 14:07:50 tid31 kernel: FADT: X_PM1a_EVT_BLK.bit_width (8) does not match PM1_EVT_LEN (4)
Jan 29 14:07:50 tid31 kernel: ACPI: DSDT 7FEF3240, 65D6 (r1 NVIDIA ASUSACPI     1000 MSFT  3000000)
Jan 29 14:07:50 tid31 kernel: ACPI: FACS 7FEF0000, 0040
Jan 29 14:07:50 tid31 kernel: ACPI: HPET 7FEF9AC0, 0038 (r1 Nvidia ASUSACPI 42302E31 AWRD       98)
Jan 29 14:07:50 tid31 kernel: ACPI: MCFG 7FEF9B40, 003C (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
Jan 29 14:07:50 tid31 kernel: ACPI: APIC 7FEF99C0, 0098 (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
Jan 29 14:07:50 tid31 kernel: ACPI: SSDT 7FEF9BC0, 087B (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
Jan 29 14:07:50 tid31 kernel: No NUMA configuration found
Jan 29 14:07:50 tid31 kernel: Faking a node at 0000000000000000-000000007fef0000
Jan 29 14:07:50 tid31 kernel: Bootmem setup node 0 0000000000000000-000000007fef0000
Jan 29 14:07:50 tid31 kernel:  NODE_DATA [0000000000012000 - 0000000000025fff]
Jan 29 14:07:50 tid31 kernel:  bootmap [0000000000026000 -  0000000000035fdf] pages 10
Jan 29 14:07:50 tid31 kernel: (6 early reservations) ==> bootmem [0000000000 - 007fef0000]
Jan 29 14:07:50 tid31 kernel:  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Jan 29 14:07:50 tid31 kernel:  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
Jan 29 14:07:50 tid31 kernel:  #2 [0000200000 - 0000992a40]    TEXT DATA BSS ==> [0000200000 - 0000992a40]
Jan 29 14:07:50 tid31 kernel:  #3 [0037cf9000 - 0037fefdcd]          RAMDISK ==> [0037cf9000 - 0037fefdcd]
Jan 29 14:07:50 tid31 kernel:  #4 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
Jan 29 14:07:50 tid31 kernel:  #5 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 - 0000012000]
Jan 29 14:07:50 tid31 kernel: found SMP MP-table at [ffff8800000f5dd0] 000f5dd0
Jan 29 14:07:50 tid31 kernel: Zone PFN ranges:
Jan 29 14:07:50 tid31 kernel:  DMA      0x00000010 -> 0x00001000
Jan 29 14:07:50 tid31 kernel:  DMA32    0x00001000 -> 0x00100000
Jan 29 14:07:50 tid31 kernel:  Normal   0x00100000 -> 0x00100000
Jan 29 14:07:50 tid31 kernel: Movable zone start PFN for each node
Jan 29 14:07:50 tid31 kernel: early_node_map[2] active PFN ranges
Jan 29 14:07:50 tid31 kernel:    0: 0x00000010 -> 0x0000009f
Jan 29 14:07:50 tid31 kernel:    0: 0x00000100 -> 0x0007fef0
Jan 29 14:07:50 tid31 kernel: ACPI: PM-Timer IO Port: 0x1008
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Jan 29 14:07:50 tid31 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Jan 29 14:07:50 tid31 kernel: ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
Jan 29 14:07:50 tid31 kernel: IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
Jan 29 14:07:50 tid31 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan 29 14:07:50 tid31 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jan 29 14:07:50 tid31 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
Jan 29 14:07:50 tid31 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Jan 29 14:07:50 tid31 kernel: ACPI: HPET id: 0x10de8201 base: 0xfeff0000
Jan 29 14:07:50 tid31 kernel: Using ACPI (MADT) for SMP configuration information
Jan 29 14:07:50 tid31 kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Jan 29 14:07:50 tid31 kernel: PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Jan 29 14:07:50 tid31 kernel: PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
Jan 29 14:07:50 tid31 kernel: PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Jan 29 14:07:50 tid31 kernel: Allocating PCI resources starting at 80000000 (gap: 7ff00000:70100000)
Jan 29 14:07:50 tid31 kernel: PERCPU: Allocating 81920 bytes of per cpu data
Jan 29 14:07:50 tid31 kernel: Built 1 zonelists in Node order, mobility grouping on.  Total pages: 514696
Jan 29 14:07:50 tid31 kernel: Policy zone: DMA32
Jan 29 14:07:50 tid31 kernel: Kernel command line: ro root=UUID=8ed334a2-d5a4-4f36-967f-85ce34f00f36 
Jan 29 14:07:50 tid31 kernel: Initializing CPU#0
Jan 29 14:07:50 tid31 kernel: Preemptible RCU implementation.
Jan 29 14:07:50 tid31 kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Jan 29 14:07:50 tid31 kernel: Extended CMOS year: 2000
Jan 29 14:07:50 tid31 kernel: Fast TSC calibration using PIT
Jan 29 14:07:50 tid31 kernel: Detected 3200.283 MHz processor.
Jan 29 14:07:50 tid31 kernel: Console: colour VGA+ 80x25
Jan 29 14:07:50 tid31 kernel: console [tty0] enabled
Jan 29 14:07:50 tid31 kernel: Checking aperture...
Jan 29 14:07:50 tid31 kernel: No AGP bridge found
Jan 29 14:07:50 tid31 kernel: Memory: 2055704k/2096064k available (3483k kernel code, 452k absent, 39908k reserved, 1853k data, 1488k init)
Jan 29 14:07:50 tid31 kernel: HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Jan 29 14:07:50 tid31 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 6400.56 BogoMIPS (lpj=3200283)
Jan 29 14:07:50 tid31 kernel: Security Framework initialized
Jan 29 14:07:50 tid31 kernel: SELinux:  Initializing.
Jan 29 14:07:50 tid31 kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan 29 14:07:50 tid31 kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jan 29 14:07:50 tid31 kernel: Mount-cache hash table entries: 256
Jan 29 14:07:50 tid31 kernel: Initializing cgroup subsys ns
Jan 29 14:07:50 tid31 kernel: Initializing cgroup subsys cpuacct
Jan 29 14:07:50 tid31 kernel: Initializing cgroup subsys devices
Jan 29 14:07:50 tid31 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Jan 29 14:07:50 tid31 kernel: CPU: L2 cache: 2048K
Jan 29 14:07:50 tid31 kernel: CPU 0/0x0 -> Node 0
Jan 29 14:07:50 tid31 kernel: CPU: Physical Processor ID: 0
Jan 29 14:07:50 tid31 kernel: CPU: Processor Core ID: 0
Jan 29 14:07:50 tid31 kernel: CPU0: Thermal monitoring enabled (TM2)
Jan 29 14:07:50 tid31 kernel: using mwait in idle threads.
Jan 29 14:07:50 tid31 kernel: ACPI: Core revision 20080926
Jan 29 14:07:50 tid31 kernel: Setting APIC routing to flat
Jan 29 14:07:50 tid31 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan 29 14:07:50 tid31 kernel: CPU0: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
Jan 29 14:07:50 tid31 kernel: Booting processor 1 APIC 0x1 ip 0x6000
Jan 29 14:07:50 tid31 kernel: Initializing CPU#1
Jan 29 14:07:50 tid31 kernel: Calibrating delay using timer specific routine.. 6399.82 BogoMIPS (lpj=3199913)
Jan 29 14:07:50 tid31 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Jan 29 14:07:50 tid31 kernel: CPU: L2 cache: 2048K
Jan 29 14:07:50 tid31 kernel: CPU 1/0x1 -> Node 0
Jan 29 14:07:50 tid31 kernel: CPU: Physical Processor ID: 0
Jan 29 14:07:50 tid31 kernel: CPU: Processor Core ID: 1
Jan 29 14:07:50 tid31 kernel: CPU1: Thermal monitoring enabled (TM2)
Jan 29 14:07:50 tid31 kernel: x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
Jan 29 14:07:50 tid31 kernel: CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
Jan 29 14:07:50 tid31 kernel: checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Jan 29 14:07:50 tid31 kernel: Brought up 2 CPUs
Jan 29 14:07:50 tid31 kernel: Total of 2 processors activated (12800.39 BogoMIPS).
Jan 29 14:07:50 tid31 kernel: net_namespace: 1520 bytes
Jan 29 14:07:50 tid31 kernel: Booting paravirtualized kernel on bare hardware
Jan 29 14:07:50 tid31 kernel: Time: 13:06:47  Date: 01/29/09
Jan 29 14:07:50 tid31 kernel: NET: Registered protocol family 16
Jan 29 14:07:50 tid31 kernel: ACPI: bus type pci registered
Jan 29 14:07:50 tid31 kernel: PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 31
Jan 29 14:07:50 tid31 kernel: PCI: MCFG area at f0000000 reserved in E820
Jan 29 14:07:50 tid31 kernel: PCI: Using MMCONFIG at f0000000 - f1ffffff
Jan 29 14:07:50 tid31 kernel: PCI: Using configuration type 1 for base access
Jan 29 14:07:50 tid31 kernel: ACPI: Interpreter enabled
Jan 29 14:07:50 tid31 kernel: ACPI: (supports S0 S1 S3 S4 S5)
Jan 29 14:07:50 tid31 kernel: ACPI: Using IOAPIC for interrupt routing
Jan 29 14:07:50 tid31 kernel: ACPI: No dock devices found.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0a.1: PME# supported from D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0a.1: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0b.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0b.1: PME# supported from D0 D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:0b.1: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.1: PME# supported from D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.1: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:14.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:00:14.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan 29 14:07:50 tid31 kernel: pci 0000:02:00.0: PME# supported from D3hot
Jan 29 14:07:50 tid31 kernel: pci 0000:02:00.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan 29 14:07:50 tid31 kernel: pci 0000:03:06.0: PME# supported from D0 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:03:06.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:03:07.0: PME# supported from D1 D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:03:07.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:03:08.0: PME# supported from D2 D3hot D3cold
Jan 29 14:07:50 tid31 kernel: pci 0000:03:08.0: PME# disabled
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.0: transparent bridge
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 *11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 *10 11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 *11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 *10 11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 *10 11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Jan 29 14:07:50 tid31 kernel: usbcore: registered new interface driver usbfs
Jan 29 14:07:50 tid31 kernel: usbcore: registered new interface driver hub
Jan 29 14:07:50 tid31 kernel: usbcore: registered new device driver usb
Jan 29 14:07:50 tid31 kernel: PCI: Using ACPI for IRQ routing
Jan 29 14:07:50 tid31 kernel: NetLabel: Initializing
Jan 29 14:07:50 tid31 kernel: NetLabel:  domain hash size = 128
Jan 29 14:07:50 tid31 kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Jan 29 14:07:50 tid31 kernel: NetLabel:  unlabeled traffic allowed by default
Jan 29 14:07:50 tid31 kernel: hpet0: at MMIO 0xfeff0000, IRQs 2, 8, 31
Jan 29 14:07:50 tid31 kernel: hpet0: 3 comparators, 32-bit 25.000000 MHz counter
Jan 29 14:07:50 tid31 kernel: pnp: PnP ACPI init
Jan 29 14:07:50 tid31 kernel: ACPI: bus type pnp registered
Jan 29 14:07:50 tid31 kernel: pnp: PnP ACPI: found 13 devices
Jan 29 14:07:50 tid31 kernel: ACPI: ACPI bus type pnp unregistered
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1000-0x107f has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1080-0x10ff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1400-0x147f has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1480-0x14ff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1800-0x187f has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:01: ioport range 0x1880-0x18ff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:02: ioport range 0x4d0-0x4d1 has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:02: ioport range 0x800-0x87f has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:02: ioport range 0x290-0x297 has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:02: ioport range 0x880-0x88f has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0b: iomem range 0xf0000000-0xf1ffffff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xdb000-0xdbfff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xf0000-0xf7fff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xf8000-0xfbfff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xfc000-0xfffff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xfeff0000-0xfeff00ff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0x7fef0000-0x7fefffff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xffff0000-0xffffffff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0x0-0x9ffff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0x100000-0x7feeffff could not be reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xfec00000-0xfec00fff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
Jan 29 14:07:50 tid31 kernel: system 00:0c: iomem range 0xfeff0000-0xfeff03ff could not be reserved
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0: PCI bridge, secondary bus 0000:01
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0:   IO window: 0xc000-0xcfff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0:   MEM window: 0xf8000000-0xfbffffff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0:   PREFETCH window: 0x000000e0000000-0x000000efffffff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0: PCI bridge, secondary bus 0000:02
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0:   IO window: 0xe000-0xefff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0:   MEM window: 0xfdc00000-0xfdcfffff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:07.0:   PREFETCH window: 0x000000fdd00000-0x000000fddfffff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.0: PCI bridge, secondary bus 0000:03
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.0:   IO window: 0xd000-0xdfff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.0:   MEM window: 0xfdf00000-0xfdffffff
Jan 29 14:07:50 tid31 kernel: pci 0000:00:10.0:   PREFETCH window: 0x000000fde00000-0x000000fdefffff
Jan 29 14:07:50 tid31 kernel: bus: 00 index 0 io port: [0x00-0xffff]
Jan 29 14:07:50 tid31 kernel: bus: 00 index 1 mmio: [0x000000-0xffffffffffffffff]
Jan 29 14:07:50 tid31 kernel: bus: 01 index 0 io port: [0xc000-0xcfff]
Jan 29 14:07:50 tid31 kernel: bus: 01 index 1 mmio: [0xf8000000-0xfbffffff]
Jan 29 14:07:50 tid31 kernel: bus: 01 index 2 mmio: [0xe0000000-0xefffffff]
Jan 29 14:07:50 tid31 kernel: bus: 01 index 3 mmio: [0x0-0x0]
Jan 29 14:07:50 tid31 kernel: bus: 02 index 0 io port: [0xe000-0xefff]
Jan 29 14:07:50 tid31 kernel: bus: 02 index 1 mmio: [0xfdc00000-0xfdcfffff]
Jan 29 14:07:50 tid31 kernel: bus: 02 index 2 mmio: [0xfdd00000-0xfddfffff]
Jan 29 14:07:50 tid31 kernel: bus: 02 index 3 mmio: [0x0-0x0]
Jan 29 14:07:50 tid31 kernel: bus: 03 index 0 io port: [0xd000-0xdfff]
Jan 29 14:07:50 tid31 kernel: bus: 03 index 1 mmio: [0xfdf00000-0xfdffffff]
Jan 29 14:07:50 tid31 kernel: bus: 03 index 2 mmio: [0xfde00000-0xfdefffff]
Jan 29 14:07:50 tid31 kernel: bus: 03 index 3 io port: [0x00-0xffff]
Jan 29 14:07:50 tid31 kernel: bus: 03 index 4 mmio: [0x000000-0xffffffffffffffff]
Jan 29 14:07:50 tid31 kernel: NET: Registered protocol family 2
Jan 29 14:07:50 tid31 kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Jan 29 14:07:50 tid31 kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan 29 14:07:50 tid31 kernel: TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
Jan 29 14:07:50 tid31 kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jan 29 14:07:50 tid31 kernel: TCP reno registered
Jan 29 14:07:50 tid31 kernel: NET: Registered protocol family 1
Jan 29 14:07:50 tid31 kernel: checking if image is initramfs... it is
Jan 29 14:07:50 tid31 kernel: Freeing initrd memory: 3035k freed
Jan 29 14:07:50 tid31 kernel: audit: initializing netlink socket (disabled)
Jan 29 14:07:50 tid31 kernel: type=2000 audit(1233234407.446:1): initialized
Jan 29 14:07:50 tid31 kernel: HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan 29 14:07:50 tid31 kernel: VFS: Disk quotas dquot_6.5.1
Jan 29 14:07:50 tid31 kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan 29 14:07:50 tid31 kernel: msgmni has been set to 4020
Jan 29 14:07:50 tid31 kernel: alg: No test for stdrng (krng)
Jan 29 14:07:50 tid31 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan 29 14:07:50 tid31 kernel: io scheduler noop registered
Jan 29 14:07:50 tid31 kernel: io scheduler anticipatory registered
Jan 29 14:07:50 tid31 kernel: io scheduler deadline registered
Jan 29 14:07:50 tid31 kernel: io scheduler cfq registered (default)
Jan 29 14:07:50 tid31 kernel: pci 0000:00:03.0: Disabling HT MSI mapping<6>pci 0000:00:07.0: Disabling HT MSI mapping<6>pci 0000:00:09.0: Disabling HT MSI mapping<6>pci 0000:00:0e.0: Disabling HT MSI mapping<6>pci 0000:00:10.0: Disabling HT MSI mapping<6>pci 0000:00:10.1: Disabling HT MSI mapping<7>pci 0000:01:00.0: Boot video device
Jan 29 14:07:50 tid31 kernel: pcieport-driver 0000:00:03.0: found MSI capability
Jan 29 14:07:50 tid31 kernel: pcieport-driver 0000:00:07.0: found MSI capability
Jan 29 14:07:50 tid31 kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan 29 14:07:50 tid31 kernel: input: Power Button (FF) as /class/input/input0
Jan 29 14:07:50 tid31 kernel: ACPI: Power Button (FF) [PWRF]
Jan 29 14:07:50 tid31 kernel: input: Power Button (CM) as /class/input/input1
Jan 29 14:07:50 tid31 kernel: ACPI: Power Button (CM) [PWRB]
Jan 29 14:07:50 tid31 kernel: fan PNP0C0B:00: registered as cooling_device0
Jan 29 14:07:50 tid31 kernel: ACPI: Fan [FAN] (on)
Jan 29 14:07:50 tid31 kernel: processor ACPI_CPU:00: registered as cooling_device1
Jan 29 14:07:50 tid31 kernel: processor ACPI_CPU:01: registered as cooling_device2
Jan 29 14:07:50 tid31 kernel: thermal LNXTHERM:01: registered as thermal_zone0
Jan 29 14:07:50 tid31 kernel: ACPI: Thermal Zone [THRM] (40 C)
Jan 29 14:07:50 tid31 kernel: Real Time Clock Driver v1.12ac
Jan 29 14:07:50 tid31 kernel: Non-volatile memory driver v1.2
Jan 29 14:07:50 tid31 kernel: Linux agpgart interface v0.103
Jan 29 14:07:50 tid31 kernel: Serial: 8250/16550 driver4 ports, IRQ sharing enabled
Jan 29 14:07:50 tid31 kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 29 14:07:50 tid31 kernel: 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 29 14:07:50 tid31 kernel: brd: module loaded
Jan 29 14:07:50 tid31 kernel: input: Macintosh mouse button emulation as /class/input/input2
Jan 29 14:07:50 tid31 kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan 29 14:07:50 tid31 kernel: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan 29 14:07:50 tid31 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 29 14:07:50 tid31 kernel: mice: PS/2 mouse device common for all mice
Jan 29 14:07:50 tid31 kernel: cpuidle: using governor ladder
Jan 29 14:07:50 tid31 kernel: cpuidle: using governor menu
Jan 29 14:07:50 tid31 kernel: usbcore: registered new interface driver hiddev
Jan 29 14:07:50 tid31 kernel: usbcore: registered new interface driver usbhid
Jan 29 14:07:50 tid31 kernel: usbhid: v2.6:USB HID core driver
Jan 29 14:07:50 tid31 kernel: TCP cubic registered
Jan 29 14:07:50 tid31 kernel: Initializing XFRM netlink socket
Jan 29 14:07:50 tid31 kernel: NET: Registered protocol family 17
Jan 29 14:07:50 tid31 kernel: registered taskstats version 1
Jan 29 14:07:50 tid31 kernel:  Magic number: 9:590:130
Jan 29 14:07:50 tid31 kernel: acpi PNP0C02:02: hash matches
Jan 29 14:07:50 tid31 kernel: acpi device:05: hash matches
Jan 29 14:07:50 tid31 kernel: Freeing unused kernel memory: 1488k freed
Jan 29 14:07:50 tid31 kernel: Write protecting the kernel read-only data: 4904k
Jan 29 14:07:50 tid31 kernel: input: AT Translated Set 2 keyboard as /class/input/input3
Jan 29 14:07:50 tid31 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: PCI INT B -> Link[APCL] -> GSI 23 (level, low) -> IRQ 23
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: EHCI Host Controller
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: debug port 1
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: irq 23, io mem 0xfe02e000
Jan 29 14:07:50 tid31 kernel: ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00
Jan 29 14:07:50 tid31 kernel: usb usb1: configuration #1 chosen from 1 choice
Jan 29 14:07:50 tid31 kernel: hub 1-0:1.0: USB hub found
Jan 29 14:07:50 tid31 kernel: hub 1-0:1.0: 8 ports detected
Jan 29 14:07:50 tid31 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jan 29 14:07:50 tid31 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 29 14:07:50 tid31 kernel: usb usb1: Product: EHCI Host Controller
Jan 29 14:07:50 tid31 kernel: usb usb1: Manufacturer: Linux 2.6.28-rt-tidRT ehci_hcd
Jan 29 14:07:50 tid31 kernel: usb usb1: SerialNumber: 0000:00:0b.1
Jan 29 14:07:50 tid31 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
Jan 29 14:07:50 tid31 kernel: ohci_hcd 0000:00:0b.0: PCI INT A -> Link[APCF] -> GSI 22 (level, low) -> IRQ 22
Jan 29 14:07:50 tid31 kernel: ohci_hcd 0000:00:0b.0: OHCI Host Controller
Jan 29 14:07:50 tid31 kernel: ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
Jan 29 14:07:50 tid31 kernel: ohci_hcd 0000:00:0b.0: irq 22, io mem 0xfe02f000
Jan 29 14:07:50 tid31 kernel: usb usb2: configuration #1 chosen from 1 choice
Jan 29 14:07:50 tid31 kernel: hub 2-0:1.0: USB hub found
Jan 29 14:07:50 tid31 kernel: hub 2-0:1.0: 8 ports detected
Jan 29 14:07:50 tid31 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Jan 29 14:07:50 tid31 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 29 14:07:50 tid31 kernel: usb usb2: Product: OHCI Host Controller
Jan 29 14:07:50 tid31 kernel: usb usb2: Manufacturer: Linux 2.6.28-rt-tidRT ohci_hcd
Jan 29 14:07:50 tid31 kernel: usb usb2: SerialNumber: 0000:00:0b.0
Jan 29 14:07:50 tid31 kernel: uhci_hcd: USB Universal Host Controller Interface driver
Jan 29 14:07:50 tid31 kernel: SCSI subsystem initialized
Jan 29 14:07:50 tid31 kernel: Driver 'sd' needs updating - please use bus_type methods
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
Jan 29 14:07:50 tid31 kernel: pata_acpi 0000:00:0e.0: PCI INT A -> Link[APSI] -> GSI 21 (level, low) -> IRQ 21
Jan 29 14:07:50 tid31 kernel: pata_acpi 0000:00:0e.0: PCI INT A disabled
Jan 29 14:07:50 tid31 kernel: usb 2-3: new low speed USB device using ohci_hcd and address 2
Jan 29 14:07:50 tid31 kernel: usb 2-3: configuration #1 chosen from 1 choice
Jan 29 14:07:50 tid31 kernel: input: Logitech USB-PS/2 Optical Mouse as /class/input/input4
Jan 29 14:07:50 tid31 kernel: generic-usb 0003:046D:C03E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-3/input0
Jan 29 14:07:50 tid31 kernel: usb 2-3: New USB device found, idVendor=046d, idProduct=c03e
Jan 29 14:07:50 tid31 kernel: usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Jan 29 14:07:50 tid31 kernel: usb 2-3: Product: USB-PS/2 Optical Mouse
Jan 29 14:07:50 tid31 kernel: usb 2-3: Manufacturer: Logitech
Jan 29 14:07:50 tid31 kernel: sata_nv 0000:00:0e.0: PCI INT A -> Link[APSI] -> GSI 21 (level, low) -> IRQ 21
Jan 29 14:07:50 tid31 kernel: sata_nv 0000:00:0e.0: Using SWNCQ mode
Jan 29 14:07:50 tid31 kernel: scsi0 : sata_nv
Jan 29 14:07:50 tid31 kernel: scsi1 : sata_nv
Jan 29 14:07:50 tid31 kernel: ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xf800 irq 21
Jan 29 14:07:50 tid31 kernel: ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xf808 irq 21
Jan 29 14:07:50 tid31 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan 29 14:07:50 tid31 kernel: ata1.00: ATA-6: WDC WD2000JD-60KLB0, 08.05J08, max UDMA/100
Jan 29 14:07:50 tid31 kernel: ata1.00: 390721968 sectors, multi 1: LBA48 
Jan 29 14:07:50 tid31 kernel: ata1.00: configured for UDMA/100
Jan 29 14:07:50 tid31 kernel: isa bounce pool size: 16 pages
Jan 29 14:07:50 tid31 kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JD-60K 08.0 PQ: 0 ANSI: 5
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] Write Protect is off
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] Write Protect is off
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan 29 14:07:50 tid31 kernel: sda: sda1 sda2 sda3 sda4 sda5
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Jan 29 14:07:50 tid31 kernel: scsi2 : pata_amd
Jan 29 14:07:50 tid31 kernel: scsi3 : pata_amd
Jan 29 14:07:50 tid31 kernel: ata3: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfd00 irq 14
Jan 29 14:07:50 tid31 kernel: ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfd08 irq 15
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC6] enabled at IRQ 16
Jan 29 14:07:50 tid31 kernel: ahci 0000:02:00.0: PCI INT A -> Link[APC6] -> GSI 16 (level, low) -> IRQ 16
Jan 29 14:07:50 tid31 kernel: ahci 0000:02:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
Jan 29 14:07:50 tid31 kernel: ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan 29 14:07:50 tid31 kernel: scsi4 : ahci
Jan 29 14:07:50 tid31 kernel: ata5: SATA max UDMA/133 abar m8192@0xfdcfe000 port 0xfdcfe100 irq 16
Jan 29 14:07:50 tid31 kernel: ata5: SATA link down (SStatus 0 SControl 300)
Jan 29 14:07:50 tid31 kernel: Initializing USB Mass Storage driver...
Jan 29 14:07:50 tid31 kernel: usbcore: registered new interface driver usb-storage
Jan 29 14:07:50 tid31 kernel: USB Mass Storage support registered.
Jan 29 14:07:50 tid31 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 29 14:07:50 tid31 kernel: kjournald starting.  Commit interval 5 seconds
Jan 29 14:07:50 tid31 kernel: SELinux:  Disabled at runtime.
Jan 29 14:07:50 tid31 kernel: type=1404 audit(1233234427.143:2): selinux=0 auid=4294967295 ses=4294967295
Jan 29 14:07:50 tid31 kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan 29 14:07:50 tid31 kernel: ACPI: I/O resource nForce2_smbus [0x1c00-0x1c3f] conflicts with ACPI region SM00 [0x1c00-0x1c05]
Jan 29 14:07:50 tid31 kernel: ACPI: Device needs an ACPI driver
Jan 29 14:07:50 tid31 kernel: i2c-adapter i2c-0: nForce2 SMBus adapter at 0x1c00
Jan 29 14:07:50 tid31 kernel: i2c-adapter i2c-1: nForce2 SMBus adapter at 0x1c80
Jan 29 14:07:50 tid31 kernel: input: PC Speaker as /class/input/input5
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Jan 29 14:07:50 tid31 kernel: ohci1394 0000:03:08.0: PCI INT A -> Link[APC3] -> GSI 18 (level, low) -> IRQ 18
Jan 29 14:07:50 tid31 kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[fdffe000-fdffe7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Jan 29 14:07:50 tid31 kernel: forcedeth: Reverse Engineered nForce ethernet driver. Version 0.61.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Jan 29 14:07:50 tid31 kernel: forcedeth 0000:00:14.0: PCI INT A -> Link[APCH] -> GSI 20 (level, low) -> IRQ 20
Jan 29 14:07:50 tid31 kernel: 8139too Fast Ethernet driver 0.9.28
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Jan 29 14:07:50 tid31 kernel: 8139too 0000:03:07.0: PCI INT A -> Link[APC2] -> GSI 17 (level, low) -> IRQ 17
Jan 29 14:07:50 tid31 kernel: eth0: RealTek RTL8139 at 0xffffc2000035e000, 00:48:54:8d:74:37, IRQ 17
Jan 29 14:07:50 tid31 kernel: parport_pc 00:09: reported by Plug and Play ACPI
Jan 29 14:07:50 tid31 kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
Jan 29 14:07:50 tid31 kernel: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
Jan 29 14:07:50 tid31 kernel: udev: renamed network interface eth0 to eth2
Jan 29 14:07:50 tid31 kernel: ppdev: user-space parallel port driver
Jan 29 14:07:50 tid31 kernel: Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
Jan 29 14:07:50 tid31 kernel: Copyright (c) 1999-2006 Intel Corporation.
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
Jan 29 14:07:50 tid31 kernel: e1000 0000:03:06.0: PCI INT A -> Link[APC1] -> GSI 16 (level, low) -> IRQ 16
Jan 29 14:07:50 tid31 kernel: forcedeth 0000:00:14.0: ifname eth0, PHY OUI 0x5043 @ 1, addr 00:1b:fc:cf:ea:c8
Jan 29 14:07:50 tid31 kernel: forcedeth 0000:00:14.0: highdma pwrctl timirq gbit lnktim desc-v3
Jan 29 14:07:50 tid31 kernel: ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
Jan 29 14:07:50 tid31 kernel: HDA Intel 0000:00:10.1: PCI INT B -> Link[AAZA] -> GSI 23 (level, low) -> IRQ 23
Jan 29 14:07:50 tid31 kernel: e1000: 0000:03:06.0: e1000_probe: (PCI:33MHz:32-bit) 00:1b:21:28:dc:a4
Jan 29 14:07:50 tid31 kernel: e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Jan 29 14:07:50 tid31 kernel: device-mapper: uevent: version 1.0.3
Jan 29 14:07:50 tid31 kernel: device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
Jan 29 14:07:50 tid31 kernel: device-mapper: multipath: version 1.0.5 loaded
Jan 29 14:07:50 tid31 kernel: EXT3 FS on sda2, internal journal
Jan 29 14:07:50 tid31 kernel: kjournald starting.  Commit interval 5 seconds
Jan 29 14:07:50 tid31 kernel: EXT3 FS on sda4, internal journal
Jan 29 14:07:50 tid31 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 29 14:07:50 tid31 kernel: Adding 3068404k swap on /dev/sda5.  Priority:-1 extents:1 across:3068404k
Jan 29 14:07:50 tid31 kernel: NET: Registered protocol family 10
Jan 29 14:07:50 tid31 kernel: lo: Disabled Privacy Extensions
Jan 29 14:07:50 tid31 kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Jan 29 14:07:50 tid31 kernel: e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
Jan 29 14:07:50 tid31 kernel: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Jan 29 14:07:50 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:07:50 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:07:50 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:07:50 tid31 kernel: Call Trace:
Jan 29 14:07:50 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:07:50 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:07:50 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:07:50 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:07:50 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:07:50 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:07:50 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:07:50 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:07:50 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:07:50 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:07:50 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:07:50 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:07:50 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:07:50 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:07:50 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:07:50 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:07:50 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:07:50 tid31 kernel: RPC: Registered udp transport module.
Jan 29 14:07:50 tid31 kernel: RPC: Registered tcp transport module.
Jan 29 14:07:51 tid31 kernel: warning: `dbus-daemon' uses deprecated v2 capabilities in a way that may be insecure.
Jan 29 14:07:52 tid31 acpid: starting up
Jan 29 14:07:55 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:07:55 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:07:55 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:07:55 tid31 kernel: Call Trace:
Jan 29 14:07:55 tid31 kernel: [<ffffffff8103d422>] ? default_wake_function+0x12/0x20
Jan 29 14:07:55 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:07:55 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:07:55 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:07:55 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:07:55 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:07:55 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:07:55 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:07:55 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:07:55 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:07:55 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:07:55 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:07:55 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:07:55 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:07:55 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:07:55 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:07:55 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:07:55 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:07:56 tid31 acpid: client connected from 2080[68:68]
Jan 29 14:07:58 tid31 acpid: client connected from 2151[0:0]
Jan 29 14:08:03 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:08:03 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:08:03 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:08:03 tid31 kernel: Call Trace:
Jan 29 14:08:03 tid31 kernel: [<ffffffff8103d422>] ? default_wake_function+0x12/0x20
Jan 29 14:08:03 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:08:03 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:08:03 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:08:03 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:08:03 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:08:03 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:08:03 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:08:03 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:08:03 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:08:03 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:08:03 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:08:03 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:08:03 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:08:03 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:08:03 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:08:03 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:08:03 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:08:06 tid31 init: prefdm main process (2107) terminated with status 1
Jan 29 14:08:06 tid31 /usr/sbin/gpm[2306]: *** info [startup.c(95)]: 
Jan 29 14:08:06 tid31 /usr/sbin/gpm[2306]: Started gpm successfully. Entered daemon mode.
Jan 29 14:08:43 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:08:43 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:08:43 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:08:43 tid31 kernel: Call Trace:
Jan 29 14:08:43 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:08:43 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:08:43 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:08:43 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:08:43 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:08:43 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:08:43 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:08:43 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:08:43 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:08:43 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:08:43 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:08:43 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:08:43 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:08:43 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:08:43 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:08:43 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:08:43 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:09:13 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:09:13 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:09:13 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:09:13 tid31 kernel: Call Trace:
Jan 29 14:09:13 tid31 kernel: [<ffffffff8103d422>] ? default_wake_function+0x12/0x20
Jan 29 14:09:13 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:09:13 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:09:13 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:09:13 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:09:13 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:09:13 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:09:13 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:09:13 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:09:13 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:09:13 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:09:13 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:09:13 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:09:13 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:09:13 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:09:13 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:09:13 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:09:13 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:09:33 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:09:33 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:09:33 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:09:33 tid31 kernel: Call Trace:
Jan 29 14:09:33 tid31 kernel: [<ffffffff8103d422>] ? default_wake_function+0x12/0x20
Jan 29 14:09:33 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:09:33 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:09:33 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:09:33 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:09:33 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:09:33 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:09:33 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:09:33 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:09:33 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:09:33 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:09:33 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:09:33 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:09:33 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:09:33 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:09:33 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:09:33 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:09:33 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:15:16 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:15:16 tid31 kernel: in_atomic(): 1 [00000100], irqs_disabled(): 0, pid: 20, name: sirq-timer/1
Jan 29 14:15:16 tid31 kernel: Pid: 20, comm: sirq-timer/1 Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:15:16 tid31 kernel: Call Trace:
Jan 29 14:15:16 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:15:16 tid31 kernel: [<ffffffff8135ea01>] __rt_spin_lock+0x81/0x90
Jan 29 14:15:16 tid31 kernel: [<ffffffff8135ec5d>] rt_read_lock+0x3d/0x60
Jan 29 14:15:16 tid31 kernel: [<ffffffff8131f717>] fn_hash_lookup+0x27/0xf0
Jan 29 14:15:16 tid31 kernel: [<ffffffff81320476>] fib4_rule_action+0x66/0x80
Jan 29 14:15:16 tid31 kernel: [<ffffffff812cc0e3>] fib_rules_lookup+0xc3/0x110
Jan 29 14:15:16 tid31 kernel: [<ffffffff81320602>] fib_lookup+0x32/0x50
Jan 29 14:15:16 tid31 kernel: [<ffffffff812e19ea>] __ip_route_output_key+0x66a/0xba0
Jan 29 14:15:16 tid31 kernel: [<ffffffff81013920>] ? nommu_map_single+0x0/0xa0
Jan 29 14:15:16 tid31 kernel: [<ffffffff81310da0>] icmp_send+0x270/0x6a0
Jan 29 14:15:16 tid31 kernel: [<ffffffff810286f9>] ? default_spin_lock_flags+0x9/0x10
Jan 29 14:15:16 tid31 kernel: [<ffffffff8109eeab>] ? cpupri_set+0xfb/0x160
Jan 29 14:15:16 tid31 kernel: [<ffffffff812deb1d>] ipv4_link_failure+0x1d/0x60
Jan 29 14:15:16 tid31 kernel: [<ffffffff8130de9c>] arp_error_report+0x2c/0x40
Jan 29 14:15:16 tid31 kernel: [<ffffffff812c5235>] neigh_timer_handler+0x165/0x4f0
Jan 29 14:15:16 tid31 kernel: [<ffffffff812c50d0>] ? neigh_timer_handler+0x0/0x4f0
Jan 29 14:15:16 tid31 kernel: [<ffffffff8105221e>] run_timer_softirq+0x20e/0x410
Jan 29 14:15:16 tid31 kernel: [<ffffffff8104c4ff>] ksoftirqd+0x12f/0x2a0
Jan 29 14:15:16 tid31 kernel: [<ffffffff8104c3d0>] ? ksoftirqd+0x0/0x2a0
Jan 29 14:15:16 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:15:16 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:15:16 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:15:16 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11
Jan 29 14:15:16 tid31 kernel: BUG: unbalanced timer-handler preempt count in neigh_timer_handler+0x0/0x4f0!
Jan 29 14:15:16 tid31 kernel: entered with 00000000, exited with 00000100.
Jan 29 14:17:13 tid31 kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Jan 29 14:17:13 tid31 kernel: in_atomic(): 1 [00000001], irqs_disabled(): 1, pid: 1097, name: kauditd
Jan 29 14:17:13 tid31 kernel: Pid: 1097, comm: kauditd Not tainted 2.6.28-rt-tidRT #1
Jan 29 14:17:13 tid31 kernel: Call Trace:
Jan 29 14:17:13 tid31 kernel: [<ffffffff8103d422>] ? default_wake_function+0x12/0x20
Jan 29 14:17:13 tid31 kernel: [<ffffffff81037bfe>] __might_sleep+0xfe/0x110
Jan 29 14:17:13 tid31 kernel: [<ffffffff8135ea91>] rt_spin_lock+0x81/0x90
Jan 29 14:17:13 tid31 kernel: [<ffffffff8110f371>] ep_poll_callback+0x21/0xf0
Jan 29 14:17:13 tid31 kernel: [<ffffffff81035b2a>] __wake_up_common+0x5a/0x90
Jan 29 14:17:13 tid31 kernel: [<ffffffff8103785a>] __wake_up_sync+0x4a/0x70
Jan 29 14:17:13 tid31 kernel: [<ffffffff812af49e>] sock_def_readable+0x3e/0x70
Jan 29 14:17:13 tid31 kernel: [<ffffffff812d9e10>] netlink_sendskb+0x30/0x60
Jan 29 14:17:13 tid31 kernel: [<ffffffff812db36d>] netlink_unicast+0x23d/0x2e0
Jan 29 14:17:13 tid31 kernel: [<ffffffff81087b1a>] kauditd_send_skb+0x2a/0x90
Jan 29 14:17:13 tid31 kernel: [<ffffffff81087c19>] kauditd_thread+0x99/0x1f0
Jan 29 14:17:13 tid31 kernel: [<ffffffff8103d410>] ? default_wake_function+0x0/0x20
Jan 29 14:17:13 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:17:13 tid31 kernel: [<ffffffff81087b80>] ? kauditd_thread+0x0/0x1f0
Jan 29 14:17:13 tid31 kernel: [<ffffffff8105ee79>] kthread+0x49/0x90
Jan 29 14:17:13 tid31 kernel: [<ffffffff8100da09>] child_rip+0xa/0x11
Jan 29 14:17:13 tid31 kernel: [<ffffffff8105ee30>] ? kthread+0x0/0x90
Jan 29 14:17:13 tid31 kernel: [<ffffffff8100d9ff>] ? child_rip+0x0/0x11


Regards,

--
Jose Angel 
