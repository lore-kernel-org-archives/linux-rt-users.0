Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882BC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 21:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CD8610E7
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 21:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbhDPVoB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235540AbhDPVoA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Apr 2021 17:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25C57610CC;
        Fri, 16 Apr 2021 21:43:35 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.188-rt77
Date:   Fri, 16 Apr 2021 21:37:25 -0000
Message-ID: <161860904503.10661.16497825100264445224@puck.lan>
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

I'm pleased to announce the 4.19.188-rt77 stable release.

Note that this is a merge of the v4.19.188 stable release and the backport
of two RT commits:

87bd0bf324f4    mm: slub: Don't resize the location tracking cache on PREEMPT_RT
3c7e3c2cc78d    locking/rwsem-rt: Add __down_read_interruptible()


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: bf5c33f2602503faeab40ce2bc95d3c460189522

Or to build 4.19.188-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.188.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.188-rt77.patch.xz


You can also build from 4.19.185-rt76 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.185-rt76-rt77.patch.xz

Enjoy!
Clark

Changes from v4.19.185-rt76:
---

Ahmed S. Darwish (1):
      net: xfrm: Localize sequence counter per network namespace

Alban Bedel (1):
      platform/x86: intel-hid: Support Lenovo ThinkPad X1 Tablet Gen 2

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

Anirudh Rayabharam (1):
      net: hso: fix null-ptr-deref during tty device unregistration

Arnaldo Carvalho de Melo (1):
      perf map: Tighten snprintf() string precision to pass gcc check on some 32-bit arches

Arnd Bergmann (3):
      x86/build: Turn off -fcf-protection for realmode targets
      soc/fsl: qbman: fix conflicting alignment attributes
      drm/imx: imx-ldb: fix out of bounds array access warning

Aya Levin (1):
      net/mlx5: Fix PBMC register mapping

Bastian Germann (1):
      ASoC: sunxi: sun4i-codec: fill ASoC card owner

Bob Peterson (1):
      gfs2: report "already frozen/thawed" errors

Clark Williams (2):
      Merge tag 'v4.19.188' into v4.19-rt
      Linux 4.19.188-rt77

Claudiu Manoil (1):
      gianfar: Handle error code at MAC address change

Dmitry Osipenko (1):
      drm/tegra: dc: Don't set PLL clock to 0Hz

Du Cheng (1):
      cfg80211: remove WARN_ON() in cfg80211_sme_connect

Eric Dumazet (2):
      net: ensure mac header is set in virtio_net_hdr_to_skb()
      sch_red: fix off-by-one checks in red_check_params()

Eryk Rybak (1):
      i40e: Fix kernel oops when i40e driver removes VF's

Esteve Varela Colominas (1):
      platform/x86: thinkpad_acpi: Allow the FnLock LED to change state

Eyal Birger (1):
      xfrm: interface: fix ipv4 pmtu check to honor ip header df

Fabio Pricoco (1):
      ice: Increase control queue timeout

Florian Fainelli (1):
      net: phy: broadcom: Only advertise EEE for supported modes

Florian Westphal (1):
      netfilter: x_tables: fix compat match/target pad out-of-bound write

Gao Xiang (1):
      parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers

Geert Uytterhoeven (1):
      regulator: bd9571mwv: Fix AVS and DVFS voltage range

Greg Kroah-Hartman (5):
      Linux 4.19.186
      Revert "cifs: Set CIFS_MOUNT_USE_PREFIX_PATH flag on setting cifs_sb->prepath."
      Linux 4.19.187
      staging: m57621-mmc: delete driver from the tree.
      Linux 4.19.188

Hans de Goede (1):
      ASoC: intel: atom: Stop advertising non working S24LE support

Heiko Carstens (1):
      init/Kconfig: make COMPILE_TEST depend on !S390

Helge Deller (1):
      parisc: parisc-agp requires SBA IOMMU driver

Jack Qiu (1):
      fs: direct-io: fix missing sdio->boundary

Jonas Holmberg (1):
      ALSA: aloop: Fix initialization of controls

Juergen Gross (1):
      xen/events: fix setting irq affinity

Karthikeyan Kathirvel (1):
      mac80211: choose first enabled channel for monitor

Krzysztof Kozlowski (1):
      clk: socfpga: fix iomem pointer cast on 64-bit

Kumar Kartikeya Dwivedi (1):
      net: sched: bump refcount for new action in ACT replace mode

Luca Fancellu (1):
      xen/evtchn: Change irq_info lock to raw_spinlock_t

Lukasz Bartosik (2):
      clk: fix invalid usage of list cursor in register
      clk: fix invalid usage of list cursor in unregister

Lv Yunlong (1):
      net:tipc: Fix a double free in tipc_sk_mcast_rcv

Maciej Żenczykowski (1):
      net-ipv6: bugfix - raw & sctp - switch to ipv6_can_nonlocal_bind()

Mans Rullgard (1):
      ARM: dts: am33xx: add aliases for mmc interfaces

Marek Behún (1):
      ARM: dts: turris-omnia: configure LED[2]/INTn pin as interrupt pin

