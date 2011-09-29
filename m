From: johnohagan <mail@johnohagan.com>
Subject: 3.0.0-1-rt-amd64: Suspend hangs
Date: Fri, 30 Sep 2011 01:01:28 +1000
Message-ID: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?=
	<u.kleine-koenig@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from razor.vivawebhost.com ([173.237.190.106]:49670 "EHLO
	razor.vivawebhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab1I2QDC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 12:03:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Running Debian testing on an HP Mini 5102 with non-RT kernel, suspend to ram, suspend to disk and resume work as expected. With the RT kernels from both testing and Sid, attempting to suspend may result in a lock-up, with a blank screen and high fan operation. Keyboard and Sysrq keys are unresponsive and a hard shutdown is necessary. This happens randomly AFAIKT, of the order of half the time, possibly more often if larger programs are running, but still occurs in single-user mode.

I ran the tests using /sys/power/pm_test described here:
https://raw.github.com/torvalds/linux/master/Documentation/power/basic-pm-debugging.txt

The freeze occurs with pm_test set to "processors", but not with "platform". 

With "single no_console_suspend" on the kernel command-line and trying STD, the screen messages are normal up to the point of saving the image, and remain there after the freeze. For STR the screen is blank when the freeze happens.

There is one tainted module on my system, brcmsmac, which I blacklisted for the testing.

I've submitted this as Debian bug #643301, and am sending this summary here on the advice of Debian maintainers.

/var/log/dmesg for boot with Sid kernel is copied below.

Regards,

John O'Hagan



[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.0-1-rt-amd64 (Debian 3.0.0-4) (ben@decadent.org.uk) (gcc version 4.5.3 (Debian 4.5.3-9) ) #1 SMP PREEMPT RT Tue Sep 20 08:38:06 UTC 2011
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-rt-amd64 root=UUID=c3ec997b-c6e2-4fb0-882c-de8659f24c67 ro quiet
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007a5e5000 (usable)
[    0.000000]  BIOS-e820: 000000007a5e5000 - 000000007a5e7000 (reserved)
[    0.000000]  BIOS-e820: 000000007a5e7000 - 000000007d03f000 (usable)
[    0.000000]  BIOS-e820: 000000007d03f000 - 000000007d240000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007d240000 - 000000007e80b000 (usable)
[    0.000000]  BIOS-e820: 000000007e80b000 - 000000007e813000 (reserved)
[    0.000000]  BIOS-e820: 000000007e813000 - 000000007e815000 (usable)
[    0.000000]  BIOS-e820: 000000007e815000 - 000000007e816000 (reserved)
[    0.000000]  BIOS-e820: 000000007e816000 - 000000007e819000 (usable)
[    0.000000]  BIOS-e820: 000000007e819000 - 000000007e876000 (reserved)
[    0.000000]  BIOS-e820: 000000007e876000 - 000000007e8d4000 (usable)
[    0.000000]  BIOS-e820: 000000007e8d4000 - 000000007e90f000 (reserved)
[    0.000000]  BIOS-e820: 000000007e90f000 - 000000007e934000 (usable)
[    0.000000]  BIOS-e820: 000000007e934000 - 000000007e944000 (reserved)
[    0.000000]  BIOS-e820: 000000007e944000 - 000000007ea44000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ea44000 - 000000007ea74000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ea74000 - 000000007f600000 (usable)
[    0.000000]  BIOS-e820: 000000007f600000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Hewlett-Packard HP Mini 5102 (VB558AV)/3653, BIOS 68PGU Ver. F.08 08/12/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x7f600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFE00000 mask 0FFE00000 write-protect
[    0.000000]   1 base 07F600000 mask 0FFF00000 uncachable
[    0.000000]   2 base 000000000 mask 080000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-000000007f600000
[    0.000000]  0000000000 - 007f600000 page 2M
[    0.000000] kernel direct mapping tables up to 7f600000 @ 7f5fd000-7f600000
[    0.000000] RAMDISK: 36cb6000 - 37653000
[    0.000000] ACPI: RSDP 00000000000fddc0 00024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 000000007ea73120 00074 (v01 HPQOEM SLIC-MPC 0000000F      01000013)
[    0.000000] ACPI: FACP 000000007ea71000 000F4 (v03 HPQOEM 3653     0000000F HP   00000001)
[    0.000000] ACPI: DSDT 000000007ea4f000 1CEA2 (v01 HPQOEM 3653     00000001 INTL 20060912)
[    0.000000] ACPI: FACS 000000007ea36000 00040
[    0.000000] ACPI: HPET 000000007ea70000 00038 (v01 HPQOEM 3653     00000001 HP   00000001)
[    0.000000] ACPI: APIC 000000007ea6f000 000BC (v01 HPQOEM 3653     00000001 HP   00000001)
[    0.000000] ACPI: MCFG 000000007ea6e000 0003C (v01 HPQOEM 3653     00000001 HP   00000001)
[    0.000000] ACPI: ASF! 000000007ea6d000 000A0 (v32 HPQOEM 3653     00000001 HP   00000001)
[    0.000000] ACPI: SSDT 000000007ea4e000 0064F (v01 HPQOEM  SataPri 00001000 INTL 20060912)
[    0.000000] ACPI: SSDT 000000007ea4d000 00692 (v01 HPQOEM  SataSec 00001000 INTL 20060912)
[    0.000000] ACPI: SLIC 000000007ea4a000 00176 (v01 HPQOEM SLIC-MPC 00000001 HP   00000001)
[    0.000000] ACPI: SSDT 000000007ea49000 0005F (v01 HPQOEM   HPQNLP 00000001 INTL 20060912)
[    0.000000] ACPI: SSDT 000000007ea48000 0066C (v01  PmRef    CpuPm 00003000 INTL 20060912)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007f600000
[    0.000000] Initmem setup node 0 0000000000000000-000000007f600000
[    0.000000]   NODE_DATA [000000007f5f8000 - 000000007f5fcfff]
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff88007b000000-ffff88007cbfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[9] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007a5e5
[    0.000000]     0: 0x0007a5e7 -> 0x0007d03f
[    0.000000]     0: 0x0007d240 -> 0x0007e80b
[    0.000000]     0: 0x0007e813 -> 0x0007e815
[    0.000000]     0: 0x0007e816 -> 0x0007e819
[    0.000000]     0: 0x0007e876 -> 0x0007e8d4
[    0.000000]     0: 0x0007e90f -> 0x0007e934
[    0.000000]     0: 0x0007ea74 -> 0x0007f600
[    0.000000] On node 0 totalpages: 520619
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3922 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7077 pages used for memmap
[    0.000000]   DMA32 zone: 509559 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 6 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007a5e5000 - 000000007a5e7000
[    0.000000] PM: Registered nosave memory: 000000007d03f000 - 000000007d240000
[    0.000000] PM: Registered nosave memory: 000000007e80b000 - 000000007e813000
[    0.000000] PM: Registered nosave memory: 000000007e815000 - 000000007e816000
[    0.000000] PM: Registered nosave memory: 000000007e819000 - 000000007e876000
[    0.000000] PM: Registered nosave memory: 000000007e8d4000 - 000000007e90f000
[    0.000000] PM: Registered nosave memory: 000000007e934000 - 000000007e944000
[    0.000000] PM: Registered nosave memory: 000000007e944000 - 000000007ea44000
[    0.000000] PM: Registered nosave memory: 000000007ea44000 - 000000007ea74000
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 105 pages/cpu @ffff88007f000000 s400128 r8192 d21760 u524288
[    0.000000] pcpu-alloc: s400128 r8192 d21760 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 513481
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-rt-amd64 root=UUID=c3ec997b-c6e2-4fb0-882c-de8659f24c67 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 2031420k/2086912k available (3390k kernel code, 4436k absent, 51056k reserved, 3336k data, 884k init)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1662.655 MHz processor.
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.31 BogoMIPS (lpj=6650620)
[    0.004020] pid_max: default: 32768 minimum: 301
[    0.008152] Security Framework initialized
[    0.008160] SELinux:  Disabled at boot.
[    0.008825] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.010826] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.011749] Mount-cache hash table entries: 256
[    0.012264] Initializing cgroup subsys cpuacct
[    0.012279] Initializing cgroup subsys memory
[    0.012317] Initializing cgroup subsys devices
[    0.012323] Initializing cgroup subsys freezer
[    0.012328] Initializing cgroup subsys net_cls
[    0.012333] Initializing cgroup subsys blkio
[    0.012471] Disabled fast string operations
[    0.012479] CPU: Physical Processor ID: 0
[    0.012483] CPU: Processor Core ID: 0
[    0.012487] mce: CPU supports 5 MCE banks
[    0.012505] CPU0: Thermal monitoring enabled (TM1)
[    0.012515] using mwait in idle threads.
[    0.013084] ACPI: Core revision 20110413
[    0.042056] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.081763] CPU0: Intel(R) Atom(TM) CPU N450   @ 1.66GHz stepping 0a
[    0.084004] Performance Events: PEBS fmt0+, Atom events, Intel PMU driver.
[    0.084004] ... version:                3
[    0.084004] ... bit width:              40
[    0.084004] ... generic registers:      2
[    0.084004] ... value mask:             000000ffffffffff
[    0.084004] ... max period:             000000007fffffff
[    0.084004] ... fixed-purpose events:   3
[    0.084004] ... event mask:             0000000700000003
[    0.097011] NMI watchdog enabled, takes one hw-pmu counter.
[    0.116115] Booting Node   0, Processors  #1
[    0.116122] smpboot cpu 1: start_ip = 9a000
[    0.008000] Disabled fast string operations
[    0.208132] NMI watchdog enabled, takes one hw-pmu counter.
[    0.212044] Brought up 2 CPUs
[    0.212053] Total of 2 processors activated (6650.21 BogoMIPS).
[    0.213178] devtmpfs: initialized
[    0.221139] PM: Registering ACPI NVS region at 7d03f000 (2101248 bytes)
[    0.222453] PM: Registering ACPI NVS region at 7e944000 (1048576 bytes)
[    0.224453] print_constraints: dummy: 
[    0.225044] NET: Registered protocol family 16
[    0.226073] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.226079] ACPI: bus type pci registered
[    0.226664] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.226672] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.516443] PCI: Using configuration type 1 for base access
[    0.522646] bio: create slab <bio-0> at 0
[    0.530598] ACPI: EC: Look up EC in DSDT
[    0.570952] ACPI: Executed 1 blocks of module-level executable AML code
[    0.752245] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.886130] ACPI: SSDT 000000007e93ac98 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
[    0.888196] ACPI: Dynamic OEM Table Load:
[    0.888203] ACPI: SSDT           (null) 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
[    0.890222] ACPI: SSDT 000000007e938818 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
[    0.892110] ACPI: Dynamic OEM Table Load:
[    0.892116] ACPI: SSDT           (null) 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
[    0.920925] ACPI: SSDT 000000007e939e18 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
[    0.923335] ACPI: Dynamic OEM Table Load:
[    0.923342] ACPI: SSDT           (null) 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
[    0.934043] ACPI: SSDT 000000007e93af18 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)
[    0.935956] ACPI: Dynamic OEM Table Load:
[    0.935962] ACPI: SSDT           (null) 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)
[    1.089289] ACPI: Interpreter enabled
[    1.089298] ACPI: (supports S0 S3 S4 S5)
[    1.089535] ACPI: Using IOAPIC for interrupt routing
[    1.122193] ACPI: Power Resource [APPR] (off)
[    1.199764] ACPI: Power Resource [PFN0] (off)
[    1.200663] ACPI: Power Resource [PFN1] (off)
[    1.201505] ACPI: Power Resource [PFN2] (off)
[    1.202333] ACPI: Power Resource [PFN3] (off)
[    1.203166] ACPI: Power Resource [PFN4] (off)
[    1.212466] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    1.214568] ACPI: No dock devices found.
[    1.214574] HEST: Table not found.
[    1.214582] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.231339] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.242059] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.242067] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.242073] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.242081] pci_root PNP0A08:00: host bridge window [mem 0x80000000-0xfebfffff]
[    1.242135] pci 0000:00:00.0: [8086:a010] type 0 class 0x000600
[    1.242227] pci 0000:00:02.0: [8086:a011] type 0 class 0x000300
[    1.242245] pci 0000:00:02.0: reg 10: [mem 0x94480000-0x944fffff]
[    1.242256] pci 0000:00:02.0: reg 14: [io  0x50a0-0x50a7]
[    1.242267] pci 0000:00:02.0: reg 18: [mem 0x80000000-0x8fffffff pref]
[    1.242277] pci 0000:00:02.0: reg 1c: [mem 0x94300000-0x943fffff]
[    1.242355] pci 0000:00:02.1: [8086:a012] type 0 class 0x000380
[    1.242370] pci 0000:00:02.1: reg 10: [mem 0x94400000-0x9447ffff]
[    1.242529] pci 0000:00:1b.0: [8086:27d8] type 0 class 0x000403
[    1.242560] pci 0000:00:1b.0: reg 10: [mem 0x94500000-0x94503fff 64bit]
[    1.242666] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.242675] pci 0000:00:1b.0: PME# disabled
[    1.242734] pci 0000:00:1c.0: [8086:27d0] type 1 class 0x000604
[    1.242841] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.242850] pci 0000:00:1c.0: PME# disabled
[    1.242913] pci 0000:00:1c.2: [8086:27d4] type 1 class 0x000604
[    1.243021] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.243030] pci 0000:00:1c.2: PME# disabled
[    1.243091] pci 0000:00:1c.3: [8086:27d6] type 1 class 0x000604
[    1.243198] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.243207] pci 0000:00:1c.3: PME# disabled
[    1.243273] pci 0000:00:1d.0: [8086:27c8] type 0 class 0x000c03
[    1.243338] pci 0000:00:1d.0: reg 20: [io  0x5060-0x507f]
[    1.243419] pci 0000:00:1d.1: [8086:27c9] type 0 class 0x000c03
[    1.243487] pci 0000:00:1d.1: reg 20: [io  0x5040-0x505f]
[    1.243567] pci 0000:00:1d.2: [8086:27ca] type 0 class 0x000c03
[    1.243633] pci 0000:00:1d.2: reg 20: [io  0x5020-0x503f]
[    1.243713] pci 0000:00:1d.3: [8086:27cb] type 0 class 0x000c03
[    1.243779] pci 0000:00:1d.3: reg 20: [io  0x5000-0x501f]
[    1.243874] pci 0000:00:1d.7: [8086:27cc] type 0 class 0x000c03
[    1.243906] pci 0000:00:1d.7: reg 10: [mem 0x94504400-0x945047ff]
[    1.244027] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.244036] pci 0000:00:1d.7: PME# disabled
[    1.244129] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    1.244271] pci 0000:00:1f.0: [8086:27bc] type 0 class 0x000601
[    1.244467] pci 0000:00:1f.2: [8086:27c0] type 0 class 0x000101
[    1.244495] pci 0000:00:1f.2: reg 10: [io  0x5098-0x509f]
[    1.244511] pci 0000:00:1f.2: reg 14: [io  0x50ac-0x50af]
[    1.244528] pci 0000:00:1f.2: reg 18: [io  0x5090-0x5097]
[    1.244544] pci 0000:00:1f.2: reg 1c: [io  0x50a8-0x50ab]
[    1.244560] pci 0000:00:1f.2: reg 20: [io  0x5080-0x508f]
[    1.244576] pci 0000:00:1f.2: reg 24: [mem 0x94504000-0x945043ff]
[    1.244624] pci 0000:00:1f.2: PME# supported from D3hot
[    1.244632] pci 0000:00:1f.2: PME# disabled
[    1.244786] pci 0000:01:00.0: [14e4:4353] type 0 class 0x000280
[    1.244824] pci 0000:01:00.0: reg 10: [mem 0x94200000-0x94203fff 64bit]
[    1.244971] pci 0000:01:00.0: supports D1 D2
[    1.245034] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.245043] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.245053] pci 0000:00:1c.0:   bridge window [mem 0x94200000-0x942fffff]
[    1.245066] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.245158] pci 0000:00:1c.2: PCI bridge to [bus 02-42]
[    1.245167] pci 0000:00:1c.2:   bridge window [io  0x3000-0x4fff]
[    1.245176] pci 0000:00:1c.2:   bridge window [mem 0x90200000-0x941fffff]
[    1.245188] pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.245579] pci 0000:43:00.0: [11ab:4381] type 0 class 0x000200
[    1.245836] pci 0000:43:00.0: reg 10: [mem 0x90100000-0x90103fff 64bit]
[    1.245982] pci 0000:43:00.0: reg 18: [io  0x2000-0x20ff]
[    1.246492] pci 0000:43:00.0: reg 30: [mem 0xfffe0000-0xffffffff pref]
[    1.246969] pci 0000:43:00.0: supports D1 D2
[    1.246974] pci 0000:43:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.247014] pci 0000:43:00.0: PME# disabled
[    1.247281] pci 0000:00:1c.3: PCI bridge to [bus 43-43]
[    1.247289] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    1.247298] pci 0000:00:1c.3:   bridge window [mem 0x90100000-0x901fffff]
[    1.247311] pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.247437] pci 0000:00:1e.0: PCI bridge to [bus 44-44] (subtractive decode)
[    1.247446] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.247456] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0x900fffff]
[    1.247468] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.247478] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    1.247487] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    1.247496] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.247505] pci 0000:00:1e.0:   bridge window [mem 0x80000000-0xfebfffff] (subtractive decode)
[    1.247556] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.250377] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.251354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    1.252366] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    1.253585] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    1.253753] ACPI Warning: For \_SB_.PCI0.PCIB._PRT: Return Package has no elements (empty) (20110413/nspredef-456)
[    1.265240]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.291519]  pci0000:00: ACPI _OSC control (0x1d) granted
[    1.373537] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.374212] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
[    1.374884] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.375555] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    1.376291] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.376968] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.377644] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.378317] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.379303] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.379487] vgaarb: loaded
[    1.379491] vgaarb: bridge control possible 0000:00:02.0
[    1.379928] PCI: Using ACPI for IRQ routing
[    1.389146] PCI: pci_cache_line_size set to 64 bytes
[    1.389718] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    1.389729] reserve RAM buffer: 000000007a5e5000 - 000000007bffffff 
[    1.389742] reserve RAM buffer: 000000007d03f000 - 000000007fffffff 
[    1.389790] reserve RAM buffer: 000000007e80b000 - 000000007fffffff 
[    1.389833] reserve RAM buffer: 000000007e815000 - 000000007fffffff 
[    1.389870] reserve RAM buffer: 000000007e819000 - 000000007fffffff 
[    1.389901] reserve RAM buffer: 000000007e8d4000 - 000000007fffffff 
[    1.389928] reserve RAM buffer: 000000007e934000 - 000000007fffffff 
[    1.389948] reserve RAM buffer: 000000007f600000 - 000000007fffffff 
[    1.390877] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    1.390891] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.390901] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    1.400465] Switching to clocksource hpet
[    1.426971] pnp: PnP ACPI init
[    1.427082] ACPI: bus type pnp registered
[    1.432485] pnp 00:00: [bus 00-ff]
[    1.432496] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.432505] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.432514] pnp 00:00: [io  0x0d00-0xffff window]
[    1.432523] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.432531] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.432540] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.432549] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.432558] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.432566] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.432575] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.432595] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.432604] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.432613] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.432622] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.432631] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.432639] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.432648] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.432657] pnp 00:00: [mem 0x80000000-0xfebfffff window]
[    1.432666] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    1.433160] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.434437] pnp 00:01: [mem 0xfed1c000-0xfed1ffff]
[    1.434447] pnp 00:01: [mem 0xfed14000-0xfed17fff]
[    1.434455] pnp 00:01: [mem 0xfed18000-0xfed18fff]
[    1.434464] pnp 00:01: [mem 0xfed19000-0xfed19fff]
[    1.434472] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    1.434480] pnp 00:01: [mem 0xfec00000-0xfec00fff]
[    1.434489] pnp 00:01: [mem 0xfed20000-0xfed3ffff]
[    1.434497] pnp 00:01: [mem 0xfed45000-0xfed8ffff]
[    1.435005] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.435020] system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
[    1.435034] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.435047] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.435061] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    1.435080] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.435094] system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.435107] system 00:01: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.435124] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.437725] pnp 00:02: [io  0x0000-0x001f]
[    1.437735] pnp 00:02: [io  0x0081-0x0091]
[    1.437744] pnp 00:02: [io  0x0093-0x009f]
[    1.437752] pnp 00:02: [io  0x00c0-0x00df]
[    1.437760] pnp 00:02: [dma 4]
[    1.438125] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.438215] pnp 00:03: [mem 0xff000000-0xffffffff]
[    1.438564] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    1.439838] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    1.440274] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.440389] pnp 00:05: [io  0x00f0]
[    1.440416] pnp 00:05: [irq 13]
[    1.440774] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.440885] pnp 00:06: [io  0x002e-0x002f]
[    1.440894] pnp 00:06: [io  0x004e-0x004f]
[    1.440902] pnp 00:06: [io  0x0061]
[    1.440910] pnp 00:06: [io  0x0063]
[    1.440928] pnp 00:06: [io  0x0065]
[    1.440936] pnp 00:06: [io  0x0067]
[    1.440943] pnp 00:06: [io  0x0070]
[    1.440951] pnp 00:06: [io  0x0080]
[    1.440959] pnp 00:06: [io  0x0092]
[    1.440967] pnp 00:06: [io  0x00b2-0x00b3]
[    1.440975] pnp 00:06: [io  0x0200-0x027f]
[    1.440983] pnp 00:06: [io  0x1000-0x1003]
[    1.440991] pnp 00:06: [io  0x1010-0x101f]
[    1.440999] pnp 00:06: [io  0xffff]
[    1.441007] pnp 00:06: [io  0x0400-0x047f]
[    1.441015] pnp 00:06: [io  0x0500-0x057f]
[    1.441023] pnp 00:06: [io  0xef80-0xef9f]
[    1.441664] system 00:06: [io  0x0200-0x027f] has been reserved
[    1.441688] system 00:06: [io  0x1000-0x1003] has been reserved
[    1.441702] system 00:06: [io  0x1010-0x101f] has been reserved
[    1.441716] system 00:06: [io  0xffff] has been reserved
[    1.441730] system 00:06: [io  0x0400-0x047f] has been reserved
[    1.441743] system 00:06: [io  0x0500-0x057f] has been reserved
[    1.441757] system 00:06: [io  0xef80-0xef9f] has been reserved
[    1.441773] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.441864] pnp 00:07: [io  0x0070-0x0077]
[    1.441883] pnp 00:07: [irq 8]
[    1.442245] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.446209] pnp 00:08: [io  0x0280-0x0287]
[    1.446230] pnp 00:08: [irq 6]
[    1.446773] pnp 00:08: Plug and Play ACPI device, IDs WACf010 (active)
[    1.446869] pnp 00:09: [io  0x0060]
[    1.446878] pnp 00:09: [io  0x0064]
[    1.446895] pnp 00:09: [irq 1]
[    1.447292] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.447406] pnp 00:0a: [irq 12]
[    1.447793] pnp 00:0a: Plug and Play ACPI device, IDs SYN0170 SYN0100 SYN0002 PNP0f13 (active)
[    1.448332] pnp 00:0b: [irq 23]
[    1.448753] pnp 00:0b: Plug and Play ACPI device, IDs HPQ0004 (active)
[    1.451902] pnp: PnP ACPI: found 12 devices
[    1.451907] ACPI: ACPI bus type pnp unregistered
[    1.474287] pci 0000:43:00.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
[    1.474308] PCI: max bus depth: 1 pci_try_num: 2
[    1.474418] pci 0000:00:1c.3: BAR 15: assigned [mem 0x94600000-0x946fffff pref]
[    1.474443] pci 0000:00:1c.2: BAR 15: assigned [mem 0x94800000-0x949fffff 64bit pref]
[    1.474465] pci 0000:00:1c.0: BAR 15: assigned [mem 0x94a00000-0x94bfffff 64bit pref]
[    1.474482] pci 0000:00:1c.0: BAR 13: assigned [io  0x6000-0x6fff]
[    1.474502] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.474510] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    1.474521] pci 0000:00:1c.0:   bridge window [mem 0x94200000-0x942fffff]
[    1.474530] pci 0000:00:1c.0:   bridge window [mem 0x94a00000-0x94bfffff 64bit pref]
[    1.474543] pci 0000:00:1c.2: PCI bridge to [bus 02-42]
[    1.474550] pci 0000:00:1c.2:   bridge window [io  0x3000-0x4fff]
[    1.474561] pci 0000:00:1c.2:   bridge window [mem 0x90200000-0x941fffff]
[    1.474571] pci 0000:00:1c.2:   bridge window [mem 0x94800000-0x949fffff 64bit pref]
[    1.474591] pci 0000:43:00.0: BAR 6: assigned [mem 0x94600000-0x9461ffff pref]
[    1.474601] pci 0000:00:1c.3: PCI bridge to [bus 43-43]
[    1.474608] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    1.474618] pci 0000:00:1c.3:   bridge window [mem 0x90100000-0x901fffff]
[    1.474627] pci 0000:00:1c.3:   bridge window [mem 0x94600000-0x947fffff pref]
[    1.474640] pci 0000:00:1e.0: PCI bridge to [bus 44-44]
[    1.474644] pci 0000:00:1e.0:   bridge window [io  disabled]
[    1.474654] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0x900fffff]
[    1.474662] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    1.474739] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.474751] pci 0000:00:1c.0: setting latency timer to 64
[    1.474802] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.474811] pci 0000:00:1c.2: setting latency timer to 64
[    1.474848] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    1.474857] pci 0000:00:1c.3: setting latency timer to 64
[    1.474872] pci 0000:00:1e.0: setting latency timer to 64
[    1.474881] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.474887] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.474893] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.474899] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff]
[    1.474905] pci_bus 0000:01: resource 0 [io  0x6000-0x6fff]
[    1.474911] pci_bus 0000:01: resource 1 [mem 0x94200000-0x942fffff]
[    1.474917] pci_bus 0000:01: resource 2 [mem 0x94a00000-0x94bfffff 64bit pref]
[    1.474923] pci_bus 0000:02: resource 0 [io  0x3000-0x4fff]
[    1.474929] pci_bus 0000:02: resource 1 [mem 0x90200000-0x941fffff]
[    1.474935] pci_bus 0000:02: resource 2 [mem 0x94800000-0x949fffff 64bit pref]
[    1.474941] pci_bus 0000:43: resource 0 [io  0x2000-0x2fff]
[    1.474947] pci_bus 0000:43: resource 1 [mem 0x90100000-0x901fffff]
[    1.474953] pci_bus 0000:43: resource 2 [mem 0x94600000-0x947fffff pref]
[    1.474959] pci_bus 0000:44: resource 1 [mem 0x90000000-0x900fffff]
[    1.474965] pci_bus 0000:44: resource 4 [io  0x0000-0x0cf7]
[    1.474971] pci_bus 0000:44: resource 5 [io  0x0d00-0xffff]
[    1.474977] pci_bus 0000:44: resource 6 [mem 0x000a0000-0x000bffff]
[    1.474983] pci_bus 0000:44: resource 7 [mem 0x80000000-0xfebfffff]
[    1.475559] NET: Registered protocol family 2
[    1.476810] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.483816] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    1.490041] TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
[    1.492786] TCP: Hash tables configured (established 262144 bind 65536)
[    1.492797] TCP reno registered
[    1.492953] UDP hash table entries: 1024 (order: 5, 131072 bytes)
[    1.493178] UDP-Lite hash table entries: 1024 (order: 5, 131072 bytes)
[    1.494302] NET: Registered protocol family 1
[    1.494412] pci 0000:00:02.0: Boot video device
[    1.494900] PCI: CLS 64 bytes, default 64
[    1.495337] Unpacking initramfs...
[    2.155334] Freeing initrd memory: 9844k freed
[    2.172157] audit: initializing netlink socket (disabled)
[    2.172226] type=2000 audit(1317223223.168:1): initialized
[    2.208635] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.210145] VFS: Disk quotas dquot_6.5.2
[    2.210575] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.211174] msgmni has been set to 3986
[    2.212629] alg: No test for stdrng (krng)
[    2.212882] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.212891] io scheduler noop registered
[    2.212897] io scheduler deadline registered
[    2.213040] io scheduler cfq registered (default)
[    2.213906] pcieport 0000:00:1c.0: setting latency timer to 64
[    2.214007] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
[    2.214622] pcieport 0000:00:1c.2: setting latency timer to 64
[    2.214711] pcieport 0000:00:1c.2: irq 41 for MSI/MSI-X
[    2.215310] pcieport 0000:00:1c.3: setting latency timer to 64
[    2.215410] pcieport 0000:00:1c.3: irq 42 for MSI/MSI-X
[    2.216510] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    2.216517] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    2.216527] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    2.216799] pcieport 0000:00:1c.2: Signaling PME through PCIe PME interrupt
[    2.216809] pcie_pme 0000:00:1c.2:pcie01: service driver pcie_pme loaded
[    2.217087] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    2.217092] pci 0000:43:00.0: Signaling PME through PCIe PME interrupt
[    2.217102] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    2.218154] ERST: Table is not found!
[    2.218577] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.297271] 00:08: ttyS0 at I/O 0x280 (irq = 6) is a 16550A
[    2.313699] Linux agpgart interface v0.103
[    2.314922] agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset
[    2.315590] agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
[    2.316329] agpgart-intel 0000:00:00.0: detected 8192K stolen memory
[    2.316793] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
[    2.317771] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.319769] i8042: Detected active multiplexing controller, rev 1.1
[    2.320850] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.320878] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    2.320894] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    2.320909] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    2.320924] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    2.321580] mousedev: PS/2 mouse device common for all mice
[    2.321778] rtc_cmos 00:07: RTC can wake from S4
[    2.322284] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    2.322531] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    2.322658] cpuidle: using governor ladder
[    2.326719] TCP cubic registered
[    2.327159] NET: Registered protocol family 10
[    2.336982] Mobile IPv6
[    2.336997] NET: Registered protocol family 17
[    2.337025] Registering the dns_resolver key type
[    2.337938] PM: Hibernation image not present or could not be loaded.
[    2.338050] registered taskstats version 1
[    2.340228] rtc_cmos 00:07: setting system clock to 2011-09-28 15:20:23 UTC (1317223223)
[    2.341107] Initializing network drop monitor service
[    2.344659] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    2.348272] Freeing unused kernel memory: 884k freed
[    2.349472] Write protecting the kernel read-only data: 6144k
[    2.360130] Freeing unused kernel memory: 688k freed
[    2.371406] Freeing unused kernel memory: 712k freed
[    2.449373] udevd[55]: starting version 172
[    3.121535] usbcore: registered new interface driver usbfs
[    3.121792] usbcore: registered new interface driver hub
[    3.143065] sky2: driver version 1.28
[    3.143305] sky2 0000:43:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    3.143348] sky2 0000:43:00.0: setting latency timer to 64
[    3.143477] sky2 0000:43:00.0: Yukon-2 Optima chip revision 1
[    3.143758] sky2 0000:43:00.0: irq 43 for MSI/MSI-X
[    3.155828] usbcore: registered new device driver usb
[    3.159326] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.159555] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.159648] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    3.159659] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    3.159900] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    3.168106] Refined TSC clocksource calibration: 1662.499 MHz.
[    3.168122] Switching to clocksource tsc
[    3.168258] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    3.168284] ehci_hcd 0000:00:1d.7: debug port 1
[    3.189931] ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
[    3.202308] ehci_hcd 0000:00:1d.7: irq 20, io mem 0x94504400
[    3.211331] sky2 0000:43:00.0: eth0: addr d8:d3:85:14:47:b6
[    3.216278] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    3.216785] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.216795] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.216803] usb usb1: Product: EHCI Host Controller
[    3.216811] usb usb1: Manufacturer: Linux 3.0.0-1-rt-amd64 ehci_hcd
[    3.216818] usb usb1: SerialNumber: 0000:00:1d.7
[    3.218310] hub 1-0:1.0: USB hub found
[    3.218379] hub 1-0:1.0: 8 ports detected
[    3.220695] SCSI subsystem initialized
[    3.222794] uhci_hcd: USB Universal Host Controller Interface driver
[    3.223112] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.223150] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.223161] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.225318] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.229914] thermal LNXTHERM:00: registered as thermal_zone0
[    3.229922] ACPI: Thermal Zone [DTSZ] (56 C)
[    3.231325] ACPI: Fan [FAN0] (off)
[    3.232686] ACPI: Fan [FAN1] (off)
[    3.233947] ACPI: Fan [FAN2] (off)
[    3.240215] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00005060
[    3.240741] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.240751] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.240759] usb usb2: Product: UHCI Host Controller
[    3.240766] usb usb2: Manufacturer: Linux 3.0.0-1-rt-amd64 uhci_hcd
[    3.240773] usb usb2: SerialNumber: 0000:00:1d.0
[    3.242193] hub 2-0:1.0: USB hub found
[    3.242257] hub 2-0:1.0: 2 ports detected
[    3.242583] ACPI: Fan [FAN3] (off)
[    3.249681] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    3.249715] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    3.249725] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.250272] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    3.251492] uhci_hcd 0000:00:1d.1: irq 22, io base 0x00005040
[    3.251986] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.251996] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.252386] usb usb3: Product: UHCI Host Controller
[    3.252394] usb usb3: Manufacturer: Linux 3.0.0-1-rt-amd64 uhci_hcd
[    3.252402] usb usb3: SerialNumber: 0000:00:1d.1
[    3.272983] hub 3-0:1.0: USB hub found
[    3.273054] hub 3-0:1.0: 2 ports detected
[    3.281754] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    3.281792] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    3.281803] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.281887] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    3.284536] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00005020
[    3.285062] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.285072] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.285081] usb usb4: Product: UHCI Host Controller
[    3.285088] usb usb4: Manufacturer: Linux 3.0.0-1-rt-amd64 uhci_hcd
[    3.285094] usb usb4: SerialNumber: 0000:00:1d.2
[    3.298577] hub 4-0:1.0: USB hub found
[    3.298649] hub 4-0:1.0: 2 ports detected
[    3.302971] libata version 3.00 loaded.
[    3.308242] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    3.308282] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    3.308293] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    3.308395] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    3.312618] uhci_hcd 0000:00:1d.3: irq 19, io base 0x00005000
[    3.313112] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.313122] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.313130] usb usb5: Product: UHCI Host Controller
[    3.313137] usb usb5: Manufacturer: Linux 3.0.0-1-rt-amd64 uhci_hcd
[    3.313145] usb usb5: SerialNumber: 0000:00:1d.3
[    3.314534] hub 5-0:1.0: USB hub found
[    3.314597] hub 5-0:1.0: 2 ports detected
[    3.324114] ata_piix 0000:00:1f.2: version 2.13
[    3.324164] ata_piix 0000:00:1f.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    3.324186] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    3.380524] thermal LNXTHERM:01: registered as thermal_zone1
[    3.380532] ACPI: Thermal Zone [CPUZ] (57 C)
[    3.381715] ACPI: Fan [FAN4] (off)
[    3.453292] thermal LNXTHERM:02: registered as thermal_zone2
[    3.453300] ACPI: Thermal Zone [SKNZ] (49 C)
[    3.480286] ata_piix 0000:00:1f.2: setting latency timer to 64
[    3.495565] scsi0 : ata_piix
[    3.504204] scsi1 : ata_piix
[    3.524700] thermal LNXTHERM:03: registered as thermal_zone3
[    3.524709] ACPI: Thermal Zone [BATZ] (30 C)
[    3.544300] thermal LNXTHERM:04: registered as thermal_zone4
[    3.544308] ACPI: Thermal Zone [FDTZ] (21 C)
[    3.550620] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x5080 irq 14
[    3.550628] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x5088 irq 15
[    3.640096] usb 1-4: new high speed USB device number 3 using ehci_hcd
[    3.724278] ata1.00: ATA-8: Hitachi HTS725016A9A364, PCBOC72E, max UDMA/100
[    3.724286] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.740274] ata1.00: configured for UDMA/100
[    3.740776] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72501 PCBO PQ: 0 ANSI: 5
[    3.774287] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    3.774709] sd 0:0:0:0: [sda] Write Protect is off
[    3.774716] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.774893] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.811035] usb 1-4: New USB device found, idVendor=04f2, idProduct=b159
[    3.811042] usb 1-4: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[    3.811048] usb 1-4: Product: CNF8243
[    3.811052] usb 1-4: Manufacturer: Chicony Electronics Co., Ltd.
[    3.811057] usb 1-4: SerialNumber: SN0001
[    4.052069] usb 2-2: new full speed USB device number 2 using uhci_hcd
[    4.130523]  sda: sda1 sda2 < sda5 >
[    4.133044] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.142721] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.217446] usb 2-2: New USB device found, idVendor=03f0, idProduct=231d
[    4.217454] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.217459] usb 2-2: Product: HP Integrated Module
[    4.217464] usb 2-2: Manufacturer: Broadcom Corp
[    5.322979] PM: Starting manual resume from disk
[    5.322987] PM: Hibernation image partition 8:5 present
[    5.322991] PM: Looking for hibernation image.
[    5.323346] PM: Image not found (code -22)
[    5.323352] PM: Hibernation image not present or could not be loaded.
[    5.374138] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    5.374146] EXT4-fs (sda1): write access will be enabled during recovery
[    5.496634] EXT4-fs (sda1): recovery complete
[    5.497245] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    7.560846] udevd[272]: starting version 172
[    8.463252] ACPI: acpi_idle registered with cpuidle
[    8.470913] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
[    8.470940] ACPI: Sleep Button [SLPB]
[    8.471662] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
[    8.520153] ACPI: Lid Switch [LID]
[    8.536156] Monitor-Mwait will be used to enter C-1 state
[    8.544475] Monitor-Mwait will be used to enter C-2 state
[    8.552163] Monitor-Mwait will be used to enter C-3 state
[    8.552209] Marking TSC unstable due to TSC halts in idle
[    8.554831] Switching to clocksource hpet
[    8.575996] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    8.576116] ACPI: Power Button [PWRF]
[    8.679728] ACPI: AC Adapter [AC] (off-line)
[    8.948265] ACPI: Battery Slot [BAT0] (battery present)
[    8.971964] hp_accel: hardware type Mini510x found
[    8.984214] lis3lv02d: 8 bits sensor found
[    9.039632] wmi: Mapper loaded
[    9.174126] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input4
[    9.196352] Registered led device: hp::hddprotect
[    9.197834] hp_accel: driver loaded
[    9.450897] udevd[296]: renamed network interface eth0 to eth2
[    9.514914] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    9.837386] cfg80211: Calling CRDA to update world regulatory domain
[    9.855396] [drm] Initialized drm 1.1.0 20060810
[   10.017134] brcmutil: module is from the staging directory, the quality is unknown, you have been warned.
[   10.043915] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.043926] i915 0000:00:02.0: setting latency timer to 64
[   10.295117] brcmsmac: module is from the staging directory, the quality is unknown, you have been warned.
[   10.377439] brcmsmac 0000:01:00.0: bus 1 slot 0 func 0 irq 5
[   10.377476] brcmsmac 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.377493] brcmsmac 0000:01:00.0: setting latency timer to 64
[   10.415637] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04711/0xa00000/0x20000
[   10.433469] Bluetooth: Core ver 2.16
[   10.433634] NET: Registered protocol family 31
[   10.433640] Bluetooth: HCI device and connection manager initialized
[   10.433654] Bluetooth: HCI socket layer initialized
[   10.433665] Bluetooth: L2CAP socket layer initialized
[   10.441631] Bluetooth: SCO socket layer initialized
[   10.466117] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input6
[   10.591322] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   10.597731] usbcore: registered new interface driver btusb
[   10.981020] input: HP WMI hotkeys as /devices/virtual/input/input7
[   11.096115] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   11.123963] i915 0000:00:02.0: irq 44 for MSI/MSI-X
[   11.124308] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   11.124316] [drm] Driver supports precise vblank timestamp query.
[   11.124772] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   11.346454] Linux media interface: v0.10
[   11.375873] Linux video capture interface: v2.00
[   11.426608] uvcvideo: Found UVC 1.00 device CNF8243 (04f2:b159)
[   11.485993] input: CNF8243 as /devices/pci0000:00/0000:00:1d.7/usb1/1-4/1-4:1.0/input/input8
[   11.486615] usbcore: registered new interface driver uvcvideo
[   11.486622] USB Video Class driver (v1.1.0)
[   11.543934] [drm] initialized overlay support
[   11.619747] fbcon: inteldrmfb (fb0) is primary device
[   11.692706] Console: switching to colour frame buffer device 170x48
[   11.708685] fb0: inteldrmfb frame buffer device
[   11.708692] drm: registered panic notifier
[   11.911618] acpi device:0d: registered as cooling_device7
[   11.915550] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input9
[   11.916280] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   11.916787] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   11.922483] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   11.922517] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   11.922540] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   11.922762] HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[   11.923301] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   12.038757] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input10
[   12.057425] input: HDA Intel Mic at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   12.058393] input: HDA Intel HP Out at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   13.273859] Adding 3994620k swap on /dev/sda5.  Priority:-1 extents:1 across:3994620k 
[   13.296351] EXT4-fs (sda1): re-mounted. Opts: (null)
[   13.534945] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   13.807698] loop: module loaded
[   16.203988] fuse init (API version 7.16)
[   20.576440] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
[   20.579398] DECnet: Routing cache hash table of 1024 buckets, 56Kbytes
[   20.579466] NET: Registered protocol family 12
[   21.022455] sky2 0000:43:00.0: eth2: enabling interface
[   21.023251] ADDRCONF(NETDEV_UP): eth2: link is not ready
[   21.483020] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input13
[   25.627157] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   25.627166] Bluetooth: BNEP filters: protocol multicast
[   25.692735] Bluetooth: RFCOMM TTY layer initialized
[   25.692784] Bluetooth: RFCOMM socket layer initialized
[   25.692791] Bluetooth: RFCOMM ver 1.11

