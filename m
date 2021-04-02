Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A51C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Apr 2021 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DBE6112F
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Apr 2021 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhDBO6q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBO6p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Apr 2021 10:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E7C60FEF;
        Fri,  2 Apr 2021 14:58:44 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.184-rt75
Date:   Fri, 02 Apr 2021 14:57:40 -0000
Message-ID: <161737546047.315104.6237703875794200008@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.184-rt75 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: e7b2a8a3acdb92b9336ed8fbcaa6b9cb827949e9

Or to build 4.19.184-rt75 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.184.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.184-rt75.patch.xz


You can also build from 4.19.182-rt74 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.182-rt74-rt75.patch.xz

Enjoy!
Clark

Changes from v4.19.182-rt74:
---

Adrian Hunter (1):
      perf auxtrace: Fix auxtrace queue conflict

Alan Stern (1):
      usb-storage: Add quirk to defeat Kindle's automatic unload

Alexander Shiyan (1):
      ASoC: fsl_ssi: Fix TDM slot setup for I2S mode

Andy Shevchenko (1):
      ACPI: scan: Use unique number for instance_no

Angelo Dureghello (1):
      can: flexcan: flexcan_chip_freeze(): fix chip freeze for missing bitrate

Arnaldo Carvalho de Melo (3):
      tools build feature: Check if get_current_dir_name() is available
      tools build feature: Check if eventfd() is available
      tools build: Check if gettid() is available before providing helper

Aya Levin (1):
      net/mlx5e: Fix error path for ethtool set-priv-flag

Christian König (1):
      drm/radeon: fix AGP dependency

Christophe Leroy (1):
      powerpc: Force inlining of cpu_has_feature() to avoid build failure

Clark Williams (3):
      Merge tag 'v4.19.183' into linux-4.19.y-rt
      Merge tag 'v4.19.184' into linux-4.19.y-rt
      Linux 4.19.184-rt75

Claudiu Beznea (1):
      ARM: dts: at91-sama5d27_som1: fix phy address to 7

Colin Ian King (1):
      usbip: Fix incorrect double assignment to udc->ud.tcp_rx

Corentin Labbe (1):
      net: stmmac: dwmac-sun8i: Provide TX and RX fifo sizes

Dan Carpenter (2):
      scsi: lpfc: Fix some error codes in debugfs
      iio: adis16400: Fix an error code in adis16400_initial_setup()

Daniel Kobras (1):
      sunrpc: fix refcount leak for rpc auth modules

Daniel Wagner (1):
      block: Suppress uevent for hidden device when removed

David Sterba (1):
      btrfs: fix slab cache flags for free space tree bitmap

Denis Efremov (1):
      sun/niu: fix wrong RXMAC_BC_FRM_CNT_COUNT count

Dinghao Liu (3):
      iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler
      ixgbe: Fix memleak in ixgbe_configure_clsu32
      e1000e: Fix error handling in e1000_set_d0_lplu_state_82571

Dmitry Baryshkov (1):
      drm/msm: fix shutdown hook in case GPU components failed to bind

Dylan Hung (1):
      ftgmac100: Restart MAC HW once

Eric Dumazet (3):
      macvlan: macvlan_count_rx() needs to be aware of preemption
      net: sched: validate stab values
      net: qrtr: fix a kernel-infoleak in qrtr_recvmsg()

Filipe Manana (1):
      btrfs: fix race when cloning extent buffer during rewind of an old root

Florian Fainelli (1):
      net: dsa: bcm_sf2: Qualify phydev->dev_flags based on port

Florian Westphal (1):
      netfilter: ctnetlink: fix dump of the expect mask attribute

Frank Sorenson (1):
      NFS: Correct size calculation for create reply length

Georgi Valkov (1):
      libbpf: Fix INSTALL flag order

Greg Kroah-Hartman (2):
      Linux 4.19.183
      Linux 4.19.184