Martin Wilck (1):
      scsi: target: pscsi: Clean up after failure in pscsi_map_sg()

Masahiro Yamada (1):
      init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM

Mateusz Palczewski (1):
      i40e: Added Asym_Pause to supported link modes

Mike Rapoport (1):
      nds32: flush_dcache_page: use page_mapping_file to avoid races with swapoff

Milton Miller (1):
      net/ncsi: Avoid channel_monitor hrtimer deadlock

Muhammad Usama Anjum (1):
      net: ipv6: check for validity before dereferencing cfg->fc_nlinfo.nlh

Pavel Andrianov (1):
      net: pxa168_eth: Fix a potential data race in pxa168_eth_remove

Pavel Skripkin (3):
      drivers: net: fix memory leak in atusb_probe
      drivers: net: fix memory leak in peak_usb_create_dev
      net: mac802154: Fix general protection fault

Pavel Tikhomirov (1):
      net: sched: sch_teql: fix null-pointer dereference

Phillip Potter (1):
      net: tun: set tun->dev->addr_len during TUNSETLINK processing

Piotr Krysiuk (2):
      bpf, x86: Validate computation of branch displacements for x86-64
      bpf, x86: Validate computation of branch displacements for x86-32

Potnuri Bharat Teja (1):
      RDMA/cxgb4: check for ipv6 address properly while destroying listener

Raed Salem (1):
      net/mlx5: Fix placement of log_max_flow_counter

Rahul Lakkireddy (1):
      cxgb4: avoid collecting SGE_QBASE regs during traffic

Rob Clark (1):
      drm/msm: Ratelimit invalid-fence message

Ronnie Sahlberg (1):
      cifs: revalidate mapping when we open files for SMB1 POSIX

Saravana Kannan (1):
      driver core: Fix locking bug in deferred_probe_timeout_work_func()

Sebastian Andrzej Siewior (2):
      mm: slub: Don't resize the location tracking cache on PREEMPT_RT
      locking/rwsem_rt: Add __down_read_interruptible()

Sergei Trofimovich (3):
      ia64: mca: allocate early mca with GFP_ATOMIC
      ia64: fix format strings for err_inject
      ia64: fix user_stack_pointer() for ptrace()

Shengjiu Wang (1):
      ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chips

Shuah Khan (4):
      usbip: add sysfs_lock to synchronize sysfs code paths
      usbip: stub-dev synchronize sysfs code paths
      usbip: vudc synchronize sysfs code paths
      usbip: synchronize event handler with sysfs code paths

Shyam Sundar S K (1):
      amd-xgbe: Update DMA coherency values

Stefan Riedmueller (1):
      ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces

Suzuki K Poulose (2):
      KVM: arm64: Hide system instruction access to Trace registers
      KVM: arm64: Disable guest access to trace filter controls

Tetsuo Handa (1):
      batman-adv: initialize "struct batadv_tvlv_tt_vlan_data"->reserved field

Tong Zhang (1):
      mISDN: fix crash in fritzpci

Tony Lindgren (1):
      bus: ti-sysc: Fix warning on unbind if reset is not deasserted

Vincent Whitchurch (1):
      cifs: Silently ignore unknown oplock break handle

Wengang Wang (1):
      ocfs2: fix deadlock between setattr and dio_end_io_write

Wolfram Sang (1):
      i2c: turn recovery error on init to debug

Xiaoming Ni (4):
      nfc: fix refcount leak in llcp_sock_bind()
      nfc: fix refcount leak in llcp_sock_connect()
      nfc: fix memory leak in llcp_sock_connect()
      nfc: Avoid endless loops caused by repeated llcp_sock_connect()

Yufen Yu (1):
      block: only update parent bi_status when bio fail

Yuya Kusakabe (1):
      virtio_net: Add XDP meta data support

Zihao Yu (1):
      riscv,entry: fix misaligned base for excp_vect_table

Zqiang (1):
      workqueue: Move the position of debug_work_activate() in __queue_work()
