Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F7C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB4A6113B
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 21:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhKEVfh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhKEVfg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Nov 2021 17:35:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 454B360F9E;
        Fri,  5 Nov 2021 21:32:56 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.215-rt94
Date:   Fri, 05 Nov 2021 21:30:12 -0000
Message-ID: <163614781239.218435.9293794866106659017@puck.lan>
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

I'm pleased to announce the 4.19.215-rt94 stable release.

In addition to a merge of the 4.19.215 stable release, this release contains
a back port of the following commit:

2cdede918a7b fscache: fix initialisation of cookie hash table raw spinlocks

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 36a43624fe45b54ab3b24adb37959675c7a6c75e

Or to build 4.19.215-rt94 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.215.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.215-rt94.patch.xz


You can also build from 4.19.214-rt93 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.214-rt93-rt94.patch.xz

Enjoy!
Clark

Changes from v4.19.214-rt93:
---

Arnd Bergmann (3):
      ARM: 9134/1: remove duplicate memcpy() definition
      ARM: 9139/1: kprobes: fix arch_init_kprobes() prototype
      ARM: 9141/1: only warn about XIP address when not compile testing

Clark Williams (2):
      Merge tag 'v4.19.215' into v4.19-rt
      Linux 4.19.215-rt94

Clément Bœsch (1):
      arm64: dts: allwinner: h5: NanoPI Neo 2: Fix ethernet node

Eric Dumazet (3):
      ipv4: use siphash instead of Jenkins in fnhe_hashfun()
      ipv6: use siphash in rt6_exception_hash()
      ipv6: make exception cache less predictible

Greg Kroah-Hartman (1):
      Linux 4.19.215

Gregor Beck (1):
      fscache: fix initialisation of cookie hash table raw spinlocks

Guenter Roeck (1):
      nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset standard tuning circuit

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

Johan Hovold (2):
      mmc: vub300: fix control-message timeouts
      net: lan78xx: fix division by zero in send path

Krzysztof Kozlowski (1):
      nfc: port100: fix using -ERRNO as command type mask

Michael Chan (1):
      net: Prevent infinite while loop in skb_tx_hash()

Nathan Chancellor (1):
      ARM: 8819/1: Remove '-p' from LDFLAGS

Naveen N. Rao (1):
      powerpc/bpf: Fix BPF_MOD when imm == 1

Nick Desaulniers (1):
      ARM: 9133/1: mm: proc-macros: ensure *_tlb_fns are 4B aligned

Oliver Neukum (1):
      usbnet: sanity check for maxpacket

Patrisious Haddad (1):
      RDMA/mlx5: Set user priority for DCT

Pavel Skripkin (2):
      Revert "net: mdiobus: Fix memory leak in __mdiobus_register"
      net: batman-adv: fix error handling

Robin Murphy (1):
      arm64: Avoid premature usercopy failure

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Trevor Woerner (1):
      net: nxp: lpc_eth.c: avoid hang when bringing interface down

Wang Hai (1):
      usbnet: fix error return code in usbnet_probe()

Wenbin Mei (1):
      mmc: cqhci: clear HALT state after CQE enable

Xin Long (5):
      sctp: use init_tag from inithdr for ABORT chunk
      sctp: fix the processing for COOKIE_ECHO chunk
      sctp: add vtag check in sctp_sf_violation
      sctp: add vtag check in sctp_sf_do_8_5_1_E_sa
      sctp: add vtag check in sctp_sf_ootb

Yang Yingliang (1):
      regmap: Fix possible double-free in regcache_rbtree_exit()

Yuiko Oshino (2):
      net: ethernet: microchip: lan743x: Fix driver crash when lan743x_pm_resume fails
      net: ethernet: microchip: lan743x: Fix dma allocation failure by using dma_set_mask_and_coherent

Zheyu Ma (1):
      ata: sata_mv: Fix the error handling of mv_chip_id()
---
Makefile                                           |  2 +-
 arch/arm/Makefile                                  |  2 +-
 arch/arm/boot/bootp/Makefile                       |  2 +-
 arch/arm/boot/compressed/Makefile                  |  2 -
 arch/arm/boot/compressed/decompress.c              |  3 ++
 arch/arm/kernel/vmlinux-xip.lds.S                  |  2 +-
 arch/arm/mm/proc-macros.S                          |  1 +
 arch/arm/probes/kprobes/core.c                     |  2 +-
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |  2 +-
 arch/arm64/lib/copy_from_user.S                    | 13 +++--
 arch/arm64/lib/copy_in_user.S                      | 20 +++++---
 arch/arm64/lib/copy_to_user.S                      | 14 ++++--
 arch/nios2/platform/Kconfig.platform               |  1 +
 arch/powerpc/net/bpf_jit_comp64.c                  | 10 +++-
 drivers/ata/sata_mv.c                              |  4 +-
 drivers/base/regmap/regcache-rbtree.c              |  7 ++-
 drivers/infiniband/hw/mlx5/qp.c                    |  2 +
 drivers/mmc/host/cqhci.c                           |  3 ++
 drivers/mmc/host/dw_mmc-exynos.c                   | 14 ++++++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 17 +++++++
 drivers/mmc/host/sdhci.c                           |  6 +++
 drivers/mmc/host/vub300.c                          | 18 +++----
 drivers/net/ethernet/microchip/lan743x_main.c      | 22 +++++++++
 drivers/net/ethernet/nxp/lpc_eth.c                 |  5 +-
 drivers/net/phy/mdio_bus.c                         |  1 -
 drivers/net/usb/lan78xx.c                          |  6 +++
 drivers/net/usb/usbnet.c                           |  5 ++
 drivers/nfc/port100.c                              |  4 +-
 fs/fscache/cookie.c                                |  2 +-
 localversion-rt                                    |  2 +-
 net/batman-adv/bridge_loop_avoidance.c             |  8 +++-
 net/batman-adv/main.c                              | 56 +++++++++++++++-------
 net/batman-adv/network-coding.c                    |  4 +-
 net/batman-adv/translation-table.c                 |  4 +-
 net/core/dev.c                                     |  6 +++
 net/ipv4/route.c                                   | 12 ++---
 net/ipv6/route.c                                   | 25 +++++++---
 net/sctp/sm_statefuns.c                            | 30 ++++++++----
 38 files changed, 251 insertions(+), 88 deletions(-)
---
