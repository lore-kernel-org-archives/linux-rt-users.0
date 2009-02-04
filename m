From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: Build error: 2.6.26.8-rt15 on ARM.
Date: Wed, 04 Feb 2009 10:27:13 +0100
Message-ID: <49895F71.5070604@albentia.com>
References: <49895AB1.2090205@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsd409-a04.servidoresdns.net ([82.223.190.34]:51515 "EHLO
	llsd409-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061AbZBDJ1S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 04:27:18 -0500
In-Reply-To: <49895AB1.2090205@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi again,

A quick grep on the full sources, lets me see that DIE_OOPS is only=20
defined under certain archs:mn10300, ia64, s390, sparc64, powerpc and=20
x86, so I suppose that tracing would only build on that platforms.

Thanks again,

    Iratxo.

Iratxo Pichel Ortiz wrote:
> Hi there,
>
> I think that I have found a built error on 2.6.26.8-rt15 on ARM (ixp4=
xx):
>
> Here (warning):
>
> In file included from kernel/trace/trace.c:37:
> include/asm/asm-offsets.h:49:1: warning: "VM_EXEC" redefined
> In file included from include/linux/pagemap.h:7,
>                 from kernel/trace/trace.c:19:
> include/linux/mm.h:77:1: warning: this is the location of the previou=
s=20
> definition
>
> And here (error):
>
> kernel/trace/trace.c: In function 'trace_die_handler':
> kernel/trace/trace.c:3588: error: 'DIE_OOPS' undeclared (first use in=
=20
> this function)
> kernel/trace/trace.c:3588: error: (Each undeclared identifier is=20
> reported only once
> kernel/trace/trace.c:3588: error: for each function it appears in.)
> make[2]: *** [kernel/trace/trace.o] Error 1
> make[1]: *** [kernel/trace] Error 2
> make: *** [kernel] Error 2
>
>
> And my .config:
>
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.26.8-rt15
> # Wed Feb  4 09:56:40 2009
> #
> CONFIG_ARM=3Dy
> CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
> CONFIG_GENERIC_GPIO=3Dy
> CONFIG_GENERIC_TIME=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> # CONFIG_NO_IOPORT is not set
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
> # CONFIG_ARCH_HAS_ILOG2_U32 is not set
> # CONFIG_ARCH_HAS_ILOG2_U64 is not set
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_SUPPORTS_AOUT=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_VECTORS_BASE=3D0xffff0000
> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
>
> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_LOCK_KERNEL=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> CONFIG_LOCALVERSION=3D"albentia-systems"
> # CONFIG_LOCALVERSION_AUTO is not set
> # CONFIG_SWAP is not set
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> # CONFIG_TASKSTATS is not set
> CONFIG_AUDIT=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_LOG_BUF_SHIFT=3D17
> # CONFIG_CGROUPS is not set
> # CONFIG_GROUP_SCHED is not set
> CONFIG_SYSFS_DEPRECATED=3Dy
> CONFIG_SYSFS_DEPRECATED_V2=3Dy
> # CONFIG_RELAY is not set
> CONFIG_NAMESPACES=3Dy
> # CONFIG_UTS_NS is not set
> # CONFIG_IPC_NS is not set
> # CONFIG_USER_NS is not set
> # CONFIG_PID_NS is not set
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=3Dy
> # CONFIG_RADIX_TREE_CONCURRENT is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_UID16=3Dy
> CONFIG_SYSCTL_SYSCALL=3Dy
> CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_COMPAT_BRK=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_ANON_INODES=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_SLAB=3Dy
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=3Dy
> CONFIG_MARKERS=3Dy
> CONFIG_HAVE_OPROFILE=3Dy
> # CONFIG_KPROBES is not set
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> # CONFIG_HAVE_DMA_ATTRS is not set
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_SLABINFO=3Dy
> CONFIG_RT_MUTEXES=3Dy
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=3Dy
> CONFIG_MODULE_SRCVERSION_ALL=3Dy
> CONFIG_KMOD=3Dy
> CONFIG_BLOCK=3Dy
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_LSF is not set
> # CONFIG_BLK_DEV_BSG is not set
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_DEFAULT_AS=3Dy
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
> # CONFIG_CLASSIC_RCU is not set
>
> #
> # System Type
> #
> # CONFIG_ARCH_AAEC2000 is not set
> # CONFIG_ARCH_INTEGRATOR is not set
> # CONFIG_ARCH_REALVIEW is not set
> # CONFIG_ARCH_VERSATILE is not set
> # CONFIG_ARCH_AT91 is not set
> # CONFIG_ARCH_CLPS7500 is not set
> # CONFIG_ARCH_CLPS711X is not set
> # CONFIG_ARCH_CO285 is not set
> # CONFIG_ARCH_EBSA110 is not set
> # CONFIG_ARCH_EP93XX is not set
> # CONFIG_ARCH_FOOTBRIDGE is not set
> # CONFIG_ARCH_NETX is not set
> # CONFIG_ARCH_H720X is not set
> # CONFIG_ARCH_IMX is not set
> # CONFIG_ARCH_IOP13XX is not set
> # CONFIG_ARCH_IOP32X is not set
> # CONFIG_ARCH_IOP33X is not set
> # CONFIG_ARCH_IXP23XX is not set
> # CONFIG_ARCH_IXP2000 is not set
> CONFIG_ARCH_IXP4XX=3Dy
> # CONFIG_ARCH_L7200 is not set
> # CONFIG_ARCH_KS8695 is not set
> # CONFIG_ARCH_NS9XXX is not set
> # CONFIG_ARCH_MXC is not set
> # CONFIG_ARCH_ORION5X is not set
> # CONFIG_ARCH_PNX4008 is not set
> # CONFIG_ARCH_PXA is not set
> # CONFIG_ARCH_RPC is not set
> # CONFIG_ARCH_SA1100 is not set
> # CONFIG_ARCH_S3C2410 is not set
> # CONFIG_ARCH_SHARK is not set
> # CONFIG_ARCH_LH7A40X is not set
> # CONFIG_ARCH_DAVINCI is not set
> # CONFIG_ARCH_OMAP is not set
> # CONFIG_ARCH_MSM7X00A is not set
> CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=3Dy
>
> #
> # Intel IXP4xx Implementation Options
> #
>
> #
> # IXP4xx Platforms
> #
> # CONFIG_MACH_NSLU2 is not set
> CONFIG_MACH_AVILA=3Dy
> # CONFIG_MACH_LOFT is not set
> # CONFIG_ARCH_ADI_COYOTE is not set
> # CONFIG_MACH_GATEWAY7001 is not set
> # CONFIG_MACH_WG302V2 is not set
> CONFIG_ARCH_IXDP425=3Dy
> # CONFIG_MACH_IXDPG425 is not set
> # CONFIG_MACH_IXDP465 is not set
> # CONFIG_MACH_KIXRP435 is not set
> CONFIG_ARCH_IXCDP1100=3Dy
> # CONFIG_ARCH_PRPMC1100 is not set
> # CONFIG_MACH_NAS100D is not set
> # CONFIG_MACH_DSMG600 is not set
> CONFIG_ARCH_IXDP4XX=3Dy
> # CONFIG_MACH_GTWX5715 is not set
>
> #
> # IXP4xx Options
> #
> CONFIG_DMABOUNCE=3Dy
> # CONFIG_IXP4XX_INDIRECT_PCI is not set
> CONFIG_IXP4XX_QMGR=3Dy
> CONFIG_IXP4XX_NPE=3Dy
>
> #
> # Boot options
> #
>
> #
> # Power management
> #
>
> #
> # Processor Type
> #
> CONFIG_CPU_32=3Dy
> CONFIG_CPU_XSCALE=3Dy
> CONFIG_CPU_32v5=3Dy
> CONFIG_CPU_ABRT_EV5T=3Dy
> CONFIG_CPU_PABRT_NOIFAR=3Dy
> CONFIG_CPU_CACHE_VIVT=3Dy
> CONFIG_CPU_TLB_V4WBI=3Dy
> CONFIG_CPU_CP15=3Dy
> CONFIG_CPU_CP15_MMU=3Dy
>
> #
> # Processor Features
> #
> CONFIG_ARM_THUMB=3Dy
> CONFIG_CPU_BIG_ENDIAN=3Dy
> # CONFIG_CPU_DCACHE_DISABLE is not set
> # CONFIG_OUTER_CACHE is not set
> CONFIG_IWMMXT=3Dy
> CONFIG_XSCALE_PMU=3Dy
>
> #
> # Bus support
> #
> CONFIG_PCI=3Dy
> CONFIG_PCI_SYSCALL=3Dy
> # CONFIG_ARCH_SUPPORTS_MSI is not set
> CONFIG_PCI_LEGACY=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCCARD is not set
>
> #
> # Kernel Features
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set
> CONFIG_PREEMPT_RT=3Dy
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_SOFTIRQS=3Dy
> CONFIG_PREEMPT_HARDIRQS=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> CONFIG_PREEMPT_RCU_BOOST=3Dy
> # CONFIG_RCU_TRACE is not set
> CONFIG_HZ=3D1000
> # CONFIG_AEABI is not set
> # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_FLATMEM_MANUAL=3Dy
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_FLAT_NODE_MEM_MAP=3Dy
> # CONFIG_SPARSEMEM_STATIC is not set
> # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
> CONFIG_PAGEFLAGS_EXTENDED=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4096
> # CONFIG_RESOURCES_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=3D1
> CONFIG_BOUNCE=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_ALIGNMENT_TRAP=3Dy
>
> #
> # Boot options
> #
> CONFIG_ZBOOT_ROM_TEXT=3D0x0
> CONFIG_ZBOOT_ROM_BSS=3D0x0
> CONFIG_CMDLINE=3D""
> # CONFIG_XIP_KERNEL is not set
> # CONFIG_KEXEC is not set
>
> #
> # Floating point emulation
> #
>
> #
> # At least one emulation must be selected
> #
> CONFIG_FPE_NWFPE=3Dy
> CONFIG_FPE_NWFPE_XP=3Dy
> # CONFIG_FPE_FASTFPE is not set
>
> #
> # Userspace binary formats
> #
> CONFIG_BINFMT_ELF=3Dy
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_ARTHUR is not set
>
> #
> # Power management options
> #
> CONFIG_PM=3Dy
> # CONFIG_PM_DEBUG is not set
> # CONFIG_SUSPEND is not set
> CONFIG_APM_EMULATION=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
>
> #
> # Networking
> #
> CONFIG_NET=3Dy
>
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_UNIX=3Dy
> # CONFIG_NET_KEY is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_ASK_IP_FIB_HASH=3Dy
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> # CONFIG_IP_ROUTE_VERBOSE is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> # CONFIG_INET_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_BEET is not set
> CONFIG_INET_LRO=3Dy
> # CONFIG_INET_DIAG is not set
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dy
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dy
> CONFIG_TCP_CONG_HTCP=3Dy
> # CONFIG_TCP_CONG_HSTCP is not set
> # CONFIG_TCP_CONG_HYBLA is not set
> # CONFIG_TCP_CONG_VEGAS is not set
> # CONFIG_TCP_CONG_SCALABLE is not set
> CONFIG_TCP_CONG_LP=3Dy
> # CONFIG_TCP_CONG_VENO is not set
> # CONFIG_TCP_CONG_YEAH is not set
> # CONFIG_TCP_CONG_ILLINOIS is not set
> # CONFIG_DEFAULT_BIC is not set
> # CONFIG_DEFAULT_CUBIC is not set
> # CONFIG_DEFAULT_HTCP is not set
> # CONFIG_DEFAULT_VEGAS is not set
> CONFIG_DEFAULT_WESTWOOD=3Dy
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"westwood"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IP_VS is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_NETFILTER_ADVANCED=3Dy
> # CONFIG_BRIDGE_NETFILTER is not set
>
> #
> # Core Netfilter Configuration
> #
> # CONFIG_NETFILTER_NETLINK_QUEUE is not set
> # CONFIG_NETFILTER_NETLINK_LOG is not set
> CONFIG_NF_CONNTRACK=3Dm
> # CONFIG_NF_CT_ACCT is not set
> # CONFIG_NF_CONNTRACK_MARK is not set
> # CONFIG_NF_CONNTRACK_EVENTS is not set
> # CONFIG_NF_CT_PROTO_DCCP is not set
> # CONFIG_NF_CT_PROTO_SCTP is not set
> # CONFIG_NF_CT_PROTO_UDPLITE is not set
> # CONFIG_NF_CONNTRACK_AMANDA is not set
> # CONFIG_NF_CONNTRACK_FTP is not set
> # CONFIG_NF_CONNTRACK_H323 is not set
> # CONFIG_NF_CONNTRACK_IRC is not set
> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
> # CONFIG_NF_CONNTRACK_PPTP is not set
> # CONFIG_NF_CONNTRACK_SANE is not set
> # CONFIG_NF_CONNTRACK_SIP is not set
> # CONFIG_NF_CONNTRACK_TFTP is not set
> # CONFIG_NF_CT_NETLINK is not set
> CONFIG_NETFILTER_XTABLES=3Dm
> # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
> # CONFIG_NETFILTER_XT_TARGET_MARK is not set
> # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
> # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
> # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
> # CONFIG_NETFILTER_XT_TARGET_TRACE is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
> # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
> # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
> # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> # CONFIG_NETFILTER_XT_MATCH_HELPER is not set
> # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
> # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
> # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_MAC is not set
> # CONFIG_NETFILTER_XT_MATCH_MARK is not set
> # CONFIG_NETFILTER_XT_MATCH_OWNER is not set
> # CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
> # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
> # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
> # CONFIG_NETFILTER_XT_MATCH_REALM is not set
> # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
> # CONFIG_NETFILTER_XT_MATCH_STATE is not set
> # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
> # CONFIG_NETFILTER_XT_MATCH_STRING is not set
> # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_CONNTRACK_IPV4=3Dm
> CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
> # CONFIG_IP_NF_QUEUE is not set
> CONFIG_IP_NF_IPTABLES=3Dm
> # CONFIG_IP_NF_MATCH_RECENT is not set
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_AH is not set
> # CONFIG_IP_NF_MATCH_TTL is not set
> CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> # CONFIG_IP_NF_TARGET_REJECT is not set
> # CONFIG_IP_NF_TARGET_LOG is not set
> # CONFIG_IP_NF_TARGET_ULOG is not set
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> # CONFIG_NF_NAT_SNMP_BASIC is not set
> # CONFIG_NF_NAT_FTP is not set
> # CONFIG_NF_NAT_IRC is not set
> # CONFIG_NF_NAT_TFTP is not set
> # CONFIG_NF_NAT_AMANDA is not set
> # CONFIG_NF_NAT_PPTP is not set
> # CONFIG_NF_NAT_H323 is not set
> # CONFIG_NF_NAT_SIP is not set
> # CONFIG_IP_NF_MANGLE is not set
> CONFIG_IP_NF_RAW=3Dm
> # CONFIG_IP_NF_ARPTABLES is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> CONFIG_BRIDGE=3Dy
> CONFIG_VLAN_8021Q=3Dy
> # CONFIG_DECNET is not set
> CONFIG_LLC=3Dy
> CONFIG_LLC2=3Dy
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_SCHED is not set
>
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dy
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> CONFIG_FIB_RULES=3Dy
>
> #
> # Wireless
> #
> # CONFIG_CFG80211 is not set
> # CONFIG_WIRELESS_EXT is not set
> # CONFIG_MAC80211 is not set
> # CONFIG_IEEE80211 is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
> CONFIG_MTD=3Dy
> # CONFIG_MTD_DEBUG is not set
> # CONFIG_MTD_CONCAT is not set
> CONFIG_MTD_PARTITIONS=3Dy
> CONFIG_MTD_REDBOOT_PARTS=3Dy
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_AFS_PARTS=3Dy
> # CONFIG_MTD_AR7_PARTS is not set
>
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_CHAR=3Dy
> CONFIG_MTD_BLKDEVS=3Dy
> CONFIG_MTD_BLOCK=3Dy
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> CONFIG_MTD_OOPS=3Dy
>
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=3Dy
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=3Dy
> CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> CONFIG_MTD_CFI_NOSWAP=3Dy
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_GEOMETRY is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_OTP=3Dy
> CONFIG_MTD_CFI_INTELEXT=3Dy
> # CONFIG_MTD_CFI_AMDSTD is not set
> # CONFIG_MTD_CFI_STAA is not set
> CONFIG_MTD_CFI_UTIL=3Dy
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
>
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_ARM_INTEGRATOR is not set
> CONFIG_MTD_IXP4XX=3Dy
> # CONFIG_MTD_PCI is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> # CONFIG_MTD_PLATRAM is not set
>
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_DATAFLASH is not set
> CONFIG_MTD_M25P80=3Dy
> CONFIG_M25PXX_USE_FAST_READ=3Dy
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
>
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOC2001PLUS is not set
> # CONFIG_MTD_NAND is not set
> # CONFIG_MTD_ONENAND is not set
>
> #
> # UBI - Unsorted block images
> #
> # CONFIG_MTD_UBI is not set
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=3Dy
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D4
> CONFIG_BLK_DEV_RAM_SIZE=3D32768
> # CONFIG_BLK_DEV_XIP is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_MISC_DEVICES=3Dy
> # CONFIG_PHANTOM is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> CONFIG_HAVE_IDE=3Dy
> # CONFIG_IDE is not set
>
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
> # CONFIG_SCSI_DMA is not set
> # CONFIG_SCSI_NETLINK is not set
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_FUSION is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
>
> #
> # Enable only one of the two stacks, unless you know what you are doi=
ng
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_IEEE1394 is not set
> # CONFIG_I2O is not set
> CONFIG_NETDEVICES=3Dy
> # CONFIG_NETDEVICES_MULTIQUEUE is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=3Dy
> # CONFIG_VETH is not set
> # CONFIG_ARCNET is not set
> # CONFIG_PHYLIB is not set
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> CONFIG_IXP4XX_ETH=3Dy
> # CONFIG_AX88796 is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_SMC91X is not set
> # CONFIG_DM9000 is not set
> # CONFIG_ENC28J60 is not set
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> # CONFIG_IBM_NEW_EMAC_ZMII is not set
> # CONFIG_IBM_NEW_EMAC_RGMII is not set
> # CONFIG_IBM_NEW_EMAC_TAH is not set
> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> # CONFIG_NET_PCI is not set
> # CONFIG_B44 is not set
> # CONFIG_NETDEV_1000 is not set
> # CONFIG_NETDEV_10000 is not set
> # CONFIG_TR is not set
>
> #
> # Wireless LAN
> #
> # CONFIG_WLAN_PRE80211 is not set
> # CONFIG_WLAN_80211 is not set
> # CONFIG_IWLWIFI_LEDS is not set
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=3Dy
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dy
> CONFIG_PPP_SYNC_TTY=3Dy
> CONFIG_PPP_DEFLATE=3Dy
> CONFIG_PPP_BSDCOMP=3Dy
> CONFIG_PPP_MPPE=3Dy
> CONFIG_PPPOE=3Dy
> # CONFIG_PPPOL2TP is not set
> # CONFIG_SLIP is not set
> CONFIG_SLHC=3Dy
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_ISDN is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
>
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
>
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> CONFIG_DEVKMEM=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D48
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=3Dy
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D256
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_IXP4XX=3Dy
> # CONFIG_NVRAM is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_RMEM is not set
> # CONFIG_ALLOC_RTSJ_MEM is not set
> CONFIG_DEVPORT=3Dy
> CONFIG_I2C=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_CHARDEV=3Dy
> # CONFIG_I2C_HELPER_AUTO is not set
>
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=3Dy
> # CONFIG_I2C_ALGOPCF is not set
> # CONFIG_I2C_ALGOPCA is not set
>
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> CONFIG_I2C_GPIO=3Dy
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_IOP3XX=3Dy
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
>
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_DS1682 is not set
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_PCF8575 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
>
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_BITBANG=3Dy
>
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_AT25=3Dy
> CONFIG_SPI_SPIDEV=3Dy
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> CONFIG_WATCHDOG=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
>
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> CONFIG_IXP4XX_WATCHDOG=3Dy
>
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>
> #
> # Sonics Silicon Backplane
> #
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
>
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_ASIC3 is not set
> # CONFIG_HTC_PASIC3 is not set
>
> #
> # Multimedia devices
> #
>
> #
> # Multimedia core support
> #
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_DVB_CORE is not set
> # CONFIG_VIDEO_MEDIA is not set
>
> #
> # Multimedia drivers
> #
> # CONFIG_DAB is not set
>
> #
> # Graphics support
> #
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> # CONFIG_FB is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
> #
> # Display device support
> #
> # CONFIG_DISPLAY_SUPPORT is not set
>
> #
> # Console display driver support
> #
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> # CONFIG_HID_SUPPORT is not set
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> # CONFIG_NEW_LEDS is not set
> CONFIG_RTC_LIB=3Dy
> # CONFIG_RTC_CLASS is not set
> # CONFIG_UIO is not set
>
> #
> # File systems
> #
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4DEV_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=3Dy
> # CONFIG_XFS_FS is not set
> # CONFIG_OCFS2_FS is not set
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
>
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_CONFIGFS_FS is not set
>
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_JFFS2_FS=3Dy
> CONFIG_JFFS2_FS_DEBUG=3D0
> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> CONFIG_JFFS2_FS_WBUF_VERIFY=3Dy
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_FS_XATTR is not set
> CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
> CONFIG_JFFS2_ZLIB=3Dy
> CONFIG_JFFS2_LZO=3Dy
> CONFIG_JFFS2_RTIME=3Dy
> # CONFIG_JFFS2_RUBIN is not set
> # CONFIG_JFFS2_CMODE_NONE is not set
> CONFIG_JFFS2_CMODE_PRIORITY=3Dy
> # CONFIG_JFFS2_CMODE_SIZE is not set
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> CONFIG_CRAMFS=3Dy
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> CONFIG_ROMFS_FS=3Dy
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dy
> # CONFIG_NFSD is not set
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dy
> # CONFIG_SUNRPC_BIND34 is not set
> CONFIG_RPCSEC_GSS_KRB5=3Dy
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=3Dy
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=3Dy
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=3Dy
> # CONFIG_DLM is not set
>
> #
> # Kernel hacking
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_ENABLE_WARN_DEPRECATED=3Dy
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=3D1024
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> CONFIG_DEBUG_FS=3Dy
> # CONFIG_HEADERS_CHECK is not set
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_DEBUG_SHIRQ is not set
> CONFIG_DETECT_SOFTLOCKUP=3Dy
> CONFIG_SCHED_DEBUG=3Dy
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_TIMER_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=3Dy
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RTMUTEX_CHECK is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_RWLOCK_TORTURE_TEST is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_TRACE_IRQFLAGS=3Dy
> CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_WRITECOUNT is not set
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> CONFIG_FRAME_POINTER=3Dy
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_HAVE_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_FTRACE=3Dy
> CONFIG_IRQSOFF_TRACER=3Dy
> CONFIG_PREEMPT_TRACER=3Dy
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_EVENT_TRACER=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_STACK_TRACER=3Dy
> CONFIG_DYNAMIC_FTRACE=3Dy
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_INTERRUPT_OFF_HIST is not set
> # CONFIG_PREEMPT_OFF_HIST is not set
> # CONFIG_WAKEUP_LATENCY_HIST is not set
> # CONFIG_PREEMPT_TRACE is not set
> # CONFIG_SAMPLES is not set
> # CONFIG_DEBUG_USER is not set
> # CONFIG_DEBUG_ERRORS is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_LL is not set
>
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITY_FILE_CAPABILITIES is not set
> CONFIG_CRYPTO=3Dy
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_BLKCIPHER=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> # CONFIG_CRYPTO_GF128MUL is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Authenticated Encryption with Associated Data
> #
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_SEQIV is not set
>
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=3Dy
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_CTS is not set
> CONFIG_CRYPTO_ECB=3Dy
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
>
> #
> # Hash modes
> #
> CONFIG_CRYPTO_HMAC=3Dy
> # CONFIG_CRYPTO_XCBC is not set
>
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_MD4=3Dy
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_TGR192=3Dy
> CONFIG_CRYPTO_WP512=3Dy
>
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_ANUBIS=3Dy
> CONFIG_CRYPTO_ARC4=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dy
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST5=3Dy
> CONFIG_CRYPTO_CAST6=3Dy
> CONFIG_CRYPTO_DES=3Dy
> # CONFIG_CRYPTO_FCRYPT is not set
> CONFIG_CRYPTO_KHAZAD=3Dy
> # CONFIG_CRYPTO_SALSA20 is not set
> # CONFIG_CRYPTO_SEED is not set
> CONFIG_CRYPTO_SERPENT=3Dy
> CONFIG_CRYPTO_TEA=3Dy
> CONFIG_CRYPTO_TWOFISH=3Dy
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dy
>
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> # CONFIG_CRYPTO_LZO is not set
> CONFIG_CRYPTO_HW=3Dy
> # CONFIG_CRYPTO_DEV_HIFN_795X is not set
>
> #
> # Library routines
> #
> CONFIG_BITREVERSE=3Dy
> # CONFIG_GENERIC_FIND_FIRST_BIT is not set
> # CONFIG_GENERIC_FIND_NEXT_BIT is not set
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=3Dy
> CONFIG_CRC7=3Dy
> CONFIG_LIBCRC32C=3Dy
> CONFIG_AUDIT_GENERIC=3Dy
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_PLIST=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_DMA=3Dy
>
> Hope this helps!
>


--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
