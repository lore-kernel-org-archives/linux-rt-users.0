Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A49C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 14:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40F561165
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJ2OzJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJ2OzI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 10:55:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7770610EA;
        Fri, 29 Oct 2021 14:52:39 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.214-rt93
Date:   Fri, 29 Oct 2021 14:51:49 -0000
Message-ID: <163551910998.1585965.10411811025830003129@puck.lan>
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

I'm pleased to announce the 4.19.214-rt93 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 9777786c0843e5563374a696ff290cabe3553468

Or to build 4.19.214-rt93 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.214.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.214-rt93.patch.xz


You can also build from 4.19.212-rt92 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.212-rt92-rt93.patch.xz

Enjoy!
Clark

Changes from v4.19.212-rt92:
---

Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Andy Shevchenko (1):
      mei: me: add Ice Lake-N device id.

Antoine Tenart (1):
      netfilter: ipvs: make global sysctl readonly in non-init netns

Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Arnd Bergmann (2):
      cb710: avoid NULL pointer subtraction
      ethernet: s2io: fix setting mac address during resume

Benjamin Coddington (1):
      NFSD: Keep existing listeners on portlist error

Billy Tsai (1):
      iio: adc: aspeed: set driver data when adc probe.

Borislav Petkov (1):
      x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically

Brendan Grieve (1):
      ALSA: usb-audio: Provide quirk for Sennheiser GSP670 Headset

Brendan Higgins (1):
      gcc-plugins/structleak: add makefile var for disabling structleak

Christophe JAILLET (1):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'

Clark Williams (3):
      Merge tag 'v4.19.213' into v4.19-rt
      Merge tag 'v4.19.214' into v4.19-rt
      Linux 4.19.214-rt93

Colin Ian King (1):
      drm/msm: Fix null pointer dereference on pointer edp

Dan Carpenter (6):
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      iio: dac: ti-dac5571: fix an error code in probe()
      pata_legacy: fix a couple uninitialized variable bugs
      drm/msm/dsi: Fix an error code in msm_dsi_modeset_init()
      drm/msm/dsi: fix off by one in dsi_bus_clk_enable error handling

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

Dexuan Cui (1):
      scsi: core: Fix shost->cmd_per_lun calculation in scsi_add_host_with_dma()

Eiichi Tsukata (1):
      sctp: account stream padding length for reconf chunk

Eugen Hristev (1):
      ARM: dts: at91: sama5d2_som1_ek: disable ISC node by default

Filipe Manana (4):
      btrfs: deal with errors when replaying dir entry during log replay
      btrfs: deal with errors when adding inode reference during log replay
      btrfs: check for error when looking up inode during dir entry replay
      btrfs: deal with errors when checking if a dir entry exists during log replay

Gerald Schaefer (1):
      dma-debug: fix sg checks in debug_dma_map_sg()

Greg Kroah-Hartman (2):
      Linux 4.19.213
      Linux 4.19.214

Guangbin Huang (1):
      net: hns3: add limit ets dwrr bandwidth cannot be 0

Guenter Roeck (1):
      xtensa: xtfpga: Try software restart before simulating CPU reset

Halil Pasic (1):
      virtio: write back F_VERSION_1 before validate

Herve Codina (2):
      net: stmmac: add support for dwmac 3.40a
      ARM: dts: spear3xx: Fix gmac node

Jackie Liu (1):
      acpi/arm64: fix next_platform_timer() section mismatch error

James Morse (1):
      x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state() fails

Jan Kara (1):
      ocfs2: fix data corruption after conversion from inline format

Jiri Valek - 2N (1):
      iio: light: opt3001: Fixed timeout error when 0 lux

Jonathan Bell (1):
      xhci: guard accesses to ep_state in xhci_endpoint_reset()

Kai Vehmanen (1):
      ALSA: hda: avoid write to STATESTS if controller is in reset

Kailang Yang (1):
      ALSA: hda/realtek - ALC236 headset MIC recording issue

Lin Ma (1):
      nfc: nci: fix the UAF of rf_conn_info object

Lukas Bulwahn (1):
      elfcore: correct reference to CONFIG_UML

Matthew Wilcox (Oracle) (1):
      vfs: check fd has read access in kernel_read_file_from_fd()

Max Filippov (1):
      xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF

