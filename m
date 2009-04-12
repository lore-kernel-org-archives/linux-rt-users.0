From: Grammostola Rosea <rosea.grammostola@gmail.com>
Subject: Debian RT and rt2500
Date: Sun, 12 Apr 2009 14:36:52 +0200
Message-ID: <49E1E064.6000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq4.gn.mail.iss.as9143.net ([212.54.34.167]:45762 "EHLO
	smtpq4.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760259AbZDLMlf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 Apr 2009 08:41:35 -0400
Received: from [212.54.34.146] (helo=smtp15.gn.mail.iss.as9143.net)
	by smtpq4.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1Lsz09-0004TE-Dn
	for linux-rt-users@vger.kernel.org; Sun, 12 Apr 2009 14:41:33 +0200
Received: from cc305009-a.groni1.gr.home.nl ([82.73.157.254] helo=[192.168.1.104])
	by smtp15.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1Lsz04-0004qG-7Q
	for linux-rt-users@vger.kernel.org; Sun, 12 Apr 2009 14:41:29 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I want to build an RT kernel with rt2500 wireless enabled. I use the 
config file of an .29.1 kernel which has rt2500 enabled. After make 
oldconfig, I expect that rt2500 is still enabled, but this is not true 
:/ And this is unexpected to me. And I don't know how to enable it. Some 
help is needed here.

Thanks in advance,

\r

Here an log

scripts/kconfig/conf -o arch/x86/Kconfig
*
* Restart config...
*
*
* General setup
*
Prompt for development and/or incomplete code/drivers (EXPERIMENTAL) 
[Y/n/?] y
Local version - append to kernel release (LOCALVERSION) []
Automatically append version information to the version string 
(LOCALVERSION_AUTO) [N/y/?] n
Kernel compression mode
 > 1. Gzip (KERNEL_GZIP) (NEW)
  2. Bzip2 (KERNEL_BZIP2) (NEW)
  3. LZMA (KERNEL_LZMA) (NEW)
choice[1-3?]: Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [Y/n/?] y
BSD Process Accounting (BSD_PROCESS_ACCT) [Y/n/?] y
  BSD Process Accounting version 3 file format (BSD_PROCESS_ACCT_V3) 
[Y/n/?] y
Export task/process statistics through netlink (EXPERIMENTAL) 
(TASKSTATS) [Y/n/?] y
  Enable per-task delay accounting (EXPERIMENTAL) (TASK_DELAY_ACCT) 
[Y/n/?] y
  Enable extended accounting over taskstats (EXPERIMENTAL) (TASK_XACCT) 
[Y/n/?] y
    Enable per-task storage I/O accounting (EXPERIMENTAL) 
(TASK_IO_ACCOUNTING) [Y/n/?] y
Auditing support (AUDIT) [Y/n/?] y
  Enable system-call auditing support (AUDITSYSCALL) [Y/n/?] y
Kernel .config support (IKCONFIG) [N/m/y/?] n
Kernel log buffer size (16 => 64KB, 17 => 128KB) (LOG_BUF_SHIFT) [17] 17
Group CPU scheduler (GROUP_SCHED) [Y/n/?] y
  Group scheduling for SCHED_OTHER (FAIR_GROUP_SCHED) [Y/n] y
  Group scheduling for SCHED_RR/FIFO (RT_GROUP_SCHED) [N/y/?] n
  Basis for grouping tasks
    1. user id (USER_SCHED)
  > 2. Control groups (CGROUP_SCHED)
  choice[1-2]: 2
Create deprecated sysfs layout for older userspace tools 
(SYSFS_DEPRECATED_V2) [N/y/?] n
Kernel->user space relay support (formerly relayfs) (RELAY) [Y/?] y
Namespaces support (NAMESPACES) [Y/?] y
  UTS namespace (UTS_NS) [Y/n/?] y
  IPC namespace (IPC_NS) [Y/n/?] y
  User namespace (EXPERIMENTAL) (USER_NS) [Y/n/?] y
  PID Namespaces (EXPERIMENTAL) (PID_NS) [Y/n/?] y
  Network namespace (NET_NS) [Y/n/?] y
Initial RAM filesystem and RAM disk (initramfs/initrd) support 
(BLK_DEV_INITRD) [Y/n/?] y
  Initramfs source file(s) (INITRAMFS_SOURCE) []
  Initial ramdisk compressed using gzip (RD_GZIP) [Y/n/?] (NEW)   
Initial ramdisk compressed using bzip2 (RD_BZIP2) [N/y/?] (NEW)   
Initial ramdisk compressed using lzma (RD_LZMA) [N/y/?] (NEW)   Built-in 
initramfs compression mode
  > 1. None (INITRAMFS_COMPRESSION_NONE) (NEW)
    2. Gzip (INITRAMFS_COMPRESSION_GZIP) (NEW)
  choice[1-2?]: Optimize for size (CC_OPTIMIZE_FOR_SIZE) [Y/n/?] y
*
* Performance Counters
*
Kernel Performance Counters (PERF_COUNTERS) [Y/n/?] (NEW) Disable heap 
randomization (COMPAT_BRK) [N/y/?] n
Choose SLAB allocator
 > 1. SLAB (SLAB)
  2. SLUB (Unqueued Allocator) (SLUB)
choice[1-2?]: 1
Profiling support (EXPERIMENTAL) (PROFILING) [Y/n/?] y
Activate markers (MARKERS) [Y/?] y
OProfile system profiling (EXPERIMENTAL) (OPROFILE) [M/n/y/?] m
  OProfile AMD IBS support (EXPERIMENTAL) (OPROFILE_IBS) [Y/n/?] y
Kprobes (KPROBES) [N/y/?] n
*
* Processor type and features
*
Tickless System (Dynamic Ticks) (NO_HZ) [Y/n/?] y
High Resolution Timer Support (HIGH_RES_TIMERS) [Y/n/?] y
Symmetric multi-processing support (SMP) [Y/n/?] y
Support sparse irq numbering (SPARSE_IRQ) [N/y/?] n
Enable MPS table (X86_MPPARSE) [Y/n/?] y
Support for big SMP systems with more than 8 CPUs (X86_BIGSMP) [N/y/?] 
(NEW) Support for extended (non-PC) x86 platforms 
(X86_EXTENDED_PLATFORM) [Y/n/?] (NEW) AMD Elan (X86_ELAN) [N/y/?] n
RDC R-321x SoC (X86_RDC321X) [N/y/?] n
Support non-standard 32-bit SMP architectures (X86_32_NON_STANDARD) 
[N/y/?] (NEW) Single-depth WCHAN output (SCHED_OMIT_FRAME_POINTER) [Y/n/?] y
paravirt-ops debugging (PARAVIRT_DEBUG) [N/y/?] n
Memtest (MEMTEST) [N/y/?] n
Processor family
  1. 386 (M386)
  2. 486 (M486)
  3. 586/K5/5x86/6x86/6x86MX (M586)
  4. Pentium-Classic (M586TSC)
  5. Pentium-MMX (M586MMX)
 > 6. Pentium-Pro (M686)
  7. Pentium-II/Celeron(pre-Coppermine) (MPENTIUMII)
  8. Pentium-III/Celeron(Coppermine)/Pentium-III Xeon (MPENTIUMIII)
  9. Pentium M (MPENTIUMM)
  10. Pentium-4/Celeron(P4-based)/Pentium-4 M/older Xeon (MPENTIUM4)
  11. K6/K6-II/K6-III (MK6)
  12. Athlon/Duron/K7 (MK7)
  13. Opteron/Athlon64/Hammer/K8 (MK8)
  14. Crusoe (MCRUSOE)
  15. Efficeon (MEFFICEON)
  16. Winchip-C6 (MWINCHIPC6)
  17. Winchip-2/Winchip-2A/Winchip-3 (MWINCHIP3D)
  18. GeodeGX1 (MGEODEGX1)
  19. Geode GX/LX (MGEODE_LX)
  20. CyrixIII/VIA-C3 (MCYRIXIII)
  21. VIA C3-2 (Nehemiah) (MVIAC3_2)
  22. VIA C7 (MVIAC7)
  23. Core 2/newer Xeon (MCORE2)
choice[1-23]: 6
Generic x86 support (X86_GENERIC) [N/y/?] n
PentiumPro memory ordering errata workaround (X86_PPRO_FENCE) [Y/n/?] y
Branch Trace Store (X86_PTRACE_BTS) [Y/n/?] y
HPET Timer Support (HPET_TIMER) [Y/n/?] y
Maximum number of CPUs (NR_CPUS) [8] 8
SMT (Hyperthreading) scheduler support (SCHED_SMT) [Y/n/?] y
Multi-core scheduler support (SCHED_MC) [Y/n/?] y
Preemption Mode
 > 1. No Forced Preemption (Server) (PREEMPT_NONE)
  2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)
  3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT_DESKTOP) (NEW)
  4. Complete Preemption (Real-Time) (PREEMPT_RT) (NEW)
