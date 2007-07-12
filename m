From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: LAPIC broken on ferrari 1000
Date: Thu, 12 Jul 2007 16:24:01 +0200
Message-ID: <200707121624.02169.joachim.deguara@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Boundary-00=_CmjlGDZUXf4qyVS"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:11382 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757678AbXGLOY1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 10:24:27 -0400
Received: from outbound2-cpk.bigfish.com (localhost [127.0.0.1])
	by outbound2-cpk-R.bigfish.com (Postfix) with ESMTP id 3279D28080
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 14:24:26 +0000 (UTC)
Received: from mail107-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound2-cpk.bigfish.com (Postfix) with ESMTP id 2F7E7208050
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 14:24:26 +0000 (UTC)
Received: from mail107-cpk (localhost [127.0.0.1])
	by mail107-cpk-R.bigfish.com (Postfix) with ESMTP id 22237778184
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 14:24:26 +0000 (UTC)
Received: from svlb1extmailp01.amd.com (unknown [139.95.251.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail107-cpk.bigfish.com (Postfix) with ESMTP id C901160805D
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 14:24:19 +0000 (UTC)
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by svlb1extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id l6CEOCO1004954
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 07:24:15 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--Boundary-00=_CmjlGDZUXf4qyVS
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  I have a ferrari 1000 laptop with AMD Turion x2 (RevF) and it seams the 
LAPIC is broke only with the RT patch.  What happens is it boots and does not 
get any timer interrupts so I have to either move the mouse or hit shift to 
get it continure booting and getting interrupts.  This is tested with 
2.6.22.1-rt1.  The dmesg along with sysrq-Q, kernel config and also the 
output of:
cat /proc/interrupts
sleep 10 (me hitting shift a few time)
cat /proc/interrupts

-Joachim


--Boundary-00=_CmjlGDZUXf4qyVS
Content-Type: text/plain;
 charset=utf-8;
 name=interrupts_10s
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=interrupts_10s

           CPU0       
  0:         71   IO-APIC-edge      timer
  1:       1276   IO-APIC-edge      i8042
  7:          0   IO-APIC-edge      lpptest
  8:          0   IO-APIC-edge      rtc
  9:        184   IO-APIC-fasteoi   acpi
 12:       6834   IO-APIC-edge      i8042
 14:          0   IO-APIC-edge      libata
 15:          0   IO-APIC-edge      libata
 16:        315   IO-APIC-fasteoi   HDA Intel
 19:        163   IO-APIC-fasteoi   ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 20:          0   IO-APIC-fasteoi   tifm_7xx1
 21:          3   IO-APIC-fasteoi   ohci1394
 22:       4174   IO-APIC-fasteoi   sata_sil, eth0
NMI:          0 
LOC:      11439 
ERR:          0
           CPU0       
  0:         71   IO-APIC-edge      timer
  1:       1288   IO-APIC-edge      i8042
  7:          0   IO-APIC-edge      lpptest
  8:          0   IO-APIC-edge      rtc
  9:        184   IO-APIC-fasteoi   acpi
 12:       6834   IO-APIC-edge      i8042
 14:          0   IO-APIC-edge      libata
 15:          0   IO-APIC-edge      libata
 16:        315   IO-APIC-fasteoi   HDA Intel
 19:        163   IO-APIC-fasteoi   ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 20:          0   IO-APIC-fasteoi   tifm_7xx1
 21:          3   IO-APIC-fasteoi   ohci1394
 22:       4174   IO-APIC-fasteoi   sata_sil, eth0
NMI:          0 
LOC:      11453 
ERR:          0

--Boundary-00=_CmjlGDZUXf4qyVS
Content-Type: text/plain;
 charset=utf-8;
 name=2.6.22.1-rt1_f1000_lapic.config
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2.6.22.1-rt1_f1000_lapic.config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.22.1-rt1
# Thu Jul 12 15:46:37 2007
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_NONIRQ_WAKEUP=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-nosmp"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=19
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_BLK_DEV_IO_TRACE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=128
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_TRACE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_START=0x200000
# CONFIG_SECCOMP is not set
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SYSFS_DEPRECATED=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_BAY=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_ACPI_CPUFREQ is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU idle PM support
#
CONFIG_CPU_IDLE=y

#
# Governors
#
CONFIG_CPU_IDLE_GOV_LADDER=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
# CONFIG_MAC80211 is not set
CONFIG_IEEE80211=y
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=y
CONFIG_IEEE80211_CRYPT_CCMP=y
# CONFIG_IEEE80211_CRYPT_TKIP is not set
CONFIG_IEEE80211_SOFTMAC=y
# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
# CONFIG_RFKILL is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_MSI_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=y
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=y
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
CONFIG_SATA_SIL=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=y
# CONFIG_PATA_ARTOP is not set
CONFIG_PATA_ATIIXP=y
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# Controllers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocols
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394_ROM_ENTRY is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_B44=y
CONFIG_FORCEDETH=y
# CONFIG_FORCEDETH_NAPI is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=y
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_RTC_HISTOGRAM is not set
CONFIG_BLOCKER=y
CONFIG_LPPTEST=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_RMEM is not set
# CONFIG_ALLOC_RTSJ_MEM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set
# CONFIG_HWMON is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L1=y
CONFIG_VIDEO_V4L1_COMPAT=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_CAPTURE_DRIVERS is not set
# CONFIG_RADIO_ADAPTERS is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_PROGEAR is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
# CONFIG_VGASTATE is not set
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_SYS_FOPS is not set
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HECUBA is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# HID Devices
#
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set

#
# MMC/SD Card Drivers
#
CONFIG_MMC_BLOCK=m

#
# MMC/SD Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Virtualization
#
CONFIG_KVM=m
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_GENERIC_ACL=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf-8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_BIND34 is not set
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=y
# CONFIG_CODA_FS_OLD_API is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_PREEMPT_TRACE=y
# CONFIG_EVENT_TRACE is not set
# CONFIG_FUNCTION_TRACE is not set
# CONFIG_WAKEUP_TIMING is not set
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

--Boundary-00=_CmjlGDZUXf4qyVS
Content-Type: text/plain;
 charset=utf-8;
 name=2.6.22.1-rt1_f1000_lapic.dmesg
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2.6.22.1-rt1_f1000_lapic.dmesg

[    0.000000] Linux version 2.6.22.1-rt1-nosmp (joachim@avanti) (gcc version 4.1.3 20070521 (prerelease) (SUSE Linux)) #2 PREEMPT RT Thu Jul 12 15:50:43 CEST 2007
[    0.000000] Command line: root=/dev/disk/by-id/scsi-SATA_Hitachi_HTS5416_SB2404SJHNT7YE-part6 sysrq_always_enable resume=/dev/sda5 splash=silent showopts processor.max_cstate=0 apic=verbose
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007be80000 (usable)
[    0.000000]  BIOS-e820: 000000007be80000 - 000000007be95000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007be95000 - 000000007bf00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007bf00000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 507520) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F81A0, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 7BE8D65C, 003C (r1 ACRSYS ACRPRDCT  6040000  LTP        0)
[    0.000000] ACPI: FACP 7BE94B9A, 0074 (r1 ATI    Bowfin    6040000 ATI     F4240)
[    0.000000] ACPI: DSDT 7BE8D698, 7502 (r1    ATI    SB460  6040000 MSFT  2000002)
[    0.000000] ACPI: FACS 7BE95FC0, 0040
[    0.000000] ACPI: SSDT 7BE94C0E, 01C4 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: APIC 7BE94DD2, 0054 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: MCFG 7BE94E26, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: BOOT 7BE94E62, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SLIC 7BE94E8A, 0176 (r1 ACRSYS ACRPRDCT  6040000 acer        0)
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 507520) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      157
[    0.000000]     0:      256 ->   507520
[    0.000000] On node 0 totalpages: 507421
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1273 pages reserved
[    0.000000]   DMA zone: 2668 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6882 pages used for memmap
[    0.000000]   DMA32 zone: 496542 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x8008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] WARNING: NR_CPUS limit of 1 reached. Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] swsusp: Registered nosave memory region: 000000000009d000 - 000000000009e000
[    0.000000] swsusp: Registered nosave memory region: 000000000009e000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000d0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000d0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
[    0.000000] Built 1 zonelists.  Total pages: 499210
[    0.000000] Kernel command line: root=/dev/disk/by-id/scsi-SATA_Hitachi_HTS5416_SB2404SJHNT7YE-part6 sysrq_always_enable resume=/dev/sda5 splash=silent showopts processor.max_cstate=0 apic=verbose
[    0.000000] Booting kernel: `0' invalid for parameter `processor.max_cstate'
[    0.000000] Initializing CPU#0
[    0.000000] WARNING: experimental RCU implementation.
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[    9.249397] time.c: Detected 1800.064 MHz processor.
[    9.251399] Console: colour VGA+ 80x25
[    9.258853] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    9.260762] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    9.261408] Checking aperture...
[    9.261502] CPU 0: aperture @ 148e000000 size 32 MB
[    9.261592] Aperture too small (32 MB)
[    9.273577] No AGP bridge found
[    9.293446] Memory: 1990544k/2030080k available (2817k kernel code, 38780k reserved, 1227k data, 196k init)
[    9.371203] Calibrating delay using timer specific routine.. 3603.88 BogoMIPS (lpj=7207760)
[    9.371427] Mount-cache hash table entries: 256
[    9.371626] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    9.371718] CPU: L2 Cache: 512K (64 bytes/line)
[    9.371820] CPU: AMD Turion(tm) 64 X2 Mobile Technology TL-56 stepping 02
[    9.371997] ACPI: Core revision 20070126
[    9.824209] enabled ExtINT on CPU#0
[    9.824468] ENABLING IO-APIC IRQs
[    9.824561] init IO_APIC IRQs
[    9.824565] IOAPIC[0]: Set routing entry (2-0 -> 0x30 -> IRQ 0 Mode:0 Active:0)
[    9.824572] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0 Active:0)
[    9.824577] IOAPIC[0]: Set routing entry (2-2 -> 0x32 -> IRQ 2 Mode:0 Active:0)
[    9.824582] IOAPIC[0]: Set routing entry (2-3 -> 0x33 -> IRQ 3 Mode:0 Active:0)
[    9.824587] IOAPIC[0]: Set routing entry (2-4 -> 0x34 -> IRQ 4 Mode:0 Active:0)
[    9.824592] IOAPIC[0]: Set routing entry (2-5 -> 0x35 -> IRQ 5 Mode:0 Active:0)
[    9.824597] IOAPIC[0]: Set routing entry (2-6 -> 0x36 -> IRQ 6 Mode:0 Active:0)
[    9.824603] IOAPIC[0]: Set routing entry (2-7 -> 0x37 -> IRQ 7 Mode:0 Active:0)
[    9.824608] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0 Active:0)
[    9.824613] IOAPIC[0]: Set routing entry (2-9 -> 0x39 -> IRQ 9 Mode:1 Active:1)
[    9.824618] IOAPIC[0]: Set routing entry (2-10 -> 0x3a -> IRQ 10 Mode:0 Active:0)
[    9.824624] IOAPIC[0]: Set routing entry (2-11 -> 0x3b -> IRQ 11 Mode:0 Active:0)
[    9.824629] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12 Mode:0 Active:0)
[    9.824634] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13 Mode:0 Active:0)
[    9.824640] IOAPIC[0]: Set routing entry (2-14 -> 0x3e -> IRQ 14 Mode:0 Active:0)
[    9.824645] IOAPIC[0]: Set routing entry (2-15 -> 0x3f -> IRQ 15 Mode:0 Active:0)
[    9.824650]  IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
[    9.824804] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
[    9.864884] Using local APIC timer interrupts.
[    9.970321] ... lapic delta = 1250114
[    9.970412] ... PM timer delta = 357975
[    9.970503] ... PM timer result ok
[    9.970595] ..... delta 1250114
[    9.970686] ..... mult: 53688631
[    9.970778] ..... calibration result: 800072
[    9.970871] ..... CPU clock speed is 1800.0651 MHz.
[    9.970963] ..... host bus clock speed is 200.0072 MHz.
[    9.971207] NET: Registered protocol family 16
[    9.971512] ACPI: ACPI Dock Station Driver 
[    9.971897] ACPI: bus type pci registered
[    9.972266] PCI: Using MMCONFIG at e0000000 - e08fffff
[    9.972404] PCI: No mmconfig possible on device 00:18
[    9.976791] ACPI: System BIOS is requesting _OSI(Linux)
[    9.976892] ACPI: Please test with "acpi_osi=!Linux"
[    9.976893] Please send dmidecode to linux-acpi@vger.kernel.org
[    9.977357] ACPI: Interpreter enabled
[    9.977454] ACPI: (supports S0 S3 S4 S5)
[    9.977756] ACPI: Using IOAPIC for interrupt routing
[   10.011450] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   10.011554] PCI: Probing PCI hardware (bus 00)
[   10.013161] PCI: Transparent bridge - 0000:00:14.4
[   10.013329] PCI: Bus #09 (-#0c) is hidden behind transparent bridge #08 (-#09) (try 'pci=assign-busses')
[   10.013470] Please report the result to linux-kernel to fix this permanently
[   10.013593] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   10.013795] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB4_._PRT]
[   10.013938] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
[   10.014076] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
[   10.014226] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[   10.014367] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   10.018251] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[   10.018709] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[   10.019182] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[   10.019633] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[   10.020084] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[   10.020531] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[   10.020978] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[   10.021429] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[   10.021880] ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7) *0, disabled.
[   10.022382] Linux Plug and Play Support v0.97 (c) Adam Belay
[   10.022485] pnp: PnP ACPI init
[   10.022588] ACPI: bus type pnp registered
[   10.024128] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13 Mode:0 Active:0)
[   10.024187] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0 Active:0)
[   10.024294] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0 Active:0)
[   10.024358] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12 Mode:0 Active:0)
[   10.025625] pnp: PnP ACPI: found 11 devices
[   10.025720] ACPI: ACPI bus type pnp unregistered
[   10.025913] SCSI subsystem initialized
[   10.026043] libata version 2.21 loaded.
[   10.026118] usbcore: registered new interface driver usbfs
[   10.026249] usbcore: registered new interface driver hub
[   10.026383] usbcore: registered new device driver usb
[   10.026517] PCI: Using ACPI for IRQ routing
[   10.026611] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   10.026755] number of MP IRQ sources: 16.
[   10.026757] number of IO-APIC #2 registers: 24.
[   10.026759] testing the IO APIC.......................
[   10.026858] 
[   10.026948] IO APIC #2......
[   10.026950] .... register #00: 02000000
[   10.026952] .......    : physical APIC id: 02
[   10.026955] .... register #01: 00178021
[   10.026957] .......     : max redirection entries: 0017
[   10.026959] .......     : PRQ implemented: 1
[   10.026961] .......     : IO APIC version: 0021
[   10.026963] .... register #02: 02000000
[   10.026965] .......     : arbitration: 02
[   10.026967] .... IRQ redirection table:
[   10.026969]  NR Dst Mask Trig IRR Pol Stat Dmod Deli Vect:   
[   10.026974]  00 001 0    0    0   0   0    1    1    30
[   10.026981]  01 001 0    0    0   0   0    1    1    31
[   10.026988]  02 001 0    0    0   0   0    1    1    32
[   10.027017]  03 001 0    0    0   0   0    1    1    33
[   10.027024]  04 001 0    0    0   0   0    1    1    34
[   10.027030]  05 001 0    0    0   0   0    1    1    35
[   10.027037]  06 001 0    0    0   0   0    1    1    36
[   10.027043]  07 001 0    0    0   0   0    1    1    37
[   10.027050]  08 001 0    0    0   0   0    1    1    38
[   10.027056]  09 001 0    1    0   1   0    1    1    39
[   10.027063]  0a 001 0    0    0   0   0    1    1    3A
[   10.027069]  0b 001 0    0    0   0   0    1    1    3B
[   10.027076]  0c 001 0    0    0   0   0    1    1    3C
[   10.027083]  0d 001 0    0    0   0   0    1    1    3D
[   10.027089]  0e 001 0    0    0   0   0    1    1    3E
[   10.027096]  0f 001 0    0    0   0   0    1    1    3F
[   10.027102]  10 000 1    0    0   0   0    0    0    00
[   10.027109]  11 000 1    0    0   0   0    0    0    00
[   10.027115]  12 000 1    0    0   0   0    0    0    00
[   10.027121]  13 000 1    0    0   0   0    0    0    00
[   10.027128]  14 000 1    0    0   0   0    0    0    00
[   10.027134]  15 000 1    0    0   0   0    0    0    00
[   10.027140]  16 000 1    0    0   0   0    0    0    00
[   10.027147]  17 000 1    0    0   0   0    0    0    00
[   10.027150] IRQ to pin mappings:
[   10.027152] IRQ0 -> 0:0
[   10.027154] IRQ1 -> 0:1
[   10.027156] IRQ2 -> 0:2
[   10.027159] IRQ3 -> 0:3
[   10.027161] IRQ4 -> 0:4
[   10.027163] IRQ5 -> 0:5
[   10.027166] IRQ6 -> 0:6
[   10.027168] IRQ7 -> 0:7
[   10.027170] IRQ8 -> 0:8
[   10.027173] IRQ9 -> 0:9
[   10.027175] IRQ10 -> 0:10
[   10.027178] IRQ11 -> 0:11
[   10.027180] IRQ12 -> 0:12
[   10.027183] IRQ13 -> 0:13
[   10.027185] IRQ14 -> 0:14
[   10.027187] IRQ15 -> 0:15
[   10.027191] .................................... done.
[   10.027292] PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
[   10.027387] PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
[   10.027480] PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
[   10.027571] PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0
[   10.027666] PCI: Cannot allocate resource region 9 of bridge 0000:00:05.0
[   10.027760] PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
[   10.027854] PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
[   10.028169] pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
[   10.028315] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[   10.028456] pnp: 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
[   10.028606] pnp: 00:08: ioport range 0x1080-0x1080 has been reserved
[   10.028700] pnp: 00:08: ioport range 0x220-0x22f has been reserved
[   10.028799] pnp: 00:09: iomem range 0xe0000-0xfffff could not be reserved
[   10.028895] pnp: 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
[   10.029037] pnp: 00:09: iomem range 0x0-0xfff could not be reserved
[   10.029471] PCI: Bridge: 0000:00:01.0
[   10.029561]   IO window: 9000-9fff
[   10.029653]   MEM window: d0100000-d01fffff
[   10.029747]   PREFETCH window: d4000000-d7ffffff
[   10.029840] PCI: Bridge: 0000:00:04.0
[   10.029931]   IO window: disabled.
[   10.030022]   MEM window: disabled.
[   10.030113]   PREFETCH window: disabled.
[   10.030205] PCI: Bridge: 0000:00:05.0
[   10.030297]   IO window: disabled.
[   10.030389]   MEM window: disabled.
[   10.030477]   PREFETCH window: disabled.
[   10.030567] PCI: Bridge: 0000:00:06.0
[   10.030659]   IO window: disabled.
[   10.030751]   MEM window: disabled.
[   10.030844]   PREFETCH window: disabled.
[   10.030936] PCI: Bridge: 0000:00:07.0
[   10.031064]   IO window: disabled.
[   10.031157]   MEM window: d0200000-d02fffff
[   10.031251]   PREFETCH window: d8000000-d80fffff
[   10.031347] PCI: Bus 9, cardbus bridge: 0000:08:09.0
[   10.031439]   IO window: 00002000-000020ff
[   10.033199]   IO window: 00002400-000024ff
[   10.033296]   PREFETCH window: 88000000-8bffffff
[   10.033392]   MEM window: 90000000-93ffffff
[   10.033487] PCI: Bridge: 0000:00:14.4
[   10.033581]   IO window: 2000-2fff
[   10.033678]   MEM window: d0300000-d03fffff
[   10.033772]   PREFETCH window: 88000000-8bffffff
[   10.033880] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   10.033886] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   10.033892] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   10.033898] PCI: Enabling device 0000:00:07.0 (0000 -> 0002)
[   10.033992] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   10.034015] PCI: Enabling device 0000:08:09.0 (0000 -> 0003)
[   10.034115] IOAPIC[0]: Set routing entry (2-20 -> 0x49 -> IRQ 20 Mode:1 Active:1)
[   10.034119] ACPI: PCI Interrupt 0000:08:09.0[A] -> GSI 20 (level, low) -> IRQ 20
[   10.034323] NET: Registered protocol family 2
[   10.055416] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   10.055975] TCP established hash table entries: 65536 (order: 10, 4194304 bytes)
[   10.058274] TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
[   10.060183] TCP: Hash tables configured (established 65536 bind 65536)
[   10.060283] TCP reno registered
[   10.067513] Unpacking initramfs... done
[   10.163492] Freeing initrd memory: 2591k freed
[   10.165107] Simple Boot Flag at 0x36 set to 0x1
[   10.165887] Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
[   10.166171] NTFS driver 2.1.28 [Flags: R/W].
[   10.166325] io scheduler noop registered
[   10.166425] io scheduler cfq registered (default)
[   10.166519] PCI: MSI quirk detected. MSI deactivated.
[   10.167111] Boot video device is 0000:01:05.0
[   10.169188] ACPI: AC Adapter [ACAD] (on-line)
[   10.169381] ACPI: Battery Slot [BAT1] (battery absent)
[   10.169602] input: Power Button (FF) as /class/input/input0
[   10.169698] ACPI: Power Button (FF) [PWRF]
[   10.169862] input: Power Button (CM) as /class/input/input1
[   10.169959] ACPI: Power Button (CM) [PWRB]
[   10.170147] input: Lid Switch as /class/input/input2
[   10.170239] ACPI: Lid Switch [LID]
[   10.170397] input: Sleep Button (CM) as /class/input/input3
[   10.170492] ACPI: Sleep Button (CM) [SLPB]
[   10.170729] cpuidle: driver acpi_idle failed to attach to cpu 0
[   10.177078] ACPI: Thermal Zone [THRM] (54 C)
[   10.179868] Real Time Clock Driver v1.12ac
[   10.180129] Linux agpgart interface v0.102 (c) Dave Jones
[   10.180532] loop: module loaded
[   10.180681] tg3.c:v3.77 (May 31, 2007)
[   10.180802] IOAPIC[0]: Set routing entry (2-22 -> 0x51 -> IRQ 22 Mode:1 Active:1)
[   10.180806] ACPI: PCI Interrupt 0000:08:04.0[A] -> GSI 22 (level, low) -> IRQ 22
[   10.221119] eth0: Tigon3 [partno(BCM95788) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:16:36:d0:6b:85
[   10.221507] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[0] TSOcap[1]
[   10.221650] eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   10.221871] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   10.222057] tun: Universal TUN/TAP device driver, 1.6
[   10.222151] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   10.222429] sata_sil 0000:00:12.0: version 2.2
[   10.222474] PCI: Enabling device 0000:00:12.0 (0005 -> 0007)
[   10.222572] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
[   10.222972] scsi0 : sata_sil
[   10.223171] scsi1 : sata_sil
[   10.223312] ata1: SATA max UDMA/100 cmd 0xffffc20000022080 ctl 0xffffc2000002208a bmdma 0xffffc20000022000 irq 22
[   10.223460] ata2: SATA max UDMA/100 cmd 0xffffc200000220c0 ctl 0xffffc200000220ca bmdma 0xffffc20000022008 irq 22
[   10.690447] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   10.699077] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC70P, max UDMA/100
[   10.699173] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (not used)
[   10.715044] ata1.00: configured for UDMA/100
[   11.025916] ata2: SATA link down (SStatus 0 SControl 310)
[   11.026094] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[   11.026340] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   11.026447] sd 0:0:0:0: [sda] Write Protect is off
[   11.026540] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   11.026557] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.026738] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   11.026843] sd 0:0:0:0: [sda] Write Protect is off
[   11.026935] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   11.026950] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.027095]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
[   11.121894] sd 0:0:0:0: [sda] Attached SCSI disk
[   11.122055] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   11.122315] PCI: Enabling device 0000:00:14.1 (0014 -> 0015)
[   11.122415] IOAPIC[0]: Set routing entry (2-16 -> 0x59 -> IRQ 16 Mode:1 Active:1)
[   11.122420] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
[   11.122646] PCI: Setting latency timer of device 0000:00:14.1 to 64
[   11.122737] scsi2 : pata_atiixp
[   11.122894] scsi3 : pata_atiixp
[   11.123030] ata3: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x0000000000018460 irq 14
[   11.123177] ata4: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x0000000000018468 irq 15
[   11.123344] ata3: port disabled. ignoring.
[   11.277592] usbmon: debugfs is not available
[   11.277736] IOAPIC[0]: Set routing entry (2-19 -> 0x61 -> IRQ 19 Mode:1 Active:1)
[   11.277740] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 19
[   11.278053] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   11.278265] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
[   11.278487] ehci_hcd 0000:00:13.2: irq 19, io mem 0xd0007000
[   11.278591] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   11.278913] usb usb1: configuration #1 chosen from 1 choice
[   11.279054] hub 1-0:1.0: USB hub found
[   11.279156] hub 1-0:1.0: 8 ports detected
[   11.381475] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.381521] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
[   11.381793] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   11.381999] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
[   11.382163] ohci_hcd 0000:00:13.0: irq 19, io mem 0xd0005000
[   11.437454] usb usb2: configuration #1 chosen from 1 choice
[   11.437595] hub 2-0:1.0: USB hub found
[   11.437700] hub 2-0:1.0: 4 ports detected
[   11.541196] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
[   11.541461] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   11.541662] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
[   11.541825] ohci_hcd 0000:00:13.1: irq 19, io mem 0xd0006000
[   11.597240] usb usb3: configuration #1 chosen from 1 choice
[   11.597383] hub 3-0:1.0: USB hub found
[   11.597489] hub 3-0:1.0: 4 ports detected
[   11.621031] usb 1-7: new high speed USB device using ehci_hcd and address 2
[   11.700989] Initializing USB Mass Storage driver...
[   11.793739] usb 1-7: configuration #1 chosen from 1 choice
[   12.335934] usb 3-4: new full speed USB device using ohci_hcd and address 2
[   12.549741] usb 3-4: configuration #1 chosen from 1 choice
[   12.552164] usbcore: registered new interface driver usb-storage
[   12.552259] USB Mass Storage support registered.
[   12.552432] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   12.556349] i8042.c: Detected active multiplexing controller, rev 1.1.
[   12.557627] serio: i8042 KBD port at 0x60,0x64 irq 1
[   12.557770] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   12.557908] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   12.558046] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   12.558182] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   12.558355] mice: PS/2 mouse device common for all mice
[   12.591175] input: AT Translated Set 2 keyboard as /class/input/input4
[   12.726699] md: raid0 personality registered for level 0
[   12.726792] md: raid1 personality registered for level 1
[   12.726908] cpuidle: using governor ladder
[   12.727046] usbcore: registered new interface driver usbhid
[   12.727147] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   12.727260] Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31 09:03:25 2007 UTC).
[   12.727401] ALSA device list:
[   12.727492]   No soundcards found.
[   12.727605] IPv4 over IPv4 tunneling driver
[   12.727790] TCP cubic registered
[   12.727884] Initializing XFRM netlink socket
[   12.727987] NET: Registered protocol family 1
[   12.728081] NET: Registered protocol family 17
[   12.728177] NET: Registered protocol family 15
[   12.728274] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   12.728367] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   12.728512] ieee80211_crypt: registered algorithm 'NULL'
[   12.728514] ieee80211_crypt: registered algorithm 'WEP'
[   12.728517] ieee80211_crypt: registered algorithm 'CCMP'
[   12.728524] powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-56 processors (version 2.00.00)
[   12.728704] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x13
[   12.728801] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x15
[   12.728895] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x1e
[   12.729509] Freeing unused kernel memory: 196k freed
[   13.451582] Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
[   13.456922] swsusp: Marking nosave pages: 000000000009d000 - 0000000000100000
[   13.456929] swsusp: Basic memory bitmaps created
[   13.470901] swsusp: Basic memory bitmaps freed
[   13.491615] Attempting manual resume
[   13.495667] input: SynPS/2 Synaptics TouchPad as /class/input/input5
[   13.675281] kjournald starting.  Commit interval 5 seconds
[   13.675570] EXT3 FS on sda6, internal journal
[   13.675705] EXT3-fs: mounted filesystem with ordered data mode.
[   16.386343] atkbd.c: Unknown key pressed (translated set 2, code 0xd8 on isa0060/serio0).
[   16.386491] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   16.561623] usb 3-4: USB disconnect, address 2
[   16.687574] atkbd.c: Unknown key released (translated set 2, code 0xd8 on isa0060/serio0).
[   16.687724] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   17.742671] ACPI: PCI Interrupt 0000:08:09.2[A] -> GSI 20 (level, low) -> IRQ 20
[   17.746975] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
[   17.930433] Bluetooth: Core ver 2.11
[   17.930581] NET: Registered protocol family 31
[   17.930678] Bluetooth: HCI device and connection manager initialized
[   17.930772] Bluetooth: HCI socket layer initialized
[   17.958939] Bluetooth: HCI USB driver ver 2.9
[   17.959068] usbcore: registered new interface driver hci_usb
[   21.518135] IOAPIC[0]: Set routing entry (2-21 -> 0x69 -> IRQ 21 Mode:1 Active:1)
[   21.518142] ACPI: PCI Interrupt 0000:08:09.1[B] -> GSI 21 (level, low) -> IRQ 21
[   21.573601] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[d0315000-d03157ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   22.237098] Adding 3148700k swap on /dev/sda5.  Priority:-1 extents:1 across:3148700k
[   22.547546] md: Autodetecting RAID arrays.
[   22.547647] md: autorun ...
[   22.547738] md: ... autorun DONE.
[   22.850754] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f0000dc3542]
[   25.710096] atkbd.c: Unknown key pressed (translated set 2, code 0xd7 on isa0060/serio0).
[   25.710247] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
[   25.804901] kjournald starting.  Commit interval 5 seconds
[   25.816513] EXT3 FS on sda7, internal journal
[   25.816646] EXT3-fs: mounted filesystem with ordered data mode.
[   25.883445] NTFS volume version 3.1.
[   25.883545] NTFS-fs warning (device sda2): load_system_files(): Volume is dirty.  Will not be able to remount read-write.  Run chkdsk and mount in Windows.
[   25.999960] atkbd.c: Unknown key released (translated set 2, code 0xd7 on isa0060/serio0).
[   26.000103] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
[   30.537841] atkbd.c: Unknown key pressed (translated set 2, code 0xd8 on isa0060/serio0).
[   30.537987] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   30.840808] atkbd.c: Unknown key released (translated set 2, code 0xd8 on isa0060/serio0).
[   30.840956] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   36.700762] atkbd.c: Unknown key pressed (translated set 2, code 0xd7 on isa0060/serio0).
[   36.700911] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
[   36.984697] atkbd.c: Unknown key released (translated set 2, code 0xd7 on isa0060/serio0).
[   36.984841] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
[   37.403852] usb 3-4: new full speed USB device using ohci_hcd and address 3
[   37.616914] usb 3-4: configuration #1 chosen from 1 choice
[   39.272356] Bluetooth: L2CAP ver 2.8
[   39.274624] Bluetooth: L2CAP socket layer initialized
[   39.290011] Bluetooth: RFCOMM socket layer initialized
[   39.290114] Bluetooth: RFCOMM ver 1.8
[   45.033920] PM: Writing back config space on device 0000:08:04.0 at offset c (was ffff0000, writing 0)
[   45.033930] PM: Writing back config space on device 0000:08:04.0 at offset b (was 3ed173b, writing 10e1025)
[   45.033953] PM: Writing back config space on device 0000:08:04.0 at offset 3 (was 0, writing 4008)
[   45.033961] PM: Writing back config space on device 0000:08:04.0 at offset 2 (was 2000000, writing 2000003)
[   45.033969] PM: Writing back config space on device 0000:08:04.0 at offset 1 (was 2b00000, writing 2b00006)
[   45.033977] PM: Writing back config space on device 0000:08:04.0 at offset 0 (was 3ed173b, writing 169c14e4)
[   48.021946] Marking TSC unstable due to cpufreq changes
[   48.213451] tg3: eth0: Link is up at 1000 Mbps, full duplex.
[   48.213457] tg3: eth0: Flow control is on for TX and on for RX.
[   50.538580] usb 3-4: USB disconnect, address 3
[   50.541313] atkbd.c: Unknown key pressed (translated set 2, code 0xd8 on isa0060/serio0).
[   50.541320] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   50.652383] atkbd.c: Unknown key released (translated set 2, code 0xd8 on isa0060/serio0).
[   50.652389] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
[   99.599447] SysRq : HELP : loglevel0-8 reBoot Crashdump tErm Full kIll saK showalLcpupc showMem Nice powerOff showPc show-all-timers(Q) unRaw Sync showTasks Unmount shoW-blocked-tasks 
[  106.131066] SysRq : Show Pending Timers
[  106.131140] Timer List Version: v0.3
[  106.131143] HRTIMER_MAX_CLOCK_BASES: 2
[  106.131145] now at 126686460480 nsecs
[  106.131147] 
[  106.131148] cpu: 0
[  106.131150]  clock 0:
[  106.131151]   .index:      0
[  106.131154]   .resolution: 4000250 nsecs
[  106.131155]   .get_time:   ktime_get_real
[  106.131162] active timers:
[  106.131164]  clock 1:
[  106.131166]   .index:      1
[  106.131168]   .resolution: 4000250 nsecs
[  106.131169]   .get_time:   ktime_get
[  106.131173] active timers:
[  106.131174]  #0: <ffff810075b5fe58>, it_real_fn, S:01
[  106.131186]  # expires at 127377048245 nsecs [in 690587765 nsecs]
[  106.131188]  #1: <ffff810075b5fe58>, hrtimer_wakeup, S:01
[  106.131196]  # expires at 141545213489 nsecs [in 14858753009 nsecs]
[  106.131198]  #2: <ffff810075b5fe58>, hrtimer_wakeup, S:01
[  106.131205]  # expires at 141545246455 nsecs [in 14858785975 nsecs]
[  106.131208]  #3: <ffff810075b5fe58>, hrtimer_wakeup, S:01
[  106.131215]  # expires at 141545277189 nsecs [in 14858816709 nsecs]
[  106.131217]  #4: <ffff810075b5fe58>, hrtimer_wakeup, S:01
[  106.131224]  # expires at 141545303729 nsecs [in 14858843249 nsecs]
[  106.131227]  #5: <ffff810075b5fe58>, hrtimer_wakeup, S:01
[  106.131233]  # expires at 147254686590 nsecs [in 20568226110 nsecs]
[  106.131236]  #6: <ffff810075b5fe58>, it_real_fn, S:01
[  106.131243]  # expires at 370729888417 nsecs [in 244043427937 nsecs]
[  106.131246]  #7: <ffff810075b5fe58>, it_real_fn, S:01
[  106.131253]  # expires at 370729951257 nsecs [in 244043490777 nsecs]
[  106.131255]  #8: <ffff810075b5fe58>, it_real_fn, S:01
[  106.131262]  # expires at 370729978912 nsecs [in 244043518432 nsecs]
[  106.131264] 
[  106.131266] 
[  106.131267] Tick Device: mode:     0
[  106.131269] Clock Event Device: pit
[  106.131272]  max_delta_ns:   27461866
[  106.131274]  min_delta_ns:   12571
[  106.131276]  mult:           5124677
[  106.131278]  shift:          32
[  106.131280]  mode:           1
[  106.131282]  next_event:     0 nsecs
[  106.131283]  set_next_event: pit_next_event
[  106.131288]  set_mode:       init_pit_timer
[  106.131291]  event_handler:  clockevents_handle_noop
[  106.131296] tick_broadcast_mask: 00000000
[  106.131297] 
[  106.131299] 
[  106.131300] Tick Device: mode:     0
[  106.131302] Clock Event Device: lapic
[  106.131305]  max_delta_ns:   671069313
[  106.131307]  min_delta_ns:   1199
[  106.131309]  mult:           53688631
[  106.131311]  shift:          32
[  106.131312]  mode:           2
[  106.131314]  next_event:     0 nsecs
[  106.131316]  set_next_event: lapic_next_event
[  106.131320]  set_mode:       lapic_timer_setup
[  106.131323]  event_handler:  tick_handle_periodic
[  106.131327] 

--Boundary-00=_CmjlGDZUXf4qyVS--