---
Makefile                                           |    2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |    3 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |    1 +
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |    2 +
 arch/arm64/include/asm/kvm_arm.h                   |    1 +
 arch/arm64/kernel/cpufeature.c                     |    1 -
 arch/arm64/kvm/debug.c                             |    2 +
 arch/ia64/include/asm/ptrace.h                     |    8 +-
 arch/ia64/kernel/err_inject.c                      |   22 +-
 arch/ia64/kernel/mca.c                             |    2 +-
 arch/nds32/mm/cacheflush.c                         |    2 +-
 arch/parisc/include/asm/cmpxchg.h                  |    2 +-
 arch/riscv/kernel/entry.S                          |    1 +
 arch/s390/kernel/cpcmd.c                           |    6 +-
 arch/x86/Makefile                                  |    2 +-
 arch/x86/net/bpf_jit_comp.c                        |   11 +-
 arch/x86/net/bpf_jit_comp32.c                      |   11 +-
 block/bio.c                                        |    2 +-
 drivers/base/dd.c                                  |    8 +-
 drivers/bus/ti-sysc.c                              |    4 +-
 drivers/char/agp/Kconfig                           |    2 +-
 drivers/clk/clk.c                                  |   47 +-
 drivers/clk/socfpga/clk-gate.c                     |    2 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |   10 +
 drivers/gpu/drm/msm/msm_fence.c                    |    2 +-
 drivers/gpu/drm/tegra/dc.c                         |   10 +-
 drivers/i2c/i2c-core-base.c                        |    7 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |    3 +-
 drivers/isdn/hardware/mISDN/mISDNipac.c            |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    6 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |    6 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c     |   23 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    3 +-
 drivers/net/ethernet/freescale/gianfar.c           |    6 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    9 +
 drivers/net/ethernet/intel/ice/ice_controlq.h      |    4 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |    2 +-
 drivers/net/ieee802154/atusb.c                     |    1 +
 drivers/net/phy/bcm-phy-lib.c                      |   11 +-
 drivers/net/tun.c                                  |   48 +
 drivers/net/usb/hso.c                              |   33 +-
 drivers/net/virtio_net.c                           |   52 +-
 drivers/platform/x86/intel-hid.c                   |    7 +
 drivers/platform/x86/thinkpad_acpi.c               |    8 +-
 drivers/regulator/bd9571mwv-regulator.c            |    4 +-
 drivers/soc/fsl/qbman/qman.c                       |    2 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/mt7621-mmc/Kconfig                 |   16 -
 drivers/staging/mt7621-mmc/Makefile                |   42 -
 drivers/staging/mt7621-mmc/TODO                    |    8 -
 drivers/staging/mt7621-mmc/board.h                 |   63 -
 drivers/staging/mt7621-mmc/dbg.c                   |  307 ---
 drivers/staging/mt7621-mmc/dbg.h                   |  149 --
 drivers/staging/mt7621-mmc/mt6575_sd.h             |  488 ----
 drivers/staging/mt7621-mmc/sd.c                    | 2392 --------------------
 drivers/target/target_core_pscsi.c                 |    8 +
 drivers/usb/usbip/stub_dev.c                       |   11 +-
 drivers/usb/usbip/usbip_common.h                   |    3 +
 drivers/usb/usbip/usbip_event.c                    |    2 +
 drivers/usb/usbip/vhci_hcd.c                       |    1 +
 drivers/usb/usbip/vhci_sysfs.c                     |   30 +-
 drivers/usb/usbip/vudc_dev.c                       |    1 +
 drivers/usb/usbip/vudc_sysfs.c                     |    5 +
 drivers/xen/events/events_base.c                   |   14 +-
 drivers/xen/events/events_internal.h               |    2 +-
 fs/cifs/connect.c                                  |    1 -
 fs/cifs/file.c                                     |    1 +
 fs/cifs/smb2misc.c                                 |    4 +-
 fs/direct-io.c                                     |    5 +-
 fs/gfs2/super.c                                    |   10 +-
 fs/ocfs2/aops.c                                    |   11 +-
 fs/ocfs2/file.c                                    |    8 +-
 include/linux/mlx5/mlx5_ifc.h                      |    8 +-
 include/linux/rwsem_rt.h                           |    1 +
 include/linux/virtio_net.h                         |    2 +
 include/net/netns/xfrm.h                           |    4 +-
 include/net/red.h                                  |    4 +-
 init/Kconfig                                       |    3 +-
 kernel/locking/rwsem-rt.c                          |   11 +
 kernel/workqueue.c                                 |    2 +-
 localversion-rt                                    |    2 +-
 mm/slub.c                                          |    3 +
 net/batman-adv/translation-table.c                 |    2 +
 net/ieee802154/nl-mac.c                            |    7 +-
 net/ieee802154/nl802154.c                          |   23 +-
 net/ipv4/netfilter/arp_tables.c                    |    2 +
 net/ipv4/netfilter/ip_tables.c                     |    2 +
 net/ipv6/netfilter/ip6_tables.c                    |    2 +
 net/ipv6/raw.c                                     |    2 +-
 net/ipv6/route.c                                   |    8 +-
 net/mac80211/main.c                                |   13 +-
 net/mac802154/llsec.c                              |    2 +-
 net/ncsi/ncsi-manage.c                             |   20 +-
 net/netfilter/x_tables.c                           |   10 +-
 net/nfc/llcp_sock.c                                |   10 +
 net/sched/act_api.c                                |    3 +
 net/sched/sch_teql.c                               |    3 +
 net/sctp/ipv6.c                                    |    7 +-
 net/tipc/socket.c                                  |    2 +-
 net/wireless/sme.c                                 |    2 +-
 net/xfrm/xfrm_interface.c                          |    3 +
 net/xfrm/xfrm_state.c                              |   10 +-
 sound/drivers/aloop.c                              |   11 +-
 sound/soc/codecs/wm8960.c                          |    8 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    6 +-
 sound/soc/sunxi/sun4i-codec.c                      |    5 +
 tools/perf/util/map.c                              |    7 +-
 110 files changed, 502 insertions(+), 3698 deletions(-)