choice[1-4]: Thread Softirqs (PREEMPT_SOFTIRQS) [Y/?] (NEW) y
Thread Hardirqs (PREEMPT_HARDIRQS) [Y/?] (NEW) y
Reroute for broken boot IRQs (X86_REROUTE_FOR_BROKEN_BOOT_IRQS) [Y/n/?] y
Machine Check Exception (X86_MCE) [Y/n/?] y
Check for non-fatal errors on AMD Athlon/Duron / Intel Pentium 4 
(X86_MCE_NONFATAL) [M/n/y/?] m
check for P4 thermal throttling interrupt. (X86_MCE_P4THERMAL) [Y/n/?] y
Toshiba Laptop support (TOSHIBA) [M/n/y/?] m
Dell laptop support (I8K) [M/n/y/?] m
Enable X86 board specific fixups for reboot (X86_REBOOTFIXUPS) [N/y/?] n
/dev/cpu/microcode - microcode support (MICROCODE) [M/n/y/?] m
  Intel microcode patch loading support (MICROCODE_INTEL) [Y/n/?] y
  AMD microcode patch loading support (MICROCODE_AMD) [Y/n/?] y
/dev/cpu/*/msr - Model-specific register support (X86_MSR) [M/n/y/?] m
/dev/cpu/*/cpuid - CPU information support (X86_CPUID) [M/n/y/?] m
/sys/kernel/debug/x86/cpu/* - CPU Debug support (X86_CPU_DEBUG) 
[N/m/y/?] (NEW) High Memory Support
  1. off (NOHIGHMEM)
 > 2. 4GB (HIGHMEM4G)
  3. 64GB (HIGHMEM64G)
choice[1-3]: 2
Memory model
 > 1. Flat Memory (FLATMEM_MANUAL)
  2. Sparse Memory (SPARSEMEM_MANUAL)
choice[1-2]: 1
Add LRU list to track non-evictable pages (UNEVICTABLE_LRU) [Y/n/?] y
Allocate 3rd-level pagetables from highmem (HIGHPTE) [N/y/?] n
Check for low memory corruption (X86_CHECK_BIOS_CORRUPTION) [N/y/?] n
Reserve low 64K of RAM on AMI/Phoenix BIOSen (X86_RESERVE_LOW_64K) [Y/n/?] y
Math emulation (MATH_EMULATION) [N/y/?] n
MTRR (Memory Type Range Register) support (MTRR) [Y/n/?] y
  MTRR cleanup support (MTRR_SANITIZER) [Y/n/?] y
    MTRR cleanup enable value (0-1) (MTRR_SANITIZER_ENABLE_DEFAULT) [0] 0
    MTRR cleanup spare reg num (0-7) 
(MTRR_SANITIZER_SPARE_REG_NR_DEFAULT) [1] 1
  x86 PAT support (X86_PAT) [N/y/?] n
EFI runtime service support (EFI) [Y/n/?] y
Enable seccomp to safely compute untrusted bytecode (SECCOMP) [Y/n/?] y
Enable -fstack-protector buffer overflow detection (EXPERIMENTAL) 
(CC_STACKPROTECTOR) [N/y/?] (NEW) Timer frequency
  1. 100 HZ (HZ_100)
 > 2. 250 HZ (HZ_250)
  3. 300 HZ (HZ_300)
  4. 1000 HZ (HZ_1000)
choice[1-4?]: 2
kexec system call (KEXEC) [Y/n/?] y
kernel crash dumps (CRASH_DUMP) [N/y/?] n
kexec jump (EXPERIMENTAL) (KEXEC_JUMP) [N/y/?] n
Build a relocatable kernel (EXPERIMENTAL) (RELOCATABLE) [N/y/?] n
Alignment value to which kernel should be aligned (PHYSICAL_ALIGN) 
[0x100000] 0x100000
Support for hot-pluggable CPUs (HOTPLUG_CPU) [Y/?] y
Compat VDSO support (COMPAT_VDSO) [N/y/?] n
Built-in kernel command line (CMDLINE_BOOL) [N/y/?] n
*
* Networking options
*
Packet socket (PACKET) [Y/n/m/?] y
  Packet socket: mmapped IO (PACKET_MMAP) [Y/n/?] y
Unix domain sockets (UNIX) [Y/n/m/?] y
Transformation user configuration interface (XFRM_USER) [M/n/y/?] m
Transformation sub policy support (EXPERIMENTAL) (XFRM_SUB_POLICY) [N/y/?] n
Transformation migrate database (EXPERIMENTAL) (XFRM_MIGRATE) [N/y/?] n
Transformation statistics (EXPERIMENTAL) (XFRM_STATISTICS) [N/y/?] n
PF_KEY sockets (NET_KEY) [M/n/y/?] m
  PF_KEY MIGRATE (EXPERIMENTAL) (NET_KEY_MIGRATE) [N/y/?] n
TCP/IP networking (INET) [Y/n/?] y
  IP: multicasting (IP_MULTICAST) [Y/n/?] y
  IP: advanced router (IP_ADVANCED_ROUTER) [Y/n/?] y
    Choose IP: FIB lookup algorithm (choose FIB_HASH if unsure)
    > 1. FIB_HASH (ASK_IP_FIB_HASH)
      2. FIB_TRIE (IP_FIB_TRIE)
    choice[1-2]: 1
  IP: policy routing (IP_MULTIPLE_TABLES) [Y/n/?] y
  IP: equal cost multipath (IP_ROUTE_MULTIPATH) [Y/n/?] y
  IP: verbose route monitoring (IP_ROUTE_VERBOSE) [Y/n/?] y
  IP: kernel level autoconfiguration (IP_PNP) [N/y/?] n
  IP: tunneling (NET_IPIP) [M/n/y/?] m
  IP: GRE tunnels over IP (NET_IPGRE) [M/n/y/?] m
    IP: broadcast GRE over IP (NET_IPGRE_BROADCAST) [Y/n/?] y
  IP: multicast routing (IP_MROUTE) [Y/n/?] y
    IP: PIM-SM version 1 support (IP_PIMSM_V1) [Y/n/?] y
    IP: PIM-SM version 2 support (IP_PIMSM_V2) [Y/n/?] y
  IP: ARP daemon support (EXPERIMENTAL) (ARPD) [N/y/?] n
  IP: TCP syncookie support (disabled per default) (SYN_COOKIES) [Y/n/?] y
  IP: AH transformation (INET_AH) [M/n/y/?] m
  IP: ESP transformation (INET_ESP) [M/n/y/?] m
  IP: IPComp transformation (INET_IPCOMP) [M/n/y/?] m
  IP: IPsec transport mode (INET_XFRM_MODE_TRANSPORT) [M/n/y/?] m
  IP: IPsec tunnel mode (INET_XFRM_MODE_TUNNEL) [M/n/y/?] m
  IP: IPsec BEET mode (INET_XFRM_MODE_BEET) [M/n/y/?] m
  Large Receive Offload (ipv4/tcp) (INET_LRO) [M/y/?] m
  INET: socket monitoring interface (INET_DIAG) [M/n/y/?] m
  TCP: MD5 Signature Option support (RFC2385) (EXPERIMENTAL) 
(TCP_MD5SIG) [Y/n/?] y
  NetLabel subsystem support (NETLABEL) [N/y/?] n
Security Marking (NETWORK_SECMARK) [Y/?] y
Asynchronous Transfer Mode (ATM) (ATM) [M/n/y/?] m
  Classical IP over ATM (ATM_CLIP) [M/n/?] m
    Do NOT send ICMP if no neighbour (ATM_CLIP_NO_ICMP) [N/y/?] n
  LAN Emulation (LANE) support (ATM_LANE) [M/n/?] m
    Multi-Protocol Over ATM (MPOA) support (ATM_MPOA) [M/n/?] m
  RFC1483/2684 Bridged protocols (ATM_BR2684) [M/n/?] m
    Per-VC IP filter kludge (ATM_BR2684_IPFILTER) [N/y/?] n
802.1d Ethernet Bridging (BRIDGE) [M/n/y/?] m
802.1Q VLAN Support (VLAN_8021Q) [M/n/y/?] m
  GVRP (GARP VLAN Registration Protocol) support (VLAN_8021Q_GVRP) [Y/n/?] y
DECnet Support (DECNET) [M/n/y/?] m
  DECnet: router support (EXPERIMENTAL) (DECNET_ROUTER) [N/y/?] n
ANSI/IEEE 802.2 LLC type 2 Support (LLC2) [M/n/y/?] m
The IPX protocol (IPX) [M/n/y/?] m
  IPX: Full internal IPX network (IPX_INTERN) [N/y/?] n
Appletalk protocol support (ATALK) [M/n/y/?] m
  Appletalk interfaces support (DEV_APPLETALK) [M/n/?] m
    Apple/Farallon LocalTalk PC support (LTPC) [M/n/?] m
    COPS LocalTalk PC support (COPS) [N/m/?] (NEW)     Appletalk-IP 
driver support (IPDDP) [M/n/?] m
      IP to Appletalk-IP Encapsulation support (IPDDP_ENCAP) [Y/n/?] y
      Appletalk-IP to IP Decapsulation support (IPDDP_DECAP) [Y/n/?] y
CCITT X.25 Packet Layer (EXPERIMENTAL) (X25) [M/n/y/?] m
LAPB Data Link Driver (EXPERIMENTAL) (LAPB) [M/n/y/?] m
Acorn Econet/AUN protocols (EXPERIMENTAL) (ECONET) [M/n/y/?] m
  AUN over UDP (ECONET_AUNUDP) [Y/n/?] y
  Native Econet (ECONET_NATIVE) [Y/n/?] y
WAN router (WAN_ROUTER) [M/n/y/?] m
Data Center Bridging support (DCB) [Y/n/?] y
*
* AX.25 network device drivers
*
Serial port KISS driver (MKISS) [M/n/?] m
Serial port 6PACK driver (6PACK) [M/n/?] m
BPQ Ethernet driver (BPQETHER) [M/n/?] m
Z8530 SCC driver (SCC) [M/n/?] m
  additional delay for PA0HZP OptoSCC compatible boards (SCC_DELAY) 
[N/y/?] n
  support for TRX that feedback the tx signal to rx (SCC_TRXECHO) [N/y/?] n
BAYCOM ser12 fullduplex driver for AX.25 (BAYCOM_SER_FDX) [M/n/?] m
BAYCOM ser12 halfduplex driver for AX.25 (BAYCOM_SER_HDX) [M/n/?] m
BAYCOM picpar and par96 driver for AX.25 (BAYCOM_PAR) [M/n/?] m
BAYCOM epp driver for AX.25 (BAYCOM_EPP) [M/n/?] m
YAM driver for AX.25 (YAM) [N/m/?] (NEW) *
* Ethernet (10000 Mbit)
*
Ethernet (10000 Mbit) (NETDEV_10000) [Y/n/?] y
  Chelsio 10Gb Ethernet support (CHELSIO_T1) [M/n/y/?] m
    Chelsio gigabit Ethernet support (CHELSIO_T1_1G) [Y/n/?] y
  Chelsio Communications T3 10Gb Ethernet support (CHELSIO_T3) [M/y/?] m
  Cisco 10G Ethernet NIC support (ENIC) [M/n/y/?] m
  Intel(R) 10GbE PCI Express adapters support (IXGBE) [M/n/y/?] m
    Direct Cache Access (DCA) Support (IXGBE_DCA) [Y/n/?] y
    Data Center Bridging (DCB) Support (IXGBE_DCB) [Y/n/?] y
  Intel(R) PRO/10GbE support (IXGB) [M/n/y/?] m
  S2IO 10Gbe XFrame NIC (S2IO) [M/n/y/?] m
  Myricom Myri-10G Ethernet support (MYRI10GE) [M/n/y/?] m
    Direct Cache Access (DCA) Support (MYRI10GE_DCA) [Y/n/?] y
  Sun Neptune 10Gbit Ethernet support (NIU) [M/n/y/?] m
  Mellanox Technologies 10Gbit Ethernet support (MLX4_EN) [M/n/y/?] m
  Tehuti Networks 10G Ethernet (TEHUTI) [M/n/y/?] m
  Broadcom NetXtremeII 10Gb support (BNX2X) [N/m/y/?] (NEW)   QLogic 
QLGE 10Gb Ethernet Driver Support (QLGE) [M/n/y/?] m
  Solarflare Solarstorm SFC4000 support (SFC) [M/n/y/?] m
    Solarflare Solarstorm SFC4000 flash MTD support (SFC_MTD) [Y/n/?] y
  ServerEngines' 10Gbps NIC - BladeEngine 2 (BE2NET) [M/n/y/?] m
*
* Token Ring driver support
*
Token Ring driver support (TR) [Y/n/m/?] y
  IBM Tropic chipset based adapter support (IBMTR) [M/n/y/?] m
  IBM Olympic chipset PCI adapter support (IBMOL) [M/n/y/?] m
  IBM Lanstreamer chipset PCI adapter support (IBMLS) [M/n/y/?] m
  3Com 3C359 Token Link Velocity XL adapter support (3C359) [N/m/y/?] 
(NEW)   Generic TMS380 Token Ring ISA/PCI adapter support (TMS380TR) 
[M/n/y/?] m
    Generic TMS380 PCI support (TMSPCI) [M/n/?] m
    SysKonnect TR4/16 ISA support (SKISA) [M/n/?] m
    Proteon ISA support (PROTEON) [M/n/?] m
    Madge Smart 16/4 PCI Mk2 support (ABYSS) [M/n/?] m
  SMC ISA/MCA adapter support (SMCTR) [N/m/y/?] (NEW) *
* PCI sound devices
*
PCI sound devices (SND_PCI) [Y/n/?] y
  Analog Devices AD1889 (SND_AD1889) [M/n/?] m
  Avance Logic ALS300/ALS300+ (SND_ALS300) [M/n/?] m
  Avance Logic ALS4000 (SND_ALS4000) [M/n/?] m
  ALi M5451 PCI Audio Controller (SND_ALI5451) [M/n/?] m
  ATI IXP AC97 Controller (SND_ATIIXP) [M/n/?] m
  ATI IXP Modem (SND_ATIIXP_MODEM) [M/n/?] m
  Aureal Advantage (SND_AU8810) [M/n/?] m
  Aureal Vortex (SND_AU8820) [M/n/?] m
  Aureal Vortex 2 (SND_AU8830) [M/n/?] m
  Emagic Audiowerk 2 (SND_AW2) [N/m/?] n
  Aztech AZF3328 / PCI168 (EXPERIMENTAL) (SND_AZT3328) [M/n/?] m
  Bt87x Audio Capture (SND_BT87X) [M/n/?] m
    Bt87x Audio overclocking (SND_BT87X_OVERCLOCK) [N/y/?] n
  SB Audigy LS / Live 24bit (SND_CA0106) [M/n/?] m
  C-Media 8338, 8738, 8768, 8770 (SND_CMIPCI) [M/n/?] m
  C-Media 8788 (Oxygen) (SND_OXYGEN) [M/n/?] m
  Cirrus Logic (Sound Fusion) CS4281 (SND_CS4281) [M/n/?] m
  Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x (SND_CS46XX) 
[N/m/?] (NEW)   CS5530 Audio (SND_CS5530) [M/n/?] m
  CS5535/CS5536 Audio (SND_CS5535AUDIO) [M/n/?] m
  (Echoaudio) Darla20 (SND_DARLA20) [M/n/?] m
  (Echoaudio) Gina20 (SND_GINA20) [M/n/?] m
  (Echoaudio) Layla20 (SND_LAYLA20) [M/n/?] m
  (Echoaudio) Darla24 (SND_DARLA24) [M/n/?] m
  (Echoaudio) Gina24 (SND_GINA24) [M/n/?] m
  (Echoaudio) Layla24 (SND_LAYLA24) [M/n/?] m
  (Echoaudio) Mona (SND_MONA) [M/n/?] m
  (Echoaudio) Mia (SND_MIA) [M/n/?] m
  (Echoaudio) 3G cards (SND_ECHO3G) [M/n/?] m
  (Echoaudio) Indigo (SND_INDIGO) [M/n/?] m
  (Echoaudio) Indigo IO (SND_INDIGOIO) [M/n/?] m
  (Echoaudio) Indigo DJ (SND_INDIGODJ) [M/n/?] m
  Emu10k1 (SB Live!, Audigy, E-mu APS) (SND_EMU10K1) [M/n/?] m
  Emu10k1X (Dell OEM Version) (SND_EMU10K1X) [M/n/?] m
  (Creative) Ensoniq AudioPCI 1370 (SND_ENS1370) [M/n/?] m
  (Creative) Ensoniq AudioPCI 1371/1373 (SND_ENS1371) [M/n/?] m
  ESS ES1938/1946/1969 (Solo-1) (SND_ES1938) [M/n/?] m
  ESS ES1968/1978 (Maestro-1/2/2E) (SND_ES1968) [M/n/?] m
  ForteMedia FM801 (SND_FM801) [M/n/?] m
    ForteMedia FM801 + TEA5757 tuner (SND_FM801_TEA575X_BOOL) [Y/n/?] y
  RME Hammerfall DSP Audio (SND_HDSP) [M/n/?] m
  RME Hammerfall DSP MADI (SND_HDSPM) [M/n/?] m
  TempoTec HiFier Fantasia (SND_HIFIER) [M/n/?] m
  ICEnsemble ICE1712 (Envy24) (SND_ICE1712) [M/n/?] m
  ICE/VT1724/1720 (Envy24HT/PT) (SND_ICE1724) [M/n/?] m
  Intel/SiS/nVidia/AMD/ALi AC97 Controller (SND_INTEL8X0) [M/n/?] m
  Intel/SiS/nVidia/AMD MC97 Modem (SND_INTEL8X0M) [M/n/?] m
  Korg 1212 IO (SND_KORG1212) [M/n/?] m
  ESS Allegro/Maestro3 (SND_MAESTRO3) [M/n/?] m
  Digigram miXart (SND_MIXART) [M/n/?] m
  NeoMagic NM256AV/ZX (SND_NM256) [M/n/?] m
  Digigram PCXHR (SND_PCXHR) [M/n/?] m
  Conexant Riptide (SND_RIPTIDE) [M/n/?] m
  RME Digi32, 32/8, 32 PRO (SND_RME32) [M/n/?] m
  RME Digi96, 96/8, 96/8 PRO (SND_RME96) [M/n/?] m
  RME Digi9652 (Hammerfall) (SND_RME9652) [M/n/?] m
  SiS 7019 Audio Accelerator (SND_SIS7019) [M/n/?] m
  S3 SonicVibes (SND_SONICVIBES) [M/n/?] m
  Trident 4D-Wave DX/NX; SiS 7018 (SND_TRIDENT) [M/n/?] m
  VIA 82C686A/B, 8233/8235 AC97 Controller (SND_VIA82XX) [M/n/?] m
  VIA 82C686A/B, 8233 based Modems (SND_VIA82XX_MODEM) [M/n/?] m
  Asus Virtuoso 100/200 (Xonar) (SND_VIRTUOSO) [M/n/?] m
  Digigram VX222 (SND_VX222) [M/n/?] m
  Yamaha YMF724/740/744/754 (SND_YMFPCI) [M/n/?] m
*
* Kernel hacking
*
Show timing information on printks (PRINTK_TIME) [Y/n/?] y
Continue building despite compiler warnings (ALLOW_WARNINGS) [Y/n/?] 
(NEW)   Enable __deprecated logic (ENABLE_WARN_DEPRECATED) [Y/n/?] y
  Enable __must_check logic (ENABLE_MUST_CHECK) [Y/n/?] y
Warn for stack frames larger than (needs gcc 4.4) (FRAME_WARN) [1024] 1024
Magic SysRq key (MAGIC_SYSRQ) [Y/n/?] y
Enable unused/obsolete exported symbols (UNUSED_SYMBOLS) [Y/n/?] y
Debug Filesystem (DEBUG_FS) [Y/?] y
Run 'make headers_check' when building vmlinux (HEADERS_CHECK) [N/y/?] n
Enable full Section mismatch analysis (DEBUG_SECTION_MISMATCH) [N/y/?] 
(NEW) Kernel debugging (DEBUG_KERNEL) [Y/n/?] y
  Debug shared IRQ handlers (DEBUG_SHIRQ) [N/y/?] n
  Detect Soft Lockups (DETECT_SOFTLOCKUP) [Y/n/?] y
    Panic (Reboot) On Soft Lockups (BOOTPARAM_SOFTLOCKUP_PANIC) [N/y/?] n
  Detect Hung Tasks (DETECT_HUNG_TASK) [Y/n/?] (NEW)     Panic (Reboot) 
On Hung Tasks (BOOTPARAM_HUNG_TASK_PANIC) [N/y/?] (NEW)   Collect 
scheduler debugging info (SCHED_DEBUG) [Y/n/?] y
  Collect scheduler statistics (SCHEDSTATS) [N/y/?] n
  Collect kernel timers statistics (TIMER_STATS) [Y/n/?] y
  Debug object operations (DEBUG_OBJECTS) [N/y/?] n
  Debug slab memory allocations (DEBUG_SLAB) [N/y/?] n
Debug preemptible kernel (DEBUG_PREEMPT) [Y/n/?] (NEW) RT Mutex 
debugging, deadlock detection (DEBUG_RT_MUTEXES) [N/y/?] n
Built-in scriptable tester for rt-mutexes (RT_MUTEX_TESTER) [N/y/?] n
Spinlock and rw-lock debugging: basic checks (DEBUG_SPINLOCK) [N/y/?] n
Lock debugging: detect incorrect freeing of live locks 
(DEBUG_LOCK_ALLOC) [N/y/?] n
Lock debugging: prove locking correctness (PROVE_LOCKING) [N/y/?] n
Lock usage statistics (LOCK_STAT) [N/y/?] n
Spinlock debugging: sleep-inside-spinlock checking 
(DEBUG_SPINLOCK_SLEEP) [N/y/?] n
Locking API boot-time self-tests (DEBUG_LOCKING_API_SELFTESTS) [N/y/?] n
kobject debugging (DEBUG_KOBJECT) [N/y/?] n
Highmem debugging (DEBUG_HIGHMEM) [N/y/?] n
Compile the kernel with debug info (DEBUG_INFO) [N/y/?] n
Debug VM (DEBUG_VM) [N/y/?] n
Debug VM translations (DEBUG_VIRTUAL) [N/y/?] n
Debug filesystem writers count (DEBUG_WRITECOUNT) [N/y/?] n
Debug linked list manipulation (DEBUG_LIST) [N/y/?] n
Debug SG table operations (DEBUG_SG) [N/y/?] n
Debug notifier call chains (DEBUG_NOTIFIERS) [N/y/?] n
Compile the kernel with frame pointers (FRAME_POINTER) [N/y/?] n
Delay each boot printk message by N milliseconds (BOOT_PRINTK_DELAY) 
[N/y/?] n
torture tests for RCU (RCU_TORTURE_TEST) [N/m/y/?] n
Self test for the backtrace code (BACKTRACE_SELF_TEST) [N/m/y/?] n
Force extended block device numbers and spread them 
(DEBUG_BLOCK_EXT_DEVT) [N/y/?] n
Fault-injection framework (FAULT_INJECTION) [N/y/?] n
Latency measuring infrastructure (LATENCYTOP) [N/y/?] n
Sysctl checks (SYSCTL_SYSCALL_CHECK) [Y/n/?] y
*
* Tracers
*
Kernel Function Tracer (FUNCTION_TRACER) [N/y/?] n
Interrupts-off Latency Tracer (IRQSOFF_TRACER) [N/y/?] n
Preemption-off Latency Tracer (PREEMPT_TRACER) [N/y/?] (NEW) Sysprof 
Tracer (SYSPROF_TRACER) [N/y/?] n
Scheduling Latency Tracer (SCHED_TRACER) [N/y/?] n
Trace process context switches (CONTEXT_SWITCH_TRACER) [Y/?] y
Trace various events in the kernel (EVENT_TRACER) [N/y/?] (NEW) Trace 
syscalls (FTRACE_SYSCALLS) [N/y/?] (NEW) Trace boot initcalls 
(BOOT_TRACER) [Y/n/?] y
Trace likely/unlikely profiler (TRACE_BRANCH_PROFILING) [N/y/?] n
Trace power consumption behavior (POWER_TRACER) [N/y/?] n
Trace max stack (STACK_TRACER) [N/y/?] n
Trace SLAB allocations (KMEMTRACE) [N/y/?] (NEW) Support for tracing 
block io actions (BLK_DEV_IO_TRACE) [Y/n/?] y
Perform a startup test on ftrace (FTRACE_STARTUP_TEST) [N/y/?] (NEW) 
Memory mapped IO tracing (MMIOTRACE) [N/y/?] n
Remote debugging over FireWire early on boot (PROVIDE_OHCI1394_DMA_INIT) 
[N/y/?] n
Remote debugging over FireWire with firewire-ohci 
(FIREWIRE_OHCI_REMOTE_DMA) [N/y/?] n
Enable dynamic printk() call support (DYNAMIC_PRINTK_DEBUG) [N/y/?] n
Enable debugging of DMA-API usage (DMA_API_DEBUG) [N/y/?] (NEW) Filter 
access to /dev/mem (STRICT_DEVMEM) [Y/n/?] y
Enable verbose x86 bootup info messages (X86_VERBOSE_BOOTUP) [Y/n/?] y
Early printk (EARLY_PRINTK) [Y/?] y
  Early printk via EHCI debug port (EARLY_PRINTK_DBGP) [N/y/?] n
Check for stack overflows (DEBUG_STACKOVERFLOW) [N/y/?] n
Stack utilization instrumentation (DEBUG_STACK_USAGE) [N/y/?] n
Debug page memory allocations (DEBUG_PAGEALLOC) [N/y/?] n
Export kernel pagetable layout to userspace via debugfs (X86_PTDUMP) 
[N/y/?] n
Write protect kernel read-only data structures (DEBUG_RODATA) [N/y/?] n
Testcase for the NX non-executable stack feature (DEBUG_NX_TEST) [N/m/?] n
Use 4Kb for kernel stacks instead of 8Kb (4KSTACKS) [N/y/?] n
IO delay type
 > 1. port 0x80 based port-IO delay [recommended] (IO_DELAY_0X80)
  2. port 0xed based port-IO delay (IO_DELAY_0XED)
  3. udelay based port-IO delay (IO_DELAY_UDELAY)
  4. no port-IO delay (IO_DELAY_NONE)
choice[1-4]: 1
Debug boot parameters (DEBUG_BOOT_PARAMS) [N/y/?] n
CPA self-test code (CPA_DEBUG) [N/y/?] n
Allow gcc to uninline functions marked 'inline' (OPTIMIZE_INLINING) 
[Y/n/?] y
*
* Restart config...
*
*
* RCU Subsystem
*
RCU Implementation
 > 1. Preemptible RCU (PREEMPT_RCU)
choice[1]: 1
Enable tracing for RCU (RCU_TRACE) [N/y/?] (NEW) #
# configuration written to .config
#