Miaohe Lin (1):
      mm, slub: fix mismatch between reconstructed freelist depth and cnt

Michael Cullen (1):
      Input: xpad - add support for another USB ID of Nacon GC-100

Miquel Raynal (1):
      usb: musb: dsps: Fix the probe error path

Nanyong Sun (1):
      net: encx24j600: check error in devm_regmap_init_encx24j600

Nick Desaulniers (1):
      ARM: 9122/1: select HAVE_FUTEX_CMPXCHG

Nikolay Martynov (1):
      xhci: Enable trust tx length quirk for Fresco FL11 USB controller

Pavankumar Kondeti (1):
      xhci: Fix command ring pointer corruption while aborting a command

Peng Li (1):
      net: hns3: disable sriov before unload hclge layer

Prashant Malani (1):
      platform/x86: intel_scu_ipc: Update timeout value in comment

Randy Dunlap (1):
      NIOS2: irqflags: rename a redefined register name

Roberto Sassu (1):
      s390: fix strrchr() implementation

Sebastian Andrzej Siewior (1):
      mqprio: Correct stats in mqprio_dump_class_stats().

Shengjiu Wang (1):
      ASoC: wm8960: Fix clock configuration on slave mode

Stephane Grosjean (1):
      can: peak_usb: pcan_usb_fd_decode_status(): fix back to ERROR_ACTIVE state notification

Stephen Boyd (1):
      nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

Steven Clarkson (1):
      ALSA: hda/realtek: Add quirk for Clevo PC50HS