Grygorii Strashko (1):
      bus: omap_l3_noc: mark l3 irqs as IRQF_NO_THREAD

Hans de Goede (1):
      platform/x86: intel-vbtn: Stop reporting SW_DOCK events

Hayes Wang (1):
      Revert "r8152: adjust the settings about MAC clock speed down for RTL8153"

Heiko Thiery (1):
      net: fec: ptp: avoid register access when ipg clock is disabled

Horia Geantă (3):
      arm64: dts: ls1046a: mark crypto engine dma coherent
      arm64: dts: ls1012a: mark crypto engine dma coherent
      arm64: dts: ls1043a: mark crypto engine dma coherent

Hui Wang (1):
      ALSA: hda: generic: Fix the micmute led init state

Isaku Yamahata (1):
      x86/mem_encrypt: Correct physical address calculation in __set_clr_pte_enc()

J. Bruce Fields (1):
      nfs: we don't support removing system.nfs4_acl

Jan Beulich (1):
      xen-blkback: don't leak persistent grants from xen_blkbk_map()

Jan Kara (1):
      ext4: add reclaim checks to xattr code

JeongHyeon Lee (1):
      dm verity: add root hash pkcs#7 signature verification

Jia-Ju Bai (5):
      net: tehuti: fix error return code in bdx_probe()
      net: hisilicon: hns: fix error return code of hns_nic_clear_all_rx_fetch()
      net: wan: fix error return code of uhdlc_init()
      scsi: qedi: Fix error return code of qedi_alloc_global_queues()
      scsi: mpt3sas: Fix error return code of mpt3sas_base_attach()

Jim Lin (1):
      usb: gadget: configfs: Fix KASAN use-after-free

Jiri Olsa (1):
      perf tools: Use %define api.pure full instead of %pure-parser

Joe Korty (1):
      NFSD: Repair misuse of sv_lock in 5.10.16-rt30.

Johan Hovold (2):
      x86/apic/of: Fix CPU devicetree-node lookups
      net: cdc-phonet: fix data-interface release on probe failure

Johannes Berg (1):
      mac80211: fix rate mask reset

Jonathan Albrieux (1):
      iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel

Jonathan Cameron (1):
      iio:adc:stm32-adc: Add HAS_IOMEM dependency

Kan Liang (1):
      perf/x86/intel: Fix a crash caused by zero PEBS status

Lv Yunlong (1):
      net/qlcnic: Fix a use after free in qlcnic_83xx_get_minidump_template

Maciej Fijalkowski (1):
      veth: Store queue_mapping independently of XDP prog presence

Macpaul Lin (1):
      USB: replace hardcode maximum usb string length by definition

Marc Kleine-Budde (1):
      can: peak_usb: Revert "can: peak_usb: add forgotten supported devices"

Mark Tomlinson (3):
      Revert "netfilter: x_tables: Switch synchronization to RCU"
      netfilter: x_tables: Use correct memory barriers.
      Revert "netfilter: x_tables: Update remaining dereference to RCU"

Markus Theil (1):
      mac80211: fix double free in ibss_leave

Martin Willi (1):
      can: dev: Move device back to init netns on owning netns delete

Mian Yousaf Kaukab (1):
      netsec: restore phy power state after controller reset

Michael Braun (1):
      gianfar: fix jumbo packets+napi+rx overrun crash

Michael Ellerman (1):
      powerpc/4xx: Fix build errors from mfdcr()

Mikulas Patocka (1):
      dm ioctl: fix out of bounds array access when no devices

Nicolas Boichat (2):
      vmlinux.lds.h: Create section for protection against instrumentation
      lkdtm: don't move ctors to .rodata

Oleg Nesterov (3):
      kernel, fs: Introduce and use set_restart_fn() and arch_set_restart_data()
      x86: Move TS_COMPAT back to asm/thread_info.h
      x86: Introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()

