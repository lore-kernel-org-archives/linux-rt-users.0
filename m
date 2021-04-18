Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1035C433ED
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Apr 2021 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B32610FC
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Apr 2021 13:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDRNIi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Apr 2021 09:08:38 -0400
Received: from mail.monom.org ([188.138.9.77]:46846 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhDRNIi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Apr 2021 09:08:38 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D6D1350051A;
        Sun, 18 Apr 2021 15:08:07 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id 1D5805001DD;
        Sun, 18 Apr 2021 15:08:07 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.267-rt221
Date:   Sun, 18 Apr 2021 13:05:12 -0000
Message-ID: <161875111291.22181.11733977662198389053@beryllium.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.267-rt221 stable release.

This is just an update to the latest stable release. No RT
specific changes.

Known issue:

  - locktorture reports a might_sleep warning for spin_locks test

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: e65ae24c8623270657748609d1bf099019dd2635

Or to build 4.4.267-rt221 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.267.xz

Enjoy!
Daniel

Changes from v4.4.262-rt219:
---

Adrian Hunter (1):
      perf auxtrace: Fix auxtrace queue conflict

Alexander Aring (8):
      net: ieee802154: nl-mac: fix check on panid
      net: ieee802154: fix nl802154 del llsec key
      net: ieee802154: fix nl802154 del llsec dev
      net: ieee802154: fix nl802154 add llsec key
      net: ieee802154: fix nl802154 del llsec devkey
      net: ieee802154: forbid monitor for set llsec params
      net: ieee802154: forbid monitor for del llsec seclevel
      net: ieee802154: stop dump llsec params for monitors

Alexander Gordeev (1):
      s390/cpcmd: fix inline assembly register clobbering

Alexey Dobriyan (1):
      scsi: qla2xxx: Fix broken #endif placement

Angelo Dureghello (1):
      can: flexcan: flexcan_chip_freeze(): fix chip freeze for missing bitrate

Arnaldo Carvalho de Melo (1):
      perf map: Tighten snprintf() string precision to pass gcc check on some 32-bit arches

Arnd Bergmann (2):
      x86/build: Turn off -fcf-protection for realmode targets
      drm/imx: imx-ldb: fix out of bounds array access warning

Atul Gopinathan (2):
      staging: rtl8192e: Fix incorrect source in memcpy()
      staging: rtl8192e: Change state information from u16 to u8

Benjamin Rood (1):
      ASoC: sgtl5000: set DAP_AVC_CTRL register to correct default value on probe

Borislav Petkov (1):
      x86/tlb: Flush global mappings when KAISER is disabled

Claudiu Manoil (1):
      gianfar: Handle error code at MAC address change

Dan Carpenter (1):
      scsi: lpfc: Fix some error codes in debugfs

Daniel Wagner (4):
      Merge tag 'v4.4.263' into v4.4-rt
      Linux 4.4.263-rt220
      Merge tag 'v4.4.267' into v4.4-rt
      Linux 4.4.267-rt221

David Brazdil (1):
      selinux: vsock: Set SID for socket returned by accept()

Denis Efremov (1):
      sun/niu: fix wrong RXMAC_BC_FRM_CNT_COUNT count

Dinghao Liu (2):
      e1000e: Fix error handling in e1000_set_d0_lplu_state_82571
      extcon: Fix error handling in extcon_dev_register

Doug Brown (1):
      appletalk: Fix skb allocation size in loopback case

Du Cheng (1):
      cfg80211: remove WARN_ON() in cfg80211_sme_connect

Eric Dumazet (3):
      macvlan: macvlan_count_rx() needs to be aware of preemption
      net: sched: validate stab values
      sch_red: fix off-by-one checks in red_check_params()

Filipe Manana (1):
      btrfs: fix race when cloning extent buffer during rewind of an old root

Florian Fainelli (1):
      net: dsa: bcm_sf2: Qualify phydev->dev_flags based on port

Florian Westphal (1):
      netfilter: x_tables: fix compat match/target pad out-of-bound write

Frank Sorenson (1):
      NFS: Correct size calculation for create reply length

Greg Kroah-Hartman (5):
      Linux 4.4.263
      Linux 4.4.264
      Linux 4.4.265
      Linux 4.4.266
      Linux 4.4.267

Grygorii Strashko (1):
      bus: omap_l3_noc: mark l3 irqs as IRQF_NO_THREAD

Gwendal Grignou (1):
      platform/chrome: cros_ec_dev - Fix security issue

Hans de Goede (2):
      ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor of 10
      ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor of 10

Heiko Carstens (1):
      init/Kconfig: make COMPILE_TEST depend on !S390

Heiko Thiery (1):
      net: fec: ptp: avoid register access when ipg clock is disabled

Helge Deller (1):
      parisc: parisc-agp requires SBA IOMMU driver

Hui Wang (1):
      ALSA: hda/realtek: call alc_update_headset_mode() in hp_automute_hook

Ikjoon Jang (1):
      ALSA: usb-audio: Apply sample rate quirk to Logitech Connect

Ilya Lipnitskiy (1):
      mm: fix race by making init_zero_pfn() early_initcall

J. Bruce Fields (2):
      nfs: we don't support removing system.nfs4_acl
      rpc: fix NULL dereference on kmalloc failure

Jack Qiu (1):
      fs: direct-io: fix missing sdio->boundary

Jakub Kicinski (1):
      ipv6: weaken the v4mapped source check

Jan Beulich (1):
      xen-blkback: don't leak persistent grants from xen_blkbk_map()

Jan Kara (3):
      ext4: handle error of ext4_setup_system_zone() on remount
      ext4: don't allow overlapping system zones
      ext4: check journal inode extents more carefully

Jia-Ju Bai (1):
      net: tehuti: fix error return code in bdx_probe()

Jim Lin (1):
      usb: gadget: configfs: Fix KASAN use-after-free

Joe Korty (1):
      NFSD: Repair misuse of sv_lock in 5.10.16-rt30.

Johan Hovold (2):
      net: cdc-phonet: fix data-interface release on probe failure
      USB: cdc-acm: fix use-after-free after probe failure

Johannes Berg (1):
      mac80211: fix rate mask reset

Jonas Holmberg (1):
      ALSA: aloop: Fix initialization of controls

Juergen Gross (1):
      xen/events: fix setting irq affinity

Karthikeyan Kathirvel (1):
      mac80211: choose first enabled channel for monitor

Krzysztof Kozlowski (1):
      clk: socfpga: fix iomem pointer cast on 64-bit

Luca Fancellu (1):
      xen/evtchn: Change irq_info lock to raw_spinlock_t

Lukasz Bartosik (1):
      clk: fix invalid usage of list cursor in unregister

Lv Yunlong (3):
      net/qlcnic: Fix a use after free in qlcnic_83xx_get_minidump_template
      scsi: st: Fix a use after free in st_open()
      net:tipc: Fix a double free in tipc_sk_mcast_rcv

Macpaul Lin (1):
      USB: replace hardcode maximum usb string length by definition

Markus Theil (1):
      mac80211: fix double free in ibss_leave

Martin Willi (1):
      can: dev: Move device back to init netns on owning netns delete

Masahiro Yamada (1):
      init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM

Michael Ellerman (1):
      powerpc/4xx: Fix build errors from mfdcr()

Miquel Raynal (7):
      mtd: rawnand: tmio: Fix the probe error path
      mtd: rawnand: socrates: Fix the probe error path
      mtd: rawnand: sharpsl: Fix the probe error path
      mtd: rawnand: plat_nand: Fix the probe error path
      mtd: rawnand: pasemi: Fix the probe error path
      mtd: rawnand: orion: Fix the probe error path
      mtd: rawnand: diskonchip: Fix the probe error path

Muhammad Usama Anjum (1):
      net: ipv6: check for validity before dereferencing cfg->fc_nlinfo.nlh

Oliver Neukum (2):
      cdc-acm: fix BREAK rx code path adding necessary calls
      USB: cdc-acm: downgrade message to debug

Pavel Andrianov (1):
      net: pxa168_eth: Fix a potential data race in pxa168_eth_remove

Pavel Skripkin (3):
      drivers: net: fix memory leak in atusb_probe
      drivers: net: fix memory leak in peak_usb_create_dev
      net: mac802154: Fix general protection fault

Pavel Tikhomirov (1):
      net: sched: sch_teql: fix null-pointer dereference

Peter Zijlstra (1):
      u64_stats,lockdep: Fix u64_stats_init() vs lockdep

Phillip Lougher (1):
      squashfs: fix xattr id and id lookup sanity checks

Phillip Potter (1):
      net: tun: set tun->dev->addr_len during TUNSETLINK processing

Piotr Krysiuk (1):
      bpf, x86: Validate computation of branch displacements for x86-64

Potnuri Bharat Teja (2):
      RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server
      RDMA/cxgb4: check for ipv6 address properly while destroying listener

Richard Weinberger (1):
      init/Kconfig: make COMPILE_TEST depend on !UML

Ronnie Sahlberg (1):
      cifs: revalidate mapping when we open files for SMB1 POSIX

Sean Nyekjaer (1):
      squashfs: fix inode lookup sanity checks

Sergei Trofimovich (4):
      ia64: fix ia64_syscall_get_set_arguments() for break-based syscalls
      ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
      ia64: mca: allocate early mca with GFP_ATOMIC
      ia64: fix user_stack_pointer() for ptrace()

Shih-Yuan Lee (FourDollars) (1):
      ALSA: hda/realtek - Fix pincfg for Dell XPS 13 9370

Shijie Luo (1):
      ext4: fix potential error in ext4_do_update_inode

Steven Rostedt (VMware) (2):
      tracing: Fix stack trace event size
      tracing: Add a vmalloc_sync_mappings() for safe measure

Tetsuo Handa (2):
      reiserfs: update reiserfs_xattrs_initialized() condition
      batman-adv: initialize "struct batadv_tvlv_tt_vlan_data"->reserved field

Thomas Gleixner (2):
      x86/ioapic: Ignore IRQ2 again
      genirq: Disable interrupts for force threaded handlers

Timo Rothenpieler (1):
      nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default

Tong Zhang (10):
      atm: eni: dont release is never initialized
      atm: lanai: dont run lanai_dev_close if not open
      atm: uPD98402: fix incorrect allocation
      atm: idt77252: fix null-ptr-dereference
      can: c_can_pci: c_can_pci_remove(): fix use-after-free
      can: c_can: move runtime PM enable/disable to c_can_platform
      staging: comedi: cb_pcidas: fix request_irq() warn
      staging: comedi: cb_pcidas64: fix request_irq() warn
      net: wan/lmc: unregister device when no matching device is found
      mISDN: fix crash in fritzpci

Torin Cooper-Bennun (1):
      can: m_can: m_can_do_rx_poll(): fix extraneous msg loss warning

Tyrel Datwyler (1):
      PCI: rpadlpar: Fix potential drc_name corruption in store functions

Vincent Palatin (1):
      USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem

Vincent Whitchurch (1):
      cifs: Silently ignore unknown oplock break handle

Vitaly Lifshits (1):
      e1000e: add rtnl_lock() to e1000_reset_task

Wang Panzhenzhuan (1):
      pinctrl: rockchip: fix restore error in resume

Xiaoming Ni (4):
      nfc: fix refcount leak in llcp_sock_bind()
      nfc: fix refcount leak in llcp_sock_connect()
      nfc: fix memory leak in llcp_sock_connect()
      nfc: Avoid endless loops caused by repeated llcp_sock_connect()

Ye Xiang (1):
      iio: hid-sensor-prox: Fix scale not correct issue

Zhaolong Zhang (1):
      ext4: fix bh ref count on error paths

Zheyu Ma (1):
      firewire: nosy: Fix a use-after-free bug in nosy_ioctl()

Zqiang (1):
      workqueue: Move the position of debug_work_activate() in __queue_work()

zhangyi (F) (2):
      ext4: find old entry again if failed to rename whiteout
      ext4: do not iput inode under running transaction in ext4_rename()
---
Makefile                                           |  2 +-
 arch/ia64/include/asm/ptrace.h                     |  8 +--
 arch/ia64/include/asm/syscall.h                    |  2 +-
 arch/ia64/kernel/mca.c                             |  2 +-
 arch/ia64/kernel/ptrace.c                          | 24 ++++++--
 arch/powerpc/include/asm/dcr-native.h              |  8 +--
 arch/s390/kernel/cpcmd.c                           |  6 +-
 arch/x86/Makefile                                  |  2 +-
 arch/x86/include/asm/tlbflush.h                    | 11 ++--
 arch/x86/kernel/apic/io_apic.c                     | 10 +++
 arch/x86/net/bpf_jit_comp.c                        | 11 +++-
 drivers/atm/eni.c                                  |  3 +-
 drivers/atm/idt77105.c                             |  4 +-
 drivers/atm/lanai.c                                |  5 +-
 drivers/atm/uPD98402.c                             |  2 +-
 drivers/block/xen-blkback/blkback.c                |  2 +-
 drivers/bus/omap_l3_noc.c                          |  4 +-
 drivers/char/agp/Kconfig                           |  2 +-
 drivers/clk/clk.c                                  | 30 ++++-----
 drivers/clk/socfpga/clk-gate.c                     |  2 +-
 drivers/extcon/extcon.c                            |  1 +
 drivers/firewire/nosy.c                            |  9 ++-
 drivers/gpu/drm/imx/imx-ldb.c                      | 10 +++
 drivers/iio/light/hid-sensor-prox.c                | 14 ++++-
 drivers/infiniband/hw/cxgb4/cm.c                   |  5 +-
 drivers/isdn/hardware/mISDN/mISDNipac.c            |  2 +-
 drivers/mtd/nand/diskonchip.c                      |  7 +--
 drivers/mtd/nand/orion_nand.c                      |  2 +-
 drivers/mtd/nand/pasemi_nand.c                     |  4 +-
 drivers/mtd/nand/plat_nand.c                       |  2 +-
 drivers/mtd/nand/sharpsl.c                         |  2 +-
 drivers/mtd/nand/socrates_nand.c                   |  2 +-
 drivers/mtd/nand/tmio_nand.c                       |  2 +-
 drivers/net/can/c_can/c_can.c                      | 24 +-------
 drivers/net/can/c_can/c_can_pci.c                  |  3 +-
 drivers/net/can/c_can/c_can_platform.c             |  6 +-
 drivers/net/can/dev.c                              |  1 +
 drivers/net/can/flexcan.c                          |  8 ++-
 drivers/net/can/m_can/m_can.c                      |  3 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  6 +-
 drivers/net/dsa/bcm_sf2.c                          |  6 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |  7 +++
 drivers/net/ethernet/freescale/gianfar.c           |  6 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |  2 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |  2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_minidump.c   |  3 +
 drivers/net/ethernet/sun/niu.c                     |  2 -
 drivers/net/ethernet/tehuti/tehuti.c               |  1 +
 drivers/net/ieee802154/atusb.c                     |  1 +
 drivers/net/tun.c                                  | 48 +++++++++++++++
 drivers/net/usb/cdc-phonet.c                       |  2 +
 drivers/net/wan/lmc/lmc_main.c                     |  2 +
 drivers/pci/hotplug/rpadlpar_sysfs.c               | 14 ++---
 drivers/pinctrl/pinctrl-rockchip.c                 | 13 ++--
 drivers/platform/chrome/cros_ec_dev.c              |  4 ++
 drivers/platform/chrome/cros_ec_proto.c            |  4 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |  4 +-
 drivers/scsi/qla2xxx/qla_target.h                  |  2 +-
 drivers/scsi/st.c                                  |  2 +-
 drivers/staging/comedi/drivers/cb_pcidas.c         |  2 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |  2 +-
 drivers/staging/rtl8192e/rtllib.h                  |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  2 +-
 drivers/usb/class/cdc-acm.c                        | 12 +++-
 drivers/usb/core/quirks.c                          |  4 ++
 drivers/usb/gadget/composite.c                     |  4 +-
 drivers/usb/gadget/configfs.c                      | 16 +++--
 drivers/usb/gadget/usbstring.c                     |  4 +-
 drivers/xen/events/events_base.c                   | 14 ++---
 drivers/xen/events/events_internal.h               |  2 +-
 fs/btrfs/ctree.c                                   |  2 +
 fs/cifs/file.c                                     |  1 +
 fs/cifs/smb2misc.c                                 |  4 +-
 fs/direct-io.c                                     |  5 +-
 fs/ext4/block_validity.c                           | 71 ++++++++++------------
 fs/ext4/ext4.h                                     |  6 +-
 fs/ext4/extents.c                                  | 16 ++---
 fs/ext4/indirect.c                                 |  6 +-
 fs/ext4/inode.c                                    | 19 +++---
 fs/ext4/mballoc.c                                  |  4 +-
 fs/ext4/namei.c                                    | 47 ++++++++++----
 fs/ext4/super.c                                    |  5 +-
 fs/nfs/Kconfig                                     |  2 +-
 fs/nfs/nfs3xdr.c                                   |  3 +-
 fs/nfs/nfs4proc.c                                  |  3 +
 fs/reiserfs/xattr.h                                |  2 +-
 fs/squashfs/export.c                               |  8 ++-
 fs/squashfs/id.c                                   |  6 +-
 fs/squashfs/squashfs_fs.h                          |  1 +
 fs/squashfs/xattr_id.c                             |  6 +-
 include/linux/if_macvlan.h                         |  3 +-
 include/linux/mfd/cros_ec.h                        |  6 +-
 include/linux/u64_stats_sync.h                     |  7 ++-
 include/net/red.h                                  | 14 ++++-
 include/net/rtnetlink.h                            |  2 +
 include/uapi/linux/usb/ch9.h                       |  3 +
 init/Kconfig                                       |  2 +-
 kernel/irq/manage.c                                |  4 ++
 kernel/trace/trace.c                               | 17 +++++-
 kernel/workqueue.c                                 |  2 +-
 localversion-rt                                    |  2 +-
 mm/memory.c                                        |  2 +-
 net/appletalk/ddp.c                                | 33 ++++++----
 net/batman-adv/translation-table.c                 |  1 +
 net/core/dev.c                                     |  2 +-
 net/dccp/ipv6.c                                    |  5 ++
 net/ieee802154/nl-mac.c                            |  7 ++-
 net/ieee802154/nl802154.c                          | 23 +++++--
 net/ipv4/netfilter/arp_tables.c                    |  2 +
 net/ipv4/netfilter/ip_tables.c                     |  2 +
 net/ipv6/ip6_input.c                               | 10 ---
 net/ipv6/netfilter/ip6_tables.c                    |  2 +
 net/ipv6/route.c                                   |  8 ++-
 net/ipv6/tcp_ipv6.c                                |  5 ++
 net/mac80211/cfg.c                                 |  4 +-
 net/mac80211/ibss.c                                |  2 +
 net/mac80211/main.c                                | 13 +++-
 net/mac802154/llsec.c                              |  2 +-
 net/netfilter/x_tables.c                           | 10 +--
 net/nfc/llcp_sock.c                                | 10 +++
 net/sched/sch_choke.c                              |  7 ++-
 net/sched/sch_gred.c                               |  2 +-
 net/sched/sch_red.c                                |  7 ++-
 net/sched/sch_sfq.c                                |  2 +-
 net/sched/sch_teql.c                               |  3 +
 net/sunrpc/auth_gss/svcauth_gss.c                  | 11 ++--
 net/sunrpc/svc_xprt.c                              |  4 +-
 net/tipc/socket.c                                  |  2 +-
 net/vmw_vsock/af_vsock.c                           |  1 +
 net/wireless/sme.c                                 |  2 +-
 sound/drivers/aloop.c                              | 11 +++-
 sound/pci/hda/patch_realtek.c                      |  2 +-
 sound/soc/codecs/rt5640.c                          |  4 +-
 sound/soc/codecs/rt5651.c                          |  4 +-
 sound/soc/codecs/sgtl5000.c                        |  2 +-
 sound/usb/quirks.c                                 |  1 +
 tools/perf/util/auxtrace.c                         |  4 --
 tools/perf/util/map.c                              |  7 +--
 139 files changed, 611 insertions(+), 335 deletions(-)