Steven Rostedt (1):
      nds32/ftrace: Fix Error: invalid operands (*UND* and *UND* sections) for `^'

Steven Rostedt (VMware) (1):
      tracing: Have all levels of checks prevent recursion

Takashi Iwai (2):
      ALSA: seq: Fix a potential UAF by wrong private_free call order
      ASoC: DAPM: Fix missing kctl change notifications

Tomaz Solc (1):
      USB: serial: option: add prod. id for Quectel EG91

Vadim Pasternak (1):
      platform/mellanox: mlxreg-io: Fix argument base in kstrtou32() call

Valentin Vidic (1):
      ocfs2: mount fails with buffer overflow in strlen

Vegard Nossum (5):
      net: arc: select CRC32
      net: korina: select CRC32
      r8152: select CRC32 and CRYPTO/CRYPTO_HASH/CRYPTO_SHA256
      lan78xx: select CRC32
      netfilter: Kconfig: use 'default y' instead of 'm' for bool config option

Werner Sembach (2):
      ALSA: hda/realtek: Complete partial device name to avoid ambiguity
      ALSA: hda/realtek: Add quirk for Clevo X170KM-G

Xiaolong Huang (1):
      isdn: cpai: check ctr->cnr to avoid array index out of bound

Yanfei Xu (1):
      net: mdiobus: Fix memory leak in __mdiobus_register

Yoshihiro Shimoda (1):
      can: rcar_can: fix suspend/resume

Yu-Tung Chang (1):
      USB: serial: option: add Quectel EC200S-CN module support

Zhang Jianhua (1):
      efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock()

Zheyu Ma (2):
      can: peak_pci: peak_pci_remove(): fix UAF
      isdn: mISDN: Fix sleeping function called from invalid context

Ziyang Xuan (3):
      nfc: fix error handling of nfc_proto_register()
      NFC: digital: fix possible memory leak in digital_tg_listen_mdaa()
      NFC: digital: fix possible memory leak in digital_in_send_sdd_req()

chongjiapeng (1):
      qed: Fix missing error code in qed_slowpath_start()
---
Makefile                                           |  2 +-
 arch/arm/Kconfig                                   |  1 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |  1 -
 arch/arm/boot/dts/spear3xx.dtsi                    |  2 +-
 arch/nios2/include/asm/irqflags.h                  |  4 +-
 arch/nios2/include/asm/registers.h                 |  2 +-
 arch/s390/lib/string.c                             | 15 ++--
 arch/x86/Kconfig                                   |  1 -
 arch/x86/kernel/cpu/intel_rdt.c                    |  2 +
 arch/xtensa/platforms/xtfpga/setup.c               | 12 ++--
 drivers/acpi/arm64/gtdt.c                          |  2 +-
 drivers/ata/pata_legacy.c                          |  6 +-
 drivers/firmware/efi/cper.c                        |  4 +-
 drivers/firmware/efi/runtime-wrappers.c            |  2 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |  4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  2 +-
 drivers/gpu/drm/msm/edp/edp_ctrl.c                 |  3 +-
 drivers/iio/adc/aspeed_adc.c                       |  1 +
 drivers/iio/adc/ti-adc128s052.c                    |  6 ++
 drivers/iio/common/ssp_sensors/ssp_spi.c           | 11 ++-
 drivers/iio/dac/ti-dac5571.c                       |  1 +
 drivers/iio/light/opt3001.c                        |  6 +-
 drivers/input/joystick/xpad.c                      |  2 +
 drivers/isdn/capi/kcapi.c                          |  5 ++
 drivers/isdn/hardware/mISDN/netjet.c               |  2 +-
 drivers/misc/cb710/sgbuf2.c                        |  2 +-
 drivers/misc/mei/hw-me-regs.h                      |  1 +
 drivers/misc/mei/pci-me.c                          |  1 +
 drivers/net/can/rcar/rcar_can.c                    | 20 +++---
 drivers/net/can/sja1000/peak_pci.c                 |  9 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |  5 +-
 drivers/net/ethernet/Kconfig                       |  1 +
 drivers/net/ethernet/arc/Kconfig                   |  1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 21 ++++++
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  9 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  1 +
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 10 ++-
 drivers/net/ethernet/microchip/encx24j600.c        |  5 +-
 drivers/net/ethernet/microchip/encx24j600_hw.h     |  4 +-
 drivers/net/ethernet/neterion/s2io.c               |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  8 +++
 drivers/net/phy/mdio_bus.c                         |  1 +
 drivers/net/usb/Kconfig                            |  5 ++
 drivers/nvmem/core.c                               |  3 +-
 drivers/platform/mellanox/mlxreg-io.c              |  2 +-
 drivers/platform/x86/intel_scu_ipc.c               |  2 +-
 drivers/scsi/hosts.c                               |  3 +-
 drivers/usb/host/xhci-pci.c                        |  2 +
 drivers/usb/host/xhci-ring.c                       | 14 ++--
 drivers/usb/host/xhci.c                            |  5 ++
 drivers/usb/musb/musb_dsps.c                       |  4 +-
 drivers/usb/serial/option.c                        |  8 +++
 drivers/usb/serial/qcserial.c                      |  1 +
 drivers/virtio/virtio.c                            | 11 +++
 fs/btrfs/tree-log.c                                | 79 ++++++++++++++--------
 fs/exec.c                                          |  2 +-
 fs/nfsd/nfsctl.c                                   |  5 +-
 fs/ocfs2/alloc.c                                   | 46 ++++---------
 fs/ocfs2/super.c                                   | 14 ++--
 include/linux/elfcore.h                            |  2 +-
 kernel/dma/debug.c                                 | 12 ++--
 kernel/trace/ftrace.c                              |  4 +-
 kernel/trace/trace.h                               | 64 ++++++------------
 kernel/trace/trace_functions.c                     |  2 +-
 localversion-rt                                    |  2 +-
 mm/slub.c                                          | 11 ++-
 net/netfilter/Kconfig                              |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  5 ++
 net/nfc/af_nfc.c                                   |  3 +
 net/nfc/digital_core.c                             |  9 ++-
 net/nfc/digital_technology.c                       |  8 ++-
 net/nfc/nci/rsp.c                                  |  2 +
 net/sched/sch_mqprio.c                             | 30 ++++----
 net/sctp/sm_make_chunk.c                           |  2 +-
 scripts/Makefile.gcc-plugins                       |  4 ++
 scripts/recordmcount.pl                            |  2 +-
 sound/core/seq_device.c                            |  8 +--
 sound/hda/hdac_controller.c                        |  5 +-
 sound/pci/hda/patch_realtek.c                      |  9 ++-
 sound/soc/codecs/wm8960.c                          | 13 +++-
 sound/soc/soc-dapm.c                               | 13 ++--
 sound/usb/quirks-table.h                           | 32 +++++++++
 85 files changed, 426 insertions(+), 227 deletions(-)
---