Pavel Skripkin (1):
      net/qrtr: fix __netdev_alloc_skb call

Pavel Tatashin (1):
      arm64: kdump: update ppos when reading elfcorehdr

Peter Zijlstra (1):
      u64_stats,lockdep: Fix u64_stats_init() vs lockdep

Phillip Lougher (1):
      squashfs: fix xattr id and id lookup sanity checks

Potnuri Bharat Teja (1):
      RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server

Rafael J. Wysocki (2):
      Revert "PM: runtime: Update device status before letting suppliers suspend"
      ACPI: scan: Rearrange memory allocation in acpi_device_add()

Rob Gardner (1):
      sparc64: Fix opcode filtering in handling of no fault loads

Sagi Grimberg (2):
      nvmet: don't check iosqes,iocqes for discovery controllers
      nvme-rdma: fix possible hang when failing to set io queues

Sasha Levin (1):
      bpf: Don't do bpf_cgroup_storage_set() for kuprobe/tp programs

Sean Nyekjaer (1):
      squashfs: fix inode lookup sanity checks

Sergei Trofimovich (2):
      ia64: fix ia64_syscall_get_set_arguments() for break-based syscalls
      ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign

Shengjiu Wang (2):
      ASoC: ak4458: Add MODULE_DEVICE_TABLE
      ASoC: ak5558: Add MODULE_DEVICE_TABLE

Shijie Luo (1):
      ext4: fix potential error in ext4_do_update_inode

Stephane Grosjean (1):
      can: peak_usb: add forgotten supported devices

Thomas Gleixner (3):
      x86/ioapic: Ignore IRQ2 again
      genirq: Disable interrupts for force threaded handlers
      locking/mutex: Fix non debug version of mutex_lock_io_nested()

Timo Rothenpieler (2):
      svcrdma: disable timeouts on rdma backchannel
      nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default

Tong Zhang (6):
      atm: eni: dont release is never initialized
      atm: lanai: dont run lanai_dev_close if not open
      atm: uPD98402: fix incorrect allocation
      atm: idt77252: fix null-ptr-dereference
      can: c_can_pci: c_can_pci_remove(): fix use-after-free
      can: c_can: move runtime PM enable/disable to c_can_platform

Torin Cooper-Bennun (1):
      can: m_can: m_can_do_rx_poll(): fix extraneous msg loss warning

Tyrel Datwyler (1):
      PCI: rpadlpar: Fix potential drc_name corruption in store functions

Vincent Whitchurch (1):
      cifs: Fix preauth hash corruption

Vitaly Lifshits (1):
      e1000e: add rtnl_lock() to e1000_reset_task

Yang Li (1):
      gpiolib: acpi: Add missing IRQF_ONESHOT

Ye Xiang (3):
      iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
      iio: hid-sensor-prox: Fix scale not correct issue
      iio: hid-sensor-temperature: Fix issues of timestamp channel

zhangyi (F) (2):
      ext4: find old entry again if failed to rename whiteout
      ext4: do not try to set xattr into ea_inode if value is empty
---
Makefile                                           |  2 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi          |  4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  1 +
 arch/arm64/kernel/crash_dump.c                     |  2 +
 arch/ia64/include/asm/syscall.h                    |  2 +-
 arch/ia64/kernel/ptrace.c                          | 24 ++++--
 arch/powerpc/include/asm/cpu_has_feature.h         |  4 +-
 arch/powerpc/include/asm/dcr-native.h              |  8 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |  1 +
 arch/sparc/kernel/traps_64.c                       | 13 ++--
 arch/x86/events/intel/ds.c                         |  2 +-
 arch/x86/include/asm/processor.h                   |  9 ---
 arch/x86/include/asm/thread_info.h                 | 23 +++++-
 arch/x86/kernel/apic/apic.c                        |  5 ++
 arch/x86/kernel/apic/io_apic.c                     | 10 +++
 arch/x86/kernel/signal.c                           | 24 +-----
 arch/x86/mm/mem_encrypt.c                          |  2 +-
 block/genhd.c                                      |  4 +-
 drivers/acpi/internal.h                            |  6 +-
 drivers/acpi/scan.c                                | 88 +++++++++++++---------
 drivers/atm/eni.c                                  |  3 +-
 drivers/atm/idt77105.c                             |  4 +-
 drivers/atm/lanai.c                                |  5 +-
 drivers/atm/uPD98402.c                             |  2 +-
 drivers/base/power/runtime.c                       | 62 ++++++---------
 drivers/block/xen-blkback/blkback.c                |  2 +-
 drivers/bus/omap_l3_noc.c                          |  4 +-
 drivers/gpio/gpiolib-acpi.c                        |  2 +-
 drivers/gpu/drm/Kconfig                            |  1 +
 drivers/gpu/drm/msm/msm_drv.c                      |  4 +
 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/qcom-spmi-vadc.c                   |  2 +-
 drivers/iio/gyro/mpu3050-core.c                    |  2 +
 drivers/iio/humidity/hid-sensor-humidity.c         | 12 +--
 drivers/iio/imu/adis16400_core.c                   |  3 +-
 drivers/iio/light/hid-sensor-prox.c                | 13 +++-
 drivers/iio/temperature/hid-sensor-temperature.c   | 14 ++--
 drivers/infiniband/hw/cxgb4/cm.c                   |  4 +-
 drivers/md/dm-ioctl.c                              |  2 +-
 drivers/md/dm-verity-target.c                      |  2 +-
 drivers/misc/lkdtm/Makefile                        |  2 +-
 drivers/misc/lkdtm/rodata.c                        |  2 +-
 drivers/net/can/c_can/c_can.c                      | 24 +-----
 drivers/net/can/c_can/c_can_pci.c                  |  3 +-
 drivers/net/can/c_can/c_can_platform.c             |  6 +-
 drivers/net/can/dev.c                              |  1 +
 drivers/net/can/flexcan.c                          |  8 +-
 drivers/net/can/m_can/m_can.c                      |  3 -
 drivers/net/dsa/bcm_sf2.c                          |  6 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c           |  7 ++
 drivers/net/ethernet/freescale/gianfar.c           | 15 ++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  4 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |  2 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  6 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  6 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_minidump.c   |  3 +
 drivers/net/ethernet/socionext/netsec.c            |  9 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 +
 drivers/net/ethernet/sun/niu.c                     |  2 -
 drivers/net/ethernet/tehuti/tehuti.c               |  1 +
 drivers/net/usb/cdc-phonet.c                       |  2 +
 drivers/net/usb/r8152.c                            | 35 ++-------
 drivers/net/veth.c                                 |  3 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  8 +-
 drivers/nvme/host/rdma.c                           |  7 +-
 drivers/nvme/target/core.c                         | 17 ++++-
 drivers/pci/hotplug/rpadlpar_sysfs.c               | 14 ++--
 drivers/platform/x86/intel-vbtn.c                  | 12 ++-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  8 +-
 drivers/scsi/qedi/qedi_main.c                      |  1 +
 drivers/usb/gadget/composite.c                     |  4 +-
 drivers/usb/gadget/configfs.c                      | 16 ++--
 drivers/usb/gadget/usbstring.c                     |  4 +-
 drivers/usb/storage/transport.c                    |  7 ++
 drivers/usb/storage/unusual_devs.h                 | 12 +++
 drivers/usb/usbip/vudc_sysfs.c                     |  2 +-
 fs/btrfs/ctree.c                                   |  2 +
 fs/btrfs/inode.c                                   |  2 +-
 fs/cifs/transport.c                                |  7 +-
 fs/ext4/inode.c                                    |  8 +-
 fs/ext4/namei.c                                    | 29 ++++++-
 fs/ext4/xattr.c                                    |  6 +-
 fs/nfs/Kconfig                                     |  2 +-
 fs/nfs/nfs3xdr.c                                   |  3 +-
 fs/nfs/nfs4proc.c                                  |  3 +
 fs/select.c                                        | 10 +--
 fs/squashfs/export.c                               |  8 +-
 fs/squashfs/id.c                                   |  6 +-
 fs/squashfs/squashfs_fs.h                          |  1 +
 fs/squashfs/xattr_id.c                             |  6 +-
 include/acpi/acpi_bus.h                            |  1 +
 include/asm-generic/sections.h                     |  3 +
 include/asm-generic/vmlinux.lds.h                  | 10 +++
 include/linux/bpf.h                                |  9 ++-
 include/linux/compiler.h                           | 54 +++++++++++++
 include/linux/compiler_types.h                     |  6 ++
 include/linux/if_macvlan.h                         |  3 +-
 include/linux/mutex.h                              |  2 +-
 include/linux/netfilter/x_tables.h                 |  7 +-
 include/linux/thread_info.h                        | 13 ++++
 include/linux/u64_stats_sync.h                     |  7 +-
 include/linux/usb_usual.h                          |  2 +
 include/net/red.h                                  | 10 ++-
 include/net/rtnetlink.h                            |  2 +
 include/uapi/linux/usb/ch9.h                       |  3 +
 kernel/futex.c                                     |  3 +-
 kernel/irq/manage.c                                | 14 ++--
 kernel/time/alarmtimer.c                           |  2 +-
 kernel/time/hrtimer.c                              |  2 +-
 kernel/time/posix-cpu-timers.c                     |  2 +-
 localversion-rt                                    |  2 +-
 net/core/dev.c                                     |  2 +-
 net/ipv4/netfilter/arp_tables.c                    | 16 ++--
 net/ipv4/netfilter/ip_tables.c                     | 16 ++--
 net/ipv6/netfilter/ip6_tables.c                    | 16 ++--
 net/mac80211/cfg.c                                 |  4 +-
 net/mac80211/ibss.c                                |  2 +
 net/netfilter/nf_conntrack_netlink.c               |  1 +
 net/netfilter/x_tables.c                           | 49 ++++++++----
 net/qrtr/qrtr.c                                    |  7 +-
 net/sched/sch_choke.c                              |  7 +-
 net/sched/sch_gred.c                               |  2 +-
 net/sched/sch_red.c                                |  7 +-
 net/sched/sch_sfq.c                                |  2 +-
 net/sunrpc/svc.c                                   |  6 +-
 net/sunrpc/svc_xprt.c                              |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c         |  6 +-
 scripts/mod/modpost.c                              |  2 +-
 sound/pci/hda/hda_generic.c                        |  2 +-
 sound/soc/codecs/ak4458.c                          |  1 +
 sound/soc/codecs/ak5558.c                          |  1 +
 sound/soc/fsl/fsl_ssi.c                            |  6 +-
 tools/build/Makefile.feature                       |  3 +
 tools/build/feature/Makefile                       | 12 +++
 tools/build/feature/test-all.c                     | 15 ++++
 tools/build/feature/test-eventfd.c                 |  9 +++
 tools/build/feature/test-get_current_dir_name.c    | 10 +++
 tools/build/feature/test-gettid.c                  | 11 +++
 tools/lib/bpf/Makefile                             |  2 +-
 tools/perf/Makefile.config                         | 12 +++
 tools/perf/jvmti/jvmti_agent.c                     |  2 +
 tools/perf/util/Build                              |  1 +
 tools/perf/util/auxtrace.c                         |  4 -
 tools/perf/util/expr.y                             |  3 +-
 tools/perf/util/get_current_dir_name.c             | 18 +++++
 tools/perf/util/parse-events.y                     |  2 +-
 tools/perf/util/util.h                             |  4 +
 152 files changed, 783 insertions(+), 389 deletions(-)
